#!/bin/sh
# TRAP 테스트를 돌린다. 크누스의 trapman.tex 부록 A의 절차를 따른다.
#
#   tests/trap.sh            요약만 찍는다
#   tests/trap.sh -v         원본 결과와의 차이를 모두 찍는다
#
# 필요한 것: go, gtangle, tftopl, gftype, curl, perl
# 테스트 파일(trap.mf 따위)은 처음 한 번 CTAN에서 tests/trap/ 아래로 받아 둔다.
set -e

TOP=$(cd "$(dirname "$0")/.." && pwd)
DIST=$TOP/tests/trap                 # 크누스가 배포한 원본 파일들
WORK=$TOP/build/trap                 # 테스트를 돌리는 곳
CTAN=https://mirrors.ctan.org/systems/knuth/dist/mf
FILES="trap.mf trap.pl trapin.log trapin.fot trap.log trap.fot trap.typ trap.72270gf trapman.tex"

# 0. 원본 파일을 받는다
mkdir -p "$DIST"
for f in $FILES; do
  [ -f "$DIST/$f" ] || curl -sSfL -o "$DIST/$f" "$CTAN/$f"
done

rm -rf "$WORK"; mkdir -p "$WORK"; cd "$WORK"
cp "$DIST/trap.mf" .

# 1. 테스트용 INIMF를 만든다. trapman의 지시대로 상수 몇 개를 바꾸고, debug 코드를 켜고,
#    화면 루틴이 화면 대신 기록 파일에 쓰도록 initScreen이 true를 돌려주게 한다.
#    키워 둔 bufSize, fileNameSize, 하프워드는 mf.web의 처음 값으로 되돌린다.
cp "$TOP/mf.w" "$TOP/go.mod" .
gtangle mf.w >/dev/null 2>&1
perl -0pi -e '
  s/(\n\tmemMax\s*=\s*)1000000/${1}3000/       or die "memMax";
  s/(\n\tmemTop\s*=\s*)1000000/${1}3000/       or die "memTop";
  s/(\n\terrorLine\s*=\s*)72/${1}64/           or die "errorLine";
  s/(\n\thalfErrorLine\s*=\s*)42/${1}32/       or die "halfErrorLine";
  s/(\n\tmaxPrintLine\s*=\s*)79/${1}72/        or die "maxPrintLine";
  s/(\n\tscreenWidth\s*=\s*)768/${1}100/       or die "screenWidth";
  s/(\n\tscreenDepth\s*=\s*)1024/${1}200/      or die "screenDepth";
  s/(\n\tgfBufSize\s*=\s*)800/${1}8/           or die "gfBufSize";
  s/(\n\tbufSize\s*=\s*)20000/${1}500/         or die "bufSize";
  s/(\n\tfileNameSize\s*=\s*)1024/${1}40/      or die "fileNameSize";
  s/(\n\tmaxHalfword\s*=\s*)0o1777777777/${1}65535/ or die "maxHalfword";
  s/(\n\tdebug\s*=\s*)false/${1}true/          or die "debug";
  s/(func initScreen\(\) bool \{\n\treturn )false/${1}true/ or die "initScreen";
' mf.go
go build -o trapmf .

# 무엇이 잘못되면 기록 파일이 끝없이 커질 수 있으므로 파일 크기를 제한한다
ulimit -f 100000
export MFINPUTS=.

# 2. 첫 실행: `**'에 빈 줄을 주고, 다시 `**'에 \input trap을 준다
printf '\n\\input trap\n' | ./trapmf -ini > trapin.fot 2>&1 || true
mv trap.log trapin.log

# 3. 둘째 실행: ` &trap  trap '을 준다
printf ' &trap  trap \n' | ./trapmf -ini > trap.fot 2>&1 || true

# 5, 6. GFtype과 TFtoPL로 바꾼다. TeX Live의 GFtype은 trapman이 말하는 ``보통''의 상수
#    (top_pixel=69 따위)보다 큰 그림을 보이므로, 원본 GF도 같은 GFtype으로 바꾸어 견준다.
gftype -mnemonics -images trap.72270gf > trap.typ 2>&1 || true
gftype -mnemonics -images "$DIST/trap.72270gf" > master.typ 2>&1 || true
tftopl trap.tfm trap.pl > /dev/null 2>&1 || true

# 4. 원본 결과와 비교한다
echo "TRAP 결과 ($WORK)"
for f in trapin.log trapin.fot trap.log trap.fot trap.typ trap.pl; do
  m="$DIST/$f"; [ "$f" = trap.typ ] && m=master.typ
  n=$(diff "$m" "$f" | grep -c '^[<>]' || true)
  printf '  %-11s 다른 줄 %s\n' "$f" "$n"
  if [ "$1" = "-v" ] && [ "$n" != 0 ]; then
    diff "$m" "$f" | sed 's/^/      /' || true
  fi
done
if cmp -s "$DIST/trap.72270gf" trap.72270gf; then
  echo "  trap.72270gf 원본과 바이트까지 같다"
else
  echo "  trap.72270gf 원본과 다르다"
fi
