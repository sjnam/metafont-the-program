# METAFONT: 한글 GWEB 판

도널드 크누스(Donald E. Knuth)의 글꼴 설계 프로그램 METAFONT의 문학적 프로그램 `mf.web`(판 2.71828182)을
한글과 Go로 옮긴 것이다. 원본은 영어 설명과 Pascal 코드로 되어 있는데, 이 번역은 설명을 한글로,
코드를 Go로 바꾸어 GWEB(Go로 쓰는 WEB)의 `.w` 파일 하나(`mf.w`)에 담았다.
같은 방식으로 옮긴 TeX(`tex-the-program`)의 짝이다.

옮긴 목적은 METAFONT의 알고리즘들과 동작 원리를 온전히 이해하는 것이다. 그래서 원본에 될 수 있는 대로
충실하게 옮기고, 원본에 없는 그림을 26장 보탰다.

- 원본의 절, 절 이름, 프로시저와 변수 이름, 프로그램의 짜임새를 그대로 따른다.
  크누스의 책 *METAFONT: The Program*(Computers & Typesetting, Volume D)과 나란히 놓고 읽을 수 있다.
- 문서는 크누스가 처음부터 GWEB과 Go로 쓴 것처럼 서술했다. Pascal에만 해당하는 설명은 걷어 내고,
  Go로 옮기면서 달라진 점은 해당하는 절의 설명에 녹여 넣었다. METAFONT의 역사와 크누스의 농담은
  그대로 두었다.
- 그림은 MetaPost로 그려 문서에 바로 넣었다(luamplib). 존 호비의 조절점 고르기, 드 카스텔조 나누기와
  룩 움직임, 가장자리 구조, 팔분면, 다각형 펜과 포락선, 타원 펜, 교차 시각, 변수의 자료 구조,
  `pencircle`의 타원 복원, `subpath` 자르기, `doublepath`, TFM 치수 합치기(`skimp`), GF 부호화 따위다.
- 같은 `mf.w`에서 사람이 읽을 문서(`mf.pdf`, 약 850쪽)와 실제로 돌아가는 프로그램(`build/mf`)이
  함께 나온다. 이 프로그램은 진짜 METAFONT와 같은 TFM과 GF를 만들고, 크누스의 TRAP 테스트를 통과한다.

## 파일

| 파일 | 내용 |
| --- | --- |
| `mf.w` | 번역 본문. 모든 것이 여기서 나온다 |
| `Makefile` | 빌드, 조판, 테스트 |
| `mf-deco.ch` | 쪽마다 액자를 두르는 바꿈 파일(`make deco`) |
| `decoframe.pdf` | `mf-deco.ch`가 쪽마다 까는 액자 그림 |
| `go.mod` | Go 모듈 정의 |
| `tests/trap.sh` | TRAP 테스트 |
| `tests/compare.sh` | 글꼴 몇 개를 진짜 METAFONT와 함께 만들어 TFM, GF, 기록 파일을 비교한다 |
| `tests/typeset-check.py` | `mf.pdf`에서 오류 없이 조용히 깨진 조판(악센트가 된 따옴표, 잘못 끊긴 수 따위)을 찾는다 |
| `orig/mf.web` | 옮긴 원본(CTAN의 2.71828182) |
| `orig/names.tsv` | 원본의 영어 이름과 한글 이름의 대응표(부 제목 52개와 이름 있는 절 500여 개) |

## 읽기 안내

### 문서의 모양

`make pdf`로 만든 `mf.pdf`를 읽으면 된다. 원본처럼 52부(part)로 되어 있고, 각 부는 번호 붙은
절(section)로 이루어진다. 절마다 설명(TeX 부분)과 코드(Go 부분)가 함께 있다. 코드 안의
`⟨…⟩`는 다른 절에 정의된 코드 조각을 그 자리에 끼워 넣는다는 뜻이고, 그 정의가 있는 절 번호가
함께 찍힌다.

이 번역은 쪽 넘김을 깔끔하게 하려고 긴 절을 몇 개로 나누기도 하고, 정의와 코드를 따로 두려고 절을
보태기도 했다. 그래서 절 번호가 원본과 어긋난다(원본 1215절, 번역 1351절). 원본이나
*METAFONT: The Program*과 맞추어 볼 때는 절 이름(`orig/names.tsv`)과 찾아보기를 쓰면 된다.
`names.tsv`는 두 판의 절 코드에 나오는 식별자를 견주어 순서대로 짝지은 것이라, 번역에서 합치거나 새로
만든 절은 빠져 있다. 마지막 부인 찾아보기에서는 식별자와 오류 메시지가 쓰인 모든 절을 찾을 수 있고,
``bugs'' 항목에는 이 번역에서 찾은 원본의 문제들이 모여 있다.

### 어디서부터 읽을까

크누스는 처음부터 차례로 읽기를 권한다. 앞부분에서 만든 도구를 뒤에서 쓰기 때문이다. 1절 끝의
지도 그림이 전체의 흐름을 보여 준다. 처음 읽는다면 다음 순서가 무난하다.

1. **기초 (1–8부)**: 문자 집합, 입출력, 문자열 풀, 오류 처리, 그리고 METAFONT의 모든 계산의 바탕인
   고정 소수점 산술. `scaled`(2^-16)와 `fraction`(2^-28)과 `angle`(2^-20도), 넘침 없이 곱하고 나누는
   `makeFraction`·`takeFraction`, 피타고라스 덧셈, 로그와 지수, CORDIC 풍의 삼각 함수(8부).
2. **메모리와 변수 (9–17부)**: 거대한 배열 `mem`의 할당(10부), 해시 표(13부), 토큰 목록(14부),
   첨자와 속성이 얽힌 변수의 자료 구조(15부, 그림 7), 저장과 복원(16부), 경로의 노드(17부).
3. **METAFONT의 기하 알고리즘들**
   - 조절점 고르기 (18부): 존 호비의 "모조 곡률" 방정식으로 매끄러운 곡선을 고른다. 이 프로그램의
     가장 아름다운 부분 가운데 하나다.
   - 이산 움직임 (19부): 베지어 곡선을 이분해서 룩 움직임으로 바꾼다.
   - 가장자리 구조 (20부)와 팔분면 나누기 (21부), 윤곽 칠하기 (22부).
   - 다각형 펜 (23부)과 포락선 칠하기 (24부), 타원 펜 (25부).
   - 방향 시각과 교차 시각 (26부): 이분법으로 두 곡선의 교점을 찾는다.
4. **방정식 (28–29부)**: 일차 방정식의 종속 목록과 독립 변수의 소거. `x=y+1`을 알면 `x>y`를 아는 기구다.
5. **언어 (30–44부)**: 훑개 `getNext`, 매크로 펼치기, 조건문과 되풀이, 식의 구문 분석(일차식에서
   식까지), 연산(42부), 문장과 명령.
6. **출력 (45–49부)**: TFM 파일(45부, 치수를 정해진 개수로 줄이는 `skimp`), GF 파일 형식(46부)과
   문자 내보내기(47부), 기반 파일의 덤프(48부), 주 프로그램(49부).

### Pascal에서 Go로

옮기면서 정한 관례는 문서의 첫 부분과 해당 절의 설명에 적혀 있다. 대표적인 것만 들면 다음과 같다.

- 식별자는 Go의 관례대로 낙타 표기로 썼다(원본의 `get_next`는 `getNext`, `end_of_MF`는 `endOfMF`).
  예약어와 겹치는 `type`은 `typ`이, 내장 이름을 가리던 `print`와 `error`는 `printStr`와 `reportError`가 되었다.
- METAFONT의 정수형(`halfword`, `scaled`, `fraction`, `pointer` 따위)은 모두 `int32`의 별칭이다.
  Go의 정수 나눗셈은 0 쪽으로 자르므로 원본의 `div`·`mod`와 같다.
- 원본의 필드 매크로 `link(p)`는 함수 `link(p)`와 `setLink(p, v)`의 짝이 된다.
- 변형 레코드 `memory_word`는 필드가 따로따로인 구조체가 된다.
- `init…tini`는 `if iniVersion {…}`, `stat…tats`는 `if stat {…}`, `debug…gubed`는 `if debug {…}`이다.
- `goto`는 되도록 `break`, `continue`, 레이블 붙은 반복문, `if`–`else`로 바꾸었다. 그렇게 바꾼 곳마다
  설명에 원본의 레이블이 어떻게 되었는지 적었다. 프로시저 바깥으로 가는 `goto endOfMF`나 `goto finalEnd`는
  `panic`이 되고, 주 프로그램이 `recover`로 받는다.
- 원본의 문자열 풀 파일(`MF.POOL`)은 없다. 메시지는 Go의 문자열 상수로 남아 그대로 찍히고,
  원본에서 문자열 번호로 쓰이던 상수들만 INIMF가 풀에 넣는다.
- 한 곳에서만 부르는 프로시저(원본에서 Pascal 컴파일러의 크기 제한 때문에 나눈 것 따위)는 이름 있는
  절로 끼워 넣었다. 크누스가 이름을 붙여 설명한 프로시저는 그대로 함수로 두었다.
- 용량을 키웠다. `memMax`는 30000에서 1000000으로(하프워드도 2^28-1로), `bufSize`는 500에서 20000으로,
  `fileNameSize`는 40에서 1024로 늘렸다. 원래 크기로는 600dpi의 `cmr10`도 빠듯하다.

## 빌드

필요한 것은 다음과 같다.

- [Go](https://go.dev/) 1.27.2 이상(`go.mod`)
- GWEB 도구 `gtangle`, `gweave`와 그 매크로(`kotexgweb.tex`, `gwebmac.tex`)
- LuaTeX와 TeX Live: 문서를 조판할 때(luamplib으로 그림을 그린다), 그리고 프로그램이 `plain.mf`나
  `cmr10.mf` 같은 입력 파일을 `kpsewhich`로 찾을 때 쓴다
- 테스트에는 `mf-nowin`, `gftype`, `tftopl`(TeX Live에 들어 있다), `curl`, `perl`도 쓴다
- [qpdf](https://qpdf.sourceforge.io/): gweave가 문서 맨 끝에 두는 차례를 맨 앞으로 옮긴다
- `make check`에는 `python3`를 쓰고, 있으면 `pdftotext`(poppler)도 쓴다

```sh
make            # build/mf와 mf.pdf를 만든다
make build      # 프로그램만: mf.w → mf.go(gtangle) → build/mf(go build)
make pdf        # 문서만: mf.w → mf.tex(gweave) → mf.pdf(luatex 두 번, qpdf로 차례를 맨 앞에)
make check      # 조판 경고(Overfull, Underfull 따위)와 조용히 깨진 조판의 수를 센다. 둘 다 0이어야 한다
make test       # make compare와 make trap(아래 테스트)을 함께 돌린다
make deco       # 쪽마다 액자를 두른 판: mf.w + mf-deco.ch → mf-deco.pdf(mf.pdf는 그대로 둔다)
make clean
```

## 실행

실행 파일 하나가 원본의 두 판, 곧 INIMF와 VIRMF 노릇을 함께 한다. 명령줄의 첫 인자가 `-ini`이면
INIMF로 작동한다. 그 밖의 인자들은 원본에서 터미널의 첫 줄(`**` 뒤)로 입력하던 것이 된다.

먼저 plain 기반을 만든다(`make base`와 같다).

```sh
cd build
./mf -ini plain dump                          # plain.mf를 읽어 plain.base를 만든다
```

그 다음 그 기반으로 글꼴을 만든다.

```sh
./mf '&plain \mode=lowres; mag=3; input cmr10'   # cmr10.tfm과 cmr10.600gf가 나온다
```

파일은 다음과 같이 찾는다.

- **입력 파일**: 먼저 현재 디렉터리에서 찾는다. 없으면 환경 변수 `MFINPUTS`의 디렉터리들에서 찾고,
  그래도 없으면 `kpsewhich`에게 묻는다.
- **기반 파일**: `&plain`은 먼저 현재 디렉터리의 `plain.base`를 찾고, 없으면 `MFBASES`의 디렉터리들에서 찾는다.
  기반 파일의 형식은 이 프로그램의 것이어서 TeX Live의 `.base`와는 바꾸어 쓸 수 없다.
- **경로**: 원본은 `>`와 `:`로만 디렉터리를 가르지만, 이 번역은 `/`도 디렉터리 구분자로 알아본다.

화면 출력은 하지 않는다. `openwindow`와 `display`는 받아들이지만 아무것도 그리지 않는다.
오류가 나면 원본처럼 터미널에서 다음 동작을 묻는다. 대화가 필요 없을 때는 `batchmode`나 `nonstopmode`를
쓴다. 출력의 날짜는 원본의 `fixDateAndTime`처럼 늘 1776년 7월 4일 정오다. 그래서 같은 입력이면 언제
돌려도 같은 파일이 나온다.

## 테스트

### 진짜 METAFONT와 비교하기

```sh
make compare                # tests/compare.sh
tests/compare.sh cmr10      # 주어진 글꼴만
```

이 번역과 TeX Live의 `mf-nowin`이 각자 plain 기반을 만든다. 그 기반으로 같은 글꼴을 200dpi와
600dpi(`mode=lowres`에 `mag=1`과 `mag=3`)로 만든 다음, TFM은 바이트 단위로, GF는 `gftype`으로 풀어서,
기록 파일은 첫 줄(배너와 날짜)을 빼고 비교한다. 기본으로 비교하는 글꼴 11개(`cmr10`, `cmbx12`, `cmti10`,
`cmmi10`, `cmsy10`, `cmex10`, `cmtt10`, `cmss10`, `cmcsc10`, `cmfib8`, `logo10`)는 두 해상도 모두 결과가
진짜 METAFONT의 것과 같다.

### TRAP 테스트

```sh
make trap                   # 요약만
tests/trap.sh -v            # 차이를 모두 보인다
```

TRAP은 크누스가 METAFONT의 구현을 검증하려고 만든 "고문 테스트"다. `tests/trap.sh`는 *trapman.tex*
부록 A의 절차를 그대로 따른다.

1. 처음 한 번, 크누스가 배포한 테스트 파일(`trap.mf`, `trap.pl`, 그리고 결과 원본인 `trapin.log`,
   `trap.log`, `trap.72270gf` 따위)을 CTAN에서 `tests/trap/`로 받는다.
2. trapman이 요구하는 상수로 테스트용 INIMF를 만든다. `memTop=memMax=3000`, `errorLine=64`,
   `halfErrorLine=32`, `maxPrintLine=72`, `screenWidth=100`, `screenDepth=200`, `gfBufSize=8`이고,
   키워 둔 `bufSize`, `fileNameSize`, 하프워드는 처음 값으로 되돌린다. `debug`를 켜고, 화면 루틴이
   기록 파일에 쓰도록 `initScreen`이 참을 돌려주게 한다. `mf.w`에서 뽑은 `mf.go`만 바꾸므로 `mf.w`는
   건드리지 않는다.
3. 첫 실행(`\input trap`)으로 `trapin.log`를 만들고, 둘째 실행(` &trap  trap `)으로 `trap.log`,
   `trap.72270gf`, `trap.tfm`을 만든다.
4. GF를 `gftype`으로, TFM을 `tftopl`로 바꾸어 원본과 비교한다.

결과는 `build/trap/`에 남는다. **`trap.72270gf`는 크누스의 원본과 바이트 하나까지 같고, `trap.pl`과
`trap.typ`도 같다.** 남는 차이는 모두 trapman이 허용하는 것들이다.

| 파일 | 차이 | 까닭 |
| --- | --- | --- |
| 모든 로그 | 첫 줄 | 배너에 `(GWEB)`이 붙는다 |
| `trapin.log`, `trap.log` | 문자열 수와 남은 용량 | 원본은 프로그램의 모든 문자열을 풀에 넣는다(trapman 4(d)) |
| `*.fot` | `**` 뒤의 입력 | 원본은 터미널이 친 글자를 되비추지만, 여기서는 파이프로 입력한다 |

`trap.typ`은 TeX Live의 `gftype`이 trapman이 말하는 ``보통''의 상수보다 큰 그림을 보이므로, 원본
GF도 같은 `gftype`으로 풀어서 비교한다.

## 원본에서 찾은 문제

METAFONT는 동결된 프로그램이지만, 옮기면서 꼼꼼히 읽다가 32비트 산술이 넘치는 곳을 몇 군데 찾았다.
모두 사용자가 일부러 계산으로 32767을 넘는 값을 만들어야 드러나는 경우다. 찾아보기의 ``bugs'' 항목에
모아 두었다.

- **`cull`의 아래 문턱 (44부)**: 문턱의 올림을 `floor_unscaled(cur_x+unity-1)`로 계산해서, `cur_x`가 32767을
  넘으면 넘친다. 그러면 무게 0인 화소가 "남길" 범위에 들어가 `cull_edges`의 전제가 깨지고 그림이 망가진다
  (`totalweight`가 -0.1875가 되었다). 표준 Pascal에서는 넘침 오류이고, TeX Live의 C 판에서는 정의되지
  않은 동작인데 컴파일러가 우연히 맞는 값을 낸다. 이 번역에서는 넘치지 않는 같은 식
  `-floorUnscaled(-curX)`로 고쳤다. 넘치지 않는 모든 값에서 결과가 같으므로 TRAP은 그대로 통과한다.
- **`display`의 창 번호 (44부)**와 **`xoffset`·`yoffset` (47부)**: `round_unscaled`가 32768을 내면
  `*unity`가 넘친다. 앞의 것은 오류 메시지에 틀린 수가 찍힐 뿐이고, 뒤의 것은 쓸모없이 큰 오프셋에서만
  생긴다. 해가 없으므로 원본대로 두고 설명만 달았다.

## 저작권과 이름

원본 `mf.web`의 저작권은 크누스에게 있다(1984). 원본 머리말은 원본을 고치는 것을 허락하되,
고친 파일의 이름이 `mf.web`이 아니어야 한다고 정해 두었다. 이 번역은 `mf.w`라는 별개의 파일이다.
TeX은 미국 수학회의 상표이고, METAFONT는 Addison-Wesley 출판사의 상표다.

원본 §2는 프로그램을 고치면 어느 판인지 알 수 있도록 배너를 바꾸라고 하고, 고친 시스템은 그냥
‘METAFONT’라고 부르지 말라고 한다. 그 이름은 TRAP 테스트로 호환성을 확인한 구현을 위한 것이다.
그래서 이 번역의 배너는 `This is METAFONT, Version 2.71828182 (GWEB)`이다.
