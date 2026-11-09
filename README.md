# METAFONT: 한글 GWEB 판

도널드 커누스(Donald E. Knuth)의 글꼴 설계 프로그램 METAFONT의 문학적 프로그램 `mf.web`(판 2.71828182)을
한글과 Go로 옮긴 것이다. 원본은 영어 설명과 Pascal 코드로 되어 있는데, 이 번역은 설명을 한글로,
코드를 Go로 바꾸어 GWEB(Go로 쓰는 WEB)의 `.w` 파일 하나(`mf.w`)에 담았다.
같은 방식으로 옮긴 TeX(`tex-the-program`)의 짝이다.

옮긴 목적은 METAFONT의 알고리즘들과 동작 원리를 온전히 이해하는 것이다. 그래서 원본에 될 수 있는 대로
충실하게 옮기고, 원본에 없는 그림을 26장 보탰다.

- 원본의 절, 절 이름, 프로시저와 변수 이름, 프로그램의 짜임새를 그대로 따른다.
  커누스의 책 *METAFONT: The Program*(Computers & Typesetting, Volume D)과 나란히 놓고 읽을 수 있다.
- 문서는 커누스가 처음부터 GWEB과 Go로 쓴 것처럼 서술했다. Pascal에만 해당하는 설명은 걷어 내고,
  Go로 옮기면서 달라진 점은 해당하는 절의 설명에 녹여 넣었다. METAFONT의 역사와 커누스의 농담은
  그대로 두었다.
- 그림은 MetaPost로 그려 문서에 바로 넣었다(luamplib). 존 호비의 조절점 고르기, 드 카스텔조 나누기와
  룩 움직임, 가장자리 구조, 팔분면, 다각형 펜과 포락선, 타원 펜, 교차 시각, 변수의 자료 구조,
  `pencircle`의 타원 복원, `subpath` 자르기, `doublepath`, TFM 치수 합치기(`skimp`), GF 부호화 따위다.
- 같은 `mf.w`에서 사람이 읽을 문서(`mf.pdf`, 약 920쪽)와 실제로 돌아가는 프로그램(`build/mf`)이
  함께 나온다. 이 프로그램은 진짜 METAFONT와 같은 TFM과 GF를 만들고, 커누스의 TRAP 테스트를 통과한다.
- 프로그램은 Go의 기능(고루틴, `unsafe`로 흉내 낸 공용체, 64비트 산술 따위)을 아낌없이 써서 빠르게
  했다(`mf.w`의 2절). 알고리즘은 그대로이고, 출력은 원본을 충실히 옮긴 판(꼬리표 `faithful`)과 바이트까지
  같다. 글꼴 열 개를 세 번씩 읽는 벤치마크가 1.26초에서 0.70초쯤으로 줄어, TeX Live의 `mf-nowin`(0.79초)보다
  빠르다.

## 파일

| 파일 | 내용 |
| --- | --- |
| `mf.w` | 번역 본문. 모든 것이 여기서 나온다 |
| `Makefile` | 빌드, 조판, 테스트 |
| `mf-deco.ch` | 쪽마다 액자를 두르는 바꿈 파일(`make deco`) |
| `decoframe.pdf` | `mf-deco.ch`가 쪽마다 까는 액자 그림 |
| `mf.bux` | 미니 색인판(`make twill`)에서 `mf.w`의 선언으로는 알 수 없는 이름들에 주는 뜻 |
| `lion.pdf` | 1절 끝, 그 쪽의 바닥에 붙이는 사자 그림 |
| `go.mod` | Go 모듈 정의 |
| `tests/trap.sh` | TRAP 테스트 |
| `tests/compare.sh` | 글꼴 몇 개를 진짜 METAFONT와 함께 만들어 TFM, GF, 기록 파일을 비교한다 |
| `tests/regress.sh` | 원본을 충실히 옮긴 판(`faithful`)의 METAFONT와 출력이 바이트까지 같은지 본다 |
| `tests/fuzz/` | `faithful` 판의 METAFONT와 견주는 차등 퍼징 |
| `tests/pgo.sh` | 프로파일 기반 최적화에 쓰는 `default.pgo`를 만든다 |
| `default.pgo` | `go build`가 읽는 CPU 프로파일 |
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
보태기도 했다. 그래서 절 번호가 원본과 어긋난다(원본 1215절, 번역 1383절). 원본이나
*METAFONT: The Program*과 맞추어 볼 때는 절 이름(`orig/names.tsv`)과 찾아보기를 쓰면 된다.
`names.tsv`는 두 판의 절 코드에 나오는 식별자를 견주어 순서대로 짝지은 것이라, 번역에서 합치거나 새로
만든 절은 빠져 있다. 마지막 부인 찾아보기에서는 식별자와 오류 메시지가 쓰인 모든 절을 찾을 수 있고,
``bugs'' 항목에는 이 번역에서 찾은 원본의 문제들이 모여 있다.

같은 `mf.w`로 모양이 다른 판을 세 가지 더 만들 수 있다. 어느 것을 만들어도 `mf.pdf`는 그대로다.

- `make deco`(`mf-deco.pdf`): 바꿈 파일 `mf-deco.ch`로 쪽마다 액자(`decoframe.pdf`)를 두른다.
- `make twill`(`mf-twill.pdf`): 커누스가 TWILL로 *TeX: The Program*을 찍은 방식을 따라, 펼친 두 쪽마다
  그 쪽에 나오는 식별자가 어디서 정의되었는지 알려 주는 미니 색인을 붙인다. gweave 대신
  [gtwill](https://github.com/sjnam/gtwill)로 조판하고, 선언에서 읽어 낼 수 없는 이름의 뜻은
  `mf.bux`에서 얻는다. `mf.bux`의 절 번호는 `mf.w`의 절이 늘거나 줄면 함께 고쳐야 한다.
- `make twill-deco`(`mf-twill-deco.pdf`): 미니 색인과 액자를 함께 붙인다.

### 어디서부터 읽을까

커누스는 처음부터 차례로 읽기를 권한다. 앞부분에서 만든 도구를 뒤에서 쓰기 때문이다. 8절의
지도 그림(그림 1)이 전체의 흐름을 보여 준다. 처음 읽는다면 다음 순서가 무난하다.

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
- 변형 레코드 `memory_word`는 모든 변형을 8바이트에 겹쳐 놓은 구조체다. Go에는 공용체가 없으므로
  `unsafe`로 흉내 낸다. 진짜 필드는 `x.sc` 하나이고, 나머지는 `x.hh().rh`, `x.qqqq().b0()`처럼
  메서드로 꺼낸다.
- `init…tini`는 `if iniVersion {…}`, `stat…tats`는 `if stat {…}`, `debug…gubed`는 `if debug {…}`이다.
- `goto`는 되도록 `break`, `continue`, 레이블 붙은 반복문, `if`–`else`로 바꾸었다. 그렇게 바꾼 곳마다
  설명에 원본의 레이블이 어떻게 되었는지 적었다. 프로시저 바깥으로 가는 `goto endOfMF`나 `goto finalEnd`는
  `panic`이 되고, 주 프로그램이 `recover`로 받는다.
- 원본의 문자열 풀 파일(`MF.POOL`)은 없다. 메시지는 Go의 문자열 상수로 남아 그대로 찍히고,
  원본에서 문자열 번호로 쓰이던 상수들만 INIMF가 풀에 넣는다.
- 한 곳에서만 부르는 프로시저(원본에서 Pascal 컴파일러의 크기 제한 때문에 나눈 것 따위)는 이름 있는
  절로 끼워 넣었다. 커누스가 이름을 붙여 설명한 프로시저는 그대로 함수로 두었다.
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
- `make twill`에는 [gtwill](https://github.com/sjnam/gtwill)과 `gtwill-refsort`, 매크로 `gtwimac.tex`를
  쓴다(gtwill 저장소에서 `make install`)
- `make pgo`는 리눅스가 아니면 [Docker](https://www.docker.com/)로 프로파일을 뜬다(아래 테스트)

```sh
make            # build/mf와 mf.pdf를 만든다
make build      # 프로그램만: mf.w → mf.go(gtangle) → build/mf(go build)
make pdf        # 문서만: mf.w → mf.tex(gweave) → mf.pdf(luatex 두 번, qpdf로 차례를 맨 앞에)
make check      # 조판 경고(Overfull, Underfull 따위)와 조용히 깨진 조판의 수를 센다. 둘 다 0이어야 한다
make base       # build/plain.base를 만든다(INIMF로 plain.mf를 읽고 dump, 아래 실행)
make compare    # 글꼴 몇 개를 진짜 METAFONT(mf-nowin)로 만든 것과 비교한다(아래 테스트)
make trap       # 커누스의 TRAP 테스트를 돌린다(아래 테스트)
make test       # make compare와 make trap을 함께 돌린다
make regress    # faithful 판의 METAFONT와 출력이 바이트까지 같은지 본다(아래 테스트)
make fuzz       # faithful 판의 METAFONT와 견주는 차등 퍼징(아래 테스트)
make pgo        # 프로파일 기반 최적화에 쓰는 default.pgo를 새로 만든다
make install    # mf 명령이 이 METAFONT를 부르게 한다(아래)
make uninstall  # make install로 설치한 것을 지운다
make deco       # 쪽마다 액자를 두른 판: mf.w + mf-deco.ch → mf-deco.pdf(mf.pdf는 그대로 둔다)
make twill      # 쪽마다 미니 색인을 붙인 판: mf.w + mf.bux → mf-twill.pdf(gtwill, luatex 세 번)
make twill-deco # 미니 색인과 액자를 함께 붙인 판: mf-twill-deco.pdf
make clean      # 만든 것을 모두 지운다
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

- **입력 파일**: 먼저 현재 디렉터리에서 찾는다. 없으면 환경 변수 `MFINPUTS`의 디렉터리들에서 찾는다.
  그래도 없으면 배포판의 파일 색인에서 찾는다.
- **배포판의 파일 색인**: METAFONT는 시작하자마자 고루틴을 띄워, `kpsewhich`에게서 `mf`의 검색 경로를
  받고 배포판의 파일 목록 데이터베이스(`ls-R`)를 여러 고루틴으로 나누어 읽는다. 그동안 METAFONT는
  기반을 읽고 일을 시작한다. 같은 이름이 검색 경로의 한 원소 안에 여럿 있거나 이름을 찾지 못하면
  그 이름만 `kpsewhich`에게 직접 묻는다. 그러니 고르는 파일은 늘 `kpsewhich`와 같다. 파일마다
  `kpsewhich`를 부르면 한 번에 0.1초쯤 드는데(그때마다 `ls-R`을 처음부터 읽는다), 이렇게 바꾸고
  나서 plain 기반을 만드는 데 0.11초 걸리던 것이 0.01초로, `cmr10`을 600dpi로 만드는 데 0.15초
  걸리던 것이 0.05초로 줄었다(TeX Live의 `mf-nowin`은 0.13초).
- **기반 파일**: `&plain`은 먼저 현재 디렉터리의 `plain.base`를 찾고, 없으면 `MFBASES`의 디렉터리들에서 찾는다.
  기반 파일의 형식은 이 프로그램의 것이어서 TeX Live의 `.base`와는 바꾸어 쓸 수 없다.
- **경로**: 원본은 `>`와 `:`로만 디렉터리를 가르지만, 이 번역은 `/`도 디렉터리 구분자로 알아본다.

화면 출력은 하지 않는다. `openwindow`와 `display`는 받아들이지만 아무것도 그리지 않는다.
오류가 나면 원본처럼 터미널에서 다음 동작을 묻는다. 대화가 필요 없을 때는 `batchmode`나 `nonstopmode`를
쓴다. 출력의 날짜는 원본의 `fixDateAndTime`처럼 늘 1776년 7월 4일 정오다. 그래서 같은 입력이면 언제
돌려도 같은 파일이 나온다.

### `mf` 명령으로 설치하기

```sh
make install                # ~/.local/bin/mf가 이 METAFONT를 부른다
make install PREFIX=~/opt   # 다른 곳에 설치한다
make uninstall              # 설치한 것을 지운다
```

`make install`은 실행 파일과 그것으로 만든 plain 기반을 `$PREFIX/share/gomf`에 두고, `$PREFIX/bin/mf`에는
`MFBASES`를 그 디렉터리로 놓고 실행 파일을 부르는 작은 스크립트를 둔다. 그래서 `&plain` 없이
`mf '\mode=lowres; input cmr10'`이라고만 해도 plain 기반을 읽는다. 이 기반은 TeX Live의 것과 형식이 달라
서로 읽을 수 없으므로 kpsewhich로 찾지 않는다. `MFBASES`는 TeX Live의 프로그램들도 쓰는 변수라서 셸 전체가
아니라 이 스크립트 안에서만 놓는다.

`$PREFIX/bin`이 PATH에서 TeX Live의 디렉터리(`/Library/TeX/texbin` 따위)보다 앞에 있어야 `mf`가 이것을
부른다. 설치한 뒤에는 셸에서 `hash -r`을 하고 `which mf`로 확인한다. 바뀌는 것은 `mf` 명령 하나뿐이고,
`mf-nowin`이나 `mpost` 같은 TeX Live의 다른 프로그램은 그대로다. 이 METAFONT는 TeX Live의
`-interaction=`이나 `-output-directory` 같은 옵션을 모른다. 맨 앞의 `-ini` 말고는 원본처럼 인자를 첫 입력
줄로 읽는다. `$PREFIX/bin/mf`가 이미 있는데 이 저장소가 설치한 것이 아니면, `make install`도
`make uninstall`도 그것을 건드리지 않고 멈춘다. 실행 파일을 새로 빌드하면 기반의 형식이 바뀌었을 수 있으니
`make install`을 다시 한다.

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

TRAP은 커누스가 METAFONT의 구현을 검증하려고 만든 "고문 테스트"다. `tests/trap.sh`는 *trapman.tex*
부록 A의 절차를 그대로 따른다.

1. 처음 한 번, 커누스가 배포한 테스트 파일(`trap.mf`, `trap.pl`, 그리고 결과 원본인 `trapin.log`,
   `trap.log`, `trap.72270gf` 따위)을 CTAN에서 `tests/trap/`로 받는다.
2. trapman이 요구하는 상수로 테스트용 INIMF를 만든다. `memTop=memMax=3000`, `errorLine=64`,
   `halfErrorLine=32`, `maxPrintLine=72`, `screenWidth=100`, `screenDepth=200`, `gfBufSize=8`이고,
   키워 둔 `bufSize`, `fileNameSize`, 하프워드는 처음 값으로 되돌린다. `debug`를 켜고, 화면 루틴이
   기록 파일에 쓰도록 `initScreen`이 참을 돌려주게 한다. `mf.w`에서 뽑은 `mf.go`만 바꾸므로 `mf.w`는
   건드리지 않는다.
3. 첫 실행(`\input trap`)으로 `trapin.log`를 만들고, 둘째 실행(` &trap  trap `)으로 `trap.log`,
   `trap.72270gf`, `trap.tfm`을 만든다.
4. GF를 `gftype`으로, TFM을 `tftopl`로 바꾸어 원본과 비교한다.

결과는 `build/trap/`에 남는다. **`trap.72270gf`는 커누스의 원본과 바이트 하나까지 같고, `trap.pl`과
`trap.typ`도 같다.** 남는 차이는 모두 trapman이 허용하는 것들이다.

| 파일 | 차이 | 까닭 |
| --- | --- | --- |
| 모든 로그 | 첫 줄 | 배너에 `(GWEB)`이 붙는다 |
| `trapin.log`, `trap.log` | 문자열 수와 남은 용량 | 원본은 프로그램의 모든 문자열을 풀에 넣는다(trapman 4(d)) |
| `*.fot` | `**` 뒤의 입력 | 원본은 터미널이 친 글자를 되비추지만, 여기서는 파이프로 입력한다 |

`trap.typ`은 TeX Live의 `gftype`이 trapman이 말하는 ``보통''의 상수보다 큰 그림을 보이므로, 원본
GF도 같은 `gftype`으로 풀어서 비교한다.

### 원본을 충실히 옮긴 판과 견주기

```sh
make regress                # make trap을 돌린 뒤 tests/regress.sh -t
tests/regress.sh            # 시간은 재지 않는다
make regress BASE=main      # 다른 가지나 커밋과 견준다(tests/regress.sh라면 BASE=main tests/regress.sh)
```

이 프로그램은 처음에 원본에 충실하게 옮긴 뒤, `go-native` 가지에서 Go의 기능을 아낌없이 써서 빠르게 하고
본줄기에 합친 것이다(`mf.w`의 2절). 조건은 출력이 한 바이트도 달라지지 않는 것이고, 앞으로 고칠 때도
그렇다. 합치기 전의 충실한 판에는 꼬리표 `faithful`을 붙여 두었다. `tests/regress.sh`는 그 커밋의 `mf.w`로
기준 METAFONT를 따로 만들고, 두 프로그램으로 같은 작업을 돌려 남긴 파일을 모두 바이트 그대로 견준다.
TRAP 테스트의 결과, plain 기반을 만들 때의 기록, 글꼴 열한 개를 200dpi와 600dpi로 만든 GF와
TFM과 기록 파일, `cmr10`을 2000dpi로 만든 것, 글꼴 열 개를 한 작업에서 세 번씩 읽어 4007자를 만드는 벤치마크(`big`), 모든 추적을
켠 작업, 입력 버퍼가 넘치는 작업, 오류 100개로 그만두는 작업이다. `-t`를 주면 걸린 시간도 견준다.

### 차등 퍼징

```sh
make fuzz                   # 1분 동안 (FUZZTIME=10m 따위로 바꿀 수 있다)
go test ./tests/fuzz        # 씨앗 입력만(make fuzz로 두 실행 파일을 먼저 만들어 두어야 한다)
```

`tests/fuzz`는 Go의 퍼징으로 METAFONT 입력을 만들어, `faithful` 판의 `mf.w`로 만든
METAFONT(`build/ref-faithful/mf`)와 지금의 METAFONT에 함께 넣는다. `make fuzz BASE=main`처럼 기준을 바꿀
수도 있다. 그리고 터미널 출력과 남긴 파일(GF, TFM, 기록 파일)이 바이트까지 같은지
본다. METAFONT는 한 프로세스에서 되풀이해 돌릴 수 없으므로 입력마다 실행 파일을 띄운다. macOS에서는
`sandbox-exec`로 가두어, 무작위 입력이 작업 디렉터리 밖에 파일을 쓰지 못하게 한다. 다른 결과가 나오면 그
입력이 `tests/fuzz/testdata/fuzz/FuzzSame/`에 남는다. 두 실행 파일은 환경 변수 `MFOURS`와 `MFREF`로
바꿀 수 있고, 기본값은 `build/mf`와 `build/ref-faithful/mf`다. 실행 파일이 없으면 테스트는 건너뛴다.

### 프로파일 기반 최적화

```sh
make pgo                    # tests/pgo.sh: default.pgo를 새로 만든다
MFCPUPROFILE=cpu.pprof build/mf '&plain \mode=lowres; input cmr10'   # 아무 작업이나 CPU 프로파일을 뜬다
```

저장소 맨 위의 `default.pgo`는 Go 컴파일러의 프로파일 기반 최적화(PGO)에 쓰는 CPU 프로파일이다.
`go build`가 저절로 읽는다. `tests/pgo.sh`는 plain 기반을 만들 때와 벤치마크(`big`)를 돌릴 때의
프로파일을 합쳐 이 파일을 만든다. 코드를 크게 고친 뒤에는 다시 만들어 두는 것이 좋다. macOS에서는
Go의 CPU 프로파일러가 표본을 마지막 시스템 호출에 잘못 붙이므로, 리눅스가 아니면 도커 컨테이너
안에서 프로파일을 뜬다.

## 저작권과 이름

원본 `mf.web`의 저작권은 커누스에게 있다(1984). 원본 머리말은 원본을 고치는 것을 허락하되,
고친 파일의 이름이 `mf.web`이 아니어야 한다고 정해 두었다. 이 번역은 `mf.w`라는 별개의 파일이다.
TeX은 미국 수학회의 상표이고, METAFONT는 Addison-Wesley 출판사의 상표다.

원본 §2는 프로그램을 고치면 어느 판인지 알 수 있도록 배너를 바꾸라고 하고, 고친 시스템은 그냥
‘METAFONT’라고 부르지 말라고 한다. 그 이름은 TRAP 테스트로 호환성을 확인한 구현을 위한 것이다.
그래서 이 번역의 배너는 `This is METAFONT, Version 2.71828182 (GWEB)`이다.
