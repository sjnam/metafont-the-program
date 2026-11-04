// 차등 퍼징: 같은 입력을 기준 METAFONT(꼬리표 faithful, 곧 원본 mf.web을 충실히 옮긴 판의
// mf.w로 만든 것)와 지금의 METAFONT로 돌려, 남긴 파일(GF, TFM, 기록 파일)과 터미널 출력이
// 바이트까지 같은지 본다.
//
//	go test ./tests/fuzz                       씨앗 입력만 돌린다
//	go test ./tests/fuzz -fuzz=FuzzSame -fuzztime=10m
//
// 실행 파일은 환경 변수 MFOURS와 MFREF로 줄 수 있다. 기본값은 build/mf와 build/ref-faithful/mf다
// (make fuzz가 둘 다 만든다). METAFONT는 전역 상태 때문에 한 프로세스에서 되풀이해 돌릴 수
// 없으므로 입력마다 실행 파일을 띄운다. METAFONT가 쓰는 파일은 작업 이름을 딴 것뿐이고 모두
// 현재 디렉터리에 생기지만, macOS에서는 sandbox-exec로 가두어 임시 디렉터리 밖에 쓰지 못하게 한다.
package fuzz

import (
	"bytes"
	"context"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"slices"
	"strings"
	"sync"
	"syscall"
	"testing"
	"time"
)

var seeds = []string{
	`show 1+1; message "hello";`,
	`mode_setup; beginchar("A", 10pt#, 7pt#, 0); pickup pencircle scaled 1pt;
draw (0,0)..(5pt,7pt)..(10pt,0); endchar;`,
	`mode_setup; beginchar("B", 8pt#, 8pt#, 2pt#); fill fullcircle scaled 6pt shifted (4pt,3pt);
unfill fullcircle scaled 3pt shifted (4pt,3pt); endchar;`,
	`z1=(0,0); z2=(3,4); x3=x1+x2; y3-y2=2; show z3; a+b=3; a-b=1; show a, b;`,
	`path p; p := (0,0){dir 30}..(10,5)..tension 2..(20,0)..cycle; show p; show length p, point 1.5 of p;`,
	`show (0,0)--(10,10) intersectiontimes ((0,10)--(10,0)); show directiontime (1,1) of ((0,0)..(5,5)..(10,0));`,
	`pen q; q := makepen ((0,0)--(3,1)--(1,4)--cycle); show q; show penoffset (1,0) of q;`,
	`string s; s := "abc" & "def"; show substring (1,4) of s, length s, ASCII "A", char 66, decimal 3.5;`,
	`for i=1 upto 5: show i*i; endfor; for t=0 step .25 until 1: show t; endfor; forsuffixes $=a,b: show $; endfor;`,
	`def twice(expr x) = 2x enddef; show twice(3); vardef f@#(text t) = t enddef; show f.a(7);`,
	`tracingequations:=tracingchoices:=tracingspecs:=tracingpens:=tracingcommands:=1; tracingonline:=1;
mode_setup; beginchar("C", 5pt#, 5pt#, 0); pickup pencircle scaled .5pt; draw (0,0)--(5pt,5pt); endchar;`,
	`mode_setup; font_size 10pt#; ligtable "f": "i" =: oct"014", "l" kern 1pt#; charlist 1: 2: 3;
extensible 4: 5,6,7,8; fontdimen 2: 3.3pt#; headerbyte 9: "ABC";
beginchar(1,1pt#,1pt#,0); endchar; beginchar(2,2pt#,2pt#,0); endchar;`,
	`picture pic; pic := nullpicture; addto pic contour unitsquare scaled 10; cull pic keeping (1,infinity);
show totalweight pic; currentpicture := pic rotated 30; shipit;`,
	`mode_setup; beginchar("D", 6pt#, 6pt#, 0); pickup pensquare scaled 1pt;
draw (0,0)..(3pt,6pt)..(6pt,0) withpen pencircle xscaled 2pt yscaled .5pt rotated 20;
filldraw (1pt,1pt)--(5pt,1pt)--(3pt,4pt)--cycle; endchar;`,
	`show sqrt 2, mexp 256, mlog 10, sind 30, cosd 60, angle (1,1), 3/7, 1/0, 4096*4096;`,
	`if 1<2: show "yes" elseif 2<3: show "no" else: show "never" fi; show (1<2) and not (2<1);`,
	`numeric x[]; x[1]=1; x[2]=x[1]+1; show x2; transform t; t=identity xscaled 2 rotated 90; show t;`,
	`undefined + "s"; show unknown x; x:=x+1; (1,2) = (3,4); begingroup interim showstopping:=1; endgroup;`,
	`mode_setup; for c=48 upto 57: beginchar(c, 4pt#, 6pt#, 0); draw (0,0)--(4pt,6pt); endchar; endfor`,
	`input cmr10`,
}

// 무한 루프에 빠지는 입력도 흔하므로 한 번 돌리는 시간을 짧게 잡는다. 두 번을 동시에 돌리므로
// 입력 하나에 드는 시간도 이 정도다. 퍼징 엔진은 오래 답이 없는 작업 프로세스를 죽여 버린다.
const runTimeout = 2 * time.Second

var (
	setupOnce         sync.Once
	setupErr          error
	oursBin, refBin   string
	oursBase, refBase string
	sandbox           string
)

// 실행 파일을 찾고, 저마다 plain 기반을 한 번만 만든다.
func setup() {
	root, _ := filepath.Abs("../..")
	oursBin = envOr("MFOURS", filepath.Join(root, "build", "mf"))
	refBin = envOr("MFREF", filepath.Join(root, "build", "ref-faithful", "mf"))
	for _, b := range []string{oursBin, refBin} {
		if _, err := os.Stat(b); err != nil {
			setupErr = fmt.Errorf("%s가 없다 (make fuzz가 만든다): %v", b, err)
			return
		}
	}
	dir, err := os.MkdirTemp("", "mffuzz-base")
	if err != nil {
		setupErr = err
		return
	}
	if p, err := exec.LookPath("sandbox-exec"); err == nil {
		sandbox = p
	}
	for i, b := range []string{oursBin, refBin} {
		d := filepath.Join(dir, fmt.Sprint(i))
		os.Mkdir(d, 0o755)
		cmd := exec.Command(b, "-ini", "plain", "dump")
		cmd.Dir = d
		if out, err := cmd.CombinedOutput(); err != nil {
			setupErr = fmt.Errorf("%s -ini plain: %v\n%s", b, err, out)
			return
		}
		if i == 0 {
			oursBase = filepath.Join(d, "plain.base")
		} else {
			refBase = filepath.Join(d, "plain.base")
		}
	}
}

func envOr(k, v string) string {
	if s := os.Getenv(k); s != "" {
		return s
	}
	return v
}

// 실행 결과: 터미널 출력과, 작업 디렉터리에 새로 생긴 파일들
type result struct {
	timedOut bool
	files    map[string][]byte
}

func run(t *testing.T, bin, baseFile, doc string) result {
	return runFor(t, runTimeout, bin, baseFile, doc)
}

func runFor(t *testing.T, timeout time.Duration, bin, baseFile, doc string) result {
	dir := t.TempDir()
	if err := os.WriteFile(filepath.Join(dir, "t.mf"), []byte(doc), 0o644); err != nil {
		t.Fatal(err)
	}
	if err := os.Symlink(baseFile, filepath.Join(dir, "plain.base")); err != nil {
		t.Fatal(err)
	}
	ctx, cancel := context.WithTimeout(context.Background(), timeout)
	defer cancel()
	args := []string{bin, `&plain \mode=lowres; input t`}
	if sandbox != "" {
		real, _ := filepath.EvalSymlinks(dir)
		profile := fmt.Sprintf(`(version 1)(allow default)(deny file-write*)
(allow file-write* (subpath %q) (subpath "/dev"))`, real)
		args = append([]string{sandbox, "-p", profile}, args...)
	}
	cmd := exec.CommandContext(ctx, args[0], args[1:]...)
	// 시간이 다 되면 프로세스 그룹째 죽인다(METAFONT가 띄운 kpsewhich까지)
	cmd.SysProcAttr = &syscall.SysProcAttr{Setpgid: true}
	cmd.Cancel = func() error { return syscall.Kill(-cmd.Process.Pid, syscall.SIGKILL) }
	cmd.WaitDelay = time.Second
	cmd.Dir = dir
	var out bytes.Buffer
	cmd.Stdout, cmd.Stderr = &out, &out
	cmd.Run()
	r := result{timedOut: ctx.Err() != nil, files: map[string][]byte{"(terminal)": out.Bytes()}}
	ents, _ := os.ReadDir(dir)
	for _, e := range ents {
		if n := e.Name(); n != "t.mf" && n != "plain.base" && !e.IsDir() {
			r.files[n], _ = os.ReadFile(filepath.Join(dir, n))
		}
	}
	return r
}

// a와 b의 파일들이 같은지 본다.
func compare(t *testing.T, a, b result) {
	var names []string
	for n := range a.files {
		names = append(names, n)
	}
	for n := range b.files {
		if _, ok := a.files[n]; !ok {
			names = append(names, n)
		}
	}
	slices.Sort(names)
	for _, n := range names {
		x, okx := a.files[n]
		y, oky := b.files[n]
		if okx != oky {
			t.Errorf("%s가 한쪽에만 있다 (기준 %v, 이쪽 %v)", n, okx, oky)
		} else if !bytes.Equal(x, y) {
			t.Errorf("%s가 다르다\n%s", n, firstDiff(x, y))
		}
	}
}

func firstDiff(x, y []byte) string {
	xl, yl := strings.Split(string(x), "\n"), strings.Split(string(y), "\n")
	for i := 0; i < max(len(xl), len(yl)); i++ {
		var a, b string
		if i < len(xl) {
			a = xl[i]
		}
		if i < len(yl) {
			b = yl[i]
		}
		if a != b {
			return fmt.Sprintf("  %d번째 줄\n  기준: %.200q\n  이쪽: %.200q", i+1, a, b)
		}
	}
	return "  (줄은 같고 바이트가 다르다)"
}

func FuzzSame(f *testing.F) {
	for _, s := range seeds {
		f.Add(s)
	}
	f.Fuzz(func(t *testing.T, body string) {
		setupOnce.Do(setup)
		if setupErr != nil {
			t.Skip(setupErr)
		}
		doc := "batchmode;\n" + body + "\nend.\n"
		var ref, ours result
		var wg sync.WaitGroup
		wg.Go(func() { ref = run(t, refBin, refBase, doc) })
		wg.Go(func() { ours = run(t, oursBin, oursBase, doc) })
		wg.Wait()
		// 보통은 수십 ms면 끝나므로, 둘 다 시간을 넘기면 무한 루프로 보고 건너뛰고,
		// 한쪽만 넘기면 수상한 일로 본다.
		if ref.timedOut && ours.timedOut {
			t.Skip("둘 다 시간 안에 끝나지 않았다")
		}
		// 한쪽만 넘겼으면 퍼징 부하 때문일 수 있으니 넘긴 쪽을 넉넉한 시간으로 한 번 더 돌린다
		if ref.timedOut {
			ref = runFor(t, 5*runTimeout, refBin, refBase, doc)
		}
		if ours.timedOut {
			ours = runFor(t, 5*runTimeout, oursBin, oursBase, doc)
		}
		if ref.timedOut || ours.timedOut {
			t.Fatalf("한쪽만 시간 안에 끝났다 (기준 %v, 지금 %v)", !ref.timedOut, !ours.timedOut)
		}
		compare(t, ref, ours)
	})
}

// 하네스가 제대로 도는지 본다: 두 METAFONT 모두 문자 하나짜리 GF를 남겨야 한다.
func TestHarness(t *testing.T) {
	setupOnce.Do(setup)
	if setupErr != nil {
		t.Skip(setupErr)
	}
	doc := "batchmode;\n" + seeds[1] + "\nend.\n"
	for _, r := range []result{run(t, refBin, refBase, doc), run(t, oursBin, oursBase, doc)} {
		if len(r.files["t.200gf"]) == 0 || !bytes.Contains(r.files["t.log"], []byte("(1 character")) {
			t.Fatalf("GF가 생기지 않았다:\n%s\n%s", r.files["(terminal)"], r.files["t.log"])
		}
	}
}
