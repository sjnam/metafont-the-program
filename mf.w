% 이 파일은 크누스의 mf.web(Version 2.71828182, 2021)을 한글 GWEB(Go)로
% 옮긴 것이다. 원본 mf.web (C) 1984 Donald E. Knuth.
% 원본의 조건(``고친 파일은 mf.web이라는 이름을 달아서는 안 된다'')에 따라
% 이 파일은 mf.web이 아니며, 크누스의 METAFONT 꾸러미의 일부가 아니다.
% 손대지 않은 원본은 CTAN의 systems/knuth/dist/mf/mf.web에 있다.
% TeX은 미국 수학회의 상표이고, METAFONT는 Addison-Wesley 출판사의 상표다.

\input kotexgweb

% 조판에 쓰는 매크로들
\def\hang{\hangindent 3em\noindent\ignorespaces}
\def\textindent#1{\hangindent2.5em\noindent\hbox to2.5em{\hss#1 }\ignorespaces}
\def\pct!{{\char`\%}} % 본문의 퍼센트 기호
\def\psqrt#1{\sqrt{\mathstrut#1}}
\def\k{_{k+1}}
\font\tenlogo=logo10 % METAFONT 로고에 쓰는 글꼴
\font\logos=logosl10
\font\eightlogo=logo8
\def\MF{{\tenlogo META}\-{\tenlogo FONT}}
\def\<#1>{$\langle#1\rangle$}
\def\section{\mathhexbox278}
\let\swap=\leftrightarrow
\def\round{\mathop{\rm round}\nolimits}
\def\(#1){} % 절 이름이 잘 정렬되도록 쓴다
\def\yskip{\vskip3pt plus1pt}
\def\PASCAL{Pascal}
\def\AT!{@@} % 매크로 이름의 `\.{\AT!}'
\chardef\AM=`\& % 앰퍼샌드 문자
% 절 번호 참조. 절의 TeX 파트 첫머리에 \seclabel{이름}을 두면, 다른 곳의
% \secref{이름}이 `\S번호'로 바뀌어 그 절에 연결된다. 이름과 번호의 대응은
% \jobname.ref에 적어 두었다가 다음 조판에서 읽으므로 조판을 두 번 해야 한다.
% 절을 쪼개거나 끼워 넣어 번호가 바뀌어도 참조는 저절로 따라간다.
\def\secmap#1#2{\expandafter\gdef\csname sec:#1\endcsname{#2}}
\openin1=\jobname.ref
\ifeof1 \else \closein1 \input \jobname.ref \fi
\newwrite\secrefout
\immediate\openout\secrefout=\jobname.ref
\def\seclabel#1{\immediate\write\secrefout{\string\secmap{#1}{\cursec}}\ignorespaces}
\def\secref#1{\expandafter\ifx\csname sec:#1\endcsname\relax
    \S??\else\S\SN{\csname sec:#1\endcsname}\fi}
\let\GWEBM=\M
\def\M#1{\GWEBM{#1}\def\cursec{#1}}
\let\GWEBN=\N
\def\N#1#2#3{\GWEBN{#1}{#2}{#3}\def\cursec{#2}}

% 그림은 luamplib으로 조판 중에 그린다. 그림들이 함께 쓰는 도우미는 여기서 한 번 정의한다.
\input luamplib.sty
\font\eighttt=cmtt8
\mplibcodeinherit{enable}
\mplibcode
bboxmargin := 3pt;
% 그림 pic을 중심이 c에 오도록 옮긴다
vardef placed(expr pic, c) = pic shifted (c - center pic) enddef;
% 상자에 든 글을 그리고 그 그림을 돌려준다
vardef boxed(expr pic, c) =
  save q; picture q; q := placed(pic, c); draw q; draw bbox q; q
enddef;
vardef westof(expr q) = (xpart llcorner bbox q, ypart center q) enddef;
vardef eastof(expr q) = (xpart lrcorner bbox q, ypart center q) enddef;
vardef northof(expr q) = (xpart center q, ypart ulcorner bbox q) enddef;
vardef southof(expr q) = (xpart center q, ypart llcorner bbox q) enddef;
% 점 z에 작은 검은 원을 찍는다
def dot(expr z) = fill fullcircle scaled 3pt shifted z enddef;
% 점 z에 작은 흰 원을 찍는다
def odot(expr z) = unfill fullcircle scaled 3.4pt shifted z;
  draw fullcircle scaled 3.4pt shifted z withpen pencircle scaled .4pt enddef;
% 중심 c, 반지름 r로 각 a에서 각 b까지 가는 호
vardef anglearc(expr c, a, b, r) =
  for t = 0 step .125 until .9: (c + r*dir(a + t*(b-a))) .. endfor (c + r*dir b)
enddef;
\endmplibcode

\def\title{\MF}
% 차례는 문서 맨 끝에 찍히는데, Makefile이 qpdf로 그것을 맨 앞으로 옮긴다.
% 차례가 몇 쪽이 되든 옮길 수 있도록, 차례 앞에 이미 내보낸 쪽 수를 로그에 적어 둔다.
\def\topofcontents{\immediate\write-1{TOC begins after page
    \directlua{tex.sprint(status.total_pages)}}%
  \null\vfill
  \font\titlelogo=logo10 scaled 1653 % 대문자 높이를 \titlefont(9.92pt)에 맞춘다
  \centerline{\titlefont {\titlelogo METAFONT}: The Program}
  \vskip 15pt
  \centerline{도널드 크누스의 \MF\ 프로그램을 한글 \.{GWEB}으로 옮김}
  \vfill}
\def\botofcontents{\vfill
  \ninepoint\baselineskip12pt
  \noindent 원본 \copyright\ 1984 Donald E. Knuth
  \bigskip\noindent
  크누스의 원본 파일 \.{mf.web}은 고치지 않는 한 얼마든지 복사하고 배포할 수 있다.
  고친 파일은 이름이 \.{mf.web}이 아닐 때에만 허용된다.
  \bigskip\noindent
  이 문서는 그 조건에 따라 원본을 한글과 \GO/로 옮긴 것이며,
  크누스의 \MF\ 꾸러미의 일부가 아니다. 손대지 않은 원본은
  {\tt https://mirrors.ctan.org/systems/knuth/dist/mf/mf.web}에서
  받을 수 있다. 번역에 잘못이 있다면 그것은 옮긴이의
  탓이지 크누스의 탓이 아니다.
  \bigskip\noindent
  \TeX은 미국 수학회의 상표이고, \MF는 Addison-Wesley 출판사의 상표다.}

% gweave가 형으로 알아보지 못하는 이름들.
@s bufio.Reader int
@s bufio.Writer int
@s os.File int

@* 들어가며.
이것은 \MF, 곧 품질 높은 활자꼴을 만들어 내려는 글꼴 컴파일러다.
뒤따르는 \GO/ 프로그램은 \MF84의 정의다. \MF84는 \MF의 표준판으로서,
@^METAFONT84@>
이식성이 아주 높도록 설계되어 매우 다양한 컴퓨터에서 똑같은 출력을 얻을 수 있다.
\MF84의 관례는 \TeX82의 관례와 같다.

다음 프로그램의 주된 목적은 \MF의 알고리즘을 될 수 있는 대로 명료하게 설명하는
데 있다. 그 결과로, 컴파일러가 이 프로그램을 특정한 기계어로 옮겼을 때 아주
효율적이지는 않을 수도 있다. 그러나 이 프로그램은 비교적 적은 수의
변경만으로 매우 다양한 운영 환경에서 효율적으로 돌아가도록 조율할 수 있게 쓰였다.
이런 유연성이 가능한 것은 뒤따르는 문서가 \.{GWEB}으로 쓰였기 때문이다. \.{GWEB}의
이름 있는 절과 변경 파일을 쓰면, 필요한 다듬기를 대부분 프로그램 본문에 손대지
않고 넣을 수 있다. 다른 언어로 반자동 번역하는 것도 가능한데, 아래의
프로그램은 \GO/에만 있는 특이한 기능을 그리 많이 쓰지 않기 때문이다.

\MF\ 같은 큰 소프트웨어에는 일정한 수준 아래로는 줄일 수 없는 본질적인 복잡성이
있다. 비록 낱낱의 부분은 그 자체로는 꽤 단순하더라도 말이다. \.{GWEB}은
프로그램의 낱낱의 조각들이 서로 맞물리는 방식을 드러내고, 서로 다른 부분을 잇는
상호 참조를 제공함으로써 알고리즘을 될 수 있는 대로 읽기 쉽게 하려는 것이다.
무슨 일이 일어나고 있는지, 그리고 왜 어떤 일을 어떤 방식으로 했는지에 대한 자세한
설명을 프로그램 곳곳에 넉넉히 뿌려 두었다. 이 설명들은 구현의 특징을 밝히지만,
\MF\ 언어 자체를 설명하려 드는 일은 드물다. 독자는 {\sl The {\logos METAFONT\/}book}에
익숙하다고 여기기 때문이다.
@.GWEB@>
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>

\par\vfill\noindent
\saveimageresource height 1.5in {metalion.pdf}\useimageresource\lastsavedimageresourceindex

@ 지금의 구현은 오랜 내력을 지니고 있다. 그것은 1977년 봄, 저자가 첫 Computer Modern
글꼴들을 개발하는 데 쓴 서브루틴과 매크로의 원형을 짠 데서 시작되었다.
@^Knuth, Donald Ervin@>
이 원조 \MF는 글자 하나를 고칠 때마다 사용자가 {\mc SAIL} 프로그램을 다시
컴파일해야 했다. 그것은 글꼴 설계를 위한 ``언어''가 아니었기 때문이다. 언어는
{\mc SAIL}이었다. 그런 식으로 수백 개의 글자를 설계한 뒤, 저자는 \MF라고 부르는
해석 가능한 언어를 개발했다. 이 언어로는 Computer Modern 프로그램들을 덜 암호처럼
나타낼 수 있었다. 완전한 \MF\ 처리기는 1979년에 저자가 설계하고 짰다. {\mc SAIL}로
쓴 이 프로그램을 레오 기바스와 라일 램쇼와 데이비드 퍽스가 여러 가지 조판 장비와
화면 단말기에 맞게 고쳐 썼다.
@^Guibas, Leonidas Ioannis@>
@^Ramshaw, Lyle Harold@>
@^Fuchs, David Raymond@>
1982년 봄에 Computer Modern 글꼴의 설계가 크게 나아졌는데, 그 뒤로 새 언어가
글자꼴 설계자의 요구를 더 잘 나타낼 것이 분명해졌다. 그래서 1984년에 완전히 새로운
\MF\ 언어와 시스템을 개발했다. 지금의 시스템은 \MF79의 이름과 정신의 일부를
이어받았지만, 세부는 모두 바뀌었다.

의심할 것 없이 아직도 고칠 여지는 많지만, 저자는 이제부터 \MF84를 ``동결''해
두기로 굳게 마음먹었다. 안정성과 신뢰성이 이 프로그램의 주된 미덕이 될 것이다.

한편 \.{GWEB} 서술은 \MF84 자체의 핵심을 바꾸지 않고도 확장할 수 있으며, 이
프로그램은 그런 확장이 그리 어렵지 않도록 설계되었다. 여기서 정의하는 문자열
|banner|는 \MF에 어떤 수정이든 가해질 때마다 바꾸어야 한다. 그래야 문제가 생겼을
때 어느 판의 \MF가 범인인지 분명해진다.
@^extensions to \MF@>
@^system dependencies@>

이 프로그램을 고친다면 그 결과로 생긴 시스템을 `\MF\kern.5pt'라고 불러서는 안 된다.
`\MF\kern.5pt'라는 공식 이름은 서로 완전히 호환되는 소프트웨어 시스템을 위해 남겨 둔
것이다. 어떤 구현이 `\MF\kern.5pt'라고 불릴 자격이 있는지 판정하는 데 도움을 주는
``\.{TRAP} 시험''이라는 특별한 시험 묶음이 있다[스탠퍼드 대학교 전산학과 보고서
CS1095, 1986년 1월 참조].

이 판은 크누스의 판 2.71828182(2021년 1월)를 옮긴 것이다. 크누스는 원본 머리에
``남아 있는 버그를 처음 찾는 사람에게 \$327.68을 주겠다''고 적어 두었다. \$327.68은
$2^{15}$센트다. \TeX의 상금이 판마다 두 배로 늘다가 \$327.68에서 멈춘 것과 같은
값이다.
@^reward@>

@<정의@>=
const banner = "This is METAFONT, Version 2.71828182 (GWEB)" // \MF가 시작할 때 찍는다

@ \seclabel{conventions}이 프로그램은 \GO/로 쓰였다. \GO/에는 공식 명세가 하나 있고 그것을 따르는
컴파일러를 거의 모든 시스템에서 쓸 수 있으므로, 컴파일러마다 다른 관례에 맞추느라
애쓸 일은 많지 않다. 그래도 운영체제와 주고받는 부분, 이를테면 파일을 찾아 열거나
터미널과 대화하는 부분은 시스템마다 다를 수밖에 없다. 그렇게 시스템에 따라 고쳐야
할지도 모르는 부분은, 찾아보기에서 `system dependencies' 항목에 적힌 번호의 절들을
보면 알 수 있다.
@^system dependencies@>

아래의 \MF\ 프로그램은 \GO/의 훌륭한 기능을 다 쓰지는 않는다. 대부분의 고급 언어에
있는 기능만 쓰려고 애썼으므로, 코드의 대부분을 다른 언어로 기계적으로 옮길 수 있다.
예컨대 메서드와 맵은 쓰지 않았고, 슬라이스와 인터페이스(|any|)는 운영체제와 주고받는 곳과
찍기 프로시저의 인자 같은 몇 곳에서만 쓴다. 동시에 도는 고루틴은 사용자의 끼어들기 신호를
받는 한 곳에서만 쓴다. 자료 구조는 모두 크기가 정해진 배열 몇 개
안에 들어 있고, 포인터는 그 배열의 첨자일 뿐이다. 실수(|float64|)는 한 번도 쓰지 않는다.
\MF가 하는 계산은 모두 고정 소수점 정수 산술이므로, 어느 컴퓨터에서나 비트 하나까지
같은 결과가 나온다. 이 밖에 프로그램 전체에 걸친 관례는 다음과 같다.
\smallskip
\item{$\bullet$} 식별자에는 \GO/의 관례대로 낙타 등 표기(|getNext|)를 쓴다. 여러 낱말로 된
이름은 둘째 낱말부터 첫 글자를 대문자로 쓰고, |endOfMF|의 \MF처럼 머리글자말은 대문자로
둔다. 이름이 \GO/의 예약어와 겹치면 다른 이름을 쓴다. 이를테면 노드의 |type| 필드를 읽는
함수는 |typ|이다.
\item{$\bullet$} 전역 변수는 꾸러미 수준의 변수이고, 프로시저와 함수는 모두 \GO/의
함수다. 한 곳에서만 불리는 프로시저도 프로그램의 짜임새를 드러내려고 따로 둔 것이
많다.
\item{$\bullet$} 메모리의 필드를 가리키는 이름, 이를테면 |link(p)|는 그 값을 읽는
함수다. 값을 바꿀 때는 짝이 되는 함수 |setLink(p,q)|를 부른다.
\item{$\bullet$} \.{GWEB}의 \.{@@d}는 코드를 만들지 않으므로, 상수와 작은 함수의 정의는
이름 있는 절 |@<정의@>|에 모은다. 어떤 함수의 안쪽 코드를 이루는 절에 정의가 따라
나오면, 그 정의는 바로 뒤의 절에 따로 둔다.
\item{$\bullet$} |goto|는 \GO/가 허용하는 한 그대로 쓴다. 함수 바깥으로 뛰어야 할 때는
|panic|과 |recover|로 흉내 낸다.
\smallskip\noindent
그 밖의 관례, 이를테면 자료형과 문자열을 다루는 방식은 그것이 처음 나오는 곳에서
설명한다.

@ 프로그램은 보통의 \GO/ 꾸러미 머리, 곧 |package| 선언과 |import| 목록으로 시작하고,
나머지 구성 요소들은 나중에 \.{GWEB}의 관례에 따라 채워진다.
@.GWEB@>
이를테면 아래에서 `|@<전역 변수@>|'라고 부르는 프로그램 부분은 변수 선언들의 나열로
바뀔 것이고, 그 나열은 이 문서의 \secref{globals}에서 시작한다. 이런 방법으로 우리는 낱낱의 전역
변수를 그것이 무엇을 뜻하는지 이해할 준비가 되었을 때 정의할 수 있다. 모든 전역 변수를
한꺼번에 정의할 필요가 없는 것이다. 원한다면 \secref{globals}의 끝에 ``이 코드는 \dots절에도
정의되어 있다''라고 나오는 상호 참조를 따라가서 전역 변수 전체를 볼 수도 있다. 프로그램 머리의 다른
부분들에도 비슷한 이야기가 들어맞는다.

\GO/에서는 꾸러미 수준의 선언 순서가 자유로우므로, 무엇이든 쓰기 전에 미리 선언해
둘 필요가 없다. 그래서 프로시저와 함수는 모두 이름 있는 절 |@<함수들@>|에 모아
여기서 한꺼번에 끼워 넣는다. 주 프로그램은 \GO/의 |main| 함수다(\secref{main}).

@c
package main

import (
	"bufio"
	"fmt"
	"io"
	"io/fs"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"strings"
)

@<전역 레이블@>
@<전역 상수@>
@<전역 형@>
@<전역 변수@>
@<정의@>

func initialize() { // 이 프로시저는 일이 제대로 시작되게 한다
	@<초기화를 위한 지역 변수@>
	@<\MF가 건드릴 만한 것은 무엇이든 초기화한다@>
}

@<기본 인쇄 프로시저@>
@<오류 처리 프로시저@>
@<함수들@>

@ 전체 \MF\ 프로그램은 방금 보인 머리로 시작하고, 그 뒤에 프로시저 선언과 함수
선언이 한 무더기 온다. 마지막으로 우리는 `|startHere|'라는 주석으로 시작하는 주
프로그램에 이르게 될 것이다. 지금 바로 주 프로그램으로 건너뛰고 싶다면 찾아보기에서
`|startHere|'를 찾으면 된다. 그러나 이 프로그램을 이해하는 가장 좋은 방법으로 저자가
권하는 것은, 지금 읽고 있는 \.{GWEB} 서술에 나오는 \MF의 구성 요소들의 순서를 대체로
따라가는 것이다. 지금의 순서는 조금 복잡한 시스템을 이해하는 문제에 대해 ``상향식''과
``하향식'' 접근법의 장점을 함께 살리려고 짠 것이기 때문이다.

@ \seclabel{map}처음 읽는 이를 위해 지도를 하나 그려 두자. \MF가 하는 일은 크게 둘로 나뉜다. 하나는
\TeX과 거의 같은 방식으로 입력을 읽어 토큰으로 바꾸고, 매크로와 조건문과 루프를 펼치고,
식과 문장을 구문 분석해서 실행하는 ``언어 처리기''다. 다른 하나는 그렇게 실행한 명령들이
요구하는 기하 계산, 곧 경로를 매끄럽게 잇고, 펜으로 칠하고, 그 결과를 화소의 격자로
바꾸는 ``그림 처리기''다. 아래 그림은 입력 한 줄이 글꼴 파일이 되기까지 지나는 길과, 그 길에서
만나는 부들을 보인다.
$$\mplibcode
beginfig(1);
save inp, gn, ex, ps, st, ch, mv, ed, gf, tfm; picture inp, gn, ex, ps, st, ch, mv, ed, gf, tfm;
inp := boxed(btex \vbox{\halign{\hfil#\hfil\cr 입력 파일\cr}} etex, (0,0));
gn := boxed(btex \vbox{\halign{\hfil#\hfil\cr 토큰 얻기\cr \ID{getNext}\cr 31--33부\cr}} etex, (105pt,0));
ex := boxed(btex \vbox{\halign{\hfil#\hfil\cr 펼치기\cr \ID{expand}\cr 34--37부\cr}} etex, (210pt,0));
ps := boxed(btex \vbox{\halign{\hfil#\hfil\cr 식 분석\cr \ID{scanExpression}\cr 39--42부\cr}} etex, (325pt,0));
st := boxed(btex \vbox{\halign{\hfil#\hfil\cr 문장 실행\cr \ID{doStatement}\cr 43--44부\cr}} etex, (325pt,-80pt));
ch := boxed(btex \vbox{\halign{\hfil#\hfil\cr 조절점 고르기\cr \ID{makeChoices}\cr 17--18부\cr}} etex, (210pt,-80pt));
mv := boxed(btex \vbox{\halign{\hfil#\hfil\cr 팔분면과 펜\cr \ID{makeSpec}, \ID{fillEnvelope}\cr 19--25부\cr}} etex, (80pt,-80pt));
ed := boxed(btex \vbox{\halign{\hfil#\hfil\cr 가장자리 구조\cr (그림 값)\cr 20부\cr}} etex, (80pt,-160pt));
gf := boxed(btex \vbox{\halign{\hfil#\hfil\cr \.{GF} 파일\cr 46--47부\cr}} etex, (230pt,-160pt));
tfm := boxed(btex \vbox{\halign{\hfil#\hfil\cr \.{TFM} 파일\cr 45부\cr}} etex, (325pt,-160pt));
drawarrow eastof(inp) -- westof(gn);
drawarrow eastof(gn) -- westof(ex);
drawarrow eastof(ex) -- westof(ps);
drawarrow (xpart northof(ex), ypart northof(ex)){up} .. {down}(xpart northof(gn), ypart northof(gn))
  dashed evenly;
label.top(btex \ninepoint 펼친 토큰 목록 etex, 1/2[northof(gn),northof(ex)] + (0,16pt));
drawarrow southof(ps) -- northof(st);
drawarrow westof(st) -- eastof(ch);
label.top(btex \ninepoint 경로 etex, 1/2[westof(st),eastof(ch)]);
drawarrow westof(ch) -- eastof(mv);
drawarrow southof(mv) -- northof(ed);
drawarrow eastof(ed) -- westof(gf);
label.top(btex \ninepoint \KW{shipout} etex, 1/2[eastof(ed),westof(gf)]);
drawarrow southof(st) -- northof(tfm);
label.rt(btex \ninepoint 글꼴 정보 etex, 1/2[southof(st),northof(tfm)]);
endfig;
\endmplibcode$$
언어 처리기의 앞쪽 절반(30--38부)은 \TeX의 같은 부분과 아주 닮았다. 그러나 \MF는 \TeX과
달리 매크로뿐 아니라 {\it 식\/}을 다루므로, 그 뒤에 수치와 쌍과 경로와 펜과 그림을 값으로
갖는 식을 분석하는 커다란 부분(39--42부)이 온다. 식의 값이 알려지지 않은 변수를 담고 있으면
일차 방정식의 체계를 풀어야 하는데, 그 일은 28--29부가 맡는다.

그림 처리기는 이 프로그램에서 가장 \MF다운 부분이다. 사용자가 `\.{draw}'나 `\.{fill}'을
쓰면 먼저 경로의 조절점을 고르고(18부), 경로를 여덟 팔분면으로 쪼갠 다음(21부), 각 조각을
화소 사이의 ``움직임''으로 바꾼다(19부). 펜으로 그을 때는 펜의 모양을 경로에 겹쳐 그 둘레를
계산한다(23--25부). 그 결과는 모두 가장자리 구조(20부)에 쌓이고, 이것이 \MF의 그림 값이다.
\KW{shipout}을 하면 그림이 \.{GF} 파일로 나가고(47부), 작업이 끝나면 모은 글꼴 정보가
\.{TFM} 파일로 나간다(45부). 그 밑에는 고정 소수점 산술(7--8부)과 메모리(9--11부)와 해시
표(13부)처럼 모든 부분이 함께 쓰는 도구가 깔려 있다.

@ \seclabel{outer-labels}주 프로그램에는 레이블이 세 개 있다. 그 가운데 |endOfMF|와 |finalEnd|로는 다른
프로시저 안에서도 뛰어든다(\secref{first-line}, \secref{jump-out}). 그러나 \GO/의 |goto|는 함수 바깥으로 뛸
수 없으므로, 그런 곳에서는 레이블을 값으로 삼아 |panic|을 일으키고, 주 프로그램이
그것을 |recover|로 받아서 해당하는 곳으로 간다. 그 값의 형이 |outerLabel|이다.
\GO/에서 레이블 이름과 보통 식별자 이름은 서로 다른 이름 공간에 있으므로, 주 프로그램
안의 레이블 |endOfMF|와 상수 |endOfMF|는 부딪치지 않는다.

@<전역 레이블@>=
type outerLabel int32 // 주 프로그램의 레이블로 가는 |panic|의 값

const (
	startOfMF outerLabel = 1    // \MF의 변수들이 초기화되면 여기로 간다
	endOfMF   outerLabel = 9998 // 파일을 닫고 우아하게 끝낼 때 여기로 간다
	finalEnd  outerLabel = 9999 // 이 레이블은 프로그램의 끝을 표시한다
)

@ 아래 코드의 일부는 \MF를 설치할 때 이따금 생기는 이상한 행동을 진단할 때나, 시스템
마법사들이 자기가 무엇을 하는지 잘 모르면서 \MF를 만지작거릴 때에만 쓰려는 것이다.
이런 코드는 `|if debug {|$\,\ldots\,$|}|'로 둘러싸여 있다. 불 상수 |debug|는 보통 때에는
거짓이고, 상수 조건의 |if| 문은 \GO/ 컴파일러가 아예 없애 주므로 이런 코드는 컴파일되지
않는 것과 같다.

마찬가지로 `|if stat {|$\,\ldots\,$|}|'로 둘러싼 조건부 코드도 있는데, 이것은 \MF의
메모리 사용에 관한 통계를 모을 때 쓰려는 것이다. 이 코드는 $\\{tracingedges}>1$일 때
찍는 특별한 진단 정보도 구현하므로, 보통은 넣어서 컴파일한다. 그래서 |stat|은 참으로 둔다.
@^debugging@>

@<정의@>=
const (
	debug = false // 디버깅할 때 |true|로 바꾼다
	stat  = true  // 사용 통계를 모으지 않으려면 |false|로 바꾼다
)

@ \seclabel{inimf}이 프로그램에는 중요한 변형이 둘 있다. (1)~\.{INIMF}라는 길고 느린 판은 \MF의
@.INIMF@>
내부 표를 초기화하는 데 필요한 여분의 계산을 한다. (2)~짧고 빠른 실무용 판은
초기화를 최소한으로 줄인다. 여기서는 프로그램 하나가 두 노릇을 다 한다. 불 변수
|iniVersion|이 참이면 (1)이고, (1)에는 필요하지만 (2)에는 필요 없는 부분은
`|if iniVersion {|$\,\ldots\,$|}|'로 둘러싼다. 이 변수는 주 프로그램이 명령줄을 보고
정한다(\secref{main}).

@<\MF가 건드릴...@>=
@<핵심 변수들의 초깃값을 정한다@>
if iniVersion {
	@<표의 항목들을 초기화한다(\.{INIMF}만 한다)@>
}

@ @<정의@>=
var iniVersion bool // 이것이 \.{INIMF}인가?

@ 이 프로그램은 디버깅할 때와 실무에 쓸 때 컴파일하는 방식을 달리할 필요가 없다.
\GO/는 배열 첨자의 범위를 언제나 검사하고, 정수 산술의 넘침은 결코 잡지 않는다
(넘친 값은 조용히 감긴다). 범위 검사는 디버깅에 큰 도움이 되고 실무에서도 그리
비싸지 않다. 넘침을 잡지 못하는 것은 크게 걱정할 일이 아닌데, \MF\ 자신이 넘칠 만한
곳마다 미리 검사하기 때문이다.
@^system dependencies@>
@^overflow in arithmetic@>

@ 이 \MF\ 구현은 \GO/ 언어 명세의 규칙을 따른다. 다만 쓸모 있는 시스템 프로그램을
만드는 데 필요한 시스템 의존 코드는 예외다.
@^system dependencies@>
\MF의 |switch| 문에는 맞는 레이블이 없을 때 적용되는 기본 경우 |default|가 자주
나온다. \GO/의 |switch|는 맞는 경우 하나만 실행하고 끝나며(다음 경우로 저절로
넘어가지 않는다), 맞는 레이블도 |default|도 없으면 아무 일도 하지 않고 지나간다.
기본 경우 장치가 없는 언어로 이 프로그램을 옮긴다면, \MF의 |switch| 문은 나머지 경우를
모두 늘어놓도록 힘들게 늘려야 할 것이다. 그런 언어에 갇힌 사람들은 실제로 그렇게
해냈다. 성공적이었지만 즐겁지는 않았다!

@ 다음 매개변수들은 \MF의 용량을 늘리거나 줄이도록 컴파일할 때 바꿀 수 있다.
\.{INIMF}와 실무용 \MF에서 값이 서로 다를 수 있다.
@.INIMF@>
@^system dependencies@>

프로그램 하나가 \.{INIMF}와 실무용 판을 겸하므로(\secref{inimf}), 아래 주석에 적은 조건 가운데
\.{INIMF}의 것을 늘 지켜야 한다. 곧 |memMax|는 |memTop|과 같아야 한다.

줄 버퍼의 크기 |bufSize|는 처음에 500이었고 파일 이름의 길이 |fileNameSize|는 40이었지만
여기서는 키웠다. 요즘에는 500자보다 긴 줄이나 40자보다 긴 경로 이름이 드물지 않기
때문이다. 메모리의 크기 |memMax|도 처음에는 30000이었는데, 이 값으로는 오늘날의 보통
해상도(600\,dpi)에서 \.{cmr10}을 만드는 데에도 빠듯하다(28175낱말이 든다). 그래서 하프워드를
넓히고(\secref{max-halfword}) 메모리를 백만 낱말로 키웠다. 다만 \.{TRAP} 테스트는 처음의 값을
요구하므로 테스트용 \.{INIMF}를 만들 때 되돌린다.

@<전역 상수@>=
const (
	@!memMax = 1000000 // \MF의 내부 배열 |mem|의 가장 큰 첨자;
	@t\qquad@>// |maxHalfword|보다 엄격히 작아야 한다;
	@t\qquad@>// \.{INIMF}에서는 |memTop|과 같아야 하고, 그 밖에는 |>=memTop|
	@!maxInternal = 100 // 내부 양의 최대 개수
	@!bufSize = 20000 // 열린 파일들의 현재 줄에 동시에 들어 있는 문자 수의 최댓값;
	@t\qquad@>// |maxHalfword|를 넘으면 안 된다
	@!errorLine = 72 // 터미널 오류 메시지의 문맥 줄의 너비
	@!halfErrorLine = 42 // 터미널 오류 메시지에서 문맥 첫 줄의 너비;
	@t\qquad@>// 30과 |errorLine-15| 사이여야 한다
	@!maxPrintLine = 79 // 출력하는 텍스트 줄의 가장 긴 너비; 적어도 60이어야 한다
	@!screenWidth = 768 // 화면 표시의 각 행에 있는 화소 수
	@!screenDepth = 1024 // 화면 표시의 각 열에 있는 화소 수
	@!stackSize = 30 // 동시에 열려 있는 입력원의 최대 개수
	@!maxStrings = 2000 // 문자열의 최대 개수; |maxHalfword|를 넘으면 안 된다
	@!stringVacancies = 8000 // \MF\ 자신의 문자열들을 저장한 뒤에 사용자의
	@t\qquad@>// 식별자 이름과 문자열을 위해 남아 있어야 할 문자 수의 최솟값
	@!poolSize = 32000 // 문자열들에 든 문자 수의 최댓값; 모든 식별자의 이름을
	@t\qquad@>// 포함한다; |stringVacancies|보다 \MF\ 자신의 문자열들의 전체 길이만큼 커야 한다
	@!moveSize = 5000 // 한 팔분면 안의 움직임을 저장하는 공간
	@!maxWiggle = 300 // 한 순환 경로에서 자동 반올림하는 점의 개수
	@!gfBufSize = 800 // 출력 버퍼의 크기; 8의 배수여야 한다
	@!fileNameSize = 1024 // 파일 이름은 이보다 길면 안 된다
	@!pathSize = 300 // 경로의 꺾인 점 사이에 있는 매듭의 최대 개수
	@!bistackSize = 785 // 이분법 알고리즘을 위한 스택의 크기;
	@t\qquad@>// 아마 이 값 그대로 두는 것이 좋을 것이다
	@!headerSize = 100 // \.{TFM} 머리 낱말의 최대 개수의 네 배
	@!ligTableSize = 5000 // 합자와 커닝 단계의 최대 개수; 적어도 255,
	@t\qquad@>// 많아야 32510이어야 한다
	@!maxKerns = 500 // 서로 다른 커닝 양의 최대 개수
	@!maxFontDimen = 50 // \KW{fontdimen} 매개변수의 최대 개수
)

@ 앞의 매개변수들과 마찬가지로 다음 값들도 \MF의 용량을 늘리거나 줄이도록 컴파일할 때
바꿀 수 있다. 그러나 이것들을 바꾸면 초기화 프로그램 \.{INIMF}를 다시 돌려서 실무용
@.INIMF@>
\MF\ 프로그램을 위한 새 표를 만들어야 한다. 다음 상수들을 함부로 이리저리 바꿀 수는
없는데, 꽤 복잡한 초기화 수치 몇몇이 이것들로부터 계산되기 때문이다. 이 구별을
강조하려고, 여기서는 이것들을 |@<전역 상수@>|에 넣지 않고 |@<정의@>|에 따로 둔다.

@<정의@>=
const (
	@!memMin = 0 // |mem| 배열의 가장 작은 첨자; |minHalfword|보다 작으면 안 된다
	@!memTop = 1000000 // \.{INIMF}가 내보내는 |mem| 배열의 가장 큰 첨자;
	@t\qquad@>// |memMin|보다 상당히 커야 하고 |memMax|보다 크면 안 된다
	@!hashSize = 2100 // 기호 토큰의 최대 개수;
	@t\qquad@>// |maxHalfword-3*paramSize|보다 작아야 한다
	@!hashPrime = 1777 // |hashSize|의 약 85\pct!에 해당하는 소수
	@!maxInOpen = 6 // 동시에 진행할 수 있는 입력 파일과 오류 삽입의 최대 개수
	@!paramSize = 150 // 동시에 쓰이는 매크로 매개변수의 최대 개수
)
@^system dependencies@>

@ \seclabel{globals}누군가 실수로 ``상수''를 잘못 정했을 때에 대비해서, \MF는 |bad|라는 전역 변수를
써서 그것들을 검사한다.

이것은 \MF에서 전역 변수를 정의하는 수많은 절 가운데 첫 번째다.

@<전역 변수@>=
var @!bad int32 // 어떤 ``상수''가 잘못되었나?

@ 나중에 우리는 `|if memMax>=maxHalfword {bad=10}|'와 같은 말을 할
것이다. (상수 |maxHalfword|를 정의하기 전까지는 그렇게 할 수 없다.)

@<``상수'' 값들이 서로 맞는지 검사한다@>=
bad = 0
if halfErrorLine < 30 || halfErrorLine > errorLine-15 {
	bad = 1
}
if maxPrintLine < 60 {
	bad = 2
}
if gfBufSize%8 != 0 {
	bad = 3
}
if memMin+1100 > memTop {
	bad = 4
}
if hashPrime > hashSize {
	bad = 5
}
if headerSize%4 != 0 {
	bad = 6
}
if ligTableSize < 255 || ligTableSize > 32510 {
	bad = 7
}

@ \seclabel{labels}가끔 나오는 |goto| 문의 뜻이 잘 통하도록, 레이블에는 하는 일이 드러나는 이름을
붙인다. 레이블 `|restart|'는 가끔 프로시저의 맨 앞에서 쓰이고, 레이블 `|reswitch|'는
가끔 |switch| 문 바로 앞에서 쓰인다. 어떤 경우가 조건을 바꾼 다음 다른 경우로 넘어가야
할 때다. 루프는 흔히 `|done|'이나 `|found|'나 `|notFound|'로 가서 빠져나오고, 가끔은
`|again|'으로 가서 되풀이된다. 서브루틴의 둘 이상의 부분이 서로 다르게
시작하지만 같게 끝난다면, 그 공통 코드는 `|commonEnding|'에 모아 둘 수 있다.
루프 몸체의 나머지를 건너뛰고 다음 차례로 가는 것은 \GO/의 |continue| 문이 하므로, 그런
레이블은 따로 두지 않는다. 프로시저를 끝낼 때는 대개 그냥 |return|하지만, 끝내기 전에
할 일이 남아 있는 프로시저에서는 그 일 바로 앞에 레이블 `|exit|'를 두고 그리로 간다.
여러 단계로 겹친 루프를 빠져나오는 레이블은 |done1|, |done2|, \dots처럼 번호를 붙인다.

덧붙여 말하면, 이 프로그램은 실제로 쓰지 않는 레이블을 결코 선언하지 않는다.
\GO/ 컴파일러는 쓰지 않는 레이블을 오류로 다루기 때문이다.

@ 흔한 프로그래밍 관용구는 \GO/에 다 있다. 변수를 1만큼 늘리고 줄이는 것은 |x++|와
|x--|, 부호를 바꾸는 것은 |x=-x|, 두 배로 하는 것은 |x+=x|,
|goto|가 일어날 때까지 끝없이 되풀이하는 것은
`|for {|$\,\ldots\,$|}|', 프로시저 호출을 끝내는 것은 |return|이다. 다만 정수의 절댓값을
구하는 함수 |abs|와 홀수인지 판정하는 함수 |odd|는 \GO/에 없으므로 여기서 만든다.

@<정의@>=
func abs(x int32) int32 {
	if x < 0 {
		return -x
	}
	return x
}

func odd(x int32) bool { return x%2 != 0 }

@* 문자 집합.
\MF를 매우 다양한 컴퓨터에 쉽게 옮겨 갈 수 있도록, 모든 입력 텍스트는 표준
{\mc ASCII}(``American Standard Code for Information Interchange'')를 포함하는 내부
8비트 코드로 바뀐다. 이 변환은 각 문자를 읽어 들이는 즉시 이루어진다. 거꾸로, 문자는
텍스트 파일로 출력되기 바로 전에 {\mc ASCII}에서 사용자의 외부 표현으로 바뀐다.
@^ASCII code@>

이런 내부 코드가 \MF\ 사용자와 관계가 있는 것은 \KW{char}와 \KW{ASCII} 연산, 그리고
문자열의 비교에서뿐이다.

@ \seclabel{ascii-code}\MF의 내부 형태로 바뀐 텍스트 문자의 형을 |asciiCode|라고 한다. 이것은 정수의
부분 범위, 곧 0부터 255까지의 정수다.

이 프로그램은 \MF가 쓰는 정수 형을 거의 모두 |int32|의 별칭으로 삼는다. 바이트 한
개짜리 형(|uint8|)으로 하면 메모리는 아끼지만, 정수 형끼리 섞어 쓰는 곳마다 형
변환을 넣어야 하기 때문이다. 별칭(|type asciiCode = int32|)은 새 형이 아니라 같은 형의
다른 이름이므로 다른 정수와 자유롭게 섞인다. 그 대신 값이 범위 안에 있는지는 형이
아니라 프로그램이 지켜야 한다.

@<전역 형@>=
type @!asciiCode = int32 // 8비트 수

@ 지금의 \MF\ 명세는 텍스트 파일이 64개보다 많은 문자를 구별할 수 있다고 가정하고
쓰였다. 더 정확히 말하면, 문자 집합에는 적어도 {\mc ASCII} 코드 \.{'40}부터
\.{'176}까지에 해당하는 글자와 기호가 있다고 가정한다. 이 문자들은 이제 대부분의
컴퓨터 터미널에서 쓸 수 있다. 물론 대문자와 소문자를 둘 다 편리하게 다룰 수 있어야
하는데, 글꼴을 설계하는 프로그램이라면 더욱 그렇다.

입력할 때 |asciiCode|로 바뀌고 출력할 때 |asciiCode|에서 바뀌는 문자들의 자료형을
|textChar|라고 부르기로 한다. \GO/에서 텍스트 파일의 문자는 바이트이므로 |textChar|는
|byte|의 별칭이고, 그 원소의 서수는 |firstTextChar|부터 |lastTextChar|까지다.
시스템에 따라서는 다음 정의를 고쳐야 할 수도 있다.
@^system dependencies@>

@<정의@>=
type textChar = byte // 텍스트 파일의 문자의 자료형

const (
	firstTextChar = 0   // |textChar|의 가장 작은 원소의 서수
	lastTextChar  = 255 // |textChar|의 가장 큰 원소의 서수
)

@ 초기화 함수 |initialize|에는 여러 곳에서 쓰는 지역 변수 |i|가 있다.

@<초기화를 위한 지역 변수@>=
var @!i int32

@ \MF\ 처리기는 배열 |xord|와 |xchr|를 써서
{\mc ASCII} 코드와 사용자의 외부 문자 집합 사이를 오간다.

@<전역 변수@>=
var @!xord [256]asciiCode // 입력 문자의 변환을 지정한다
var @!xchr [256]textChar  // 출력 문자의 변환을 지정한다

@ 우리는 시스템이 표준 {\mc ASCII}의 보이는 문자들을 읽고 쓸 수 있다고
가정하고 있다(그것을 나타내는 데 꼭 {\mc ASCII} 코드를 쓰지는 않더라도). 그러므로 다음
대입문들은 시스템에 따라 고칠 필요 없이 배열 |xchr|의 표준 부분을 제대로 초기화한다.
한편 \MF를 덜 완전한 문자 집합으로 구현할 수도 있는데, 그런 경우에는 여기서 무언가를
바꾸어야 할 것이다.
@^system dependencies@>

@<핵심 변수들의...@>=
xchr[0o40] = ' '; xchr[0o41] = '!'; xchr[0o42] = '"'; xchr[0o43] = '#'
xchr[0o44] = '$'; xchr[0o45] = '%'; xchr[0o46] = '&'; xchr[0o47] = '\''
xchr[0o50] = '('; xchr[0o51] = ')'; xchr[0o52] = '*'; xchr[0o53] = '+'
xchr[0o54] = ','; xchr[0o55] = '-'; xchr[0o56] = '.'; xchr[0o57] = '/'
xchr[0o60] = '0'; xchr[0o61] = '1'; xchr[0o62] = '2'; xchr[0o63] = '3'
xchr[0o64] = '4'; xchr[0o65] = '5'; xchr[0o66] = '6'; xchr[0o67] = '7'
xchr[0o70] = '8'; xchr[0o71] = '9'; xchr[0o72] = ':'; xchr[0o73] = ';'
xchr[0o74] = '<'; xchr[0o75] = '='; xchr[0o76] = '>'; xchr[0o77] = '?'
xchr[0o100] = '@@'; xchr[0o101] = 'A'; xchr[0o102] = 'B'; xchr[0o103] = 'C'
xchr[0o104] = 'D'; xchr[0o105] = 'E'; xchr[0o106] = 'F'; xchr[0o107] = 'G'
xchr[0o110] = 'H'; xchr[0o111] = 'I'; xchr[0o112] = 'J'; xchr[0o113] = 'K'
xchr[0o114] = 'L'; xchr[0o115] = 'M'; xchr[0o116] = 'N'; xchr[0o117] = 'O'
xchr[0o120] = 'P'; xchr[0o121] = 'Q'; xchr[0o122] = 'R'; xchr[0o123] = 'S'
xchr[0o124] = 'T'; xchr[0o125] = 'U'; xchr[0o126] = 'V'; xchr[0o127] = 'W'
xchr[0o130] = 'X'; xchr[0o131] = 'Y'; xchr[0o132] = 'Z'; xchr[0o133] = '['
xchr[0o134] = '\\'; xchr[0o135] = ']'; xchr[0o136] = '^'; xchr[0o137] = '_'
xchr[0o140] = '`'; xchr[0o141] = 'a'; xchr[0o142] = 'b'; xchr[0o143] = 'c'
xchr[0o144] = 'd'; xchr[0o145] = 'e'; xchr[0o146] = 'f'; xchr[0o147] = 'g'
xchr[0o150] = 'h'; xchr[0o151] = 'i'; xchr[0o152] = 'j'; xchr[0o153] = 'k'
xchr[0o154] = 'l'; xchr[0o155] = 'm'; xchr[0o156] = 'n'; xchr[0o157] = 'o'
xchr[0o160] = 'p'; xchr[0o161] = 'q'; xchr[0o162] = 'r'; xchr[0o163] = 's'
xchr[0o164] = 't'; xchr[0o165] = 'u'; xchr[0o166] = 'v'; xchr[0o167] = 'w'
xchr[0o170] = 'x'; xchr[0o171] = 'y'; xchr[0o172] = 'z'; xchr[0o173] = '{'
xchr[0o174] = '|'; xchr[0o175] = '}'; xchr[0o176] = '~'

@ {\mc ASCII} 코드는 어느 정도까지만 ``표준''이다. 많은 컴퓨터 시설에서는 94개보다
많은 인쇄 문자를 쉽게 쓸 수 있는 편이 낫다고 보았기 때문이다. 입출력 파일에 표준
{\mc ASCII} 코드만 나타나는 시스템에서 \MF를 쓴다면 |xchr[0 .. @'37]|에 어떤 코드를
넣든 별로 상관없지만, 가장 안전한 방침은 아래 코드처럼 모두 공백으로 두는 것이다.

그러나 |xchr|를 달리 정하면 확장 문자 집합을 가진 컴퓨터에서 \MF가 더 친절해져서,
사용자가 `\.{<>}' 대신 `\.^^Z' 같은 것을 칠 수 있게 된다. 확장 문자 집합을 가진
사람들은 코드를 마음대로 정해서, \MF\ 사용자가 입력 파일에 쓸 수 있는 문자는 무엇이든
그에 해당하는 |xchr|를 줄 수 있다. 그때는 \MF의 |charClass| 표도 알맞게 고쳐야 한다.
(\TeX과 달리 \MF에서는 범주 코드의 배정, 곧 |charClass|를 설치할 때 정해 두고 사용자가 바꾸지 못한다.)
그런 변경은 프로그램의 이식성을 떨어뜨리므로, 한다 해도 조심스럽게 해야 한다.
@^character set dependencies@>
@^system dependencies@>

@<핵심 변수들의...@>=
for i = 0; i <= 0o37; i++ {
	xchr[i] = ' '
}
for i = 0o177; i <= 0o377; i++ {
	xchr[i] = ' '
}

@ 다음의 시스템 독립 코드는 배열 |xord|가 |xchr|의 정보에 대한 알맞은 역을 담게 한다.
두 코드 |i<j<@'177|에 대해 |xchr[i]=xchr[j]|이면 |xord[xchr[i]]|의 값은 |j| 이상이 된다는 데
주목하라. 그러므로 우연히 겹칠 때에는 \.{'40}보다 작은 코드 대신 표준 {\mc ASCII} 코드
번호가 쓰인다.

@<핵심 변수들의...@>=
for i = firstTextChar; i <= lastTextChar; i++ {
	xord[textChar(i)] = 0o177
}
for i = 0o200; i <= 0o377; i++ {
	xord[xchr[i]] = i
}
for i = 0; i <= 0o176; i++ {
	xord[xchr[i]] = i
}

@* 입력과 출력.
이식성의 골칫거리는 운영체제마다 입력과 출력을 아주 다르게 다룬다는 사실이다. 아마
전산학자들이 이 문제에 충분한 관심을 기울이지 않았기 때문일 것이다. 사람들은 어쩐지
입력과 출력이 ``진짜'' 프로그래밍의 일부가 아니라고 느껴 왔다. 하기야 어떤 종류의
프로그래밍이 다른 것보다 더 재미있는 것은 사실이다. 지금의 입출력 관례들이 이토록 다양하고
이토록 지저분하니, 코드의 이런 부분에서 기쁨을 얻는 길은 프로그램을 그렇지 않았을 때보다
조금이나마 덜 나쁘게 만드는 방법을 찾아내는 드문 경우뿐이다. 우리에게는 두 가지 선택이
있다. 입출력에 지금 덤벼들어 끝내 버리든지, 입출력을 끝 무렵까지 미루든지. 어느 쪽도 그리
끌리지 않으니, 끝내 버리기로 하자.

우리가 해야 할 기본 연산은 다음과 같다. (1)~파일이나 사용자의 터미널로부터 텍스트를
입력하고 그곳으로 텍스트를 출력한다. (2)~파일로부터 8비트 바이트를 입력하고 파일로 8비트
바이트를 출력한다. (3)~운영체제에 지정된 파일에 대한 입력이나 출력을 시작하라(``열라'')
또는 끝내라(``닫으라'')고 지시한다. (4)~입력 파일의 끝에 이르렀는지 검사한다.
(5)~사용자의 화면에 비트들을 보인다. 비트를 보이는 연산은 나중의 부에서 다룰 것이고,
여기서는 더 전통적인 종류의 입출력만 다룬다.

\MF는 두 종류의 파일을 다루어야 한다. 텍스트 자료를 담은 파일은 |alphaFile|이라고 부르고,
8비트 이진 정보를 담은 파일은 |byteFile|이라고 부르기로 한다. 많은 컴퓨터에서 이 두 형은
같은 것이지만 때로는 중요한 차이가 있으므로, 우리는 둘을 조심스럽게 구별할 것이다. 이런
파일을 고속 망을 통해 컴퓨터에서 컴퓨터로 옮기는 표준 규약을 이제 점점 더 많은 사용자 집단이
쓸 수 있게 되었다.

이 프로그램은 실은 세 번째 종류의 파일도 쓴다. 그것을 |wordFile|이라고 부르는데, 프로그램이
자기 초기화에 쓸 기반 정보(base)를 내보냈다가 다시 읽어 들이는 데 쓴다. 낱말 파일은 나중에
정의하겠지만, 그 전에도 낱말 파일에 대한 간단한 연산들은 지정할 수 있을 것이다.

\GO/에서 파일은 운영체제의 파일 |os.File|에 버퍼를 둔 읽기 객체와 쓰기 객체를 묶은
구조체로 나타낸다. 파일을 인자로 받는 프로시저에는 파일을 가리키는 포인터를 넘긴다.
\MF는 이진 파일을 쓰기만 하고 읽지는 않는다(\.{TFM} 파일과 \.{GF} 파일을 만들 뿐이다).

@<전역 형@>=
type @!eightBits = int32 // 부호 없는 한 바이트짜리 양
type @!alphaFile struct { // 텍스트 자료를 담은 파일
	f *os.File
	r *bufio.Reader
	w *bufio.Writer
}
type @!byteFile struct { // 이진 자료를 담은 파일
	f *os.File
	w *bufio.Writer
}

@ 입력과 출력에 관해 해야 할 일의 대부분은 \GO/의 표준 꾸러미 |os|와 |bufio|로 처리할
수 있다. 파일 변수를 실행 중에 정해지는 파일 이름과 연결할 수 있다는 것이 우리의
목적에 결정적이다. 우리는 외부 이름이 |nameOfFile|로 지정된 파일을 실행 시스템이 열
수 있다고 가정한다. 이 배열은 다른 문자 배열과 마찬가지로 첨자 1부터 쓴다.
@^system dependencies@>

@<전역 변수@>=
var @!nameOfFile [fileNameSize + 1]textChar // 첨자는 |1 .. fileNameSize|
var @!nameLength int32 // |nameOfFile|에서 실제로 뜻이 있는 문자의 수(나머지는 공백)

@ 파일을 열 때 \GO/의 |os.Open|과 |os.Create|는 무언가 잘못되었더라도 운영체제의 오류
메시지를 내지 않고 오류 값을 돌려준다. 지정한 이름의 파일을 찾을 수 없거나 다른 까닭으로
열 수 없으면(이를테면 누군가 같은 파일에 쓰려 하고 있을 수도 있다) 그 값이 |nil|이 아니므로,
\MF는 알맞은 바로잡기 조치를 할 수 있다.
@^system dependencies@>

\MF의 파일 여는 프로시저들은 |nameOfFile|이 가리키는 파일을 열 수 없으면 |false|를
돌려준다. 파일의 외부 이름은 곧 뒤에서 정의하는 함수 |externalName|이 |nameOfFile|로부터
만든다. 낱말 파일의 형 |wordFile|은 \secref{memory-word}에서 정의한다.

@<함수들@>=
func aOpenIn(f *alphaFile) bool { // 텍스트 파일을 입력용으로 연다
	file, err := os.Open(externalName())
	if err != nil {
		return false
	}
	*f = alphaFile{f: file, r: bufio.NewReader(file)}
	return true
}

func aOpenOut(f *alphaFile) bool { // 텍스트 파일을 출력용으로 연다
	file, err := os.Create(externalName())
	if err != nil {
		return false
	}
	*f = alphaFile{f: file, w: bufio.NewWriter(file)}
	return true
}


@ @<함수들@>=
func bOpenOut(f *byteFile) bool { // 이진 파일을 출력용으로 연다
	file, err := os.Create(externalName())
	if err != nil {
		return false
	}
	*f = byteFile{f: file, w: bufio.NewWriter(file)}
	return true
}

func wOpenIn(f *wordFile) bool { // 낱말 파일을 입력용으로 연다
	file, err := os.Open(externalName())
	if err != nil {
		return false
	}
	*f = wordFile{f: file, r: bufio.NewReader(file)}
	wGet(f) // 첫 원소를 |f.buf|에 읽어 둔다
	return true
}


@ @<함수들@>=
func wOpenOut(f *wordFile) bool { // 낱말 파일을 출력용으로 연다
	file, err := os.Create(externalName())
	if err != nil {
		return false
	}
	*f = wordFile{f: file, w: bufio.NewWriter(file)}
	return true
}

@ \seclabel{external-name}\MF는 입력 파일을 찾지 못하면
그 이름 앞에 `\.{MFinputs:}'를 붙여 다시 찾고, 기반 파일의 이름에는 `\.{MFbases:}'를
붙인다(\secref{mf-area}, \secref{base-default}). 이것은 \MF84를 개발한 시스템에서 표준 파일들이
있는 곳을 가리키던 이름이다. 요즘의 시스템에서는 그런 이름이 뜻이 없으므로, 함수
|externalName|이 이 머리말을 알아보고 해당하는 파일을 찾아 준다. 먼저 환경 변수
\.{MFINPUTS}와 \.{MFBASES}에 쌍점으로 나누어 적은 디렉터리들을 차례로 뒤지고, 입력 파일은
거기서 찾지 못하면 \TeX\ 배포판의 \.{kpsewhich} 명령에 물어본다. 그러면 \.{plain.mf}나
\.{cmr10.mf} 같은 표준 파일들을 찾을 수 있다. 기반 파일은 구현마다 형식이 달라서 다른 \MF의
것을 읽을 수 없으므로 \.{kpsewhich}에 묻지 않는다. 찾지 못하면 머리말을 뗀 이름을
돌려주므로, 그런 파일이 현재 디렉터리에 있으면 그것이 열린다.

\.{kpsewhich}는 부를 때마다 배포판의 파일 목록을 처음부터 읽으므로 한 번에 0.1초쯤 걸린다.
그런데 \.{cmr10.mf} 하나가 \.{roman.mf}, \.{punct.mf}, \.{comlig.mf} 같은 파일을 열몇 개
읽으므로, 파일마다 물으면 계산은 0.05초면 끝나는 글꼴 하나에 1.4초가 걸린다. 그래서
\TeX을 옮길 때 글꼴 파일에 한 것처럼, \.{kpsewhich}에게는 입력 디렉터리의 목록만 한 번 받아서
처음 입력 파일을 찾을 때 그 디렉터리들을 훑어 이름에서 경로로 가는 표 |mfFiles|를 만든다.
목록의 순서대로 훑고 먼저 나온 것을 남기므로, 맨 앞의 현재 디렉터리가 이긴다. 표에 없는 파일만
\.{kpsewhich}에게 따로 묻는다. 그러면 \.{cmr10}을 만드는 데 0.2초가 채 들지 않는다.
@^system dependencies@>

@<함수들@>=
func externalName() string {
	nm := string(nameOfFile[1 : nameLength+1])
	for _, a := range [...]struct{ area, env string }{
		{"MFinputs:", "MFINPUTS"}, {"MFbases:", "MFBASES"}} {
		if rest, ok := strings.CutPrefix(nm, a.area); ok {
			nm = rest
			for _, dir := range filepath.SplitList(os.Getenv(a.env)) {
				if dir != "" {
					if _, err := os.Stat(filepath.Join(dir, nm)); err == nil {
						return filepath.Join(dir, nm)
					}
				}
			}
			if a.env == "MFINPUTS" {
				@<입력 디렉터리들을 훑어 표 |mfFiles|를 아직 안 만들었으면 만든다@>
				if p, ok := mfFiles[nm]; ok {
					return p
				}
				if out, err := exec.Command("kpsewhich", nm).Output(); err == nil {
					if p := strings.TrimSpace(string(out)); p != "" {
						return p
					}
				}
			}
			break
		}
	}
	return nm
}

@ 입력 디렉터리의 목록은 \.{kpsewhich -show-path=mf}가 쌍점으로 나누어 알려 준다. 끝이 `\.{//}'인
디렉터리는 그 아래를 모두 뒤지라는 뜻이고, 앞의 `\.{!!}'는 파일 목록 데이터베이스만 믿으라는
뜻인데, 여기서는 디스크를 직접 훑으므로 그냥 떼어 낸다. 배포판이 없어 목록이 비어도 표는 빈 채로
만들어지므로, 다시 훑으려 하지 않는다.

@<입력 디렉터리들을 훑어...@>=
if mfFiles == nil {
	mfFiles = map[string]string{}
	out, _ := exec.Command("kpsewhich", "-show-path=mf").Output()
	for _, dir := range filepath.SplitList(strings.TrimSpace(string(out))) {
		dir = strings.TrimPrefix(dir, "!!")
		deep := strings.HasSuffix(dir, "//")
		root := strings.TrimRight(dir, "/")
		if root == "" {
			continue
		}
		filepath.WalkDir(root, func(p string, e fs.DirEntry, err error) error {
			switch {
			case err != nil:
			case e.IsDir():
				if p != root && !deep {
					return filepath.SkipDir
				}
			default:
				if _, dup := mfFiles[e.Name()]; !dup {
					mfFiles[e.Name()] = p
				}
			}
			return nil
		})
	}
}

@ @<전역 변수@>=
var @!mfFiles map[string]string // 입력 파일 이름에서 경로로 가는 표

@ 파일은 루틴 |aClose|, |bClose|, |wClose|로 닫는다. 이 루틴들은 파일 |f|에 대한 입력이나 출력이 모두
@^system dependencies@>
끝났을 때 써야 한다. 그러면 나중에 |f|를 다시 열 수 있다. 또 |f|를 출력에 썼다면
닫는 연산은 해당하는 외부 파일이 사용자의 영역에 나타나서 읽힐 준비가 되게 한다.
여기서는 쓰기 버퍼를 비운 다음 파일을 닫는다.

이 프로시저들은 파일이 성공적으로 열리기 전에 닫히더라도 오류 메시지를 내면 안 된다.
그래서 열린 적이 없는 파일이면 아무 일도 하지 않는다.

@<함수들@>=
func aClose(f *alphaFile) { // 텍스트 파일을 닫는다
	if f.w != nil {
		f.w.Flush()
	}
	if f.f != nil {
		f.f.Close()
	}
	*f = alphaFile{}
}

func bClose(f *byteFile) { // 이진 파일을 닫는다
	if f.w != nil {
		f.w.Flush()
	}
	if f.f != nil {
		f.f.Close()
	}
	*f = byteFile{}
}

func wClose(f *wordFile) { // 낱말 파일을 닫는다
	if f.w != nil {
		f.w.Flush()
	}
	if f.f != nil {
		f.f.Close()
	}
	*f = wordFile{}
}

@ 이진 출력과 텍스트 출력은 간단한 루틴 몇 개로 할 수 있으므로 특별한
준비를 할 필요는 없다. 그러나 텍스트 입력은 |asciiCode| 값으로 바꾸어야 하기 때문에 더
어렵다. \MF의 관례는 효율적이어야 하고, 사용자의 운영 환경과 잘 어울려야 한다.

@ 텍스트 출력에는 프로시저 |write(f,@t$\ldots$@>)|와 |writeLn(f,@t$\ldots$@>)|를 쓴다.
이것들은 인자들을 텍스트 파일 |f|에 차례로 쓰고, |writeLn|은
끝에 줄바꿈을 덧붙인다. 인자는 문자열, 문자(|byte|), 정수일 수
있다. 정수는 꼭 필요한 만큼의 너비로 찍는다. 이진 파일에서는 |bPut(f,c)|가 바이트 |c|를
파일에 쓴다.

조심할 점이 하나 있다. \GO/의 작은따옴표 상수 |' '|는 문자가 아니라 정수(|rune|)이므로,
|write|에 넘기면 수로 찍힌다. 그래서 |write|에 넘기는 문자열 상수는 모두 큰따옴표로
쓴다.

@<함수들@>=
func write(f *alphaFile, xs ...any) {
	for _, x := range xs {
		switch x := x.(type) {
		case string:
			f.w.WriteString(x)
		case byte:
			f.w.WriteByte(x)
		case int:
			fmt.Fprint(f.w, x)
		case int32:
			fmt.Fprint(f.w, x)
		default:
			panic(fmt.Sprintf("write: %T", x))
		}
	}
}

func writeLn(f *alphaFile, xs ...any) {
	write(f, xs...)
	f.w.WriteByte('\n')
}

func bPut(f *byteFile, c eightBits) { // 바이트 하나를 쓴다
	f.w.WriteByte(byte(c))
}

@ 텍스트 파일의 입력은 |inputLn|이라는 루틴을 써서 한 번에 한 줄씩 읽는다. 이 함수는
|buffer|, |first|, |last|라는 전역 변수를 써서 정의하는데, 이 변수들은 나중에 자세히 설명하겠다.
지금으로서는 |buffer|가 |asciiCode| 값의 배열이고, |first|와 |last|가 이 배열의 첨자로서
텍스트 한 줄의 시작과 끝을 나타낸다는 것만 알면 된다.

@<전역 변수@>=
var @!buffer [bufSize + 1]asciiCode // 읽고 있는 문자들의 줄
var @!first int32 // |buffer|에서 쓰이지 않는 첫 위치
var @!last int32 // |buffer|에 방금 입력한 줄의 끝
var @!maxBufStack int32 // |buffer|에서 쓰인 가장 큰 첨자

@ 함수 |inputLn|은 지정된 파일의 다음 줄을 버퍼 배열의 쓸 수 있는 위치로 가져오고 |true|를
돌려준다. 다만 파일을 이미 다 읽었다면 |false|를 돌려주고 |last=first|로 놓는다. 일반적으로
파일의 다음 줄을 나타내는 |asciiCode| 수들은 |buffer[first]|, |buffer[first+1]|, \dots,
|buffer[last-1]|에 들어가고, 전역 변수 |last|는 |first|에 그 줄의 길이를 더한 값이 된다.
줄 끝의 공백들은 지운다. 그러므로 |last=first|이거나(이때 그 줄은 완전히 비어 있었다)
|buffer[last-1]!=" "|이다.
@^inner loop@>

그러나 |inputLn|의 보통 동작으로 |last>=bufSize|가 될 것 같으면 넘침 오류를 낸다. 이렇게
해서 \MF의 다른 부분들은 배열 |buffer|의 경계를 넘어설 걱정 없이 |buffer[last+1]|의 내용을
안전하게 들여다볼 수 있다. 함수 |inputLn|에 들어올 때는 언제나 |first<bufSize|라는 조건이
성립하므로, ``빈'' 줄을 위한 자리는 언제나 있다.

변수 |maxBufStack|은 지금의 작업을 해내려면 매개변수 |bufSize|가 얼마나 커야 하는지
추적하는 데 쓰이는데, 이것도 |inputLn|이 최신 상태로 유지한다.

매개변수 |bypassEoln|이 |true|면 |inputLn|은 줄의 첫 문자를 보기 전에 앞 줄의 끝 표시를
건너뛰어야 한다. 그러나 \GO/의 |bufio.Reader|로 읽을 때는 줄 끝 문자를 그 줄을 읽으면서
함께 읽어 버리는 편이 자연스럽다. 그러면 다음 줄을 읽기 전에 건너뛸 것이 없으므로, 이
프로그램에서는 이 매개변수가 쓰이지 않는다. 이 프로시저는 줄의 끝에 이르면 그 너머를
읽지 않는다. 그러므로 보통의 텍스트 파일만이 아니라 사용자의 터미널에서 입력을 얻는 데도
쓸 수 있다.

파일의 마지막 줄은 줄바꿈 문자로 끝나지 않을 수도 있는데, 그런 줄도 보통의 줄처럼
읽는다. 함수 |inputLn|이 |false|를 돌려주는 것은 파일의 끝에서 첫 바이트조차 읽지 못했을
때뿐이다.

@<함수들@>=
func inputLn(f *alphaFile, bypassEoln bool) bool { // 다음 줄을 입력하거나 |false|를 돌려준다
	last = first // 마태복음 19:30 참조
	c, err := f.r.ReadByte()
	if err != nil {
		return false
	}
	lastNonblank := first // 줄 끝의 공백을 지운 |last|
	for err == nil && c != '\n' {
		@<문자 |c|를 |buffer|에 넣고 다음 문자를 읽는다@>
	}
	last = lastNonblank
	return true
}

@ 앞 절의 안쪽 루프 몸체다. 함수 |inputLn|의 안쪽 루프는 \MF의 ``안쪽 루프''의
일부이므로(입력의 모든 문자가 여기를 지나 들어온다), 문자 배열 전체를 한꺼번에 읽어
들이는 특별한 루틴이 있다면 그것을 써서 시스템 부담을 줄이는 것이 현명하다. 이 코드는
해야 할 일을 보이려고 한 번에 한 바이트씩 읽지만, 시스템에 따라서는 대개 더 세밀한
조율이 가능하다.
@^system dependencies@>

@<문자 |c|를 |buffer|에...@>=
if last >= maxBufStack {
	maxBufStack = last + 1
	if maxBufStack == bufSize {
		@<입력 버퍼의 넘침을 알리고 그만둔다@>
	}
}
buffer[last] = xord[c]
c, err = f.r.ReadByte()
last++
if buffer[last-1] != ' ' {
	lastNonblank = last
}

@ 사용자의 터미널은 다른 텍스트 파일들과 본질적으로 똑같이 행동한다. 다만 입력과 출력에
모두 쓰인다는 점이 다르다. 터미널을 입력 파일로 볼 때는 파일 변수를 |termIn|이라고 부르고,
출력 파일로 볼 때는 |termOut|이라고 부른다.
@^system dependencies@>

@<전역 변수@>=
var @!termIn alphaFile // 입력 파일로서의 터미널
var @!termOut alphaFile // 출력 파일로서의 터미널

@ 터미널 파일들은 \GO/의 표준 입력과 표준 출력으로 연다.
@^system dependencies@>

@<정의@>=
func tOpenIn()  { termIn.r = bufio.NewReader(os.Stdin) }  // 터미널을 텍스트 입력용으로 연다
func tOpenOut() { termOut.w = bufio.NewWriter(os.Stdout) } // 터미널을 텍스트 출력용으로 연다

@ 사용자의 터미널에서는 입력과 출력이 뒤섞이므로 그 둘을 맞추어야 할 때가 있다. 이 목적에는
시스템에 따라 다른 프로시저 셋을 쓴다. 첫째인 |updateTerminal|은 지금까지 터미널에 출력한 것이 모두
실제로 컴퓨터의 내부 버퍼를 떠나 보내졌는지 확인하고 싶을 때 부른다. 둘째인
|clearTerminal|은 사용자가 미리 쳐 둔 입력을 모두 취소하고 싶을 때 부른다(곧 뜻밖의 오류
메시지를 낼 참이기 때문이다). 셋째인 |wakeUpTerminal|은 사용자가 운영체제에 어떤 지시를
해서 터미널을 꺼 두었다면 그것을 되살리기로 되어 있다. 첫째는 터미널의 출력 버퍼를 비우면
된다. 그러나 미리 쳐 둔 입력을 취소하거나 꺼 둔 터미널을 되살리는 이식성 있는 방법은
없으므로, 여기서는 뒤의 둘이 아무 일도 하지 않는다.
@^system dependencies@>

@<정의@>=
func updateTerminal() { termOut.w.Flush() } // 터미널 출력 버퍼를 비운다
func clearTerminal()  {}                    // 터미널 입력 버퍼를 비운다
func wakeUpTerminal() {}                    // 사용자가 출력을 막아 둔 것을 푼다

@ \seclabel{first-line}\MF\ 입력의 첫 줄을 사용자의 터미널에서 읽으려면 특별한 루틴이 필요하다. 이 줄이 다른
것은 기록 파일을 열기 전에 읽기 때문이다. 여기에는 일종의 ``닭이 먼저냐 달걀이 먼저냐''
문제가 있다. 사용자가 첫 줄에 `\.{input cmr10}'을 치거나, 그 줄이 부른 어떤 매크로가 그런
\.{input}을 하면 기록 파일의 이름은 `\.{cmr10.log}'가 된다. 그러나 터미널 입력의 첫 줄을
처리하는 동안 \.{input} 명령이 하나도 실행되지 않으면, 기록 파일은 기본 이름
`\.{mfput.log}'를 얻게 된다. (첫 \.{input} 명령 전에 첫 줄이 낸 오류 메시지는 기록
파일에 들어가지 않는다.)
@.mfput@>

첫 줄은 명령줄에서 올 수도 있다는 점에서 더욱 특별하다. 사용자가 `\.{mf cmr10}' 같은
명령줄을 쳐서 \MF\ 작업을 시작할 수 있으면 좋다. 그런 경우 \MF는 입력의 첫 줄이
`\.{cmr10}'인 것처럼, 곧 첫 줄이 명령줄에서 \MF를 부른 부분 뒤의 나머지인 것처럼 동작할 것이다.

첫 줄은 또 \MF가 기반 파일을 읽어 들이기 전에 읽힐 수도 있다는 점에서도 특별하다. 그런
경우에는 아직 보통의 오류 메시지를 낼 수 없다. 다음 코드는 나중에 설명할 개념들을 쓴다.
그런 경우에 프로그램을 조용히 끝낼 때는 |panic(finalEnd)|를 쓴다(\secref{outer-labels}).
@^system dependencies@>

@<입력 버퍼의 넘침을 알리고 그만둔다@>=
if baseIdent == 0 {
	writeLn(&termOut, "Buffer size exceeded!")
	panic(finalEnd)
@.Buffer size exceeded@>
} else {
	loc = first
	limit = last - 1
	overflow("buffer size", bufSize)
@:METAFONT capacity exceeded buffer size}{\quad buffer size@>
}

@ 시스템마다 시작하는 방법이 다르다. 그러나 어떤 관례를 받아들이든, 터미널을 초기화하는
루틴은 다음 명세를 만족해야 한다.

\yskip\textindent{1)}터미널로부터 입력받도록 파일 |termIn|을 연다. (파일 |termOut|은
이미 터미널로 출력하도록 열려 있을 것이다.)

\textindent{2)}사용자가 명령줄을 주었다면 그 줄을 터미널 입력의 첫 줄로 여긴다. 그렇지
않으면 사용자에게 `\.{**}'로 입력을 재촉하고, 그에 대한 대답으로 친 것을 입력의 첫 줄로
삼는다.

\textindent{3)}입력의 첫 줄은, 명령줄이든 아니든, 배열 |buffer|의 위치 |first|부터
|last-1|까지에 나타나야 한다.

\textindent{4)}전역 변수 |loc|은 \MF가 다음에 읽을 문자가 |buffer[loc]|에 있도록 정해야
한다. 이 문자는 공백이 아니어야 하고, |loc<last|여야 한다.

\yskip\noindent(공백이 아닌 줄이 들어올 때까지 사용자에게 여러 번 재촉해야 할 수도 있다.
재촉 기호가 나중의 `\.*' 대신 `\.{**}'인 것은 뜻이 조금 다르기 때문이다. `\.{**}' 바로 뒤에는
`\.{input}'을 치지 않아도 된다.)

변수 |loc|은 현재 입력 상태의 한 구성 요소인데, 나중에 정의할 다른 구성 요소들과 마찬가지로
전역 변수다(\secref{cur-input}).

@ \seclabel{init-terminal}다음 프로그램은 필요한 초기화를 한다. 명령줄의 인자는 |os.Args|로 얻는다. 인자가 있으면
그것들을 공백으로 이어 붙인 것을 첫 줄로 삼는다. 다만 첫 인자가 `\.{-ini}'면 그것은
\.{INIMF}로 돌라는 뜻이므로(\secref{main}) 첫 줄에 넣지 않는다. 이를테면
`\.{mf -ini plain dump}'라고 치면 첫 줄은 `\.{plain dump}'가 된다. 첫 줄이 버퍼에 다
들어가지 않으면 명령줄이 없는 것처럼 한다.
@^system dependencies@>

@<함수들@>=
func initTerminal() bool { // 터미널 입력을 시작한다
	tOpenIn()
	@<명령줄이 있으면 그것을 첫 줄로 삼고 |return true|@>
	for {
		wakeUpTerminal()
		write(&termOut, "**")
		updateTerminal()
@.**@>
		if !inputLn(&termIn, true) { // 이런 일은 일어나지 않아야 한다
			writeLn(&termOut)
			write(&termOut, "! End of file on the terminal... why?")
@.End of file on the terminal@>
			return false
		}
		loc = first
		for loc < last && buffer[loc] == ' ' {
			loc++
		}
		if loc < last {
			return true // 줄이 온통 공백이 아니면 돌아간다
		}
		writeLn(&termOut, "Please type the name of your input file.")
	}
}

@ 명령줄의 인자들을 공백으로 이어 붙여 버퍼의 |first|부터 넣는다. 그것이 온통 공백이
아니면 터미널에서 첫 줄을 받았을 때와 똑같이 |loc|을 정하고 |true|를 돌려준다.

@<명령줄이 있으면...@>=
args := os.Args[1:]
if len(args) > 0 && args[0] == "-ini" {
	args = args[1:]
}
if cmd := strings.Join(args, " "); len(cmd) > 0 && first+int32(len(cmd)) < bufSize {
	last = first
	for k := 0; k < len(cmd); k++ {
		buffer[last] = xord[cmd[k]]
		last++
	}
	for last > first && buffer[last-1] == ' ' { // |inputLn|처럼 줄 끝의 공백을 지운다
		last--
	}
	loc = first
	for loc < last && buffer[loc] == ' ' {
		loc++
	}
	if loc < last {
		return true
	}
}

@* 문자열 다루기.
기호 토큰의 이름과 진단 메시지는 8비트 문자들로 된 가변 길이 문자열이다. \MF는
프로그래밍 언어의 문자열 기능에 기대지 않고, 모든 문자열 처리를 손수 만든 방법으로 한다.

정교한 동적 문자열 기능은 필요 없으므로, 필요한 연산은 모두 간단한 자료 구조로 처리할 수
있다. 배열 |strPool|은 모든 문자열의 모든 (8비트) {\mc ASCII} 코드를 담고, 배열
|strStart|는 각 문자열의 시작점의 첨자를 담는다. 문자열은 정수 번호로 가리키므로, 문자열
번호 |s|는 |strStart[s]<=j<strStart[s+1]|인 문자 |strPool[j]|들로 이루어진다. 정수 변수
|poolPtr|과 |strPtr|은 각각 |strPool|과 |strStart|에서 지금까지 쓴 항목의 수를
나타낸다. 위치 |strPool[poolPtr]|와 |strStart[strPtr]|는 다음 문자열을 할당할 준비가
되어 있다.

문자열 번호 0부터 255까지는 {\mc ASCII} 문자 하나에 해당하는 문자열을 위해 남겨 둔다.
그래서 문자 하나짜리 문자열의 번호는 그 문자의 {\mc ASCII} 코드와 같다. 이를테면 문자열
번호 46은 아마 문자 하나 `\..'일 것이다. 그러나 어떤 {\mc ASCII} 코드에는 표준적인 보이는 표현이
없는데, \MF는 때로 임의의 {\mc ASCII} 문자를 찍을 수 있어야 하므로, 처음 256개의 문자열은
256가지 경우 각각에 대해 무엇을 찍어야 하는지 정확히 지정하는 데 쓴다.

배열 |strPool|의 원소는 실제로 찍을 수 있는 {\mc ASCII} 코드여야 한다. 곧 그 지역의 문자
집합에 |xchr| 등가물이 있어야 한다. (이 제약은 미리 실어 둔 문자열에만 적용되고, 사용자가
동적으로 만든 문자열에는 적용되지 않는다.)

배열 |strPool|의 원소는 바이트(|packedASCIICode|)이고 |asciiCode|는 |int32|이므로, 둘
사이를 오갈 때는 언제나 함수 |si|와 |so|를 거친다. 바이트를 부호 있는 수로만 다룰 수 있는
시스템이라도 이 두 함수만 고치면 되도록 하려는 것이다. 덤으로 \GO/의 형 검사가 이 둘을
빠짐없이 썼는지 하나하나 확인해 준다.
@^system dependencies@>

@<전역 형@>=
type @!poolPointer = int32 // |strPool|을 가리키는 변수를 위해; |0 .. poolSize|
type @!strNumber = int32 // |strStart|를 가리키는 변수를 위해; |0 .. maxStrings|
type @!packedASCIICode = uint8 // 배열 |strPool|의 원소

func si(c asciiCode) packedASCIICode { return packedASCIICode(c) } // |asciiCode|를 |packedASCIICode|로 바꾼다
func so(c packedASCIICode) asciiCode { return asciiCode(c) } // |packedASCIICode|를 |asciiCode|로 바꾼다

@ @<전역 변수@>=
var @!strPool [poolSize + 1]packedASCIICode // 문자들
var @!strStart [maxStrings + 1]poolPointer // 시작 포인터들
var @!poolPtr poolPointer // |strPool|에서 쓰이지 않는 첫 위치
var @!strPtr strNumber // 지금 만들고 있는 문자열의 번호
var @!initPoolPtr poolPointer // |poolPtr|의 처음 값
var @!initStrPtr strNumber // |strPtr|의 처음 값
var @!maxPoolPtr poolPointer // 지금까지 |poolPtr|의 가장 큰 값
var @!maxStrPtr strNumber // 지금까지 |strPtr|의 가장 큰 값

@ 기본적인 문자열 연산 가운데 몇몇은 아주 자주 쓰이므로 아주 짧은 함수로 만든다. \GO/
컴파일러는 이런 작은 함수를 부르는 곳에 펼쳐 넣으므로 프로시저 호출의 부담은 없다.
이를테면 다음은 문자열의 길이를 계산하는 간단한 함수다.

@<정의@>=
func length(s strNumber) int32 { return strStart[s+1] - strStart[s] } // 문자열 |s|의 문자 수

@ 현재 문자열의 길이는 |curLength|라고 부른다.

@<정의@>=
func curLength() int32 { return poolPtr - strStart[strPtr] }

@ 문자열은 문자 코드를 |strPool|에 덧붙여서 만든다. 여기서 정의하는 함수 |appendChar|는
|poolPtr|의 값이 너무 커졌는지 검사하지 않는다. 이 검사는 |appendChar|를 쓰기 전에 해야 한다.

배열 |strPool|에 문자를 |l|개 더 덧붙일 자리가 있는지 검사하려면 |strRoom(l)|이라고 쓴다. 자리가
없으면 이것은 사과하는 오류 메시지를 내고 \MF를 그만두게 한다. 지금까지 쓴 가장 큰 자리
|maxPoolPtr|도 이 함수가 기록한다.

@<정의@>=
func appendChar(c asciiCode) { // |asciiCode| |c|를 |strPool|의 끝에 넣는다
	strPool[poolPtr] = si(c)
	poolPtr++
}

func strRoom(l int32) { // 풀이 넘치지 않았는지 확인한다
	if poolPtr+l > maxPoolPtr {
		if poolPtr+l > poolSize {
			overflow("pool size", poolSize-initPoolPtr)
@:METAFONT capacity exceeded pool size}{\quad pool size@>
		}
		maxPoolPtr = poolPtr + l
	}
}

@ \MF의 문자열 식은 무지막지한 방식으로 구현된다. 새 문자열이나 부분 문자열이 필요할 때마다
그냥 문자열 풀에 베껴 넣는 것이다.

이런 방식이 정당한 것은 \MF\ 응용에서 문자열 식이 그리 대수롭지 않기 때문이다. 문자열을
한 문장에서 다음 문장까지 보관해야 하는 일은 드물다. 그래도 한 번만 쓰일 문자열들의 공간을
되찾으려 애쓰지 않는다면 공간을 쓸데없이 낭비할 것이다.

그래서 간단한 참조 횟수 장치를 둔다. 어떤 문자열을 프로그램의 다른 곳에서 가리키는 참조가
@^reference counts@>
없고, 그보다 나중에 만든 문자열을 가리키는 참조도 없으면, 그 문자열의 공간을 되찾는다.

문자열 번호 |s|를 가리키는 참조의 수는 |strRef[s]|다. 특별한 값 |strRef[s]=maxStrRef=127|은
참조의 수가 알 수 없는 양수라는 뜻이다. 그런 문자열은 결코 재활용되지 않는다. 어떤 문자열이
동시에 126번보다 많이 참조되면 그것을 이 부류에 넣는다. 그래서 각 |strRef|를 저장하는 데는
한 바이트면 충분하다.

@<정의@>=
const @!maxStrRef = 127 // ``무한한'' 참조 수

func addStrRef(s strNumber) { // 참조를 하나 더한다
	if strRef[s] < maxStrRef {
		strRef[s]++
	}
}

@ @<전역 변수@>=
var @!strRef [maxStrings + 1]int32 // 참조 횟수; |0 .. maxStrRef|

@ 문자열의 참조 하나가 사라질 때는 다음과 같이 한다. 마지막 참조가 사라진 문자열을 없애는
프로시저 |flushString|은, 그 문자열이 맨 위에 있지 않으면 참조 횟수를 0으로 표시만 해 둔다.
맨 위에 있으면 그 문자열과 함께, 그 아래에 쌓여 있는 참조 없는 문자열들도 한꺼번에 걷어 낸다.

@<정의@>=
func deleteStrRef(s strNumber) { // 참조를 하나 뺀다
	if strRef[s] < maxStrRef {
		if strRef[s] > 1 {
			strRef[s]--
		} else {
			flushString(s)
		}
	}
}

@ @<함수들@>=
func flushString(s strNumber) {
	if s < strPtr-1 {
		strRef[s] = 0
	} else {
		for {
			strPtr--
			if strRef[strPtr-1] != 0 {
				break
			}
		}
	}
	poolPtr = strStart[strPtr]
}

@ 일련의 문자들을 |strPool|에 덧붙이고 나면, 함수 |makeString|을 부를 때 그것이 정식으로
문자열이 된다. 이 함수는 새 문자열의 식별 번호를 값으로 돌려준다.

@<함수들@>=
func makeString() strNumber { // 현재 문자열이 풀에 들어간다
	if strPtr == maxStrPtr {
		if strPtr == maxStrings {
			overflow("number of strings", maxStrings-initStrPtr)
@:METAFONT capacity exceeded number of strings}{\quad number of strings@>
		}
		maxStrPtr++
	}
	strRef[strPtr] = 1
	strPtr++
	strStart[strPtr] = poolPtr
	return strPtr - 1
}

@ 다음 서브루틴은 문자열 |s|를, |buffer|의 위치 |k|에서 시작하는 같은 길이의 다른 문자열과
비교한다. 두 문자열이 같을 때, 그리고 오직 그때에만 결과는 |true|다.

@<함수들@>=
func strEqBuf(s strNumber, k int32) bool { // 문자열이 같은지 검사한다
	for j := strStart[s]; j < strStart[s+1]; j++ {
		if so(strPool[j]) != buffer[k] {
			return false
		}
		k++
	}
	return true
}

@ 다음은 비슷한 루틴인데, 문자열 풀 안의 두 문자열을 비교하며 두 문자열의 길이가 같다고
가정하지 않는다. 첫 문자열이 둘째 문자열보다 사전 순서로 크면 양수를, 작으면 음수를, 같으면
0을 돌려준다.

@<함수들@>=
func strVsStr(s, t strNumber) int32 { // 문자열의 크기를 비교한다
	ls, lt := length(s), length(t) // 길이들
	l := min(ls, lt) // 아직 비교할 길이
	j, k := strStart[s], strStart[t] // 차례로 도는 첨자들
	for l > 0 {
		if strPool[j] != strPool[k] {
			return int32(strPool[j]) - int32(strPool[k])
		}
		j++
		k++
		l--
	}
	return ls - lt
}

@ 변수 |strPool|, |strStart|, |poolPtr|, |strPtr|의 처음 값은 \.{INIMF} 프로그램이
계산하는데, 그 일부는 프로그램 안에 적어 둔 문자열 상수의 목록을 바탕으로 한다(\secref{pool-literals}).
이 함수는 \.{INIMF}에서만 쓰인다. 미리 실어 두는 문자열은 결코 지워지지 않도록 참조 횟수를
|maxStrRef|로 놓는다.
@.INIMF@>
@^string pool@>

@<함수들@>=
func getStringsStarted() bool { // 문자열 풀을 초기화한다.
	@t\qquad@>// 무언가 잘못되면 |false|를 돌려준다
	var k, l int32 // 작은 첨자나 계수기
	var g strNumber // 방금 만든 문자열
	poolPtr = 0
	strPtr = 0
	maxPoolPtr = 0
	maxStrPtr = 0
	strStart[0] = 0
	@<처음 256개의 문자열을 만든다@>
	@<나머지 문자열을 |poolLiterals|에서 넣고 |true|나 |false|를 돌려준다@>
}

@ 소문자 16진 숫자 하나를 덧붙이는 작은 함수 |appLcHex|는 이 절에서만 쓰이므로, 코드
안의 함수 리터럴로 둔다.

@<처음 256개...@>=
appLcHex := func(x int32) {
	l = x
	if l < 10 {
		appendChar(l + '0')
	} else {
		appendChar(l - 10 + 'a')
	}
}
for k = 0; k <= 255; k++ {
	unprintable := @<문자 |k|를 찍을 수 없다@>
	if unprintable {
		appendChar('^')
		appendChar('^')
		if k < 0o100 {
			appendChar(k + 0o100)
		} else if k < 0o200 {
			appendChar(k - 0o100)
		} else {
			appLcHex(k / 16)
			appLcHex(k % 16)
		}
	} else {
		appendChar(k)
	}
	g = makeString()
	strRef[g] = maxStrRef
}

@ 처음 128개의 문자열에는 95개의 표준 {\mc ASCII} 문자가 들어가고, 나머지 33개의 문자는
시스템에 따른 변경을 여기서 하지 않는 한 `\.{\^\^A}' 같은 세 기호 꼴로 찍힐 것이다. 확장
문자 집합을 가진 시스템, 이를테면 |xchr[@'32]=@t\.{\char'47\^\^Z\char'47}@>|인 곳에서는 문자열 \.{'32}가
세 문자 \.{'136}, \.{'136}, \.{'132}(\.{\^\^Z}) 대신 문자 하나 \.{'32}이기를 바랄 것이다.
한편 확장 문자 집합을 가진 사람들도 문자열 \.{'15}는 \.{\^\^M}으로 나타내고 싶을 것이다.
\.{'15}는 {\mc ASCII}의 ``캐리지 리턴'' 코드이기 때문이다. 탭이나 줄 먹임이나 캐리지 리턴이나 벨
소리, 또는 텍스트 파일에서 이상하게 다루어지는 문자들 대신 눈에 보이는 문자열을 만들어 내자는
것이다.

코드 128--255의 찍을 수 없는 문자들도 비슷하게 \.{\^\^80}--\.{\^\^ff}로 나타낸다.

여기서 정의하는 불 식은 \MF\ 내부 코드 번호~|k|가 그 지역의 문자 집합에서 말썽 없는 보이는
기호에 해당하지 않는 한 |true|여야 한다. 문자 |k|를 찍을 수 없고 |k<@'200|이면 문자 |k+@'100|이나
|k-@'100|은 찍을 수 있어야 한다. 게다가 {\mc ASCII} 코드 \.{'60}--\.{'71}, \.{'136},
\.{'141}--\.{'146}은 찍을 수 있어야 한다.
@^character set dependencies@>
@^system dependencies@>

@<문자 |k|를 찍을 수 없다@>=
(k < ' ' || k > '~')

@ \seclabel{pool-literals}\MF\ 자신의 메시지들은 \GO/의 문자열 상수로 프로그램 안에 들어 있고, |printStr| 같은
프로시저가 그것을 직접 찍는다(\secref{print}). 그러나 문자열 상수 가운데 몇몇은 찍히기만 하는
것이 아니라 문자열 번호로서 변수에 들어가거나 다른 문자열 번호와 비교된다. 이를테면
`|curExt=str(".mf")|'나 `|if curExt==str("")|' 같은 것이다. 그런 문자열들은 풀 안에
있어야 하므로 목록 |poolLiterals|에 모아 두고, \.{INIMF}가 처음 256개의 문자열 바로
@.INIMF@>
다음에 차례로 풀에 넣는다. 그러면 목록의 $i$번째 문자열의 번호는 언제나 $256+i$가 된다.
기반 파일은 풀 전체를 담으므로 실무용 판에서도 번호가 같다. 문자열 상수의 번호는 함수
|str|이 돌려준다.

목록의 항목은 그 문자열을 쓰는 부에서 이름 있는 절 |@<번호로 쓰이는 문자열 상수들@>|에 덧붙인다.
그 절들은 등장 순서대로 이어 붙으므로 번호는 늘 같다.

@<전역 변수@>=
var @!poolLiterals = [...]string{ // 번호로 쓰이는 문자열 상수들
	@<번호로 쓰이는 문자열 상수들@>
}

@ 문자열 상수들을 차례로 풀에 넣다가 자리가 모자라면 |getStringsStarted|는 |false|를
돌려준다.

@<나머지 문자열을...@>=
for _, lit := range poolLiterals {
	@<문자열 하나를 넣되, 자리가 빠듯하면 |false|를 돌려준다@>
}
return true

@ 문자열 상수 |lit|의 길이가 |l|이다. 문자열 공간에는 사용자의 식별자와 문자열을
위해 적어도 |stringVacancies|만큼의 자리가 남아 있어야 한다.

@<문자열 하나를 넣되...@>=
l = int32(len(lit)) // 길이를 계산한다
if poolPtr+l+stringVacancies > poolSize {
	wakeUpTerminal()
	writeLn(&termOut, "! You have to increase POOLSIZE.")
@.You have to increase POOLSIZE@>
	return false
}
for k = 0; k < l; k++ {
	appendChar(xord[lit[k]])
}
g = makeString()
strRef[g] = maxStrRef

@ \seclabel{pool-check}문자열 상수의 목록이 바뀌면 문자열의 번호도 바뀐다. 그러므로 옛 목록을 가진 \MF가
만든 기반 파일을 새 \MF가 읽어 들여서는 안 된다. 이를 막으려고 기반 파일의 첫
낱말에는 목록의 검사합 |poolCheckSum|을 적어 두고(\secref{dump-constants}), 기반 파일을 읽을 때 그것을
맞추어 본다.
@^check sum@>

@ 함수 |str|은 \GO/ 문자열 상수 |s|에 해당하는 풀 문자열의 번호를 돌려준다. 한
문자짜리 문자열은 처음 256개 가운데 하나이므로 그 문자의 코드를 돌려준다. 그 밖의
문자열은 목록 |poolLiterals|에 있어야 한다. 목록에 없는 문자열을 물으면 프로그램의
잘못이므로 |panic|을 일으킨다.

@<함수들@>=
func str(s string) strNumber {
	if len(s) == 1 {
		return strNumber(s[0])
	}
	for i, lit := range poolLiterals {
		if lit == s {
			return 256 + strNumber(i)
		}
	}
	panic("str: " + s + " is not in poolLiterals")
}

@ 다음 두 문자열은 여러 부에서 함께 쓰므로 여기서 목록에 넣는다. 빈 문자열은 \MF의 문자열
값으로 자주 쓰인다.

@<번호로 쓰이는 문자열 상수들@>=
"", "???",

@* 화면과 기록 파일에 찍기.
사용자의 터미널과 기록 파일로 보내는 메시지는 여러 `|printStr|' 프로시저가 만든다. 이
프로시저들은 전역 변수 |selector|의 값에 따라 출력을 여러 곳으로 보내는데, 그 값은 다음과
같을 수 있다.

\yskip
\hang |termAndLog|, 보통의 설정으로, 터미널과 기록 파일에 찍는다.

\hang |logOnly|, 기록 파일에만 찍는다.

\hang |termOnly|, 터미널에만 찍는다.

\hang |noPrint|, 아무 데도 찍지 않는다. 기록 파일을 열기 전의 드문 경우에만 쓰인다.

\hang |pseudo|, 출력을 순환 버퍼에 넣는다. 이 버퍼는 루틴 |showContext|가 쓴다. 이 이상한
방식을 쓰는 까닭은 그 루틴에 이르렀을 때 이야기할 것이다.

\hang |newString|, 출력을 문자열 풀의 현재 문자열에 덧붙인다.

\yskip
\noindent 기호 이름 `|termAndLog|' 따위에는 |noPrint+1=termOnly|, |noPrint+2=logOnly|,
|termOnly+2=logOnly+1=termAndLog|라는 편리한 관계를 만족하는 수 코드를 주었다.

전역 변수 셋, 곧 |tally|와 |termOffset|과 |fileOffset|은 가장 최근에 0으로 되돌린 뒤로
찍은 문자의 수를 기록한다. 변수 |tally|는 (아주 길 수도 있는) 찍은 구간의 길이를 기록하는 데
쓴다. 한편 |termOffset|과 |fileOffset|은 각각 터미널과 기록 파일에 출력하고 있는 현재
줄에 지금까지 문자가 몇 개 나왔는지 추적한다.

@<전역 변수@>=
const (
	@!noPrint = iota // 자료가 사라지게 하는 |selector| 설정
	@!termOnly // 터미널에만 찍는다
	@!logOnly // 기록 파일에만 찍는다
	@!termAndLog // 보통의 |selector| 설정
	@!pseudo // |showContext|를 위한 특별한 |selector| 설정
	@!newString // 찍는 것을 문자열 풀로 돌린다
	@!maxSelector = newString // 가장 큰 |selector| 설정
)

var @!logFile alphaFile // \MF\ 작업의 기록
var @!selector int32 // 메시지를 찍을 곳; |0 .. maxSelector|
var @!dig [23]int32 // 출력하고 있는 수의 숫자들; 저마다 |0 .. 15|
var @!tally int32 // 최근에 찍은 문자의 수
var @!termOffset int32 // 현재 터미널 줄의 문자 수; |0 .. maxPrintLine|
var @!fileOffset int32 // 현재 파일 줄의 문자 수; |0 .. maxPrintLine|
var @!trickBuf [errorLine + 1]asciiCode // 흉내 찍기를 위한 순환 버퍼
var @!trickCount int32 // 흉내 찍기의 문턱값; 나중에 설명한다
var @!firstCount int32 // 흉내 찍기를 위한 또 하나의 변수

@ @<출력 루틴들을 초기화한다@>=
selector = termOnly
tally = 0
termOffset = 0
fileOffset = 0

@ 터미널과 기록 파일로 출력하는 매크로 약어들을 편의를 위해 여기서 정의한다. 어떤
시스템에서는 터미널 출력에 특별한 관례가 필요한데, 이 절에서 |wterm|, |wtermLn|,
|wtermCr|를 바꾸어 그 관례를 따를 수 있다.
@^system dependencies@>

@<정의@>=
func wterm(xs ...any)   { write(&termOut, xs...) }
func wtermLn(xs ...any) { writeLn(&termOut, xs...) }
func wtermCr()          { writeLn(&termOut) }
func wlog(xs ...any)    { write(&logFile, xs...) }
func wlogLn(xs ...any)  { writeLn(&logFile, xs...) }
func wlogCr()           { writeLn(&logFile) }

@ 텍스트 출력의 한 줄을 끝내려면 |printLn|을 부른다.

@<기본 인쇄...@>=
func printLn() { // 줄의 끝을 찍는다
	switch selector {
	case termAndLog:
		wtermCr()
		wlogCr()
		termOffset = 0
		fileOffset = 0
	case logOnly:
		wlogCr()
		fileOffset = 0
	case termOnly:
		wtermCr()
		termOffset = 0
	case noPrint, pseudo, newString:
		// 아무것도 하지 않는다
	} // 다른 경우는 없다
} // |tally|는 영향을 받지 않는다

@ \seclabel{print-char}프로시저 |printChar|는 문자 하나를 원하는 곳으로 보낸다. 이때 배열 |xchr|를 써서 그 문자를
|inputLn|과 어울리는 외부 문자로 바꾼다. 찍는 것은 모두 |printLn|이나 |printChar|를 거친다.

@<기본 인쇄...@>=
func printChar(s asciiCode) { // 문자 하나를 찍는다
	switch selector {
	case termAndLog:
		wterm(xchr[s])
		wlog(xchr[s])
		termOffset++
		fileOffset++
		if termOffset == maxPrintLine {
			wtermCr()
			termOffset = 0
		}
		if fileOffset == maxPrintLine {
			wlogCr()
			fileOffset = 0
		}
	case logOnly:
		wlog(xchr[s])
		fileOffset++
		if fileOffset == maxPrintLine {
			printLn()
		}
	case termOnly:
		wterm(xchr[s])
		termOffset++
		if termOffset == maxPrintLine {
			printLn()
		}
	case noPrint:
		// 아무것도 하지 않는다
	case pseudo:
		if tally < trickCount {
			trickBuf[tally%errorLine] = s
		}
	case newString:
		if poolPtr < poolSize {
			appendChar(s)
		} // 문자열 공간이 가득 차면 문자들을 버린다
	} // 다른 경우는 없다
	tally++
}

@ \seclabel{print}문자열 전체는 |printStr|를 불러서 출력한다. 표준 {\mc ASCII} 문자 하나 \.c를 출력할
때는 |printStr("c")|를 부를 수도 있다는 데 주목하라. 앞에서 설명했듯이 |"c"=99|가 문자 하나짜리
문자열의 번호이기 때문이다. 그러나 |printChar("c")|가 더 빠르므로, \MF는 그것이 안전하다고
알 때에는 바로 |printChar| 루틴으로 간다. (지금의 구현은 보이는 {\mc ASCII} 문자를 찍는
것은 언제나 안전하다고 가정한다.)
@^system dependencies@>

함수 |printStr|의 인자 |x|는 문자열 번호(정수)일 수도 있고 \GO/의 문자열 상수일 수도 있으므로
(\secref{pool-literals}) 형이 |any|다. 길이가 1이 아닌 \GO/ 문자열은 번호가 255보다 큰 풀 문자열을 찍을
때처럼 그 문자들을 |printChar|로 찍는다. 길이가 1인 \GO/ 문자열은 그 문자의 코드, 곧 한
문자짜리 문자열의 번호로 바꾼다. 인자를 문자열 번호로 바꾸는 일은 함수 |strnum|이 한다.

이 루틴의 원래 이름은 그냥 `print'였지만, \GO/에서 그것은 내장 함수의 이름이다. 내장 이름을
가리지 않으려고 |printStr|라고 부른다.

@<기본 인쇄...@>=
func printStr(x any) { // 문자열 |s|를 찍는다
	if t, ok := x.(string); ok && len(t) != 1 {
		for k := 0; k < len(t); k++ {
			printChar(xord[t[k]])
		}
		return
	}
	s := strnum(x)
	if s < 0 || s >= strPtr {
		printStr("???") // 이런 일은 일어날 수 없다
		return
@.???@>
	}
	if s < 256 && selector > pseudo {
		printChar(s)
	} else {
		for j := strStart[s]; j < strStart[s+1]; j++ {
			printChar(so(strPool[j]))
		}
	}
}

@ 함수 |strnum|은 |printStr|와 그 친척들이 받은 인자를 문자열 번호로 바꾼다. 인자는 정수이거나
길이가 1인 \GO/ 문자열이어야 한다. \GO/의 작은따옴표 상수(|rune|)는 |int32|의 별칭이므로
그대로 문자 코드가 된다.

@<기본 인쇄...@>=
func strnum(x any) strNumber {
	switch x := x.(type) {
	case int32:
		return x
	case int:
		return strNumber(x)
	case string:
		return str(x)
	}
	panic(fmt.Sprintf("strnum: %T", x))
}

@ 이따금 보이는 {\mc ASCII} 코드가 아닐지도 모르는 문자들로 된 문자열을 찍어야 할 때가 있다.
그럴 때는 |slowPrint|를 쓴다. 각 문자를 한 문자짜리 문자열로 찍으므로, 찍을 수 없는 문자는
`\.{\^\^M}' 같은 꼴로 나온다.

\GO/ 문자열 상수가 인자로 오면 그 문자들을 하나씩 |printStr|로 찍는다.

@<기본 인쇄...@>=
func slowPrint(x any) { // 문자열 |s|를 찍는다
	if t, ok := x.(string); ok && len(t) != 1 {
		for k := 0; k < len(t); k++ {
			printStr(xord[t[k]])
		}
		return
	}
	s := strnum(x)
	if s < 0 || s >= strPtr {
		printStr("???") // 이런 일은 일어날 수 없다
		return
@.???@>
	}
	if s < 256 && selector > pseudo {
		printChar(s)
	} else {
		for j := strStart[s]; j < strStart[s+1]; j++ {
			printStr(so(strPool[j]))
		}
	}
}

@ 다음은 \MF가 맨 처음 찍는 것, 곧 판 번호와 기반 이름을 밝히는 머리줄이다. 변수
|termOffset|은 잠시 틀린 값을 갖지만, 이 부분은 시스템에 따라 다르다고 가정하므로 그 어긋남은
심각하지 않다.
@^system dependencies@>

@<출력 루틴들을...@>=
wterm(banner)
if baseIdent == 0 {
	wtermLn(" (no base preloaded)")
} else {
	slowPrint(baseIdent)
	printLn()
}
updateTerminal()

@ 프로시저 |printNl|은 |printStr|와 같지만, 문자열이 새 줄의 처음에 나타나도록 한다.

@<기본 인쇄...@>=
func printNl(s any) { // 문자열 |s|를 줄의 처음에 찍는다
	if (termOffset > 0 && odd(selector)) ||
		(fileOffset > 0 && selector >= logOnly) {
		printLn()
	}
	printStr(s)
}

@ 범위 |0 .. 9|의 숫자들로 된 배열은 |printTheDigs|로 찍는다.

@<기본 인쇄...@>=
func printTheDigs(k eightBits) { // |dig[k-1]|$\,\ldots\,$|dig[0]|을 찍는다
	for k > 0 {
		k--
		printChar('0' + dig[k])
	}
}

@ 정수 |n|의 십진 표현을 찍는 다음 프로시저는 |n=0|이거나 |(-n)|이 넘침을 일으킬 때에도
제대로 동작하도록 조심스럽게 썼다. 이것은 음수 인자에 나머지 연산이나 나눗셈을 쓰지
않는다. 그런 연산의 결과는 언어나 컴퓨터마다 다를 수 있기 때문이다.

@<기본 인쇄...@>=
func printInt(n int32) { // 정수를 십진 꼴로 찍는다
	var k int32 // 현재 숫자의 첨자; $\vert n\vert<10^{23}$이라고 가정한다
	var m int32 // 위험할 수도 있는 경우에 |n|의 부호를 바꾸는 데 쓴다
	k = 0
	if n < 0 {
		printChar('-')
		if n > -100000000 {
			n = -n
		} else {
			m = -1 - n
			n = m / 10
			m = (m % 10) + 1
			k = 1
			if m < 10 {
				dig[0] = m
			} else {
				dig[0] = 0
				n++
			}
		}
	}
	for {
		dig[k] = n % 10
		n /= 10
		k++
		if n == 0 {
			break
		}
	}
	printTheDigs(k)
}

@ \MF는 숫자 두 개를 찍는 하찮은 프로시저도 쓴다. 다음 서브루틴은 대개 |0<=n<=99| 범위의
매개변수로 불린다.

@<함수들@>=
func printDd(n int32) { // 가장 낮은 두 자리 숫자를 찍는다
	n = abs(n) % 100
	printChar('0' + (n / 10))
	printChar('0' + (n % 10))
}

@ 다음은 사용자에게 입력 한 줄을 치라고 하는 프로시저다. 이 프로시저는 |selector|의 설정이
|termOnly|나 |termAndLog|라고 가정한다. 입력은 배열 |buffer|의 위치 |first|부터 |last-1|까지에
들어가고, 알맞으면 기록 파일에 메아리친다. 줄 끝 |buffer[last]|에는 `\.\%'를 넣어 두는데, 이것은
훑개가 줄의 끝을 알아보는 표지다.

이 프로시저는 |interaction<scrollMode|일 때는 결코 불리지 않는다.

@<함수들@>=
func promptInput(s any) { // 문자열을 찍고 입력 한 줄을 얻는다
	wakeUpTerminal()
	printStr(s)
	termInput()
}

func termInput() { // 터미널에서 한 줄을 얻는다
	updateTerminal() // 이제 사용자는 틀림없이 재촉 기호를 본다
	if !inputLn(&termIn, true) {
		fatalError("End of file on the terminal!")
@.End of file on the terminal@>
	}
	termOffset = 0 // 사용자의 줄은 \<\rm return>으로 끝났다
	selector-- // 입력을 메아리칠 준비를 한다
	if last != first {
		for k := first; k <= last-1; k++ {
			printStr(buffer[k])
		}
	}
	printLn()
	buffer[last] = '%'
	selector++ // 앞의 상태로 되돌린다
}

@* 오류 알리기.
무언가 이상한 것이 발견되면 \MF는 대개 다음과 같은 일을 한다.
$$\vbox{\halign{#\hfil\cr
|printErr("Something anomalous has been detected")|\cr
|help3("This is the first line of my offer to help.",|\cr
|"This is the second line. I'm trying to",|\cr
|"explain the best way for you to proceed.")|\cr
|reportError()|\cr}}$$
도움말이 두 줄이면 |help2|를 쓰는 식이다. 이런 비공식 도움말은 찍힌 공식 오류 메시지의
낱말들을 보완하는 쉬운 낱말로 써야 한다. (미국 바깥에서는 도움말을 그 지역의 말로 옮기는
것이 좋다. 지금의 구현에서 도움말 한 줄은 많아야 60글자이므로 |maxPrintLine|을 넘지 않는다.)

프로시저 |printErr|는 공식 메시지 앞에 `\.!'를 붙이고, 멈추게 될 경우에 터미널이 깨어
있도록 한다. 프로시저 |reportError|는 공식 메시지 뒤에 `\..'를 붙이고 오류가 난 곳을 보여 준다. 또
|interaction=errorStopMode|면 사용자와 대화에 들어가는데, 그동안 도움말을 찍을 수도 있다.
@^system dependencies@>

@ 전역 변수 |interaction|의 설정은 넷인데, 사용자와 주고받는 정도가 차례로 커진다.

@<전역 변수@>=
const (
	@!batchMode = iota // 멈추지 않고 터미널 출력도 하지 않는다
	@!nonstopMode // 멈추지 않는다
	@!scrollMode // 오류에서 멈추지 않는다
	@!errorStopMode // 기회가 있을 때마다 멈추어 사용자와 대화한다
)

func printErr(s any) {
	if interaction == errorStopMode {
		wakeUpTerminal()
	}
	printNl("! ")
	printStr(s)
@.!\relax@>
}

var @!interaction int32 // 사용자와 주고받는 현재 수준; |batchMode .. errorStopMode|

@ @<핵심 변수들의...@>=
interaction = errorStopMode

@ \MF는 |selector|의 설정이 보통과 다를 수도 있을 때에는 |reportError|를 부르지 않도록
조심한다. 오류 메시지를 낼 때 |selector|가 가질 수 있는 값은 다음뿐이다.

\yskip\hang|noPrint| (|interaction=batchMode|이고 |logFile|을 아직 열지 않았을 때);

\hang|termOnly| (|interaction>batchMode|이고 |logFile|을 아직 열지 않았을 때);

\hang|logOnly| (|interaction=batchMode|이고 |logFile|이 열려 있을 때);

\hang|termAndLog| (|interaction>batchMode|이고 |logFile|이 열려 있을 때).

@<|interaction|에 따라 찍기 |selector|를 초기화한다@>=
if interaction == batchMode {
	selector = noPrint
} else {
	selector = termOnly
}

@ 프로시저 |reportError|를 부를 때 |getNext| 루틴이 활성이면 전역 변수 |deletionsAllowed|를
|false|로 놓는다. 이렇게 해서 |getNext|가 결코 재귀적으로 불리지 않게 한다.
@^recursion@>

전역 변수 |history|는 지금까지 발견된 오류 가운데 가장 나쁜 수준을 기록한다. 이 변수는 네
가지 값, 곧 |spotless|, |warningIssued|, |errorMessageIssued|, |fatalErrorStop|을 가질
수 있다.

또 하나의 전역 변수 |errorCount|는 대화 없이 |reportError|가 일어날 때마다 1씩 늘어나고, 문장이
끝날 때마다 0으로 되돌아간다. 이 값이 100에 이르면 \MF는 더 계속해 봐야 소용없다고
판단한다.

@<전역 변수@>=
const (
	@!spotless = iota // 아직 아무 잘못도 없을 때의 |history| 값
	@!warningIssued // |beginDiagnostic|을 불렀을 때의 |history| 값
	@!errorMessageIssued // |reportError|를 불렀을 때의 |history| 값
	@!fatalErrorStop // 너무 일찍 끝났을 때의 |history| 값
)

var @!deletionsAllowed bool // |reportError|가 |getNext|를 불러도 안전한가?
var @!history int32 // 지금까지 입력이 깨끗했나? |spotless .. fatalErrorStop|
var @!errorCount int32 // 지난 문장이 끝난 뒤로 대화 없이 지나간 오류의 수; |-1 .. 100|

@ 변수 |history|의 처음 값은 |fatalErrorStop|이지만, \MF가 초기화 과정에서 살아남으면
|spotless|로 바뀐다.

@<핵심 변수들의...@>=
deletionsAllowed = true
errorCount = 0 // |history|는 다른 곳에서 초기화한다

@ 오류는 \MF의 거의 어디에서나 발견될 수 있으므로, 오류 프로시저들은 프로그램의 처음
가까이에서 정의하고 싶다. 그런데 오류 프로시저들은 다시 다른 프로시저들, 이를테면
|normalizeSelector|, |getNext|, |termInput|, |showContext|, |beginFileReading|,
|openLogFile|, |closeFilesAndTerminate|, |clearForErrorPrompt|를 쓰고, 디버깅할 때는
|debugHelp|도 쓴다. 다행히 \GO/에서는 함수를 쓰기 전에 선언할 필요가 없으므로, 이것들은
저마다 제자리에서 정의하면 된다.

프로시저 |getNext|로 토큰 하나를 지우는 동안 어떤 오류가 일어나거나, \MF가 치명적이지 않은
오류를 고치려 하는 동안 치명적인 오류가 일어나면 |reportError|가 재귀적으로 불릴 수 있다. 그러나
그런 재귀는 결코 두 단계보다 깊어지지 않는다.
@^recursion@>

@ 도움말의 낱낱의 줄은 배열 |helpLine|에 기록된다. 이 배열의 위치 |0 .. (helpPtr-1)|에
항목들이 들어 있다. 그것들은 거꾸로, 곧 |helpLine[0]|이 맨 마지막에 나오도록 찍어야 한다.

이를테면 함수 호출 |help3("a","b","c")|는 |helpPtr=3|, |helpLine[2]="a"|,
|helpLine[1]="b"|, |helpLine[0]="c"|로 놓는다. 도움말은 언제나 문자열 상수이므로
|helpLine|은 \GO/ 문자열의 배열이다. 사용자가 \KW{errhelp}로 정한 도움말은 문자열 번호
|errHelp|로 따로 둔다.

@<전역 변수@>=
func help0() { helpPtr = 0 } // 이따금 도움말이 없을 수도 있다
func help1(a string) { // 도움말이 한 줄일 때 쓴다
	helpPtr = 1
	helpLine[0] = a
}
func help2(a, b string) { // 도움말이 두 줄일 때 쓴다
	helpPtr = 2
	helpLine[1], helpLine[0] = a, b
}
func help3(a, b, c string) { // 도움말이 세 줄일 때 쓴다
	helpPtr = 3
	helpLine[2], helpLine[1], helpLine[0] = a, b, c
}
func help4(a, b, c, d string) { // 도움말이 네 줄일 때 쓴다
	helpPtr = 4
	helpLine[3], helpLine[2], helpLine[1], helpLine[0] = a, b, c, d
}
func help5(a, b, c, d, e string) { // 도움말이 다섯 줄일 때 쓴다
	helpPtr = 5
	helpLine[4], helpLine[3], helpLine[2], helpLine[1], helpLine[0] = a, b, c, d, e
}
func help6(a, b, c, d, e, f string) { // 도움말이 여섯 줄일 때 쓴다
	helpPtr = 6
	helpLine[5], helpLine[4], helpLine[3] = a, b, c
	helpLine[2], helpLine[1], helpLine[0] = d, e, f
}

var @!helpLine [6]string // 다음 |reportError|를 위한 도움말
var @!helpPtr int32 // 들어 있는 도움말 줄의 수; |0 .. 6|
var @!useErrHelp bool // |errHelp| 문자열을 보여 주어야 하나?
var @!errHelp strNumber // \KW{errhelp}로 정한 문자열

@ @<핵심 변수들의...@>=
helpPtr = 0
useErrHelp = false
errHelp = 0

@ \seclabel{jump-out}프로시저 |jumpOut|은 활성인 모든 프로시저 단계를 그냥 가로질러 |endOfMF|로 간다. 이것이
프로그램 전체에서 단 하나의 뻔하지 않은 비지역 이동이다. 이것은 특정한 오류에서 회복할 길이
없을 때 쓰인다. \GO/에서는 |panic|으로 모든 함수를 빠져나가고, 주 프로그램이 그것을 받아
레이블 |endOfMF|로 간다(\secref{outer-labels}, \secref{main}).
@^system dependencies@>

@<오류 처리...@>=
func jumpOut() {
	panic(endOfMF)
}

@ 이제 일반적인 |reportError| 루틴이다.

이 루틴에 가장 어울리는 이름은 그냥 `error'겠지만, \GO/에서 그것은 내장 인터페이스 형의
이름이다. 내장 이름을 가리지 않으려고 |reportError|라고 부른다.

@<오류 처리...@>=
func reportError() { // 오류 보고의 일을 마친다
	var c asciiCode // 사용자가 친 것
	var s1, s2, s3 int32 // 토큰을 지울 때 전역 변수들을 저장하는 데 쓴다
	var j poolPointer // 찍고 있는 문자의 위치
	history = max(history, errorMessageIssued)
	printChar('.')
	showContext()
	if interaction == errorStopMode {
		@<사용자의 조언을 얻고 |return|한다@>
	}
	errorCount++
	if errorCount == 100 {
		printNl("(That makes 100 errors; please try again.)")
@.That makes 100 errors...@>
		history = fatalErrorStop
		jumpOut()
	}
	@<도움말을 기록 파일에 넣는다@>
}

@ 다음 루프에서 몸체의 맨 처음으로 다시 갈 때는 |continue| 문을 쓴다. \GO/의 |continue|는
|switch| 문 안에서도 그것을 둘러싼 |for| 루프에 대해 작용한다.

@<사용자의 조언을...@>=
for {
	if interaction != errorStopMode {
		return
	}
	clearForErrorPrompt()
	promptInput("? ")
@.?\relax@>
	if last == first {
		return
	}
	c = buffer[first]
	if c >= 'a' {
		c = c + 'A' - 'a' // 대문자로 바꾼다
	}
	@<코드 |c|를 해석하고, 끝났으면 |return|한다@>
}

@ 여기서 사용자가 \MF에서 시스템 편집기로 쉽게 돌아갈 수 있도록, 문제의 줄을 바로 고칠 수
있게 해 주는 `\.E' 선택지를 주면 좋을 것이다. 그러나 그런 확장에는 시스템 마법이 좀 필요하므로,
지금의 구현은 고쳐야 할 파일의 이름과 해당 줄 번호를 찍어 주기만 한다.
@^system dependencies@>

디버깅 루틴들을 주석으로 막지 않았을 때 쓸 수 있는 비밀 선택지 `\.D'도 있다.
@^debugging@>

@<코드 |c|를 해석하고...@>=
switch c {
case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
	if deletionsAllowed {
		@<토큰 |c-"0"|개를 지우고 |continue|@>
	}
case 'D':
	if debug {
		debugHelp()
		continue
	}
case 'E':
	if filePtr > 0 {
		if inputStack[filePtr].nameField >= 256 {
			printNl("You want to edit file ")
@.You want to edit file x@>
			slowPrint(inputStack[filePtr].nameField)
			printStr(" at line ")
			printInt(line)
			interaction = scrollMode
			jumpOut()
		}
	}
case 'H':
	@<도움말 정보를 찍고 |continue|@>
case 'I':
	@<터미널에서 새 재료를 끼워 넣고 |return|한다@>
case 'Q', 'R', 'S':
	@<대화 수준을 바꾸고 |return|한다@>
case 'X':
	interaction = scrollMode
	jumpOut()
default:
	// 아무것도 하지 않는다
}
@<쓸 수 있는 선택지들의 차림표를 찍는다@>

@ @<쓸 수 있는 선택지들의...@>=
printStr("Type <return> to proceed, S to scroll future error messages,")
@.Type <return> to proceed...@>
printNl("R to run without stopping, Q to run quietly,")
printNl("I to insert something, ")
if filePtr > 0 {
	if inputStack[filePtr].nameField >= 256 {
		printStr("E to edit your file,")
	}
}
if deletionsAllowed {
	printNl("1 or ... or 9 to ignore the next 1 to 9 tokens of input,")
}
printNl("H for help, X to quit.")

@ 여기서 \MF의 저자는 |"Q"|, |"R"|, |"S"|와 원하는 대화 설정 |batchMode|, |nonstopMode|,
|scrollMode| 사이의 수치 관계를 이용한 것을 사과한다.
@^Knuth, Donald Ervin@>

@<대화 수준을...@>=
errorCount = 0
interaction = batchMode + c - 'Q'
printStr("OK, entering ")
switch c {
case 'Q':
	printStr("batchmode")
	selector--
case 'R':
	printStr("nonstopmode")
case 'S':
	printStr("scrollmode")
} // 다른 경우는 없다
printStr("...")
printLn()
updateTerminal()
return

@ 다음 코드를 실행할 때, |buffer[(first+1) .. (last-1)]|에는 사용자가 끼워 넣은 재료가 들어
있을 수 있다. 그렇지 않으면 다시 재촉한다. 프로그램의 이 부분을 완전히 이해하려면 \MF의 입력
스택에 익숙해야 한다.

@<터미널에서 새 재료를...@>=
beginFileReading() // 터미널 입력을 위해 새 구문 수준에 들어간다
if last > first+1 {
	loc = first + 1
	buffer[first] = ' '
} else {
	promptInput("insert>")
	loc = first
@.insert>@>
}
first = last + 1
limit = last
return

@ 한 번에 토큰을 99개까지 지울 수 있다.

@<토큰 |c-"0"|개를...@>=
s1 = curCmd
s2 = curMod
s3 = curSym
okToInterrupt = false
if last > first+1 && buffer[first+1] >= '0' && buffer[first+1] <= '9' {
	c = c*10 + buffer[first+1] - '0'*11
} else {
	c -= '0'
}
for c > 0 {
	getNext() // |reportError|의 한 단계 재귀 호출이 일어날 수 있다
	@<현재 토큰이 문자열이면 그 참조 횟수를 줄인다@>
	c--
}
curCmd = s1
curMod = s2
curSym = s3
okToInterrupt = true
help2("I have just deleted some text, as you asked.",
	"You can now delete more, or insert, or whatever.")
showContext()
continue

@ @<도움말 정보를...@>=
if useErrHelp {
	@<문자열 |errHelp|를 찍되, 여러 줄로 찍을 수도 있다@>
	useErrHelp = false
} else {
	if helpPtr == 0 {
		help2("Sorry, I don't know how to help in this situation.",
			"Maybe you should try asking a human?")
	}
	for {
		helpPtr--
		printStr(helpLine[helpPtr])
		printLn()
		if helpPtr == 0 {
			break
		}
	}
}
help4("Sorry, I already gave what help I could...",
	"Maybe you should try asking a human?",
	"An error might have occurred before I noticed any problems.",
	"``If all else fails, read the instructions.''")
continue

@ 사용자가 \KW{errhelp}로 정한 문자열에서 `\.\%'는 줄바꿈을 뜻한다. 진짜 `\.\%'를 찍으려면
`\.{\%\%}'라고 겹쳐 쓴다.

@<문자열 |errHelp|를 찍되...@>=
j = strStart[errHelp]
for j < strStart[errHelp+1] {
	if strPool[j] != si('%') {
		printStr(so(strPool[j]))
	} else if j+1 == strStart[errHelp+1] {
		printLn()
	} else if strPool[j+1] != si('%') {
		printLn()
	} else {
		j++
		printChar('%')
	}
	j++
}

@ @<도움말을 기록 파일에...@>=
if interaction > batchMode {
	selector-- // 터미널 출력을 피한다
}
if useErrHelp {
	printNl("")
	@<문자열 |errHelp|를 찍되...@>
} else {
	for helpPtr > 0 {
		helpPtr--
		printNl(helpLine[helpPtr])
	}
}
printLn()
if interaction > batchMode {
	selector++ // 터미널 출력을 다시 살린다
}
printLn()

@ 이상한 경우에는 찍기 선택자가 알 수 없는 상태에 있을 수도 있다. 다음 서브루틴은 조금 더
오래 돌아갈 수 있을 만큼만 상황을 바로잡는다.

@<함수들@>=
func normalizeSelector() {
	if logOpened {
		selector = termAndLog
	} else {
		selector = termOnly
	}
	if jobName == 0 {
		openLogFile()
	}
	if interaction == batchMode {
		selector--
	}
}

@ 다음 프로시저는 \MF가 죽기 전에 남기는 마지막 말을 찍는다.

@<오류 처리...@>=
func succumb() {
	if interaction == errorStopMode {
		interaction = scrollMode // 더는 대화하지 않는다
	}
	if logOpened {
		reportError()
	}
	if debug {
		if interaction > batchMode {
			debugHelp()
		}
	}
	history = fatalErrorStop
	jumpOut() // 회복할 수 없는 오류
}

func fatalError(s string) { // |s|를 찍고, 그것으로 끝이다
	normalizeSelector()
	printErr("Emergency stop")
	help1(s)
	succumb()
@.Emergency stop@>
}

@ 다음은 가장 무서운 오류 메시지다.

@<오류 처리...@>=
func overflow(s string, n int32) { // 유한성 때문에 멈춘다
	normalizeSelector()
	printErr("METAFONT capacity exceeded, sorry [")
@.METAFONT capacity exceeded ...@>
	printStr(s)
	printChar('=')
	printInt(n)
	printChar(']')
	help2("If you really absolutely need more capacity,",
		"you can ask a wizard to enlarge me.")
	succumb()
}

@ 프로그램이 언젠가 완전히 미쳐 날뛸 수도 있는데, 그때는 멈추는 수밖에 없다. 그 전에 아무
오류도 발견되지 않았다면 그것은 나쁜 소식이다. 그래서 사용자보다는 \MF\ 관리자를 위한
메시지를 찍는다(사용자가 유달리 악랄하지 않았다면 말이다). 찾아보기의 `this can't happen'
항목들이 문제를 정확히 짚어 내는 데 도움이 될 것이다.
@^dry rot@>

@<오류 처리...@>=
func confusion(s string) { // 일관성 검사가 어긋났다; |s|가 그곳을 알려 준다
	normalizeSelector()
	if history < errorMessageIssued {
		printErr("This can't happen (")
		printStr(s)
		printChar(')')
@.This can't happen@>
		help1("I'm broken. Please show this to someone who can fix can fix")
	} else {
		printErr("I can't go on meeting you like this")
@.I can't go on...@>
		help2("One of your faux pas seems to have wounded me deeply...",
			"in fact, I'm barely conscious. Please fix it and try again.")
	}
	succumb()
}

@ 사용자는 이따금 \MF가 돌아가는 동안 끼어들고 싶어 한다. 실행 시스템이 이것을
허용한다면, 그런 끼어들기 신호가 오면 전역 변수 |interrupt|를 0이 아닌 값으로 놓는 루틴을
구현할 수 있다. \GO/에서는 |os/signal| 꾸러미로 끼어들기 신호를 받을 수 있으므로 바로 그렇게
한다(다음 절). 그럴 수 없는 시스템이라도 아마 적어도 디버거를 써서 |interrupt|를 0이
아니게 할 방법은 있을 것이다.
@^system dependencies@>
@^debugging@>

@<전역 변수@>=
func checkInterrupt() {
	if interrupt != 0 {
		pauseForInstructions()
	}
}

var @!interrupt int32 // \MF가 멈추고 지시를 기다려야 하나?
var @!okToInterrupt bool // 끼어들기를 받아들여야 하나?
var @!interruptSignal = make(chan os.Signal, 1) // 끼어들기 신호가 들어오는 통로

@ @<핵심 변수들의...@>=
interrupt = 0
okToInterrupt = true

@ 주 프로그램은 시작하자마자 다음 일을 해 둔다(\secref{main}). 사용자가 끼어들기 신호(대개
\.{Ctrl-C})를 보내면 따로 도는 고루틴이 그것을 받아서 |interrupt|를 1로 놓는다. \MF는
|checkInterrupt|를 부를 때에만 이 변수를 살피므로, 신호는 그때 처리된다.

@<끼어들기 신호를 받으면 |interrupt|를 놓게 한다@>=
signal.Notify(interruptSignal, os.Interrupt)
go func() {
	for range interruptSignal {
		interrupt = 1
	}
}()

@ 끼어들기가 발견되면 프로그램은 가장 높은 대화 수준에 들어가서, 사용자가 |reportError| 루틴의 거의
모든 유연성을 누리게 한다. \MF는 그렇게 해도 안전한 때에만 끼어들기를 검사한다.

@<함수들@>=
func pauseForInstructions() {
	if okToInterrupt {
		interaction = errorStopMode
		if selector == logOnly || selector == noPrint {
			selector++
		}
		printErr("Interruption")
@.Interruption@>
		help3("You rang?",
			"Try to insert an instruction for me (e.g., `I show x;'),",
			"unless you just want to quit by typing `X'.")
		deletionsAllowed = false
		reportError()
		deletionsAllowed = true
		interrupt = 0
	}
}

@ \MF의 오류 메시지 가운데 많은 것은 빠진 토큰을 뒤에서 몰래 끼워 넣었다고 알린다. 이 공통
코드를 서브루틴 하나에 넣으면 문자열 공간과 프로그램 공간을 아낄 수 있다.

@<함수들@>=
func missingErr(s any) {
	printErr("Missing `")
	printStr(s)
	printStr("' has been inserted")
@.Missing...inserted@>
}

@* 눈금 수의 산술.
\MF가 하는 주된 계산은 절댓값이 $2^{31}$보다 작은 정수만으로 이루어진다. 그래서 이
프로그램에 지정된 산술은 몇몇 작은 컴퓨터를 포함한 매우 다양한 컴퓨터에서 정확히 같은
방식으로 수행될 수 있다.
@^small computers@>

그러나 피제수가 음수일 때 정수 나눗셈의 결과는 언어나 컴퓨터마다 다를 수 있다. 이를테면
|(-2*n-1)/2|는 어떤 컴퓨터에서는 |-(n+1)|이고 다른 컴퓨터에서는 |-n|이다. 산술에는 크게 두
가지가 있다. 항등식 |(a+q*b)/b=(a/b)+q|가 성립하는 ``평행 이동을 보존하는'' 산술과,
|(-a)/b=-(a/b)|가 성립하는 ``부호 바꿈을 보존하는'' 산술이다. 그래서 \MF도 두 가지가 생기고,
둘은 서로 다른 결과를 낼 수 있다. 다만 언어를 제대로 쓰는 한 그 차이는 무시할 만하다.
\TeX\ 처리기는 두 가지 산술이 똑같은 출력을 내도록 조심스럽게 정의했지만, \MF를 같은
방식으로 묶어 두는 것은 너무 비효율적일 것이다.

\GO/의 정수 나눗셈 |/|는 0 쪽으로 자르고, 나머지 |%|의 부호는 피제수를 따른다. 곧 \GO/의
산술은 ``부호 바꿈을 보존하는'' 쪽이다. \MF의 \.{TRAP} 시험의 기록은 이 쪽의 산술로 만든
것이므로, 이 구현은 그 기록과 맞는다.
@^negative dividends@>

@<정의@>=
const @!elGordo = 0o17777777777 // $2^{31}-1$, \MF가 좋아하는 가장 큰 값

@ \MF가 가장 자주 하는 연산 가운데 하나는 주어진 두 정수 |a|와~|b|의 가운뎃값
$\lfloor{a+b\over2}\rfloor$를 계산하는 것이다. 이 프로그램에서 가운뎃값 연산은 언제나
`|half(a+b)|'로 나타낸다.

원본은 이진 자리 옮김을 쓸 수 있는 언어라면 |half|를 `|(a+b)|를 오른쪽으로 한 비트 옮긴
것'으로 바꾸어 될 수 있는 대로 빠르게 하라고 권한다. 그러나 조심해야 한다. 자리 옮김
|x>>1|은 음의 홀수에서 $-\infty$ 쪽으로 내림하므로 |x/2|와 결과가 다르다. 이를테면
|-3>>1=-2|이지만 |-3/2=-1|이다. 그렇게 바꾼 \MF는 ``평행 이동을 보존하는'' 산술의 \MF가 되어,
\.{TRAP} 시험의 기록과 어긋날 수 있다. 여기서는 나눗셈을 그대로 둔다. \GO/ 컴파일러는
|x/2|를 자리 옮김 몇 개로 바꾸어 주므로 손해도 없다.
@^system dependencies@>

@<정의@>=
func half(x int32) int32 { return x / 2 }

@ 계산 하나가 서브루틴을 여러 번 부를 수도 있는데, 산술 넘침이 일어났을 때 오류 메시지를
여러 번 내지 않는 것이 바람직하다. 그래서 아래의 루틴들은 사용자에게 오류를 바로 알리는 대신
전역 변수 |arithError|를 |true|로 놓는다.
@^overflow in arithmetic@>

@<전역 변수@>=
var @!arithError bool // 최근에 산술 넘침이 일어났나?

@ @<핵심 변수들의...@>=
arithError = false

@ 중요한 곳에서 프로그램은 |checkArith|를 불러 산술 오류가 있었는지 검사한다.

@<정의@>=
func checkArith() {
	if arithError {
		clearArith()
	}
}

@ @<함수들@>=
func clearArith() {
	printErr("Arithmetic overflow")
@.Arithmetic overflow@>
	help4("Uh, oh. A little while ago one of the quantities that I was",
		"computing got too large, so I'm afraid your answers will be",
		"somewhat askew. You'll probably have to adopt different",
		"tactics next time. But I shall try to carry on anyway.")
	reportError()
	arithError = false
}

@ 덧셈이 넘치지 않는지 늘 검사하지는 않는다. 그러나 넘침이 그리 드물지 않을 만한 곳에서는
루틴 |slowAdd|를 쓴다.

@<함수들@>=
func slowAdd(x, y int32) int32 {
	if x >= 0 {
		if y <= elGordo-x {
			return x + y
		}
		arithError = true
		return elGordo
	}
	if -y <= elGordo+x {
		return x + y
	}
	arithError = true
	return -elGordo
}

@ 고정 소수점 산술은 $2^{-16}$의 배수인 {\sl 눈금 정수\/}(scaled integer)로 한다. 다시 말하면
이진 소수점이 이진 컴퓨터 낱말의 오른쪽 끝에서 열여섯 비트 위치에 있다고 가정한다.

@<정의@>=
const (
	@!quarterUnit = 0o40000 // $2^{14}$, 0.250000을 나타낸다
	@!halfUnit = 0o100000 // $2^{15}$, 0.50000을 나타낸다
	@!threeQuarterUnit = 0o140000 // $3\cdot2^{14}$, 0.75000을 나타낸다
	@!unity = 0o200000 // $2^{16}$, 1.00000을 나타낸다
	@!two = 0o400000 // $2^{17}$, 2.00000을 나타낸다
	@!three = 0o600000 // $2^{17}+2^{16}$, 3.00000을 나타낸다
)

@ @<전역 형@>=
type @!scaled = int32 // 이 형은 눈금 정수에 쓴다
type @!smallNumber = int32 // 이 형은 이름이 다 말해 준다; |0 .. 63|

@ 다음 함수는 주어진 십진 소수 $(.d_0d_1\ldots d_{k-1})$로부터 눈금 정수를 만드는 데 쓴다.
여기서 |0<=k<=17|이다. 숫자 $d_i$는 |dig[i]|에 주어지고, 계산은 올바르게 반올림한 결과를 낸다.

@<함수들@>=
func roundDecimals(k smallNumber) scaled { // 십진 소수를 바꾼다
	var a int32 // 누산기
	a = 0
	for k > 0 {
		k--
		a = (a + dig[k]*two) / 10
	}
	return half(a + 1)
}

@ 거꾸로, 다음은 |printInt|와 비슷한 프로시저다. 이 프로시저의 출력을 나중에 \MF가 읽어서
위의 |roundDecimals| 루틴으로 바꾸면 원래의 값이 정확히 다시 만들어진다. 값이 정수가 아닐
때에만 소수점을 찍는다. 가장 적은 개수의 소수 자리로 결과를 찍는 방법이 여럿 있으면, 그
가운데 원래 값에 가장 가까운 것을 고른다.

루프의 불변 관계는, 앞으로 찍을 십진 숫자들의 나열이 범위
$s-\delta\le10\cdot2^{16}f<s$에 있는 분수~$f$를 이룰 때, 그리고 오직 그때에만 원래의 수를
내놓는다는 것이다. 값 $f=0$이 이 조건을 만족할 때, 그리고 오직 그때에만 멈출 수 있다. 루프는 $s$가
0이 될 수 있기 전에 끝난다.

이를테면 $0.1$을 읽으면 |roundDecimals|는 $\lfloor 6553.6+{1\over2}\rfloor=6554$를 만든다.
이 값을 찍을 때 루프는 처음에 $s=65545$, $\delta=10$으로 시작해서 숫자 `\.1'을 찍고 나면 $s=10$,
$\delta=100$이 되어 멈춘다. 그래서 `\.{0.1}'이 찍힌다. 값 6554는 $0.1000061\ldots$이지만,
다섯 자리까지 다 찍지 않아도 되돌아올 수 있는 가장 짧은 꼴이 고스란히 나오는 것이다.

@<기본 인쇄...@>=
func printScaled(s scaled) { // 다섯 자리로 반올림한 눈금 실수를 찍는다
	var delta scaled // 허용되는 부정확함의 양
	if s < 0 {
		printChar('-')
		s = -s // 음수면 부호를 찍는다
	}
	printInt(s / unity) // 정수 부분을 찍는다
	s = 10*(s%unity) + 5
	if s != 5 {
		delta = 10
		printChar('.')
		for {
			if delta > unity {
				s = s + 0o100000 - (delta / 2) // 마지막 숫자를 반올림한다
			}
			printChar('0' + (s / unity))
			s = 10 * (s % unity)
			delta *= 10
			if s <= delta {
				break
			}
		}
	}
}

@ 괄호 안에 쉼표로 가른 눈금 양 두 개를 찍고 싶을 때가 자주 있다.

@<기본 인쇄...@>=
func printTwo(x, y scaled) { // `|(x,y)|'를 찍는다
	printChar('(')
	printScaled(x)
	printChar(',')
	printScaled(y)
	printChar(')')
}

@ \MF\ 프로그램의 |scaled| 양들은 대개 절댓값이 $2^{12}$보다 작다고 여기므로, \MF는 내부
산술의 상당 부분을 유효 숫자 28비트로 한다. 형 |fraction|은 이진 소수점이 오른쪽에서 28비트
위치에 있다고 여기는 눈금 정수다.

@<정의@>=
const (
	@!fractionHalf = 0o1000000000 // $2^{27}$, 0.50000000을 나타낸다
	@!fractionOne = 0o2000000000 // $2^{28}$, 1.00000000을 나타낸다
	@!fractionTwo = 0o4000000000 // $2^{29}$, 2.00000000을 나타낸다
	@!fractionThree = 0o6000000000 // $3\cdot2^{28}$, 3.00000000을 나타낸다
	@!fractionFour = 0o10000000000 // $2^{30}$, 4.00000000을 나타낸다
)

@ @<전역 형@>=
type @!fraction = int32 // 이 형은 눈금 분수에 쓴다

@ 사실 앞에서 말한 두 가지 눈금만으로는 모자란다. \MF에는 또 하나의 눈금이 있는데, 각도를
$2^{-20}$도 단위로 나타내는 데 내부적으로 쓴다.

세 가지 눈금을 나란히 놓으면 다음과 같다. 모두 같은 32비트 정수이고, 이진 소수점의 위치만
다르다.
$$\vbox{\halign{#\hfil\quad&#\hfil\quad&#\hfil\cr
형&1의 표현&쓰임\cr
\noalign{\smallskip\hrule\smallskip}
|scaled|&$2^{16}=65536$&사용자가 보는 수치, 좌표\cr
|fraction|&$2^{28}$&$\sin$, $\cos$, 매개변수 $t$, 비율\cr
|angle|&$2^{20}$ (1도)&방향과 각도\cr}}$$

@<정의@>=
const (
	@!fortyFiveDeg = 0o264000000 // $45\cdot2^{20}$, $45^\circ$를 나타낸다
	@!ninetyDeg = 0o550000000 // $90\cdot2^{20}$, $90^\circ$를 나타낸다
	@!oneEightyDeg = 0o1320000000 // $180\cdot2^{20}$, $180^\circ$를 나타낸다
	@!threeSixtyDeg = 0o2640000000 // $360\cdot2^{20}$, $360^\circ$를 나타낸다
)

@ @<전역 형@>=
type @!angle = int32 // 이 형은 눈금 각도에 쓴다

@ 루틴 |makeFraction|은 주어진 정수 |p|와~|q|로부터 |p/q|에 해당하는 |fraction|을 만든다.
두 수 |p|와 |q|가 양수이면 이 함수는 정수 $f=\lfloor2^{28}p/q+{1\over2}\rfloor$를 계산한다. 두 수가
같은 눈금 형 |t|라면 ``형 관계'' |makeFraction(t,t)=fraction|이 성립한다. 또 이 서브루틴을
``거꾸로'' 써서 눈금 형 사이의 관계 |makeFraction(t,fraction)=t|를 얻을 수도 있다.

결과의 크기가 $2^{31}$ 이상이 될 것 같으면 |makeFraction|은 |arithError=true|로 놓는다.
\MF의 내부 계산은 대부분 이런 오류를 피하도록 설계되었다.

64비트 정수 산술을 쓸 수 있다면 그냥 |@t$(2^{29}$@>*p+q)/(2*q)|를 계산하면 된다는 데 주목하라.
그러나 32비트 산술에 묶여 있다면 다중 정밀도 묘기를 부리거나 간단하지만 느린 반복을 써야
한다. 다중 정밀도 기법은 여기서 쓴 코드보다 세 배쯤 빠르겠지만, 곱셈과 나눗셈이 열여섯 번쯤
더 드는 비교적 길고 까다로운 코드가 될 것이다.

이 연산은 \MF의 ``안쪽 루프''의 일부다. 실제로 아래 코드를 그대로 두면 이것이 실행 시간(입출력을
빼고)의 거의 10\pct!를 차지할 것이다. 그러므로 기계에 맞게 고쳐 쓰면 \MF가 더 빨리 돈다. 지금의
구현은 이식성이 아주 높지만 느리다. 처음 단계를 빼면 곱셈과 나눗셈을 피한다. 시스템 마법사들은
이것을 바꾸어 쓸 때 모든 경우에 똑같은 결과를 낸다는 보장이 있는 루틴으로만 바꾸어야 한다.
@^system dependencies@>

\GO/에는 64비트 정수 |int64|가 있으므로 마법사가 아니라도 그렇게 바꿀 수 있다. 그래도 여기서는
크누스의 반복을 그대로 둔다. 이것이 \MF\ 산술의 정의이고, 반복의 불변 관계를 따라가 보는 것도
이 프로그램을 읽는 즐거움 가운데 하나이기 때문이다.

아래에서 말하겠지만, 효율을 위해 기계에 따른 코드로 바꾸어야 할 루틴이 몇 개 더 있다. 그러나 어떤
프로시저가 ``안쪽 루프''의 일부가 아니라면 그런 변경은 권할 만하지 않다. 비용이 너무 크지 않은 한
꾀부리기보다 단순함과 튼튼함이 낫다.
@^inner loop@>

@<함수들@>=
func makeFraction(p, q int32) fraction {
	var f int32 // 앞에 1 비트가 붙은 분수 비트들
	var n int32 // $\vert p/q\vert$의 정수 부분
	var negative bool // 결과의 부호를 바꾸어야 하나?
	var beCareful int32 // 컴파일러의 어떤 최적화를 막는다
	@<|p|와 |q|를 양수로 만들고 결과의 부호를 |negative|에 기억한다@>
	n = p / q
	p = p % q
	if n >= 8 {
		arithError = true
		if negative {
			return -elGordo
		}
		return elGordo
	}
	n = (n - 1) * fractionOne
	@<$f=\lfloor 2^{28}(1+p/q)+{1\over2}\rfloor$를 계산한다@>
	if negative {
		return -(f + n)
	}
	return f + n
}

@ @<|p|와 |q|를 양수로 만들고 결과의 부호를 |negative|에 기억한다@>=
if p >= 0 {
	negative = false
} else {
	p = -p
	negative = true
}
if q <= 0 {
	if debug {
		if q == 0 {
			confusion("/")
		}
	}
@:this can't happen /}{\quad \./@>
	q = -q
	negative = !negative
}

@ 여기의 루프는 |f|, |p|, |q| 사이의 다음 불변 관계를 지킨다. (i)~|0<=p<q|;
(ii)~$fq+p=2^k(q+p_0)$. 여기서 $k$는 정수이고 $p_0$은 |p|의 처음 값이다.

이것은 손으로 하는 긴 나눗셈을 이진법으로 하는 것이다. 몫의 비트를 하나씩 |f|의 오른쪽에
붙여 가는데, 나머지 |p|를 두 배로 해서 |q|를 뺄 수 있으면 1을, 없으면 0을 붙인다. 몫 |f|가
$2^{28}$에 이르면 소수 28비트를 다 얻은 것이고, 마지막에 나머지의 두 배가 |q| 이상이면 1을
더해 반올림한다.

계산을 |(p+p)-q| 대신 |(p-q)+p|로 지정한 데 주목하라. 앞의 것은 넘칠 수 있기 때문이다. 최적화하는
컴파일러가 이 점을 놓치지 않기를 바라자. 계산의 순서가 필요하다는 것을 강조하려고 특별한 변수
|beCareful|을 쓴다. \GO/에서는 정수 산술이 감기도록 언어가 정해 두었으므로, 컴파일러가 두 식이
같은 값을 낸다고 보고 순서를 바꾸더라도 감기는 산술에서는 실제로 같은 값이 나오므로
결과는 달라지지 않는다.
@^inner loop@>

@<$f=\lfloor 2^{28}(1+p/q)+{1\over2}\rfloor$를...@>=
f = 1
for {
	beCareful = p - q
	p = beCareful + p
	if p >= 0 {
		f = f + f + 1
	} else {
		f += f
		p = p + q
	}
	if f >= fractionOne {
		break
	}
}
beCareful = p - q
if beCareful+p >= 0 {
	f++
}

@ 함수 |makeFraction|의 짝은 |takeFraction|으로, 주어진 정수~|q|에 분수~|f|를 곱한다. 피연산자가
양수이면 이것은 |q|와~|f|에 대해 대칭인 함수 $p=\lfloor qf/2^{28}+{1\over2}\rfloor$를 계산한다.

이 루틴은 |makeFraction|보다도 더 ``안쪽 루프''에 가깝다. 지금의 구현은 보통의 작업에서
\MF\ 계산 시간의 20\pct! 가까이를 차지하므로, 기계어나 64비트 산술로 바꾸는 것이 좋다.
@^inner loop@> @^system dependencies@>

@<함수들@>=
func takeFraction(q int32, f fraction) int32 {
	var p int32 // 지금까지의 분수
	var negative bool // 결과의 부호를 바꾸어야 하나?
	var n int32 // |q|의 추가 배수
	var beCareful int32 // 컴파일러의 어떤 최적화를 막는다
	@<|f>=0|이고 |q>=0|인 경우로 줄인다@>
	if f < fractionOne {
		n = 0
	} else {
		n = f / fractionOne
		f = f % fractionOne
		if q <= elGordo/n {
			n = n * q
		} else {
			arithError = true
			n = elGordo
		}
	}
	f = f + fractionOne
	@<$p=\lfloor qf/2^{28}+{1\over2}\rfloor-q$를 계산한다@>
	beCareful = n - elGordo
	if beCareful+p > 0 {
		arithError = true
		n = elGordo - p
	}
	if negative {
		return -(n + p)
	}
	return n + p
}

@ @<|f>=0|이고 |q>=0|인...@>=
if f >= 0 {
	negative = false
} else {
	f = -f
	negative = true
}
if q < 0 {
	q = -q
	negative = !negative
}

@ 이 경우의 불변 관계는 (i)~$\lfloor(qf+p)/2^k\rfloor
=\lfloor qf_0/2^{28}+{1\over2}\rfloor$, 여기서 $k$는 정수이고 $f_0$은 |f|의 처음 값이다;
(ii)~$2^k\le f<2^{k+1}$이다.

이것은 곱셈을 이진법으로 하되, 아래 자리부터 하는 것이다. 분수 |f|의 비트를 오른쪽 끝부터 하나씩
떼어 내면서, 그 비트가 1이면 |p|에 |q|를 더하고, 어느 쪽이든 |p|를 반으로 한다. 이렇게 하면
곱 $qf$의 위쪽 비트들만 남고 아래쪽 비트들은 버려지므로 넘침이 일어나지 않는다. 변수 |p|의 처음
값 $2^{27}$은 마지막 반올림을 위한 ${1\over2}$에 해당한다. 정수 |q|가 $2^{30}$ 이상이면 |p+q|가
넘칠 수 있으므로 |p+half(q-p)|로 계산한다.
@^inner loop@>

@<$p=\lfloor qf/2^{28}+{1\over2}\rfloor-q$를...@>=
p = fractionHalf // 이것은 $2^{27}$이다; 이제 $k=28$로 불변 관계가 성립한다
if q < fractionFour {
	for {
		if odd(f) {
			p = half(p + q)
		} else {
			p = half(p)
		}
		f = half(f)
		if f == 1 {
			break
		}
	}
} else {
	for {
		if odd(f) {
			p = p + half(q-p)
		} else {
			p = half(p)
		}
		f = half(f)
		if f == 1 {
			break
		}
	}
}

@ 어떤 것에 |scaled| 양을 곱하고 싶을 때는 |takeFraction|과 비슷하지만 눈금이 다른 방법을
쓴다. 피연산자가 양수이면 |takeScaled|는 양 $p=\lfloor qf/2^{16}+{1\over2}\rfloor$를 계산한다.

여기서도 할 수 있으면 64비트 산술을 쓰는 것이 좋다. 그렇지 않으면 Computer Modern 글꼴을 만들
때 |takeScaled|가 실행 시간의 2\pct!보다 많이 쓸 것이다.
@^inner loop@>

@<함수들@>=
func takeScaled(q int32, f scaled) int32 {
	var p int32 // 지금까지의 분수
	var negative bool // 결과의 부호를 바꾸어야 하나?
	var n int32 // |q|의 추가 배수
	var beCareful int32 // 컴파일러의 어떤 최적화를 막는다
	@<|f>=0|이고 |q>=0|인...@>
	if f < unity {
		n = 0
	} else {
		n = f / unity
		f = f % unity
		if q <= elGordo/n {
			n = n * q
		} else {
			arithError = true
			n = elGordo
		}
	}
	f = f + unity
	@<$p=\lfloor qf/2^{16}+{1\over2}\rfloor-q$를 계산한다@>
	beCareful = n - elGordo
	if beCareful+p > 0 {
		arithError = true
		n = elGordo - p
	}
	if negative {
		return -(n + p)
	}
	return n + p
}

@ @<$p=\lfloor qf/2^{16}+{1\over2}\rfloor-q$를...@>=
p = halfUnit // 이것은 $2^{15}$이다; 이제 $k=16$으로 불변 관계가 성립한다
@^inner loop@>
if q < fractionFour {
	for {
		if odd(f) {
			p = half(p + q)
		} else {
			p = half(p)
		}
		f = half(f)
		if f == 1 {
			break
		}
	}
} else {
	for {
		if odd(f) {
			p = p + half(q-p)
		} else {
			p = half(p)
		}
		f = half(f)
		if f == 1 {
			break
		}
	}
}

@ 빠짐없이 갖추려고 |makeScaled|도 둔다. 이것은 몫을 |fraction| 대신 |scaled| 수로 계산한다.
다시 말해 피연산자가 양수이면 결과는 $\lfloor2^{16}p/q+{1\over2}\rfloor$다. (이 프로시저는
그리 자주 쓰이지 않으므로 \MF의 안쪽 루프에 들지 않는다.)

@<함수들@>=
func makeScaled(p, q int32) scaled {
	var f int32 // 앞에 1 비트가 붙은 분수 비트들
	var n int32 // $\vert p/q\vert$의 정수 부분
	var negative bool // 결과의 부호를 바꾸어야 하나?
	var beCareful int32 // 컴파일러의 어떤 최적화를 막는다
	if p >= 0 {
		negative = false
	} else {
		p = -p
		negative = true
	}
	if q <= 0 {
		if debug {
			if q == 0 {
				confusion("/")
			}
		}
@:this can't happen /}{\quad \./@>
		q = -q
		negative = !negative
	}
	n = p / q
	p = p % q
	if n >= 0o100000 {
		arithError = true
		if negative {
			return -elGordo
		}
		return elGordo
	}
	n = (n - 1) * unity
	@<$f=\lfloor 2^{16}(1+p/q)+{1\over2}\rfloor$를 계산한다@>
	if negative {
		return -(f + n)
	}
	return f + n
}

@ @<$f=\lfloor 2^{16}(1+p/q)+{1\over2}\rfloor$를...@>=
f = 1
for {
	beCareful = p - q
	p = beCareful + p
	if p >= 0 {
		f = f + f + 1
	} else {
		f += f
		p = p + q
	}
	if f >= unity {
		break
	}
}
beCareful = p - q
if beCareful+p >= 0 {
	f++
}

@ \seclabel{velocity}다음은 앞의 루틴들을 쓰는 전형적인 예다. 이것은 함수
$${1\over3\tau}f(\theta,\phi)=
{\tau^{-1}\bigl(2+\sqrt2\,(\sin\theta-{1\over16}\sin\phi)
 (\sin\phi-{1\over16}\sin\theta)(\cos\theta-\cos\phi)\bigr)\over
3\,\bigl(1+{1\over2}(\sqrt5-1)\cos\theta+{1\over2}(3-\sqrt5\,)\cos\phi\bigr)}$$
를 계산한다. 여기서 $\tau$는 |scaled| ``긴장''(tension) 매개변수다. 이것은 직선 경로에서 각
$\theta$로 출발해서 각 $\phi$로 끝나는 곡선의 첫 조절점을 놓는 \MF의 마법 같은 어림
인자다. (실제로는 이 양이 4를 넘으면 \MF는 그것을 4로 줄인다.)

이 공식은 존 하비(John Hobby)가 찾아낸 것이다. 곡선의 두 조절점은 $z_0+{1\over3}\rho\,
e^{i\theta}(z_1-z_0)$과 $z_1-{1\over3}\sigma\,e^{-i\phi}(z_1-z_0)$에 놓는데(18부), 상대 속도를
$\rho=f(\theta,\phi)/\tau$와 $\sigma=f(\phi,\theta)/\tau$로 정하면 원호를 아주 잘 근사하는 곡선이
나온다. 이 함수가 돌려주는 값은 $\rho/3$이다. 이를테면 $\theta=\phi=90^\circ$이고 $\tau=1$이면
삼각 함수 부분이 사라져 값이 정확히 $2\over3$가 된다. 지름이 $d$인 반원을 베지에 곡선 하나로
그린다면 두 조절점이 양 끝에서 높이 ${2\over3}d$에 놓이고, 그러면 곡선의 한가운데가 정확히
반지름 높이를 지난다. 아래 그림은 $\tau=1$에서 출발각 $\theta$를 바꾸어 가며 $\phi=\theta$인
곡선들을 그린 것이다. 이 그림을 그린 MetaPost도 \MF와 같은 공식을 쓰므로, 대칭인 곡선들은
모두 원호에 아주 가깝다.
$$\mplibcode
beginfig(2);
save u; numeric u; u := 60pt;
for th = 15, 30, 45, 60, 75, 90:
  draw (0,0){dir th} .. {dir -th}(2u,0) withpen pencircle scaled .4pt;
endfor
draw (0,0)--(2u,0) dashed evenly;
dot((0,0)); dot((2u,0));
label.bot(btex $z_0$ etex, (0,0)); label.bot(btex $z_1$ etex, (2u,0));
label.lft(btex $\theta=90^\circ$ etex, (0,u));
endfig;
\endmplibcode$$

삼각 함수 부분에서 $\sqrt2$를 곱하는 양은 $\sqrt2$보다 작다. (그것은 여덟 항의 합인데, 각 항의
절댓값은 $\sin\theta\cos\theta\le{1\over2}$ 같은 관계로 묶을 수 있다.) 그러므로 분자는 양수다.
그리고 긴장 $\tau$는 적어도 $3\over4$로 묶여 있으므로 분자는 $16\over3$보다 작다. 분모는 음이
아니고 많아야~6이다. 따라서 아래의 고정 소수점 계산은 32비트 컴퓨터 낱말의 범위 안에 머문다는
보장이 있다.

각 $\theta$와 $\phi$는 |fraction| 인자 |st|, |ct|, |sf|, |cf|로 간접적으로 주어진다. 이것들은 각각
$\sin\theta$, $\cos\theta$, $\sin\phi$, $\cos\phi$를 나타낸다.

@<함수들@>=
func velocity(st, ct, sf, cf fraction, t scaled) fraction {
	var acc, num, denom int32 // 중간 계산을 위한 레지스터들
	acc = takeFraction(st-(sf/16), sf-(st/16))
	acc = takeFraction(acc, ct-cf)
	num = fractionTwo + takeFraction(acc, 379625062)
	@t\qquad@>// $2^{28}\sqrt2\approx379625062.497$
	denom = fractionThree + takeFraction(ct, 497706707) + takeFraction(cf, 307599661)
	@t\qquad@>// $3\cdot2^{27}\cdot(\sqrt5-1)\approx497706706.78$이고
	@t\qquad@>// $3\cdot2^{27}\cdot(3-\sqrt5\,)\approx307599661.22$
	if t != unity {
		num = makeScaled(num, t) // |makeScaled(fraction,scaled)=fraction|
	}
	if num/4 >= denom {
		return fractionFour
	}
	return makeFraction(num, denom)
}

@ 다음은 조금 다른 서브루틴으로, 주어진 정수 $(a,b,c,d)$에 대해 $ab$가 $cd$보다 큰지, 같은지,
작은지를 엄밀하게 검사한다. 대개는 빨리 결정이 난다. 결과는 세 경우에 각각 $+1$, 0, $-1$이다.

곱 $ab$와 $cd$를 직접 계산하면 넘칠 수 있으므로, 이 루틴은 $a/d$와 $c/b$를 비교한다. 몫이
다르면 거기서 결정이 나고, 같으면 나머지로 이루어진 더 작은 문제 하나가 남는다. 이것은 두
분수를 연분수로 펼쳐 가며 비교하는 것과 같다. 유클리드 호제법처럼 수가 빠르게 줄어든다.

@<함수들@>=
func abVsCd(a, b, c, d int32) int32 {
	var q, r int32 // 임시 레지스터들
	@<|a,c>=0|이고 |b,d>0|인 경우로 줄인다@>
	for {
		q = a / d
		r = c / b
		if q != r {
			if q > r {
				return 1
			}
			return -1
		}
		q = a % d
		r = c % b
		if r == 0 {
			if q == 0 {
				return 0
			}
			return 1
		}
		if q == 0 {
			return -1
		}
		a = b
		b = q
		c = d
		d = r
	} // 이제 |a>d>0|이고 |c>b>0|이다
}

@ @<|a,c>=0|이고...@>=
if a < 0 {
	a = -a
	b = -b
}
if c < 0 {
	c = -c
	d = -d
}
if d <= 0 {
	if b >= 0 {
		if (a == 0 || b == 0) && (c == 0 || d == 0) {
			return 0
		}
		return 1
	}
	if d == 0 {
		if a == 0 {
			return 0
		}
		return -1
	}
	q = a
	a = c
	c = q
	q = -b
	b = -d
	d = q
} else if b <= 0 {
	if b < 0 {
		if a > 0 {
			return -1
		}
	}
	if c == 0 {
		return 0
	}
	return -1
}

@ 기계에 의존하지 않는 방식으로 짠 간단한 반올림과 잘라내기 연산들로 이 기초 루틴들을
마무리하자. 인자가 $-2^{31}\le x<2^{31}$이기만 하면 언제나 넘침 없이 돌아가게 하려고 루틴들이 조금
복잡해졌다.

@<함수들@>=
func floorScaled(x scaled) scaled { // $2^{16}\lfloor x/2^{16}\rfloor$
	var beCareful int32 // 임시 레지스터
	if x >= 0 {
		return x - (x % unity)
	}
	beCareful = x + 1
	return x + ((-beCareful) % unity) + 1 - unity
}

func floorUnscaled(x scaled) int32 { // $\lfloor x/2^{16}\rfloor$
	var beCareful int32 // 임시 레지스터
	if x >= 0 {
		return x / unity
	}
	beCareful = x + 1
	return -(1 + ((-beCareful) / unity))
}

func roundUnscaled(x scaled) int32 { // $\lfloor x/2^{16}+.5\rfloor$
	var beCareful int32 // 임시 레지스터
	if x >= halfUnit {
		return 1 + ((x - halfUnit) / unity)
	} else if x >= -halfUnit {
		return 0
	}
	beCareful = x + 1
	return -(1 + ((-beCareful - halfUnit) / unity))
}

func roundFraction(x fraction) scaled { // $\lfloor x/2^{12}+.5\rfloor$
	var beCareful int32 // 임시 레지스터
	if x >= 2048 {
		return 1 + ((x - 2048) / 4096)
	} else if x >= -2048 {
		return 0
	}
	beCareful = x + 1
	return -(1 + ((-beCareful - 2048) / 4096))
}

@* 대수 함수와 초월 함수.
\MF는 필요한 특수 함수를 모두 맨바닥부터 계산한다. 실수 산술이나 사인과 코사인 따위를
위한 시스템 서브루틴에는 기대지 않는다. 그래서 어느 컴퓨터에서나 정확히 같은 값이 나온다.

@ 눈금 정수 |x|의 제곱근을 얻으려면 $s=\lfloor 2^8\!\sqrt x +{1\over2}\rfloor$를 계산하면 된다.
양수 $x$에 대해 이 값은 $2^{16}x-s\le s^2<2^{16}x+s$를 만족하는 유일한 정수다. 다음 서브루틴은 불변
관계 $x=2^{46-2k}x_0\bmod 2^{30}$, $0<y=\lfloor 2^{16-2k}x_0\rfloor-s^2+s\le q=2s$를 지키는 반복
방법으로 $s$를 정한다. 여기서 $x_0$은 $x$의 처음 값이다. 다만 첫 반복을 시작할 때는 $y$의
값이 0일 수도 있다.

이것은 학교에서 배우는 ``자리마다 제곱근 구하기''를 이진법으로 하는 것이다. 한 번 돌 때마다
$x_0$의 비트 두 개를 |y|로 끌어내리고, 근의 다음 비트가 1인지 0인지를 결정해서 |q|에 반영한다.

@<함수들@>=
func squareRt(x scaled) scaled {
	var k smallNumber // 반복을 다스리는 계수기
	var y, q int32 // 중간 계산을 위한 레지스터들
	if x <= 0 {
		@<0이나 음수 인자의 제곱근을 처리한다@>
	}
	k = 23
	q = 2
	for x < fractionTwo { // 곧 $x<2^{29}$인 동안
		k--
		x = x + x + x + x
	}
	if x < fractionFour {
		y = 0
	} else {
		x = x - fractionFour
		y = 1
	}
	for {
		@<|x|, |y|, |q| 사이의 불변 관계를 지키며 |k|를 1 줄인다@>
		if k == 0 {
			break
		}
	}
	return half(q)
}

@ @<0이나 음수 인자의...@>=
if x < 0 {
	printErr("Square root of ")
@.Square root...replaced by 0@>
	printScaled(x)
	printStr(" has been replaced by 0")
	help2("Since I don't take square roots of negative numbers,",
		"I'm zeroing this one. Proceed, with fingers crossed.")
	reportError()
}
return 0

@ @<|x|, |y|, |q| 사이의...@>=
x += x
y += y
if x >= fractionFour { // $|fractionFour|=2^{30}$임에 주목하라
	x = x - fractionFour
	y++
}
x += x
y = y + y - q
q += q
if x >= fractionFour {
	x = x - fractionFour
	y++
}
if y > q {
	y = y - q
	q = q + 2
} else if y <= 0 {
	q = q - 2
	y = y + q
}
k--

@ 피타고라스 덧셈 $\psqrt{a^2+b^2}$는 클리브 몰러와 도널드 모리슨이 찾아낸 우아한 반복
방법으로 구현한다[{\sl IBM Journal of Research and Development\/ \bf27} (1983), 577--581].
@^Moler, Cleve Barry@>
@^Morrison, Donald Ross@>
이 방법은 |a|와~|b|의 피타고라스 합이 변하지 않게 두 수를 고치면서 작은 인자를 줄여 간다.

@<함수들@>=
func pythAdd(a, b int32) int32 {
	var r fraction // |a|와 |b|를 바꾸는 데 쓰는 레지스터
	var big bool // 결과가 위험하게 $2^{31}$에 가까운가?
	a = abs(a)
	b = abs(b)
	if a < b {
		r = b
		b = a
		a = r
	} // 이제 |0<=b<=a|다
	if b > 0 {
		if a < fractionTwo {
			big = false
		} else {
			a = a / 4
			b = b / 4
			big = true
		} // 산술 넘침을 피하려고 정밀도를 줄였다
		@<|a|를 $\psqrt{a^2+b^2}$의 근삿값으로 바꾼다@>
		if big {
			if a < fractionTwo {
				a = a + a + a + a
			} else {
				arithError = true
				a = elGordo
			}
		}
	}
	return a
}

@ 핵심 생각은 벡터 $(a,b)$를 점 $(a,b/2)$를 지나는 직선에 대해 뒤집는 것이다. 그러면 길이는
그대로이면서 $b$는 $b^3/(4a^2+b^2)$로 줄어든다. 비율 $b/a$가 한 번에 세제곱으로
작아지므로 수렴이 아주 빠르다. 처음 $b/a\le1$이면 $1/5$, $1/500$, $10^{-8}$쯤, \dots로 줄어들어서
몇 번만 돌면 $b^2/a^2$가 |fraction|의 정밀도 아래로 내려간다.
$$\mplibcode
beginfig(3);
save u, a, b, p, q, m; numeric u, a, b; pair p, q, m; u := 90pt;
a := 1; b := .8;
p := (a,b)*u; m := (a,b/2)*u;
q := p reflectedabout(m, m + dir(angle(m) + 90));
draw (0,0)--p withpen pencircle scaled .6pt;
draw (0,0)--q withpen pencircle scaled .6pt;
draw (0,0)--(1.5u,0);
draw (m - .35u*dir(angle(m)+90))--(m + .5u*dir(angle(m)+90)) dashed evenly;
draw (0,0)--m dashed withdots scaled .5;
draw p--q withpen pencircle scaled .2pt dashed evenly scaled .5;
draw subpath(0, 1.2) of fullcircle scaled (2*abs p) withpen pencircle scaled .2pt;
dot(p); dot(q); dot(m);
label.top(btex $(a,b)$ etex, p);
label.lrt(btex $(a',b')$ etex, q);
label.rt(btex $(a,b/2)$ etex, m);
endfig;
\endmplibcode$$
코드에서 |r|은 먼저 $b^2/a^2$이 되고, 그다음 $r/(4+r)=b^2/(4a^2+b^2)$이 된다. 새 값은
$a'=a+2ar$, $b'=br$이다.

@<|a|를 $\psqrt{a^2+b^2}$의...@>=
for {
	r = makeFraction(b, a)
	r = takeFraction(r, r) // 이제 $r\approx b^2/a^2$이다
	if r == 0 {
		break
	}
	r = makeFraction(r, fractionFour+r)
	a = a + takeFraction(a+a, r)
	b = takeFraction(b, r)
}

@ 다음은 $\psqrt{a^2-b^2}$를 위한 비슷한 알고리즘이다. 이 방법은 $b$가 $a$에 가까우면 느리게
수렴하지만, 그 밖에는 잘 돌아간다.

@<함수들@>=
func pythSub(a, b int32) int32 {
	var r fraction // |a|와 |b|를 바꾸는 데 쓰는 레지스터
	var big bool // 입력이 위험하게 $2^{31}$에 가까운가?
	a = abs(a)
	b = abs(b)
	if a <= b {
		@<잘못된 |pythSub|를 처리하고 |a=0|으로 놓는다@>
	} else {
		if a < fractionFour {
			big = false
		} else {
			a = half(a)
			b = half(b)
			big = true
		}
		@<|a|를 $\psqrt{a^2-b^2}$의 근삿값으로 바꾼다@>
		if big {
			a = a + a
		}
	}
	return a
}

@ @<|a|를 $\psqrt{a^2-b^2}$의...@>=
for {
	r = makeFraction(b, a)
	r = takeFraction(r, r) // 이제 $r\approx b^2/a^2$이다
	if r == 0 {
		break
	}
	r = makeFraction(r, fractionFour-r)
	a = a - takeFraction(a+a, r)
	b = takeFraction(b, r)
}

@ @<잘못된 |pythSub|를...@>=
if a < b {
	printErr("Pythagorean subtraction ")
	printScaled(a)
	printStr("+-+")
	printScaled(b)
	printStr(" has been replaced by 0")
@.Pythagorean...@>
	help2("Since I don't take square roots of negative numbers,",
		"I'm zeroing this one. Proceed, with fingers crossed.")
	reportError()
}
a = 0

@ 로그와 지수의 서브루틴에는 표가 둘 쓰인다. 첫째는 간단해서, 표 |twoToThe[k]|는 $2^k$와 같다.
둘째는 계산이 좀 더 드는데, 저자는 그것을 제대로 계산했다고 주장한다. 표 |specLog[k]|는
$\ln\bigl(1/(1-2^{-k})\bigr)= 2^{-k}+{1\over2}2^{-2k}+{1\over3}2^{-3k}+\cdots\,$에 $2^{27}$을
곱해 가장 가까운 정수로 반올림한 것이다.

@<전역 변수@>=
var @!twoToThe [31]int32 // 2의 거듭제곱
var @!specLog [29]int32 // 특별한 로그들; 첨자는 |1 .. 28|

@ @<초기화를 위한 지역 변수@>=
var @!k int32 // 만능 루프 첨자

@ @<핵심 변수들의...@>=
twoToThe[0] = 1
for k = 1; k <= 30; k++ {
	twoToThe[k] = 2 * twoToThe[k-1]
}
specLog[1] = 93032640
specLog[2] = 38612034
specLog[3] = 17922280
specLog[4] = 8662214
specLog[5] = 4261238
specLog[6] = 2113709
specLog[7] = 1052693
specLog[8] = 525315
specLog[9] = 262400
specLog[10] = 131136
specLog[11] = 65552
specLog[12] = 32772
specLog[13] = 16385
for k = 14; k <= 27; k++ {
	specLog[k] = twoToThe[27-k]
}
specLog[28] = 1

@ 다음은 |scaled| 양의 자연로그에 $2^8$을 곱한 것을 계산하는 루틴이다. 인자 |x|가 주어진 양의
정수일 때, 그 결과는 $2^{24}\ln(x/2^{16})$의 정수 근삿값이다.

방법은 {\sl The Art of Computer Programming\/}의 연습 문제 1.2.2--25를 바탕으로 한다. 주
반복 동안 $1\le 2^{-30}x<1/(1-2^{1-k})$이고, $2^{30}x$의 로그를 누산 레지스터~$y$에 더하는
일이 남아 있다. 계산하는 동안 $y$에는 정확도의 보조 비트 세 개를 더 두고, 처음의 인자 줄이기
동안에는 |y|를 넓히는 보조 비트 열여섯 개를 |z|에 둔다. (변수 |z|가 음수가 되지 않도록 |z|에
$100\cdot2^{16}=6553600$을 더하고 |y|에서 100을 뺀다. 또 |y|에서 실제로 빼는 양은 100이 아니라
96인데, 마지막에 8로 나누기 전에 반올림을 위해 4를 더하고 싶기 때문이다.)

요점은 이렇다. 어떤 수 $x$에 $1-2^{-k}$ 꼴의 인수를 거듭 곱해서 $x$를 1로 만들 수 있다면,
$\ln x$는 곱한 인수들의 $\ln\bigl(1/(1-2^{-k})\bigr)$, 곧 |specLog[k]|들의 합이다. 그리고
$x(1-2^{-k})=x-x/2^k$이므로 곱셈은 자리 옮김과 뺄셈 하나면 된다.

@<함수들@>=
func mLog(x scaled) scaled {
	var y, z int32 // 보조 레지스터들
	var k int32 // 반복 계수기
	if x <= 0 {
		@<양이 아닌 수의 로그를 처리한다@>
	}
	y = 1302456956 + 4 - 100 // $14\times2^{27}\ln2\approx1302456956.421063$
	z = 27595 + 6553600 // 그리고 $2^{16}\times .421063\approx 27595$
	for x < fractionFour {
		x += x
		y = y - 93032639
		z = z - 48782
	} // $2^{27}\ln2\approx 93032639.74436163$이고
	@t\qquad@>// $2^{16}\times.74436163\approx 48782$
	y = y + (z / unity)
	k = 2
	for x > fractionFour+4 {
		@<|x|에 $2^{-k}$의 인수를 곱할 수 있을 때까지 |k|를 늘리고, 그에 맞게 $y$를 고친다@>
	}
	return y / 8
}

@ @<|x|에 $2^{-k}$의...@>=
z = ((x - 1) / twoToThe[k]) + 1 // $z=\lceil x/2^k\rceil$
for x < fractionFour+z {
	z = half(z + 1)
	k = k + 1
}
y = y + specLog[k]
x = x - z

@ @<양이 아닌 수의 로그를...@>=
printErr("Logarithm of ")
@.Logarithm...replaced by 0@>
printScaled(x)
printStr(" has been replaced by 0")
help2("Since I don't take logs of non-positive numbers,",
	"I'm zeroing this one. Proceed, with fingers crossed.")
reportError()
return 0

@ 거꾸로, 지수 루틴은 |x|가 |scaled|일 때 $\exp(x/2^8)$을 계산한다. 인자 |x|를 정수로 보면 결과는
$2^{16}\exp(x/2^{24})$의 정수 근삿값이다.

@<함수들@>=
func mExp(x scaled) scaled {
	var k smallNumber // 루프를 다스리는 첨자
	var y, z int32 // 보조 레지스터들
	if x > 174436200 { // $2^{24}\ln((2^{31}-1)/2^{16})\approx 174436199.51$
		arithError = true
		return elGordo
	}
	if x < -197694359 { // $2^{24}\ln(2^{-1}/2^{16})\approx-197694359.45$
		return 0
	}
	if x <= 0 {
		z = -8 * x
		y = 0o4000000 // $y=2^{20}$
	} else {
		if x <= 127919879 {
			z = 1023359037 - 8*x
			@t\qquad@>// $2^{27}\ln((2^{31}-1)/2^{20})\approx 1023359037.125$
		} else {
			z = 8 * (174436200 - x) // |z|는 언제나 음이 아니다
		}
		y = elGordo
	}
	@<|y|에 $\exp(-z/2^{27})$을 곱한다@>
	if x <= 127919879 {
		return (y + 8) / 16
	}
	return y
}

@ 여기의 생각은 |z|에서 |specLog[k]|를 빼는 것이 |y|에 $1-2^{-k}$를 곱하는 것에 해당한다는
것이다.

미묘한 점 하나(이것은 확인해야 했다)는, $x=127919879$이면 |y|의 값이 |y+8|이 넘치지 않을
만큼 줄어든다는 것이다. 실제로 이 경우에 $z$는 5가 되고, |y|는 |k=25|일 때 64만큼, |k=27|일 때
16만큼 줄어든다.

@<|y|에 $\exp(-z/2^{27})$을...@>=
k = 1
for z > 0 {
	for z >= specLog[k] {
		z = z - specLog[k]
		y = y - 1 - ((y - twoToThe[k-1]) / twoToThe[k])
	}
	k++
}

@ 삼각 서브루틴들은 보조 표 |specAtan|을 하나 쓴다. 그 항목 |specAtan[k]|는 탄젠트가~$1/2^k$인 |angle|의
근삿값을 담는다.

@<전역 변수@>=
var @!specAtan [27]angle // $\arctan2^{-k}$에 $2^{20}\cdot180/\pi$를 곱한 것; 첨자는 |1 .. 26|

@ @<핵심 변수들의...@>=
specAtan[1] = 27855475
specAtan[2] = 14718068
specAtan[3] = 7471121
specAtan[4] = 3750058
specAtan[5] = 1876857
specAtan[6] = 938658
specAtan[7] = 469357
specAtan[8] = 234682
specAtan[9] = 117342
specAtan[10] = 58671
specAtan[11] = 29335
specAtan[12] = 14668
specAtan[13] = 7334
specAtan[14] = 3667
specAtan[15] = 1833
specAtan[16] = 917
specAtan[17] = 458
specAtan[18] = 229
specAtan[19] = 115
specAtan[20] = 57
specAtan[21] = 29
specAtan[22] = 14
specAtan[23] = 7
specAtan[24] = 4
specAtan[25] = 2
specAtan[26] = 1

@ \seclabel{octants}정수 |x|와 |y|가 주어지고 둘 다 0은 아니라고 하자. 함수 |nArg|는 탄젠트가 방향 $(x,y)$를
가리키는 |angle|을 돌려준다. 이 서브루틴은 먼저 올바른 팔분면을 정하고, 그다음 |0<=y<=x|인 문제를
푼 다음, 결과를 알맞게 바꾸어 |-oneEightyDeg<=@t$\theta$@><=oneEightyDeg| 범위의 답을
돌려준다. (좌표가 |y=0|이고 |x<0|이면 답은 |+oneEightyDeg|이지만, 이를테면 |y=-1|이고 $x=-2^{30}$이면
|-oneEightyDeg|라는 답도 나올 수 있다.)

팔분면은 ``그레이 코드''로 나타내는데, 그렇게 하는 것이 계산이 가장 단순하다. 세 비트가 저마다
변환 하나를 뜻한다. 비트 |negateX|는 $x$의 부호를 바꾸었다는 뜻이고, |negateY|는 $y$의 부호를,
|switchXAndY|는 $x$와 $y$를 맞바꾸었다는 뜻이다. 첫 팔분면의 점에 이 변환들을 거꾸로 하면
원래의 점이 나온다. 아래 그림에서 팔분면의 이름 밑의 수가 그 코드다. 코드에서 1을 뺀 세 비트를
보면 이웃한 팔분면끼리는 비트 하나만 다르다.
$$\mplibcode
beginfig(4);
save u; numeric u; u := 52pt;
for k = 0 upto 3: draw (dir(45k)*-1.15u)--(dir(45k)*1.15u) withpen pencircle scaled .3pt; endfor
draw fullcircle scaled 2.3u withpen pencircle scaled .3pt;
label(btex \vbox{\halign{\hfil#\hfil\cr 첫째\cr 1\cr}} etex, dir(22.5)*.72u);
label(btex \vbox{\halign{\hfil#\hfil\cr 둘째\cr 5\cr}} etex, dir(67.5)*.72u);
label(btex \vbox{\halign{\hfil#\hfil\cr 셋째\cr 6\cr}} etex, dir(112.5)*.72u);
label(btex \vbox{\halign{\hfil#\hfil\cr 넷째\cr 2\cr}} etex, dir(157.5)*.72u);
label(btex \vbox{\halign{\hfil#\hfil\cr 다섯째\cr 4\cr}} etex, dir(202.5)*.72u);
label(btex \vbox{\halign{\hfil#\hfil\cr 여섯째\cr 8\cr}} etex, dir(247.5)*.72u);
label(btex \vbox{\halign{\hfil#\hfil\cr 일곱째\cr 7\cr}} etex, dir(292.5)*.72u);
label(btex \vbox{\halign{\hfil#\hfil\cr 여덟째\cr 3\cr}} etex, dir(337.5)*.72u);
label.rt(btex $x$ etex, (1.15u,0)); label.top(btex $y$ etex, (0,1.15u));
endfig;
\endmplibcode$$

@<정의@>=
const (
	@!negateX = 1
	@!negateY = 2
	@!switchXAndY = 4
	@!firstOctant = 1
	@!secondOctant = firstOctant + switchXAndY
	@!thirdOctant = firstOctant + switchXAndY + negateX
	@!fourthOctant = firstOctant + negateX
	@!fifthOctant = firstOctant + negateX + negateY
	@!sixthOctant = firstOctant + switchXAndY + negateX + negateY
	@!seventhOctant = firstOctant + switchXAndY + negateY
	@!eighthOctant = firstOctant + negateY
)

@ @<함수들@>=
func nArg(x, y int32) angle {
	var z angle // 보조 레지스터
	var t int32 // 임시 저장소
	var k smallNumber // 루프 계수기
	var octant int32 // 팔분면 코드
	if x >= 0 {
		octant = firstOctant
	} else {
		x = -x
		octant = firstOctant + negateX
	}
	if y < 0 {
		y = -y
		octant = octant + negateY
	}
	if x < y {
		t = y
		y = x
		x = t
		octant = octant + switchXAndY
	}
	if x == 0 {
		@<정의되지 않는 편각을 처리한다@>
	}
	@<변수 |z|를 $(x,y)$의 편각으로 놓는다@>
	@<|z|와 |octant|에 따라 알맞은 답을 돌려준다@>
}

@ @<정의되지 않는 편각을...@>=
printErr("angle(0,0) is taken as zero")
@.angle(0,0)...zero@>
help2("The `angle' between two identical points is undefined.",
	"I'm zeroing this one. Proceed, with fingers crossed.")
reportError()
return 0

@ @<|z|와 |octant|에 따라...@>=
switch octant {
case firstOctant:
	return z
case secondOctant:
	return ninetyDeg - z
case thirdOctant:
	return ninetyDeg + z
case fourthOctant:
	return oneEightyDeg - z
case fifthOctant:
	return z - oneEightyDeg
case sixthOctant:
	return -z - ninetyDeg
case seventhOctant:
	return z - ninetyDeg
case eighthOctant:
	return -z
} // 다른 경우는 없다
panic("nArg")

@ 이 지점에서는 |x>=y>=0|이고 |x>0|이다. 정확한 고정 소수점 계산을 하려고 수들을
$2^{28}\le x<2^{29}$가 될 때까지 키우거나 줄인다.

@<변수 |z|를 $(x,y)$의...@>=
for x >= fractionTwo {
	x = half(x)
	y = half(y)
}
z = 0
if y > 0 {
	for x < fractionOne {
		x += x
		y += y
	}
	@<|z|를 $(x,y)$의 편각까지 늘린다@>
}

@ 이 절의 계산 동안 변수 |x|와~|y|는 실제 좌표 $(x,2^{-k}y)$를 나타낸다. 우리는 조건
|x>=y|를 지키므로 탄젠트는 많아야 $2^{-k}$이다. 만일 $x<2y$이면 탄젠트는 $2^{-k-1}$보다 크다.
변환 $(a,b)\mapsto(a+b\tan\phi,b-a\tan\phi)$는 $(a,b)$를 각이 $\phi$만큼 줄어든 좌표로 바꾼다.
특별히 $a=x$, $b=2^{-k}y$, $\tan\phi=2^{-k-1}$인 경우에 이 연산은 여기 보인 아주 간단한
반복이 된다. [존 E. 메깃, {\sl IBM Journal of Research and Development\/ \bf6} (1962),
@^Meggitt, John E.@>
210--226 참조.]

이것은 오늘날 흔히 {\mc CORDIC}이라고 부르는 방법이다. 탄젠트가 $2^{-k}$인 각들로 벡터를 조금씩
돌려 $x$축에 붙이면서, 돌린 각들을 |z|에 모은다. 회전은 곱셈 없이 자리 옮김과 덧셈만으로
이루어진다. 다만 이런 회전은 벡터를 $\sqrt{1+4^{-k}}$배 늘리는데, 편각만 구하면 되므로 그것은
상관없다. 열다섯 번째 단계 뒤로는 $x$가 더 바뀌지 않는다고 보아도 될 만큼 $2^{-2k}$가 작으므로
|x|를 고치지 않는다.

변수 |x|의 처음 값에는 많아야 $(1+{1\over2})(1+{1\over8})(1+{1\over32})\cdots\approx 1.7584$가 곱해지므로
정수 넘침이 일어날 걱정은 없다.

@<|z|를 $(x,y)$의...@>=
k = 0
for {
	y += y
	k++
	if y > x {
		z = z + specAtan[k]
		t = x
		x = x + (y / twoToThe[k+k])
		y = y - t
	}
	if k == 15 {
		break
	}
}
for {
	y += y
	k++
	if y > x {
		z = z + specAtan[k]
		y = y - x
	}
	if k == 26 {
		break
	}
}

@ 거꾸로, 루틴 |nSinCos|는 |angle|을 받아 그 각의 사인과 코사인을 만든다. 이 루틴의 결과는
전역 정수 변수 |nSin|과 |nCos|에 넣는다.

@<전역 변수@>=
var @!nSin, @!nCos fraction // |nSinCos|가 계산한 결과

@ 각도 $\theta$에 $2^{20}$을 곱한 정수 |z|가 주어질 때, |nSinCos(z)|의 목적은 꽤 큰 어떤
수~|r|에 대해 |x=@t$r\cos\theta$@>|와 |y=@t$r\sin\theta$@>|를 (근사적으로) 정하는 것이다. 두 값 |x|와
|y| 가운데 큰 쪽은 $2^{28}$과 $2^{30}$ 사이에 있게 되므로 정확도는 거의 잃지 않는다. 그다음
|x|와~|y|를 |r|로 나눈다.

@<함수들@>=
func nSinCos(z angle) { // 사인과 코사인의 배수를 계산한다
	var k smallNumber // 루프를 다스리는 변수
	var q int32 // 사분면을 가리킨다; |0 .. 7|
	var r fraction // |(x,y)|의 크기
	var x, y, t int32 // 임시 레지스터들
	for z < 0 {
		z = z + threeSixtyDeg
	}
	z = z % threeSixtyDeg // 이제 |0<=z<threeSixtyDeg|다
	q = z / fortyFiveDeg
	z = z % fortyFiveDeg
	x = fractionOne
	y = x
	if !odd(q) {
		z = fortyFiveDeg - z
	}
	@<|(x,y)|에서 각 |z|를 뺀다@>
	@<|(x,y)|를 |q|가 정하는 팔분면으로 바꾼다@>
	r = pythAdd(x, y)
	nCos = makeFraction(x, r)
	nSin = makeFraction(y, r)
}

@ 이 경우에는 팔분면에 차례로 번호를 매긴다.

@<|(x,y)|를 |q|가...@>=
switch q {
case 0:
	// 아무것도 하지 않는다
case 1:
	t = x
	x = y
	y = t
case 2:
	t = x
	x = -y
	y = t
case 3:
	x = -x
case 4:
	x = -x
	y = -y
case 5:
	t = x
	x = -y
	y = -t
case 6:
	t = x
	x = y
	y = -t
case 7:
	y = -y
} // 다른 경우는 없다

@ 함수 |nSinCos|의 주 반복은 |nArg|의 주 반복과 비슷하지만 거꾸로 적용한다. 표 |specAtan[k]|의 값은 충분히
천천히 줄어들므로, 이 루프는 (있지도 않은) 값 |specAtan[27]|이 필요해지기 전에 반드시 끝난다.
벡터 $(1,1)$, 곧 $45^\circ$ 방향에서 출발해서 |z|만큼 시계 방향으로 돌린다. 그래서 앞 절은
|q|가 짝수일 때 |z|를 $45^\circ-z$로 바꾸어 두었다.

@<|(x,y)|에서 각 |z|를...@>=
k = 1
for z > 0 {
	if z >= specAtan[k] {
		z = z - specAtan[k]
		t = x
		x = t + y/twoToThe[k]
		y = y - t/twoToThe[k]
	}
	k++
}
if y < 0 {
	y = 0 // 이 조심은 결코 필요하지 않을지도 모른다
}

@ 이제 난수 만들기를 살펴봄으로써 수치 유틸리티 루틴의 모음을 마무리하자.
\MF는 {\sl The Art of Computer Programming}의 3.6절이 권하는 덧셈 방식으로 의사 난수를
만든다. 다만 결과는 0과 |fractionOne-1| 사이(양 끝 포함)의 무작위 분수다.

보조 배열 |randoms|에는 의사 난수 분수 55개가 들어 있다. 점화식 $x_n=(x_{n-55}-x_{n-24})\bmod
2^{28}$을 써서, |newRandoms|를 부를 때마다 새 $x_n$을 55개씩 한꺼번에 만든다. 전역 변수
|jRandom|은 어느 원소를 가장 최근에 썼는지 알려 준다.

@<전역 변수@>=
var @!randoms [55]fraction // 마지막으로 만든 무작위 값 55개
var @!jRandom int32 // 아직 쓰지 않은 |randoms|의 수; |0 .. 54|

@ 무작위 분수 하나를 쓰려면 아래 프로그램은 `|nextRandom()|'을 부르고 나서 |randoms[jRandom]|을
가져온다. 함수 |nextRandom|은 실은 수들을 거꾸로 꺼낸다. 55개씩 만든 $x$의 덩어리를 사실상 ``뒤집는''
것이다. 그러나 그렇다고 덜 무작위해지지는 않는다.

@<정의@>=
func nextRandom() {
	if jRandom == 0 {
		newRandoms()
	} else {
		jRandom--
	}
}

@ @<함수들@>=
func newRandoms() {
	var k int32 // |randoms|의 첨자
	var x fraction // 누산기
	for k = 0; k <= 23; k++ {
		x = randoms[k] - randoms[k+31]
		if x < 0 {
			x = x + fractionOne
		}
		randoms[k] = x
	}
	for k = 24; k <= 54; k++ {
		x = randoms[k] - randoms[k-24]
		if x < 0 {
			x = x + fractionOne
		}
		randoms[k] = x
	}
	jRandom = 54
}

@ 표 |randoms|를 초기화하려면 다음 루틴을 부른다.

@<함수들@>=
func initRandoms(seed scaled) {
	var j, jj, k fraction // 대충 무작위인 정수들
	var i int32 // |randoms|의 첨자
	j = abs(seed)
	for j >= fractionOne {
		j = half(j)
	}
	k = 1
	for i = 0; i <= 54; i++ {
		jj = k
		k = j - k
		j = jj
		if k < 0 {
			k = k + fractionOne
		}
		randoms[(i*21)%55] = j
	}
	newRandoms()
	newRandoms()
	newRandoms() // 배열을 ``데운다''
}

@ 눈금 값~|x|가 주어질 때 범위 |0<=u<x|나 |0>=u>x|나 |0=u=x|에서 고른 균등한 난수를 만들려면
여기 보인 대로 한다.

함수 |takeFraction|을 쓰면 값 0과~|x|는 0과~|x| 사이의 다른 특정한 값들보다 절반쯤의 확률로만 나온다는
데 주목하라. 답을 반올림하기 때문이다.

@<함수들@>=
func unifRand(x scaled) scaled {
	var y scaled // 시험 값
	nextRandom()
	y = takeFraction(abs(x), randoms[jRandom])
	if y == abs(x) {
		return 0
	} else if x > 0 {
		return y
	}
	return -y
}

@ 끝으로, 평균이 0이고 표준 편차가 1인 정규 편차는 비율 방법({\sl The Art of Computer
Programming\/}의 알고리즘 3.4.1R)으로 쉽게 얻을 수 있다.

비율 방법의 생각은 이렇다. 점 $(U,V)$를 영역 $\{(u,v):0<u\le\sqrt{f(v/u)}\}$에서 균등하게
고르면 $X=V/U$의 밀도는 $f$에 비례한다. 정규 분포라면 그 영역은 $\vert v\vert\le\sqrt{8/e}$인
직사각형 안에 들어가므로, 직사각형에서 점을 고르고 $X^2\le-4\ln U$를 만족할 때까지 되풀이한다.
아래 코드의 |abVsCd(1024,l,x,x)>=0|이 바로 $x^2\le-4\ln u$를 검사한다.

@<함수들@>=
func normRand() scaled {
	var x, u, l int32 // 책에서 말하는 $2^{16}X$, $2^{28}U$, $-2^{24}\ln U$
	for {
		for {
			nextRandom()
			x = takeFraction(112429, randoms[jRandom]-fractionHalf)
			@t\qquad@>// $2^{16}\sqrt{8/e}\approx 112428.82793$
			nextRandom()
			u = randoms[jRandom]
			if abs(x) < u {
				break
			}
		}
		x = makeFraction(x, u)
		l = 139548960 - mLog(u) // $2^{24}\cdot12\ln2\approx139548959.6165$
		if abVsCd(1024, l, x, x) >= 0 {
			break
		}
	}
	return x
}

@* 꾸린 자료.
메모리를 효율적으로 쓰려고, \MF는 주요 자료 구조의 바탕을 |memoryWord|에 둔다.
낱말 |memoryWord|에는 (부호 있는) 정수(눈금 정수일 수도 있다)가 들어가거나, 정수를 저장하는
데 쓰는 크기의 절반이나 4분의 1인 필드가 몇 개 들어간다.

변수 |x|의 형이 |memoryWord|라면, |x|에는 다음과 같이 가리킬 수 있는 필드가 넷까지 들어 있다.
$$\vbox{\halign{\hfil#&#\hfil&#\hfil\cr
|x|&.|sc|\qquad&(정수 하나, 또는 |scaled| 정수 하나)\cr
|x.hh.lh|, |x.hh|&.|rh|&(하프워드 필드 둘)\cr
|x.hh.b0|, |x.hh.b1|, |x.hh|&.|rh|&(쿼터워드 필드 둘, 하프워드 필드 하나)\cr
|x.qqqq.b0|, |x.qqqq.b1|, |x.qqqq|&.|b2|, |x.qqqq.b3|\hskip-100pt
  &\qquad\qquad\qquad(쿼터워드 필드 넷)\cr}}$$
이것은 쓰기에 좀 거추장스럽고 읽기에도 그리 좋지 않지만, 필드를 읽고 쓰는 짧은 함수들을
써서 표기를 더 짧고 투명하게 할 것이다. 아래의 \GO/ 코드는 |memoryWord|와 그 하위 형들을
형식적으로 정의한다. \MF는 낱말 안에서 필드들의 상대 위치에 대해 아무것도 가정하지 않는다.

정수를 32비트로 가정하고 있으므로 하프워드는 적어도 16비트, 쿼터워드는 적어도 8비트를 담아야
@^system dependencies@>
한다. 그러나 비트가 더 있어도 해롭지 않다. 이를테면 36비트 낱말이 넉넉하면 |memMax|를
262142만큼 크게 할 수 있을지도 모른다.

주의: |memoryWord|의 모든 변형을 정수 하나의 공간에 꾸려 넣지 않으면 귀중한 메모리가 끔찍하게
낭비된다. 그런데 \GO/에는 변형들을 한 공간에 겹쳐 놓는 가변 레코드가 없으므로, 여기서는
|memoryWord|를 모든 변형을 따로 담는 구조체로 정의한다(\secref{memory-word}). 그래서 낱말 하나가
차지하는 메모리는 몇 배로 늘어나지만, 요즘의 컴퓨터에서는 견딜 만하다.

지금의 구현은 가정을 거의 하지 않는다. 범위가 `|minQuarterword .. maxQuarterword|'인
정수를 쿼터워드에 넣을 수 있고, 범위가 `|minHalfword .. maxHalfword|'인 정수를 하프워드에
넣을 수 있다면 모든 것이 만족스럽게 돌아갈 것이다.

대개는 |minQuarterword=minHalfword=0|으로 하는 것이 가장 효율적이므로, 심각한 문제를 일으키지
않는 한 그렇게 하도록 애써야 한다.

@ \seclabel{max-halfword}원본은 대부분의 32비트 컴퓨터에 |maxHalfword=65535|를 권한다. 그런데 메모리의 첨자는
하프워드에 들어가야 하므로(|memMax<maxHalfword|) 이 값은 메모리의 크기를 6만 낱말 남짓으로
묶어 버린다. 여기서는 하프워드가 |int32|이므로(\secref{memory-word}) 더 큰 값을 쓸 수 있다.
\.{web2c}를 비롯한 오늘날의 구현들처럼 $2^{28}-1$로 하면 메모리를 얼마든지 늘릴 수 있다.
위쪽의 네 비트를 남겨 두는 것은 하프워드 두 개의 합이나 차가 넘치지 않게 하려는 것이다.
@^system dependencies@>

@<정의@>=
const (
	@!minQuarterword = 0 // |quarterword|에 허용되는 가장 작은 값
	@!maxQuarterword = 255 // |quarterword|에 허용되는 가장 큰 값
	@!minHalfword = 0 // |halfword|에 허용되는 가장 작은 값
	@!maxHalfword = 0o1777777777 // |halfword|에 허용되는 가장 큰 값, $2^{28}-1$
)

@ 쿼터워드와 하프워드의 값이 만족해야 하는 부등식들(정확히는 만족하면 안 되는 부등식들)은 다음과
같다.

@<``상수'' 값들이...@>=
if iniVersion {
	if memMax != memTop {
		bad = 10
	}
}
if memMax < memTop {
	bad = 10
}
if minQuarterword > 0 || maxQuarterword < 127 {
	bad = 11
}
if minHalfword > 0 || maxHalfword < 32767 {
	bad = 12
}
if minQuarterword < minHalfword || maxQuarterword > maxHalfword {
	bad = 13
}
if memMin < minHalfword || memMax >= maxHalfword {
	bad = 14
}
if maxStrings > maxHalfword {
	bad = 15
}
if bufSize > maxHalfword {
	bad = 16
}
if maxQuarterword-minQuarterword < 255 || maxHalfword-minHalfword < 65535 {
	bad = 17
}

@ 값 |minHalfword|를 빼는 연산은 \MF에서 꽤 자주 일어나므로, 여기서 정의하는 함수 |ho|로 줄여
쓰면 편리하다. 마찬가지로 |qi|와 |qo|는 쿼터워드에 넣고 꺼내는 데 쓴다.

컴파일러가 `|x-0|' 같은 식을 최적화하지 않는다면, |minHalfword=0|일 때 이 함수들을 뻔한 방식으로
단순하게 해 두어야 \MF가 더 빨리 돈다.
@^system dependencies@>

@<정의@>=
func ho(x halfword) int32 { return x - minHalfword } // 하프워드에서 항목을 꺼낸다
func qo(x quarterword) int32 { return x - minQuarterword } // 쿼터워드에서 8비트를 꺼낸다
func qi(x int32) quarterword { return x + minQuarterword } // 쿼터워드에 8비트를 넣는다

@ \seclabel{memory-word}독자는 다음 정의를 꼼꼼히 공부해야 한다.
@^system dependencies@>

정수 자료와 |scaled| 자료는 같은 필드 |sc|에 들어간다. \GO/에는 가변 레코드(C의 공용체)가
없으므로 |memoryWord|는 모든 변형을 따로 담는 구조체이고, 하프워드 필드 |lh|와 쿼터워드
필드 |b0|, |b1|도 따로 있다. 그래도 \MF는 한 낱말에 어떤 변형으로 쓴 값을 다른 변형으로
읽는 일이 없으므로, 필드가 겹치든 겹치지 않든 동작은 같다. 쿼터워드와 하프워드는
|asciiCode|처럼 |int32|의 별칭이다(\secref{ascii-code}).

낱말 파일에는 현재 원소를 담는 필드 |buf|를 둔다. 그러면 다음 원소를 읽어 오기 전에도 현재
원소를 언제나 들여다볼 수 있다.

@<전역 형@>=
type @!quarterword = int32 // 낱말의 1/4; |minQuarterword .. maxQuarterword|
type @!halfword = int32 // 낱말의 1/2; |minHalfword .. maxHalfword|
type @!twoHalves struct {
	@!rh halfword
	@!lh halfword // 이 필드와 다음 두 필드는 겹쳐 놓아도 된다
	@!b0 quarterword
	@!b1 quarterword
}
type @!fourQuarters struct {
	b0 quarterword
	b1 quarterword
	@!b2 quarterword
	@!b3 quarterword
}
type @!memoryWord struct {
	@!sc int32 // 정수나 |scaled| 값
	@!hh twoHalves
	@!qqqq fourQuarters
}
type @!wordFile struct {
	f     *os.File
	r     *bufio.Reader
	w     *bufio.Writer
	buf   memoryWord // 파일의 현재 원소
	atEOF bool       // 파일의 끝에 이르렀는가?
}

@ 디버깅할 때에는 |memoryWord|가 어떤 형인지 모르고 찍고 싶을 수도 있다. 그래서 모든 방식으로
찍는다. 둘째 수는 |sc| 필드를 |scaled|로 읽은 것이고, 셋째 수는 |fraction|으로 읽은 것이다.
@^debugging@>
이 프로시저는 디버깅 코드에서만 불린다.

@<함수들@>=
func printWord(w memoryWord) { // |w|를 모든 방식으로 찍는다
	printInt(w.sc)
	printChar(' ')
	printScaled(w.sc)
	printChar(' ')
	printScaled(w.sc / 0o10000)
	printLn()
	printInt(w.hh.lh)
	printChar('=')
	printInt(w.hh.b0)
	printChar(':')
	printInt(w.hh.b1)
	printChar(';')
	printInt(w.hh.rh)
	printChar(' ')
	printInt(w.qqqq.b0)
	printChar(':')
	printInt(w.qqqq.b1)
	printChar(':')
	printInt(w.qqqq.b2)
	printChar(':')
	printInt(w.qqqq.b3)
}

@* 동적 메모리 할당.
\MF\ 시스템은 메모리 할당을 거의 다 스스로 한다. 그래서 문자열이나 쓰레기 수집 따위의
자동 기능이 없는 환경으로도 쉽게 옮겨 갈 수 있고, 사용자가 받는 오류 메시지를 스스로 통제할 수
있다. \MF의 동적 저장 요구는 큰 배열 |mem|을 마련해서 처리하는데, \MF\ 루틴들은 그 안의 잇닿은
낱말 덩어리들을 노드로 쓴다.

포인터 변수는 이 배열의 첨자이거나, 나중에 설명할 |eqtb|라는 다른 배열의 첨자이다. 포인터
변수는 |mem|의 경계 바깥에 있는 특별한 표시일 수도 있으므로, 포인터는 어떤 |halfword| 값이든 가질
수 있게 한다. 가장 작은 메모리 첨자는 널 포인터를 나타낸다.

@<전역 변수@>=
type @!pointer = halfword // 표시이거나 |mem|이나 |eqtb|의 위치

const @!null = memMin // 널 포인터

@ 배열 |mem|은 따로 할당되는 두 영역으로 나뉘지만, 두 영역의 경계선은 고정되어 있지 않다. 두
영역은 함께 자라다가 각 작업에서 저마다 ``자연스러운'' 크기를 찾는다. 위치 |loMemMax| 이하에는
낱말이 둘 이상인 가변 길이 레코드를 저장한다. 이 영역은 {\sl The Art of Computer Programming}의
연습 문제 2.5--19에 설명된 것과 비슷한 알고리즘으로 관리한다. 그러나 할당된 노드에는 크기 필드가
없다. 노드를 해제할 때 그 크기를 아는 것은 프로그램의 책임이다. 위치 |hiMemMin| 이상에는 한
낱말짜리 레코드를 저장한다. 이 영역의 할당에는 관례적인 \.{AVAIL} 스택을 쓴다.

배열 |mem|에서 |memMin|부터 |memTop|까지의 위치는 \.{INIMF} 전처리기가 미리 싣는 기반 파일의 일부로
@.INIMF@>
내보낼 수 있다. 실무용 \MF는 더 많은 공간을 마련하려고 메모리를 위쪽 끝으로 늘릴 수 있다.
메모리에서 |memTop|과 |memMax| 사이의 위치는 언제나 한 낱말짜리 노드에 쓰인다.

배열 |mem|의 할당을 다스리는 핵심 포인터들 사이에는 정해진 순서가 있다.
$$\hbox{|null=memMin<loMemMax<hiMemMin<memTop<=memEnd<=memMax|.}$$
그림으로 그리면 다음과 같다. 회색 부분이 노드들이 사는 곳이고, 위쪽의 화살표는 두 영역이
자라는 방향이다. 가운데의 빈 틈이 바닥나야 비로소 메모리가 모자란 것이다.
$$\mplibcode
beginfig(5);
save w, h, xl, xh, xt, xe; numeric w, h, xl, xh, xt, xe;
w := 420pt; h := 16pt;
xl := 160pt; xh := 250pt; xt := 300pt; xe := 345pt;
fill (0,0)--(xl,0)--(xl,h)--(0,h)--cycle withcolor .85white;
fill (xh,0)--(xe,0)--(xe,h)--(xh,h)--cycle withcolor .85white;
draw (0,0)--(w,0)--(w,h)--(0,h)--cycle;
for x = xl, xh, xe: draw (x,0)--(x,h); endfor
label(btex \ninepoint 가변 크기 노드 etex, (xl/2, h/2));
label(btex \ninepoint 빈 틈 etex, ((xl+xh)/2, h/2));
label(btex \ninepoint 한 낱말 노드 etex, ((xh+xe)/2, h/2));
drawarrow (xl-20pt, h+5pt)--(xl+10pt, h+5pt);
drawarrow (xh+20pt, h+5pt)--(xh-10pt, h+5pt);
for x = 0, xl, xh, xe, w: draw (x,0)--(x,-4pt); endfor
label.bot(btex \ID{memMin} etex, (0,-4pt));
label.bot(btex \ID{loMemMax} etex, (xl,-4pt));
label.bot(btex \ID{hiMemMin} etex, (xh,-4pt));
label.bot(btex \ID{memEnd} etex, (xe,-4pt));
label.bot(btex \ID{memMax} etex, (w,-4pt));
draw (xt,h)--(xt,h+4pt);
label.top(btex \ID{memTop} etex, (xt,h+4pt));
endfig;
\endmplibcode$$

배열 |mem|에서 실제로 쓰는 첨자는 |memMin .. memMax|다. \GO/의 배열은 첨자가 0부터
시작하는데, 여기서는 |memMin=0|이므로 첨자를 그대로 쓸 수 있다.

@<전역 변수@>=
var @!mem [memMax + 1]memoryWord // 큰 동적 저장 영역
var @!loMemMax pointer // 쓰고 있는 가변 크기 메모리의 가장 큰 위치
var @!hiMemMin pointer // 쓰고 있는 한 낱말짜리 메모리의 가장 작은 위치

@ 특정 응용의 메모리 요구를 연구하려고, 현재의 메모리 사용량과 최대 사용량을 추적하는
선택 기능을 쓸 수 있다. `|if stat {|$\,\ldots\,$|}|'로 둘러싼 코드가 있으면 \MF는 조금 느려지지만,
|tracingStats|가 양수일 때 이 통계를 알려 준다.

@<전역 변수@>=
var @!varUsed, @!dynUsed int32 // 메모리를 얼마나 쓰고 있나

@ 먼저 한 낱말짜리 메모리 영역을 살펴보자. 가장 간단하기 때문이다. 포인터 변수 |memEnd|는
지금까지 쓰인 적이 있는 |mem|의 가장 큰 번호의 위치를 담는다. 위치 |hiMemMin|과 |memEnd| 사이(양
끝 포함)의 빈 위치들은 형이 |twoHalves|이고, |mem[p]|가 이 형일 때 그 |lh| 필드와 |rh| 필드를
|info(p)|와 |link(p)|라고 쓴다. 한 낱말짜리 빈 위치들은 |null|로 끝나는 연결 목록
$$|avail|,\;\hbox{|link(avail)|},\;\hbox{|link(link(avail))|},\;\ldots$$
을 이룬다.

함수 |link(p)|와 |info(p)|는 |mem[p].hh.rh|와 |mem[p].hh.lh|를 읽는다. 이 필드들을 바꿀 때는
|setLink(p,q)|와 |setInfo(p,q)|를 부른다(\secref{conventions}). 앞으로 나오는 모든 필드가 이와 같다.

@<전역 변수@>=
func link(p pointer) halfword       { return mem[p].hh.rh } // 메모리 낱말의 |link| 필드
func setLink(p pointer, v halfword) { mem[p].hh.rh = v }
func info(p pointer) halfword       { return mem[p].hh.lh } // 메모리 낱말의 |info| 필드
func setInfo(p pointer, v halfword) { mem[p].hh.lh = v }

var @!avail pointer // 쓸 수 있는 한 낱말짜리 노드 목록의 머리
var @!memEnd pointer // |mem|에서 쓰인 마지막 한 낱말짜리 노드

@ 한 낱말짜리 메모리가 바닥났다면 사용자가 `\KW{enddef}'나 `\KW{endfor}' 같은 토큰을 잊어버렸다는
뜻일지도 모른다. 나중에 우리는 문제를 정확히 짚어 내는 데 도움을 주려는 프로시저들을 정의할
것이다(|showTokenList|와 |runaway|).

@ 함수 |getAvail|은 |link| 필드가 널인 새 한 낱말짜리 노드를 가리키는 포인터를 돌려준다.
그러나 남은 자리가 없으면 \MF는 멈춘다.
@^inner loop@>

쓸 수 있는 공간의 목록이 비어 있으면, 곧 |avail=null|이면, 먼저 |memEnd|를 늘려 본다. 그렇게 할
수 없으면, 곧 |memEnd=memMax|면, |hiMemMin|을 줄여 본다. 그것도 할 수 없으면, 곧
|hiMemMin=loMemMax+1|이면, 그만두어야 한다.

@<함수들@>=
func getAvail() pointer { // 한 낱말짜리 노드 할당
	var p pointer // 얻는 새 노드
	p = avail // |avail| 스택의 맨 위 위치를 얻는다
	if p != null {
		avail = link(avail) // 그리고 그것을 꺼낸다
	} else if memEnd < memMax { // 아니면 처녀지로 들어간다
		memEnd++
		p = memEnd
	} else {
		hiMemMin--
		p = hiMemMin
		if hiMemMin <= loMemMax {
			runaway() // 메모리가 바닥나면 폭주했을지 모르는 텍스트를 보인다
			overflow("main memory size", memMax+1-memMin)
			@t\qquad@>// 그만둔다; 한 낱말짜리 노드가 모두 쓰이고 있다
@:METAFONT capacity exceeded main memory size}{\quad main memory size@>
		}
	}
	setLink(p, null) // 새 노드에 흔히 원하는 초기화를 해 준다
	if stat {
		dynUsed++ // 통계를 유지한다
	}
	return p
}

@ 거꾸로, 한 낱말짜리 노드는 |freeAvail|을 불러 재활용한다.

@<정의@>=
func freeAvail(p pointer) { // 한 낱말짜리 노드의 해방
	setLink(p, avail)
	avail = p
	if stat {
		dynUsed--
	}
}

@ 함수 |getAvail|을 가장 자주 부르게 될 곳들에서는 그 대신 |fastGetAvail| 루틴을 쓴다. 이것은
프로그램을 조금 더 쓰는 대신, 빈 노드가 있으면 |getAvail|을 부르지 않고 바로 떼어 온다.
\GO/ 컴파일러는 이 작은 함수를 대개 부르는 곳에 펼쳐 넣으므로 프로시저 호출의 부담도
아낀다. 새 노드는 함숫값으로 돌려준다.
@^inner loop@>

@<정의@>=
func fastGetAvail() (p pointer) {
	p = avail // 될 수 있으면 시간을 아끼려고 |getAvail|을 피한다
	if p == null {
		p = getAvail()
	} else {
		avail = link(p)
		setLink(p, null)
		if stat {
			dynUsed++
		}
	}
	return
}

@ 배열 |mem|의 가변 크기 부분에서 쓸 수 있는 공간의 목록은 빈 노드들로 이루어진, 비어 있지 않은
이중 연결 순환 목록이다. 떠도는 포인터 |rover|가 이 목록을 가리킨다.

빈 노드는 저마다 크기가 2 이상이다. 첫 낱말의 |link| 필드에는 특별한 값 |maxHalfword|가, |info|
필드에는 크기가 들어 있다. 둘째 낱말에는 이중 연결을 위한 포인터 둘이 들어 있다.

비어 있지 않은 노드도 저마다 크기가 2 이상이다. 그 첫 낱말은 형이 |twoHalves|\kern-1pt이고,
그 |link| 필드는 결코 |maxHalfword|와 같지 않다. 그 밖에는 다른 필드와 다른 낱말들의 내용에 대해
완전한 자유가 있다.

(조건 |memMax<maxHalfword|를 요구하는 것은 비어 있지 않은 노드의 |link| 필드에 |maxHalfword|가
나타나면 끔찍한 일이 일어날 수 있기 때문이다.)

@<정의@>=
const @!emptyFlag = maxHalfword // 빈 가변 크기 노드의 |link|

func isEmpty(p pointer) bool { return link(p) == emptyFlag } // 빈 노드인지 검사한다
func nodeSize(p pointer) halfword { return info(p) } // 빈 가변 크기 노드의 크기 필드
func setNodeSize(p pointer, v halfword) { setInfo(p, v) }
func llink(p pointer) halfword { return info(p + 1) } // 빈 노드들의 이중 연결 목록에서 왼쪽 연결
func setLlink(p pointer, v halfword) { setInfo(p+1, v) }
func rlink(p pointer) halfword { return link(p + 1) } // 빈 노드들의 이중 연결 목록에서 오른쪽 연결
func setRlink(p pointer, v halfword) { setLink(p+1, v) }

@ @<전역 변수@>=
var @!rover pointer // 빈 노드 목록의 어떤 노드를 가리킨다

@ 가변 크기 영역은 대략 다음 그림과 같은 모습이다. 회색은 쓰고 있는 노드이고 흰 것은 빈
노드다. 빈 노드들은 메모리 안의 위치와 상관없이 |rlink|와 |llink|로 이어져 고리를 이루고,
|rover|는 그 고리의 어느 한 노드를 가리킨다. 그림에는 |rlink| 연결만 그렸다.
$$\mplibcode
beginfig(6);
save u, h, cell; numeric u, h; u := 18pt; h := 14pt;
def cell(expr a, b, used) =
  if used: fill (a*u,0)--(b*u,0)--(b*u,h)--(a*u,h)--cycle withcolor .8white; fi
  for i = a+1 upto b-1: draw (i*u,0)--(i*u,h) withpen pencircle scaled .2pt; endfor
  draw (a*u,0)--(b*u,0)--(b*u,h)--(a*u,h)--cycle;
enddef;
cell(0,2,true); cell(2,5,false); cell(5,8,true); cell(8,10,false); cell(10,12,true); cell(12,16,false);
drawarrow (3.5u, h){up} .. (6u, h+16pt) .. {down}(8.5u, h);
drawarrow (9.5u, h){up} .. (11u, h+12pt) .. {down}(12.5u, h);
drawarrow (13.5u, h){up} .. {left}(12.5u, h+28pt) -- (3.5u, h+28pt){left} .. {down}(2.5u, h);
label.bot(btex \ID{rover} etex, (8.5u, -8pt));
drawarrow (8.5u,-8pt)--(8.5u,0);
endfig;
\endmplibcode$$

@ 인자 |s|로 |getNode|를 부르면 크기가 |s|인 새 노드를 가리키는 포인터를 돌려준다. 크기 |s|는 2 이상이어야
한다. 새 노드의 첫 낱말의 |link| 필드는 널로 놓는다. 알맞은 공간이 없으면 넘침으로 멈춘다.

함수 |getNode|를 $s=2^{30}$으로 부르면 이웃한 빈 영역들을 합치기만 하고 값 |maxHalfword|를 돌려준다.

할당은 ``첫맞춤''(first fit)이다. 포인터 |rover|에서 출발해 고리를 한 바퀴 돌면서 처음 만나는 충분히 큰
빈 노드의 {\it 위쪽 끝\/}을 떼어 준다. 위쪽 끝을 떼면 남은 아래쪽 부분은 고리에서의 자리를 그대로
지키므로 연결을 고칠 필요가 없다. 또 노드를 해제할 때는 이웃과 합치지 않고 그냥 고리에 넣기만
한다. 그 대신 할당할 때 지나가는 노드의 물리적 다음 노드가 빈 노드이면 그 자리에서 합친다. 합치는
일을 필요할 때까지 미루는 것이다.

@<함수들@>=
func getNode(s int32) pointer { // 가변 크기 노드 할당
	var p pointer // 지금 살펴보고 있는 노드
	var q pointer // 물리적으로 |p| 다음에 있는 노드
	var r int32 // 새로 할당한 노드, 또는 그 영예의 후보
	var t, tt int32 // 임시 레지스터들
@^inner loop@>
restart:
	p = rover // 고리의 어떤 빈 노드에서 시작한다
	for {
		@<노드 |p|와 그 물리적 후속자들 안에서 할당해 보고, 할당할 수 있었으면 |goto found|@>
		p = rlink(p) // 고리의 다음 노드로 옮겨 간다
		if p == rover {
			break
		} // 목록 전체를 지날 때까지 되풀이한다
	}
	if s == 0o10000000000 {
		return maxHalfword
	}
	if loMemMax+2 < hiMemMin {
		if loMemMax+2 <= memMin+maxHalfword {
			@<가변 크기 메모리를 늘리고 |goto restart|@>
		}
	}
	overflow("main memory size", memMax+1-memMin) // 미안하지만, 알맞은 것이 남아 있지 않다
@:METAFONT capacity exceeded main memory size}{\quad main memory size@>
found:
	setLink(r, null) // 이 노드는 이제 비어 있지 않다
	if stat {
		varUsed = varUsed + s // 사용 통계를 유지한다
	}
	return r
}

@ 메모리의 아래쪽 부분은 한 번에 1000낱말씩 자란다. 다만 바닥이 아주 가까우면 그렇게 하지 않는다.
자랄 때는 새 노드를 쓸 수 있는 공간의 목록에 이어 넣기만 하면 된다. 이렇게 조절하며 자라게 하면
\MF를 ``가상 메모리'' 시스템에서 구현할 때 |mem| 사용이 연속되게 유지하는 데 도움이 된다.
@^virtual memory@>

@<가변 크기 메모리를 늘리고...@>=
if hiMemMin-loMemMax >= 1998 {
	t = loMemMax + 1000
} else {
	t = loMemMax + 1 + (hiMemMin-loMemMax)/2 // |loMemMax+2<=t<hiMemMin|
}
if t > memMin+maxHalfword {
	t = memMin + maxHalfword
}
p = llink(rover)
q = loMemMax
setRlink(p, q)
setLlink(rover, q)
setRlink(q, rover)
setLlink(q, p)
setLink(q, emptyFlag)
setNodeSize(q, t-loMemMax)
loMemMax = t
setLink(loMemMax, null)
setInfo(loMemMax, null)
rover = q
goto restart

@ @<노드 |p|와 그 물리적...@>=
q = p + nodeSize(p) // 물리적 후속자를 찾는다
for isEmpty(q) { // 노드 |p|와 노드 |q|를 합친다
	t = rlink(q)
	tt = llink(q)
@^inner loop@>
	if q == rover {
		rover = t
	}
	setLlink(t, tt)
	setRlink(tt, t)
	q = q + nodeSize(q)
}
r = q - s
if r > p+1 {
	@<노드 |p|의 위쪽 끝에서 할당하고 |goto found|@>
}
if r == p {
	if rlink(p) != p {
		@<노드 |p| 전체를 할당하고 |goto found|@>
	}
}
setNodeSize(p, q-p) // 크기가 자랐을 경우에 대비해 크기를 다시 정한다

@ @<노드 |p|의 위쪽 끝에서...@>=
setNodeSize(p, r-p) // 남은 크기를 저장한다
rover = p // 다음에는 여기서 찾기 시작한다
goto found

@ 여기서는 노드 |p|를 고리에서 지우고, |rover|를 옮겨 간다.

@<노드 |p| 전체를...@>=
rover = rlink(p)
t = llink(p)
setLlink(rover, t)
setRlink(t, rover)
goto found

@ 거꾸로, 크기가 |s|인 어떤 가변 크기 노드 |p|가 더는 필요 없으면, 연산 |freeNode(p,s)|가 |p|를
지금 |rover|가 가리키는 곳 바로 앞에 새 빈 노드로 넣어서 그 낱말들을 쓸 수 있게 한다.

@<함수들@>=
func freeNode(p pointer, s halfword) { // 가변 크기 노드의 해방
	var q pointer // |llink(rover)|
	setNodeSize(p, s)
	setLink(p, emptyFlag)
@^inner loop@>
	q = llink(rover)
	setLlink(p, q)
	setRlink(p, rover) // 두 연결을 놓는다
	setLlink(rover, p)
	setRlink(q, p) // |p|를 고리에 넣는다
	if stat {
		varUsed = varUsed - s // 사용 통계를 유지한다
	}
}

@ \.{INIMF}가 메모리를 써 내보내기 바로 전에, 쓸 수 있는 공간의 이중 연결 목록을 정렬한다. 그때에는
목록이 아마 아주 짧을 것이므로 간단한 끼워 넣기 정렬을 쓴다. 가장 작은 빈 위치는 |rover|가 가리키고,
그다음으로 작은 것은 |rlink(rover)|가 가리키는 식이 된다.

@<함수들@>=
func sortAvail() { // 빈 가변 크기 노드들을 위치에 따라 정렬한다
	var p, q, r pointer // |mem|의 첨자들
	var oldRover pointer // |rover|의 처음 설정
	p = getNode(0o10000000000) // 이웃한 빈 영역들을 합친다
	p = rlink(rover)
	setRlink(rover, maxHalfword)
	oldRover = rover
	for p != oldRover {
		@<|p|를 |rover|에서 시작하는 목록에 정렬해 넣고 |p|를 |rlink(p)|로 나아가게 한다@>
	}
	p = rover
	for rlink(p) != maxHalfword {
		setLlink(rlink(p), p)
		p = rlink(p)
	}
	setRlink(p, rover)
	setLlink(rover, p)
}

@ 다음 |for| 루프는 반드시 끝난다. 정렬하는 동안 |rover|에서 시작하는 목록은 |maxHalfword|로
끝나기 때문이다.

@<|p|를 |rover|에서...@>=
if p < rover {
	q = p
	p = rlink(q)
	setRlink(q, rover)
	rover = q
} else {
	q = rover
	for rlink(q) < p {
		q = rlink(q)
	}
	r = rlink(p)
	setRlink(p, rlink(q))
	setRlink(q, p)
	p = r
}

@* 메모리의 배치.
배열 |mem|의 몇몇 영역은 고정된 용도에 바친다. 정적 할당으로 버틸 수 있을 때는 그것이 동적 할당보다
효율적이기 때문이다. 이를테면 위치 |memMin|부터 |memMin+2|까지는 언제나 `$(0,0)$'인 널 펜 좌표의
명세를 저장하는 데 쓴다. 다음 정의들은 고정된 위치에 기호 이름을 주어 정적 할당을 해낸다.
정적 가변 크기 노드들은 위치 |memMin|부터 |loMemStatMax|까지에 나타나고, 정적 한 낱말짜리 노드들은
위치 |hiMemStatMin|부터 |memTop|까지(양 끝 포함)에 나타난다.

@<정의@>=
const (
	@!nullCoords = memMin // $(0,0)$인 펜 오프셋의 명세
	@!nullPen = nullCoords + 3 // |coordNodeSize=3|으로 정의할 것이다
	@!depHead = nullPen + 10 // 그리고 |penNodeSize=10|으로
	@!zeroVal = depHead + 2 // 언제나 0인 값을 위한 두 낱말
	@!tempVal = zeroVal + 2 // 임시 값 노드를 위한 두 낱말
	@!endAttr = tempVal // 우리는 |endAttr+2|만 쓴다
	@!infVal = endAttr + 2 // 그리고 |infVal+1|만
	@!badVardef = infVal + 2 // \KW{vardef} 오류 회복을 위한 두 낱말
	@!loMemStatMax = badVardef + 1 // 가변 크기 |mem|에서 정적으로
	@t\qquad@>// 할당한 가장 큰 낱말
	@!sentinel = memTop // 정렬된 목록의 끝
	@!tempHead = memTop - 1 // 어떤 종류의 임시 목록의 머리
	@!holdHead = memTop - 2 // 다른 종류의 임시 목록의 머리
	@!hiMemStatMin = memTop - 2 // 한 낱말짜리 |mem|에서 정적으로
	@t\qquad@>// 할당한 가장 작은 낱말
)

@ 다음 코드는 \MF가 느린 방법으로 스스로를 초기화할 때 |mem|의 동적 부분을 처음 상태로 갖추어 놓는다.

@<표의 항목들을 초기화한다...@>=
rover = loMemStatMax + 1 // 동적 메모리를 초기화한다
setLink(rover, emptyFlag)
setNodeSize(rover, 1000) // 이것은 1000낱말짜리 빈 노드다
setLlink(rover, rover)
setRlink(rover, rover)
loMemMax = rover + 1000
setLink(loMemMax, null)
setInfo(loMemMax, null)
for k = hiMemStatMin; k <= memTop; k++ {
	mem[k] = mem[loMemMax] // 목록 머리들을 지운다
}
avail = null
memEnd = memTop
hiMemMin = hiMemStatMin // 한 낱말짜리 메모리를 초기화한다
varUsed = loMemStatMax + 1 - memMin
dynUsed = memTop + 1 - hiMemMin // 통계를 초기화한다

@ 프로시저 |flushList(p)|는 주어진 위치에서 시작하는 한 낱말짜리 노드들의 연결 목록 전체를,
|sentinel|이나 한 낱말짜리 영역에 있지 않은 포인터에 이를 때까지 해제한다. 또 하나의 프로시저
|flushNodeList|는 한 낱말짜리 노드와 두 낱말짜리 노드가 섞인 연결 목록 전체를 |null| 포인터에
이를 때까지 해제한다.
@^inner loop@>

@<함수들@>=
func flushList(p pointer) { // 한 낱말짜리 노드들의 목록을 쓸 수 있게 한다
	var q, r pointer // 목록을 훑는 것들
	if p >= hiMemMin {
		if p != sentinel {
			r = p
			for {
				q = r
				r = link(r)
				if stat {
					dynUsed--
				}
				if r < hiMemMin || r == sentinel {
					break
				}
			} // 이제 |q|는 목록의 마지막 노드다
			setLink(q, avail)
			avail = p
		}
	}
}

func flushNodeList(p pointer) {
	var q pointer // 재활용하고 있는 노드
	for p != null {
		q = p
		p = link(p)
		if q < hiMemMin {
			freeNode(q, 2)
		} else {
			freeAvail(q)
		}
	}
}

@ \MF를 잘못 확장하면 배열 |mem|이 엉망이 될 수도 있다. 이를테면 어떤 포인터들이 틀렸거나, 어떤
``죽은'' 노드들이 마지막 참조가 사라졌을 때 해제되지 않았을 수도 있다. 프로시저 |checkMem|과
|searchMem|은 그런 문제를 진단하는 데 쓸 수 있다. 이 프로시저들은 |free|와 |wasFree|라는 배열 두
개를 쓰는데, 이것들은 \MF의 디버깅 루틴들을 넣었을 때에만 쓰인다. (디버깅하는 동안에는 |mem|의
@^debugging@>
크기를 줄이고 싶을지도 모른다.)

@<전역 변수@>=
var @!free [memMax + 1]bool // 빈 칸들
var @!wasFree [memMax + 1]bool // 앞에서 비어 있던 칸들
var @!wasMemEnd, @!wasLoMax, @!wasHiMin pointer // 앞의 |memEnd|, |loMemMax|, |hiMemMin|
var @!panicking bool // 메모리를 줄곧 검사하고 싶은가?

@ @<핵심 변수들의...@>=
if debug {
	wasMemEnd = memMin // 모든 것이 앞에서 비어 있었다고 표시한다
	wasLoMax = memMin
	wasHiMin = memMax
	panicking = false
}

@ 프로시저 |checkMem|은 |mem|의 쓸 수 있는 공간의 목록들이 제대로 된 꼴인지 확인하고, 선택에 따라
지난번에 이 프로시저를 불렀을 때는 비어 있었으나 지금은 예약된 위치를 모두 찍는다.

@<함수들@>=
func checkMem(printLocs bool) {
	var p, q, r pointer // |mem|에서 지금 관심 있는 위치들
	var clobbered bool // 무언가 잘못되었나?
	for p = memMin; p <= loMemMax; p++ {
		free[p] = false // 아마 이것을 더 빨리 할 수 있을 것이다
	}
	for p = hiMemMin; p <= memEnd; p++ {
		free[p] = false // 마찬가지
	}
	@<한 낱말짜리 |avail| 목록을 검사한다@>
	@<가변 크기 |avail| 목록을 검사한다@>
	@<쓸 수 없는 노드들의 표시를 검사한다@>
	@<일차 종속 관계의 목록을 검사한다@>
	if printLocs {
		@<새로 바빠진 위치들을 찍는다@>
	}
	for p = memMin; p <= loMemMax; p++ {
		wasFree[p] = free[p]
	}
	for p = hiMemMin; p <= memEnd; p++ {
		wasFree[p] = free[p] // |wasFree=free|가 더 빠를지도 모른다
	}
	wasMemEnd = memEnd
	wasLoMax = loMemMax
	wasHiMin = hiMemMin
}

@ @<한 낱말짜리 |avail|...@>=
p = avail
q = null
clobbered = false
for p != null {
	if p > memEnd || p < hiMemMin {
		clobbered = true
	} else if free[p] {
		clobbered = true
	}
	if clobbered {
		printNl("AVAIL list clobbered at ")
@.AVAIL list clobbered...@>
		printInt(q)
		break
	}
	free[p] = true
	q = p
	p = link(q)
}

@ @<가변 크기 |avail|...@>=
p = rover
q = null
clobbered = false
done2:
for {
	if p >= loMemMax || p < memMin {
		clobbered = true
	} else if rlink(p) >= loMemMax || rlink(p) < memMin {
		clobbered = true
	} else if !isEmpty(p) || nodeSize(p) < 2 ||
		p+nodeSize(p) > loMemMax || llink(rlink(p)) != p {
		clobbered = true
	}
	if clobbered {
		printNl("Double-AVAIL list clobbered at ")
		printInt(q)
		break done2
	}
@.Double-AVAIL list clobbered...@>
	for q = p; q <= p+nodeSize(p)-1; q++ { // 모든 위치를 비었다고 표시한다
		if free[q] {
			printNl("Doubly free location at ")
@.Doubly free location...@>
			printInt(q)
			break done2
		}
		free[q] = true
	}
	q = p
	p = rlink(p)
	if p == rover {
		break
	}
}

@ @<쓸 수 없는 노드들의...@>=
p = memMin
for p <= loMemMax { // 노드 |p|는 비어 있지 않아야 한다
	if isEmpty(p) {
		printNl("Bad flag at ")
		printInt(p)
@.Bad flag...@>
	}
	for p <= loMemMax && !free[p] {
		p++
	}
	for p <= loMemMax && free[p] {
		p++
	}
}

@ @<새로 바빠진 위치들을...@>=
printNl("New busy locs:")
@.New busy locs@>
for p = memMin; p <= loMemMax; p++ {
	if !free[p] && (p > wasLoMax || wasFree[p]) {
		printChar(' ')
		printInt(p)
	}
}
for p = hiMemMin; p <= memEnd; p++ {
	if !free[p] && (p < wasHiMin || p > wasMemEnd || wasFree[p]) {
		printChar(' ')
		printInt(p)
	}
}

@ 프로시저 |searchMem|은 ``누가 노드~|p|를 가리키는가?''라는 물음에 답하려 한다. 그러면서 형이
|twoHalves|가 아닐지도 모르는 |mem|의 |link| 필드와 |info| 필드를 꺼내 본다. 이것은 ``거짓
걸림''(우연히 |p|를 가리키는 것처럼 보이는 낱말)으로 이어질 수 있다. 그러나 디버깅의 목적에는
|p|를 가리키지 {\sl 않는\/} 곳들을 걸러 내고 싶으므로, 거짓 걸림 몇 개쯤은 참을 만하다.

@<함수들@>=
func searchMem(p pointer) { // |p|를 가리키는 포인터를 찾는다
	var q int32 // 지금 찾고 있는 위치
	for q = memMin; q <= loMemMax; q++ {
		if link(q) == p {
			printNl("LINK(")
			printInt(q)
			printChar(')')
		}
		if info(q) == p {
			printNl("INFO(")
			printInt(q)
			printChar(')')
		}
	}
	for q = hiMemMin; q <= memEnd; q++ {
		if link(q) == p {
			printNl("LINK(")
			printInt(q)
			printChar(')')
		}
		if info(q) == p {
			printNl("INFO(")
			printInt(q)
			printChar(')')
		}
	}
	@<|eqtb|에서 |p|와 같은 등가물을 찾는다@>
}

@* 명령 코드.
더 나아가기 전에, \MF가 따르는 여러 명령을 나타내는 내부 코드 번호에 기호 이름을 정해야 한다.
이 코드들은 얼마쯤 제멋대로이지만 완전히 그렇지는 않다. 이를테면 프로그램의 |switch| 문이 멀리
떨어진 경우들을 고려하지 않아도 되도록, 또는 |switch| 문을 |if| 문으로 바꿀 수 있도록 어떤
코드들은 이웃하게 만들었다. 어떤 명령은 그 코드가 |minPrimaryCommand|와 |maxPrimaryCommand|
사이(양 끝 포함)에 있을 때, 그리고 오직 그때에만 식을 시작할 수 있다. 식으로 시작하지 않는 문장의
첫 토큰은 명령 코드가 |minCommand|와 |maxStatementCommand| 사이(양 끝 포함)에 있다. 가장 큰 번호의
명령들의 순서(|comma<semicolon<endGroup<stop|)는 이 프로그램의 구문 분석과 오류 회복 방법에 결정적이다.

어쨌든 다음이 그 목록이다. 나중에 참고하라. 코드는 1부터 차례로 붙으므로 \GO/의 |iota|로 매기고,
범위의 경계를 가리키는 이름들은 따로 정의한다.

@<정의@>=
const (
	@!ifTest = iota + 1 // 조건부 텍스트(\KW{if})
	@!fiOrElse // 조건문의 구분자(\KW{elseif}, \KW{else}, \KW{fi})
	@!input // 소스 파일을 입력한다(\KW{input}, \KW{endinput})
	@!iteration // 되풀이한다(\KW{for}, \KW{forsuffixes}, \KW{forever}, \KW{endfor})
	@!repeatLoop // \KW{endfor} 대신 쓰는 특별한 명령
	@!exitTest // 루프에서 일찍 빠져나간다(\KW{exitif})
	@!relax // 아무것도 하지 않는다(\.{\char`\\})
	@!scanTokens // 문자열을 입력 버퍼에 넣는다
	@!expandAfter // 토큰 하나를 미리 본다
	@!definedMacro // 사용자가 정의한 매크로
	@!displayCommand // 화면에 그림을 보인다(\KW{display})
	@!saveCommand // 토큰들의 목록을 저장한다(\KW{save})
	@!interimCommand // 내부 양을 저장한다(\KW{interim})
	@!letCommand // 기호 토큰을 다시 정의한다(\KW{let})
	@!newInternal // 새 내부 양을 정의한다(\KW{newinternal})
	@!macroDef // 매크로를 정의한다(\KW{def}, \KW{vardef} 따위)
	@!shipOutCommand // 글자를 내보낸다(\KW{shipout})
	@!addToCommand // 가장자리에 더한다(\KW{addto})
	@!cullCommand // 가장자리를 추리고 정규화한다(\KW{cull})
	@!tfmCommand // 글꼴 계량 정보를 위한 명령(\KW{ligtable} 따위)
	@!protectionCommand // 보호 표시를 정한다(\KW{outer}, \KW{inner})
	@!showCommand // 진단 출력(\KW{show}, \KW{showvariable} 따위)
	@!modeCommand // 대화 수준을 정한다(\KW{batchmode} 따위)
	@!randomSeed // 난수 생성기를 초기화한다(\KW{randomseed})
	@!messageCommand // 사용자와 소통한다(\KW{message}, \KW{errmessage})
	@!everyJobCommand // 시작 토큰을 지정한다(\KW{everyjob})
	@!delimiters // 구분자 한 쌍을 정의한다(\KW{delimiters})
	@!openWindow // 화면에 창을 정의한다(\KW{openwindow})
	@!specialCommand // 특별한 정보를 내보낸다(\KW{special}, \KW{numspecial})
	@!typeName // 형을 선언한다(\KW{numeric}, \KW{pair} 따위)
)

@ 다음 명령들은 식을 시작할 수 있는 것들(|typeName|부터 |plusOrMinus|까지)과 이차식, 삼차식, 식 수준의
연산자들이다. 값은 앞 묶음에 이어서 매긴다.

@<정의@>=
const (
	@!leftDelimiter = typeName + 1 + iota // 짝이 맞는 구분자 쌍의 왼쪽
	@!beginGroup // 그룹의 시작(\KW{begingroup})
	@!nullary // 인자가 없는 연산자(이를테면 \KW{normaldeviate})
	@!unary // 인자가 하나인 연산자(이를테면 \KW{sqrt})
	@!strOp // 첨자를 문자열로 바꾼다(\KW{str})
	@!cycle // 순환 경로를 닫는다(\KW{cycle})
	@!primaryBinary // `\KW{of}'를 받는 이항 연산(이를테면 \KW{point})
	@!capsuleToken // 토큰 목록에 넣어 둔 값
	@!stringToken // 문자열 상수(이를테면 \.{"hello"})
	@!internalQuantity // 내부 수치 매개변수(이를테면 \KW{pausing})
	@!tagToken // 원시적인 뜻이 없는 기호 토큰
	@!numericToken // 수치 상수(이를테면 \.{3.14159})
	@!plusOrMinus // `\.+'나 `\.-'
	@!tertiarySecondaryMacro // \KW{secondarydef}로 정의한 매크로
	@!tertiaryBinary // 셋째 수준의 연산자(이를테면 `\.{++}')
	@!leftBrace // 연산자 `\.{\char`\{}'
	@!pathJoin // 연산자 `\.{..}'
	@!ampersand // 연산자 `\.\&'
	@!expressionTertiaryMacro // \KW{tertiarydef}로 정의한 매크로
	@!expressionBinary // 식 수준의 연산자(이를테면 `\.<')
	@!equals // 연산자 `\.='
	@!andCommand // 연산자 `\KW{and}'
	@!secondaryPrimaryMacro // \KW{primarydef}로 정의한 매크로
	@!slash // 연산자 `\./'
	@!secondaryBinary // 둘째 수준의 연산자(이를테면 \KW{shifted})
)

@ 나머지는 식 안에서 쓰이는 구두점 노릇의 명령들이다. 맨 끝의 넷은 순서가 중요하다.

@<정의@>=
const (
	@!paramType = secondaryBinary + 1 + iota // 매개변수의 형(\KW{primary}, \KW{expr}, \KW{suffix} 따위)
	@!controls // 조절점을 직접 지정한다(\KW{controls})
	@!tension // 매듭 사이의 긴장을 지정한다(\KW{tension})
	@!atLeast // 아래로 묶인 긴장 값(\KW{atleast})
	@!curlCommand // 끝 매듭에서 휨을 지정한다(\KW{curl})
	@!macroSpecial // 특별한 매크로 연산자(\KW{quote}, \.{\#\AT!} 따위)
	@!rightDelimiter // 짝이 맞는 구분자 쌍의 오른쪽
	@!leftBracket // 연산자 `\.['
	@!rightBracket // 연산자 `\.]'
	@!rightBrace // 연산자 `\.{\char`\}}'
	@!withOption // 칠하기의 선택 사항(\KW{withpen}, \KW{withweight})
	@!cullOp // 연산자 `\KW{keeping}'이나 `\KW{dropping}'
	@!thingToAdd // \KW{addto}의 변형(\KW{contour}, \KW{doublepath}, \KW{also})
	@!ofToken // 연산자 `\KW{of}'
	@!fromToken // 연산자 `\KW{from}'
	@!toToken // 연산자 `\KW{to}'
	@!atToken // 연산자 `\KW{at}'
	@!inWindow // 연산자 `\KW{inwindow}'
	@!stepToken // 연산자 `\KW{step}'
	@!untilToken // 연산자 `\KW{until}'
	@!ligKernToken // 연산자 `\KW{kern}'과 `\.{=:}'과 `\.{=:\char'174}' 따위
	@!assignment // 연산자 `\.{:=}'
	@!skipTo // 연산 `\KW{skipto}'
	@!bcharLabel // 연산자 `\.{\char'174\char'174:}'
	@!doubleColon // 연산자 `\.{::}'
	@!colon // 연산자 `\.:'
	@!comma // 연산자 `\.,'; |colon+1|이어야 한다
	@!semicolon // 연산자 `\.;'; |comma+1|이어야 한다
	@!endGroup // 그룹을 끝낸다(\KW{endgroup}); |semicolon+1|이어야 한다
	@!stop // 작업을 끝낸다(\KW{end}, \KW{dump}); |endGroup+1|이어야 한다
)

@ 범위의 경계를 가리키는 이름들이다.

@<정의@>=
const (
	@!minCommand = definedMacro + 1
	@!maxStatementCommand = typeName
	@!minPrimaryCommand = typeName
	@!minSuffixToken = internalQuantity
	@!maxSuffixToken = numericToken
	@!maxPrimaryCommand = plusOrMinus // |numericToken+1|이기도 해야 한다
	@!minTertiaryCommand = plusOrMinus
	@!maxTertiaryCommand = tertiaryBinary
	@!minExpressionCommand = leftBrace
	@!maxExpressionCommand = equals
	@!minSecondaryCommand = andCommand
	@!maxSecondaryCommand = secondaryBinary
	@!maxCommandCode = stop
	@!outerTag = maxCommandCode + 1 // 명령 코드에 더하는 보호 코드
)

func endOfStatement() bool { return curCmd > comma }

@ \MF의 변수와 캡슐에는 여러 가지 ``형''이 있는데, 다음 코드 번호로 구별한다.

@<정의@>=
const (
	@!undefined = 0 // 아무 형도 선언되지 않았다
	@!unknownTag = 1 // 이 상수를 아래의 어떤 형 코드에 더한다
	@!vacuous = 1 // 식이 없었다
	@!booleanType = 2 // 값을 아는 \KW{boolean}
	@!unknownBoolean = booleanType + unknownTag
	@!stringType = 4 // 값을 아는 \KW{string}
	@!unknownString = stringType + unknownTag
	@!penType = 6 // 값을 아는 \KW{pen}
	@!unknownPen = penType + unknownTag
	@!futurePen = 8 // 더 높은 수준에서 \KW{pen}이 될 부분식
	@!pathType = 9 // 값을 아는 \KW{path}
	@!unknownPath = pathType + unknownTag
	@!pictureType = 11 // 값을 아는 \KW{picture}
	@!unknownPicture = pictureType + unknownTag
	@!transformType = 13 // \KW{transform} 변수나 캡슐
	@!pairType = 14 // \KW{pair} 변수나 캡슐
	@!numericType = 15 // \KW{numeric}으로 선언했으나 쓰지 않은 변수
	@!known = 16 // 값을 아는 \KW{numeric}
	@!dependent = 17 // |fraction| 계수를 가진 일차 결합
	@!protoDependent = 18 // |scaled| 계수를 가진 일차 결합
	@!independent = 19 // 값을 모르는 \KW{numeric}
	@!tokenList = 20 // 변수 이름이나 첨자 인자나 텍스트 인자
	@!structured = 21 // 첨자와 속성을 가진 변수
	@!unsuffixedMacro = 22 // \KW{vardef}로 정의했으나 \.{\AT!\#}가 없는 변수
	@!suffixedMacro = 23 // \KW{vardef}로 정의했고 \.{\AT!\#}가 있는 변수
)

@ \MF는 `|case unknownTypes:|'라고 쓰고 싶은 곳이 여럿 있다. \GO/의 |case|에는 값을 쉼표로 늘어놓을
수 있지만 그 목록에 이름을 붙일 수는 없으므로, 그런 곳에서는 다섯 형을 그대로 늘어놓는다. 곧
|unknownBoolean|, |unknownString|, |unknownPen|, |unknownPicture|, |unknownPath|다.

@<기본 인쇄...@>=
func printType(t smallNumber) {
	switch t {
	case vacuous:
		printStr("vacuous")
	case booleanType:
		printStr("boolean")
	case unknownBoolean:
		printStr("unknown boolean")
	case stringType:
		printStr("string")
	case unknownString:
		printStr("unknown string")
	case penType:
		printStr("pen")
	case unknownPen:
		printStr("unknown pen")
	case futurePen:
		printStr("future pen")
	case pathType:
		printStr("path")
	case unknownPath:
		printStr("unknown path")
	case pictureType:
		printStr("picture")
	case unknownPicture:
		printStr("unknown picture")
	@<|printType|에서 수치 형과 그 밖의 형의 이름을 찍는 경우들@>
	default:
		printStr("undefined")
	}
}

@ 형 |known|부터 |independent|까지는 모두 수치 값의 형이다. 그 뒤의 형들은 변수에만 나타난다.

@<|printType|에서 수치 형과 그 밖의 형의 이름을 찍는 경우들@>=
case transformType:
	printStr("transform")
case pairType:
	printStr("pair")
case known:
	printStr("known numeric")
case dependent:
	printStr("dependent")
case protoDependent:
	printStr("proto-dependent")
case numericType:
	printStr("numeric")
case independent:
	printStr("independent")
case tokenList:
	printStr("token list")
case structured:
	printStr("structured")
case unsuffixedMacro:
	printStr("unsuffixed macro")
case suffixedMacro:
	printStr("suffixed macro")

@ \MF\ 안의 값은 |type|뿐 아니라 |nameType|도 가진 두 낱말짜리 노드에 저장된다. 필드 |nameType|이
가질 수 있는 값은 여기서 정의한다. 자세한 설명은 나중에 하겠다.

@<정의@>=
const (
	@!root = iota // 변수의 맨 위 수준의 |nameType|
	@!savedRoot // 같은 것인데, 변수를 저장했을 때
	@!structuredRoot // |structured| 가지가 일어나는 곳의 |nameType|
	@!subscr // 첨자 노드의 |nameType|
	@!attr // 속성 노드의 |nameType|
	@!xPartSector // 노드의 \KW{xpart}의 |nameType|
	@!yPartSector // 노드의 \KW{ypart}의 |nameType|
	@!xxPartSector // 노드의 \KW{xxpart}의 |nameType|
	@!xyPartSector // 노드의 \KW{xypart}의 |nameType|
	@!yxPartSector // 노드의 \KW{yxpart}의 |nameType|
	@!yyPartSector // 노드의 \KW{yypart}의 |nameType|
	@!capsule // 따로 넣어 둔 부분식의 |nameType|
	@!token // 수치 토큰이나 문자열 토큰의 |nameType|
)

@ 값을 만드는 원시 연산에는 명령 코드에 더해 둘째 식별 코드가 있다. 속(屬)과 종(種) 같은 것이다.
이를테면 `\.*'의 명령 코드는 |primaryBinary|이고, 둘째 식별 코드는 |times|다. 둘째 코드는 형
코드와 겹치지 않도록 30에서 시작한다. 어떤 형 코드(이를테면 |stringType|)는 형을 가리키는 데뿐
아니라 연산자로도 쓰이기 때문이다.

@<정의@>=
const (
	@!trueCode = iota + 30 // \.{true}의 연산 코드
	@!falseCode // \.{false}의 연산 코드
	@!nullPictureCode // \.{nullpicture}의 연산 코드
	@!nullPenCode // \.{nullpen}의 연산 코드
	@!jobNameOp // \.{jobname}의 연산 코드
	@!readStringOp // \.{readstring}의 연산 코드
	@!penCircle // \.{pencircle}의 연산 코드
	@!normalDeviate // \.{normaldeviate}의 연산 코드
	@!oddOp // \.{odd}의 연산 코드
	@!knownOp // \.{known}의 연산 코드
	@!unknownOp // \.{unknown}의 연산 코드
	@!notOp // \.{not}의 연산 코드
	@!decimal // \.{decimal}의 연산 코드
	@!reverse // \.{reverse}의 연산 코드
	@!makePathOp // \.{makepath}의 연산 코드
	@!makePenOp // \.{makepen}의 연산 코드
	@!totalWeightOp // \.{totalweight}의 연산 코드
	@!octOp // \.{oct}의 연산 코드
	@!hexOp // \.{hex}의 연산 코드
	@!asciiOp // \.{ASCII}의 연산 코드
	@!charOp // \.{char}의 연산 코드
	@!lengthOp // \.{length}의 연산 코드
	@!turningOp // \.{turningnumber}의 연산 코드
	@!xPart // \.{xpart}의 연산 코드
	@!yPart // \.{ypart}의 연산 코드
	@!xxPart // \.{xxpart}의 연산 코드
	@!xyPart // \.{xypart}의 연산 코드
	@!yxPart // \.{yxpart}의 연산 코드
	@!yyPart // \.{yypart}의 연산 코드
	@!sqrtOp // \.{sqrt}의 연산 코드
	@!mExpOp // \.{mexp}의 연산 코드
	@!mLogOp // \.{mlog}의 연산 코드
	@!sinDOp // \.{sind}의 연산 코드
	@!cosDOp // \.{cosd}의 연산 코드
	@!floorOp // \.{floor}의 연산 코드
	@!uniformDeviate // \.{uniformdeviate}의 연산 코드
	@!charExistsOp // \.{charexists}의 연산 코드
	@!angleOp // \.{angle}의 연산 코드
	@!cycleOp // \.{cycle}의 연산 코드
)

@ 다음은 이항 연산자들의 둘째 코드다. 앞 묶음에 이어서 매긴다. 그 가운데 |substringOf|부터 뒤는 피연산자 사이에
\KW{of}를 두는 연산자들이어서, |printOp|가 이름 뒤에 `\.{of}'를 붙인다.

@<정의@>=
const (
	@!plus = cycleOp + 1 + iota // \.+의 연산 코드
	@!minus // \.-의 연산 코드
	@!times // \.*의 연산 코드
	@!over // \./의 연산 코드
	@!pythagAdd // \.{++}의 연산 코드
	@!pythagSub // \.{+-+}의 연산 코드
	@!orOp // \.{or}의 연산 코드
	@!andOp // \.{and}의 연산 코드
	@!lessThan // \.<의 연산 코드
	@!lessOrEqual // \.{<=}의 연산 코드
	@!greaterThan // \.>의 연산 코드
	@!greaterOrEqual // \.{>=}의 연산 코드
	@!equalTo // \.=의 연산 코드
	@!unequalTo // \.{<>}의 연산 코드
	@!concatenate // \.\&의 연산 코드
	@!rotatedBy // \.{rotated}의 연산 코드
	@!slantedBy // \.{slanted}의 연산 코드
	@!scaledBy // \.{scaled}의 연산 코드
	@!shiftedBy // \.{shifted}의 연산 코드
	@!transformedBy // \.{transformed}의 연산 코드
	@!xScaled // \.{xscaled}의 연산 코드
	@!yScaled // \.{yscaled}의 연산 코드
	@!zScaled // \.{zscaled}의 연산 코드
	@!intersect // \.{intersectiontimes}의 연산 코드
	@!doubleDot // 잘못된 \.{..}의 연산 코드
	@!substringOf // \.{substring}의 연산 코드
	@!subpathOf // \.{subpath}의 연산 코드
	@!directionTimeOf // \.{directiontime}의 연산 코드
	@!pointOf // \.{point}의 연산 코드
	@!precontrolOf // \.{precontrol}의 연산 코드
	@!postcontrolOf // \.{postcontrol}의 연산 코드
	@!penOffsetOf // \.{penoffset}의 연산 코드
)

const @!minOf = substringOf

@ @<함수들@>=
func printOp(c quarterword) {
	if c <= numericType {
		printType(c)
		return
	}
	switch c {
	@<|printOp|에서 연산 코드마다 이름을 찍는 경우들@>
	default:
		printStr("..")
	}
}

@ 연산 코드의 이름은 대개 그 원시 명령의 이름이다. 산술 연산자는 기호 하나로 찍는다.

@<|printOp|에서 연산 코드마다...@>=
case trueCode:
	printStr("true")
case falseCode:
	printStr("false")
case nullPictureCode:
	printStr("nullpicture")
case nullPenCode:
	printStr("nullpen")
case jobNameOp:
	printStr("jobname")
case readStringOp:
	printStr("readstring")
case penCircle:
	printStr("pencircle")
case normalDeviate:
	printStr("normaldeviate")
case oddOp:
	printStr("odd")
case knownOp:
	printStr("known")
case unknownOp:
	printStr("unknown")
case notOp:
	printStr("not")
case decimal:
	printStr("decimal")
case reverse:
	printStr("reverse")
case makePathOp:
	printStr("makepath")
case makePenOp:
	printStr("makepen")
case totalWeightOp:
	printStr("totalweight")

@ @<|printOp|에서 연산 코드마다...@>=
case octOp:
	printStr("oct")
case hexOp:
	printStr("hex")
case asciiOp:
	printStr("ASCII")
case charOp:
	printStr("char")
case lengthOp:
	printStr("length")
case turningOp:
	printStr("turningnumber")
case xPart:
	printStr("xpart")
case yPart:
	printStr("ypart")
case xxPart:
	printStr("xxpart")
case xyPart:
	printStr("xypart")
case yxPart:
	printStr("yxpart")
case yyPart:
	printStr("yypart")
case sqrtOp:
	printStr("sqrt")
case mExpOp:
	printStr("mexp")
case mLogOp:
	printStr("mlog")
case sinDOp:
	printStr("sind")
case cosDOp:
	printStr("cosd")

@ @<|printOp|에서 연산 코드마다...@>=
case floorOp:
	printStr("floor")
case uniformDeviate:
	printStr("uniformdeviate")
case charExistsOp:
	printStr("charexists")
case angleOp:
	printStr("angle")
case cycleOp:
	printStr("cycle")
case plus:
	printChar('+')
case minus:
	printChar('-')
case times:
	printChar('*')
case over:
	printChar('/')
case pythagAdd:
	printStr("++")
case pythagSub:
	printStr("+-+")
case orOp:
	printStr("or")
case andOp:
	printStr("and")
case lessThan:
	printChar('<')
case lessOrEqual:
	printStr("<=")
case greaterThan:
	printChar('>')
case greaterOrEqual:
	printStr(">=")

@ @<|printOp|에서 연산 코드마다...@>=
case equalTo:
	printChar('=')
case unequalTo:
	printStr("<>")
case concatenate:
	printStr("&")
case rotatedBy:
	printStr("rotated")
case slantedBy:
	printStr("slanted")
case scaledBy:
	printStr("scaled")
case shiftedBy:
	printStr("shifted")
case transformedBy:
	printStr("transformed")
case xScaled:
	printStr("xscaled")
case yScaled:
	printStr("yscaled")
case zScaled:
	printStr("zscaled")
case intersect:
	printStr("intersectiontimes")
case substringOf:
	printStr("substring")
case subpathOf:
	printStr("subpath")
case directionTimeOf:
	printStr("directiontime")
case pointOf:
	printStr("point")
case precontrolOf:
	printStr("precontrol")

@ @<|printOp|에서 연산 코드마다...@>=
case postcontrolOf:
	printStr("postcontrol")
case penOffsetOf:
	printStr("penoffset")

@ \MF에는 사용자가 만지작거리고 싶어 할 내부 매개변수도 한 무더기 있다. 그런 매개변수에는 저마다
식별 코드 번호가 있는데, 여기서 정의한다.

@<정의@>=
const (
	@!tracingTitles = iota + 1 // 제목이 나타나면 터미널에 보인다
	@!tracingEquations // 각 변수가 알려지게 되면 보인다
	@!tracingCapsules // 캡슐도 보인다
	@!tracingChoices // 경로에 고른 조절점을 보인다
	@!tracingSpecs // 화소화하기 전에 경로를 팔분면으로 나눈 것을 보인다
	@!tracingPens // 만든 펜의 세부를 보인다
	@!tracingCommands // 명령과 연산을 실행하기 전에 보인다
	@!tracingRestores // 변수나 내부 양을 되돌릴 때 보인다
	@!tracingMacros // 매크로를 펼치기 전에 보인다
	@!tracingEdges // 화소화한 가장자리를 계산하는 대로 보인다
	@!tracingOutput // 화소화한 가장자리를 내보낼 때 보인다
	@!tracingStats // 작업이 끝날 때 메모리 사용을 보인다
	@!tracingOnline // 긴 진단을 기록 파일뿐 아니라 터미널에도 보인다
)

@ 다음 내부 매개변수들은 날짜와 시각, 그리고 내보낼 글자에 관한 것이다.

@<정의@>=
const (
	@!year = tracingOnline + 1 + iota // 지금의 해(이를테면 1984)
	@!month // 지금의 달(이를테면 3 $\equiv$ 3월)
	@!day // 그 달의 날
	@!time // 이 작업이 시작된 때의 자정 뒤 분 수
	@!charCode // 다음에 내보낼 글자의 번호
	@!charExt // 다음에 내보낼 글자의 확장 코드
	@!charWd // 다음에 내보낼 글자의 너비
	@!charHt // 다음에 내보낼 글자의 높이
	@!charDp // 다음에 내보낼 글자의 깊이
	@!charIc // 다음에 내보낼 글자의 이탤릭 보정
	@!charDx // 다음 글자에 대한 장치의 $x$ 움직임(화소 단위)
	@!charDy // 다음 글자에 대한 장치의 $y$ 움직임(화소 단위)
	@!designSize // |charWd .. charIc|에 쓰는 측정 단위(포인트 단위)
	@!hppp // 포인트당 가로 화소 수
	@!vppp // 포인트당 세로 화소 수
	@!xOffset // 내보내는 글자의 가로 옮김
	@!yOffset // 내보내는 글자의 세로 옮김
)

@ 나머지는 \MF의 동작 방식을 다스리는 매개변수들이다.

@<정의@>=
const (
	@!pausing = yOffset + 1 + iota // 양수이면 줄을 읽기 전에 터미널에 보인다
	@!showstopping // 양수이면 \KW{show} 명령마다 멈춘다
	@!fontmaking // 양수이면 글꼴 계량 출력을 만든다
	@!proofing // 양수이면 교정 모드, 음수이면 출력을 막는다
	@!smoothing // 양수이면 움직임을 ``매끄럽게'' 한다
	@!autorounding // 경로를 ``좋은'' 점으로 고치는 것을 다스린다
	@!granularity // 자동 반올림이 이 화소 크기를 쓴다
	@!fillin // 대각선의 추가 진하기
	@!turningCheck // 시계 방향 경로의 방향 바꿈을 다스린다
	@!warningCheck // 변수의 값이 클 때의 오류 메시지를 다스린다
	@!boundaryChar // 합자를 위한 경계 글자
)

const @!maxGivenInternal = boundaryChar

@ @<전역 변수@>=
var @!internal [maxInternal + 1]scaled // 내부 양들의 값; 첨자는 |1 .. maxInternal|
var @!intName [maxInternal + 1]strNumber // 그 이름들
var @!intPtr int32 // 지금까지 정의된 가장 큰 내부 양; |maxGivenInternal .. maxInternal|

@ @<핵심 변수들의...@>=
for k = 1; k <= maxGivenInternal; k++ {
	internal[k] = 0
}
intPtr = maxGivenInternal

@ 내부 양들의 기호 이름은 나중에 정의할 |primitive|라는 루틴으로 \MF의 해시 표에 넣는다. 그
이름들을 다른 곳에서 다시 늘어놓지 않아도 되도록 지금 넣어 두자.

@<\MF의 원시 명령을 저마다 해시 표에 넣는다@>=
primitive("tracingtitles", internalQuantity, tracingTitles)
@!@:tracingtitles_}{\KW{tracingtitles} primitive@>
primitive("tracingequations", internalQuantity, tracingEquations)
@!@:tracingequations_}{\KW{tracingequations} primitive@>
primitive("tracingcapsules", internalQuantity, tracingCapsules)
@!@:tracingcapsules_}{\KW{tracingcapsules} primitive@>
primitive("tracingchoices", internalQuantity, tracingChoices)
@!@:tracingchoices_}{\KW{tracingchoices} primitive@>
primitive("tracingspecs", internalQuantity, tracingSpecs)
@!@:tracingspecs_}{\KW{tracingspecs} primitive@>
primitive("tracingpens", internalQuantity, tracingPens)
@!@:tracingpens_}{\KW{tracingpens} primitive@>
primitive("tracingcommands", internalQuantity, tracingCommands)
@!@:tracingcommands_}{\KW{tracingcommands} primitive@>
primitive("tracingrestores", internalQuantity, tracingRestores)
@!@:tracingrestores_}{\KW{tracingrestores} primitive@>
primitive("tracingmacros", internalQuantity, tracingMacros)
@!@:tracingmacros_}{\KW{tracingmacros} primitive@>
primitive("tracingedges", internalQuantity, tracingEdges)
@!@:tracingedges_}{\KW{tracingedges} primitive@>
primitive("tracingoutput", internalQuantity, tracingOutput)
@!@:tracingoutput_}{\KW{tracingoutput} primitive@>
primitive("tracingstats", internalQuantity, tracingStats)
@!@:tracingstats_}{\KW{tracingstats} primitive@>
primitive("tracingonline", internalQuantity, tracingOnline)
@!@:tracingonline_}{\KW{tracingonline} primitive@>
primitive("year", internalQuantity, year)
@!@:year_}{\KW{year} primitive@>
primitive("month", internalQuantity, month)
@!@:month_}{\KW{month} primitive@>
primitive("day", internalQuantity, day)
@!@:day_}{\KW{day} primitive@>
primitive("time", internalQuantity, time)
@!@:time_}{\KW{time} primitive@>
primitive("charcode", internalQuantity, charCode)
@!@:charcode_}{\KW{charcode} primitive@>

@ @<\MF의 원시 명령을...@>=
primitive("charext", internalQuantity, charExt)
@!@:charext_}{\KW{charext} primitive@>
primitive("charwd", internalQuantity, charWd)
@!@:charwd_}{\KW{charwd} primitive@>
primitive("charht", internalQuantity, charHt)
@!@:charht_}{\KW{charht} primitive@>
primitive("chardp", internalQuantity, charDp)
@!@:chardp_}{\KW{chardp} primitive@>
primitive("charic", internalQuantity, charIc)
@!@:charic_}{\KW{charic} primitive@>
primitive("chardx", internalQuantity, charDx)
@!@:chardx_}{\KW{chardx} primitive@>
primitive("chardy", internalQuantity, charDy)
@!@:chardy_}{\KW{chardy} primitive@>
primitive("designsize", internalQuantity, designSize)
@!@:designsize_}{\KW{designsize} primitive@>
primitive("hppp", internalQuantity, hppp)
@!@:hppp_}{\KW{hppp} primitive@>
primitive("vppp", internalQuantity, vppp)
@!@:vppp_}{\KW{vppp} primitive@>
primitive("xoffset", internalQuantity, xOffset)
@!@:xoffset_}{\KW{xoffset} primitive@>
primitive("yoffset", internalQuantity, yOffset)
@!@:yoffset_}{\KW{yoffset} primitive@>
primitive("pausing", internalQuantity, pausing)
@!@:pausing_}{\KW{pausing} primitive@>
primitive("showstopping", internalQuantity, showstopping)
@!@:showstopping_}{\KW{showstopping} primitive@>
primitive("fontmaking", internalQuantity, fontmaking)
@!@:fontmaking_}{\KW{fontmaking} primitive@>
primitive("proofing", internalQuantity, proofing)
@!@:proofing_}{\KW{proofing} primitive@>
primitive("smoothing", internalQuantity, smoothing)
@!@:smoothing_}{\KW{smoothing} primitive@>
primitive("autorounding", internalQuantity, autorounding)
@!@:autorounding_}{\KW{autorounding} primitive@>

@ @<\MF의 원시 명령을...@>=
primitive("granularity", internalQuantity, granularity)
@!@:granularity_}{\KW{granularity} primitive@>
primitive("fillin", internalQuantity, fillin)
@!@:fillin_}{\KW{fillin} primitive@>
primitive("turningcheck", internalQuantity, turningCheck)
@!@:turningcheck_}{\KW{turningcheck} primitive@>
primitive("warningcheck", internalQuantity, warningCheck)
@!@:warningcheck_}{\KW{warningcheck} primitive@>
primitive("boundarychar", internalQuantity, boundaryChar)
@!@:boundarychar_}{\KW{boundarychar} primitive@>

@ 그래도 기호를 써서 찍기 위해 이름을 한 번 더 늘어놓아야 한다. 이 이름들은 문자열 번호로
배열 |intName|에 들어가므로 문자열 상수의 목록에 넣는다. 위의 |primitive|는 이 목록에 있는
이름을 해시 표에 넣을 때 풀에 같은 문자열을 두 번 만들지 않고 목록의 것을 쓴다(\secref{primitive}).

@<표의 항목들을...@>=
intName[tracingTitles] = str("tracingtitles")
intName[tracingEquations] = str("tracingequations")
intName[tracingCapsules] = str("tracingcapsules")
intName[tracingChoices] = str("tracingchoices")
intName[tracingSpecs] = str("tracingspecs")
intName[tracingPens] = str("tracingpens")
intName[tracingCommands] = str("tracingcommands")
intName[tracingRestores] = str("tracingrestores")
intName[tracingMacros] = str("tracingmacros")
intName[tracingEdges] = str("tracingedges")
intName[tracingOutput] = str("tracingoutput")
intName[tracingStats] = str("tracingstats")
intName[tracingOnline] = str("tracingonline")
intName[year] = str("year")
intName[month] = str("month")
intName[day] = str("day")
intName[time] = str("time")
intName[charCode] = str("charcode")
intName[charExt] = str("charext")
intName[charWd] = str("charwd")
intName[charHt] = str("charht")
intName[charDp] = str("chardp")
intName[charIc] = str("charic")
intName[charDx] = str("chardx")
intName[charDy] = str("chardy")
intName[designSize] = str("designsize")
intName[hppp] = str("hppp")
intName[vppp] = str("vppp")
intName[xOffset] = str("xoffset")
intName[yOffset] = str("yoffset")
intName[pausing] = str("pausing")
intName[showstopping] = str("showstopping")
intName[fontmaking] = str("fontmaking")
intName[proofing] = str("proofing")
intName[smoothing] = str("smoothing")
intName[autorounding] = str("autorounding")
intName[granularity] = str("granularity")
intName[fillin] = str("fillin")
intName[turningCheck] = str("turningcheck")
intName[warningCheck] = str("warningcheck")
intName[boundaryChar] = str("boundarychar")

@ @<번호로 쓰이는 문자열 상수들@>=
"tracingtitles", "tracingequations", "tracingcapsules", "tracingchoices", "tracingspecs",
"tracingpens", "tracingcommands", "tracingrestores", "tracingmacros", "tracingedges",
"tracingoutput", "tracingstats", "tracingonline", "year", "month",
"day", "time", "charcode", "charext", "charwd",
"charht", "chardp", "charic", "chardx", "chardy",
"designsize", "hppp", "vppp", "xoffset", "yoffset",
"pausing", "showstopping", "fontmaking", "proofing", "smoothing",
"autorounding", "granularity", "fillin", "turningcheck", "warningcheck",
"boundarychar",

@ 다음 프로시저는 \MF가 입력과 출력을 초기화하기 바로 전에 불려서 날짜와 시각의 처음 값을 정한다.
@^system dependencies@>
이 프로그램은 적절한 값이 전역 변수 |sysTime|, |sysDay|, |sysMonth|, |sysYear|에 들어 있다고
그냥 가정한다(구현하는 사람이 부주의할 경우에 대비해서 1776년 7월 4일 정오로 초기화한다).
\GO/에서는 |time| 꾸러미로 지금 시각을 쉽게 얻을 수 있지만, 이 구현은 원본의 날짜를 그대로 둔다.
그러면 기록 파일과 \.{GF} 파일의 내용이 언제 만들든 같아서, 진짜 \MF의 결과와 바이트 하나까지
맞추어 볼 수 있다.

값들이 |scaled| 정수라는 데 주목하라. 그러므로 서기 32767년 뒤로는 \MF를 더 쓸 수 없다.

@<함수들@>=
func fixDateAndTime() {
	sysTime = 12 * 60
	sysDay = 4
	sysMonth = 7
	sysYear = 1776 // 자명한 진리들
	internal[time] = sysTime * unity // 자정 뒤의 분 수
	internal[day] = sysDay * unity // 그 달의 날
	internal[month] = sysMonth * unity // 그 해의 달
	internal[year] = sysYear * unity // 서기
}

@ \MF는 이따금 진단 정보를 찍어야 하는데, |tracingOnline|이 양수가 아니면 그것은 기록 파일에만
들어간다. 이제 |tracingOnline|을 정의했으므로 찍기 명령의 목적지를 조정하는 루틴 두 개를 정의할 수
있다.

@<기본 인쇄...@>=
func beginDiagnostic() { // 추적할 준비를 한다
	oldSetting = selector
	if internal[tracingOnline] <= 0 && selector == termAndLog {
		selector--
		if history == spotless {
			history = warningIssued
		}
	}
}

func endDiagnostic(blankLine bool) { // 추적한 다음 알맞은 조건을 되돌린다
	printNl("")
	if blankLine {
		printLn()
	}
	selector = oldSetting
}

@ 앞의 루틴들이 돌아가려면 전역 변수를 몇 개 더 선언해야 한다.

@<전역 변수@>=
var @!oldSetting int32 // |0 .. maxSelector|
var @!sysTime, @!sysDay, @!sysMonth, @!sysYear int32 // 외부 시스템이 주는 날짜와 시각

@ 줄 번호를 찍을 때는 이따금 |beginDiagnostic|을 다음과 같이 쓴다. (매개변수 |s|는
대개 |"Path"|나 |"Cycle spec"| 따위다.)

@<기본 인쇄...@>=
func printDiagnostic(s, t any, nuline bool) {
	beginDiagnostic()
	if nuline {
		printNl(s)
	} else {
		printStr(s)
	}
	printStr(" at line ")
	printInt(line)
	printStr(t)
	printChar(':')
}

@ 256개의 |asciiCode| 문자는 표 |charClass|에 따라 부류로 나뉜다. 낱낱의 부류 번호에는 여기서
정의하는 몇 경우를 빼면 의미나 구문의 뜻이 없다. 같은 부류의 문자들이 이어지면 토큰 하나가
되고, 부류가 바뀌면 토큰이 끝난다. 이를테면 `\.{<=}'은 두 문자가 모두 부류 10이므로 토큰 하나지만
`\.{<(}'은 토큰 둘이다. 표준이 아닌 \MF\ 확장에서 부류 번호를 더 쓰고 싶을 때 바탕으로 쓸 수 있는
|maxClass|도 있다.

@<정의@>=
const (
	@!digitClass = 0 // \.{0123456789}의 부류 번호
	@!periodClass = 1 // `\..'의 부류 번호
	@!spaceClass = 2 // 공백과 표준이 아닌 문자들의 부류 번호
	@!percentClass = 3 // `\.\%'의 부류 번호
	@!stringClass = 4 // `\."'의 부류 번호
	@!rightParenClass = 8 // `\.)'의 부류 번호
	@!letterClass = 9 // 글자와 밑줄 문자
	@!leftBracketClass = 17 // `\.['
	@!rightBracketClass = 18 // `\.]'
	@!invalidClass = 20 // 입력의 나쁜 문자
	@!maxClass = 20 // 가장 큰 부류 번호
)

func isolatedClass(c int32) bool { return c >= 5 && c <= 8 } // 길이 1인 토큰만 만드는 문자들

@ @<전역 변수@>=
var @!charClass [256]int32 // 부류 번호들; |0 .. maxClass|

@ 비{\mc ASCII} 문자 집합을 받아들이려고 고친다면, {\sl The {\logos METAFONT\/}book}의 부록~C의
지침을 따라야 한다.
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
@^system dependencies@>

@<핵심 변수들의...@>=
for k = '0'; k <= '9'; k++ {
	charClass[k] = digitClass
}
charClass['.'] = periodClass
charClass[' '] = spaceClass
charClass['%'] = percentClass
charClass['"'] = stringClass
charClass[','] = 5
charClass[';'] = 6
charClass['('] = 7
charClass[')'] = rightParenClass
for k = 'A'; k <= 'Z'; k++ {
	charClass[k] = letterClass
}
for k = 'a'; k <= 'z'; k++ {
	charClass[k] = letterClass
}
charClass['_'] = letterClass
charClass['<'] = 10
charClass['='] = 10
charClass['>'] = 10
charClass[':'] = 10
charClass['|'] = 10
charClass['`'] = 11
charClass['\''] = 11
charClass['+'] = 12

@ @<핵심 변수들의...@>=
charClass['-'] = 12
charClass['/'] = 13
charClass['*'] = 13
charClass['\\'] = 13
charClass['!'] = 14
charClass['?'] = 14
charClass['#'] = 15
charClass['&'] = 15
charClass['@@'] = 15
charClass['$'] = 15
charClass['^'] = 16
charClass['~'] = 16
charClass['['] = leftBracketClass
charClass[']'] = rightBracketClass
charClass['{'] = 19
charClass['}'] = 19
for k = 0; k <= ' '-1; k++ {
	charClass[k] = invalidClass
}
for k = 127; k <= 255; k++ {
	charClass[k] = invalidClass
}

@* 해시 표.
기호 토큰은 ``합쳐지는 목록''의 방법이라고 부르는 꽤 표준적인 해시 표 알고리즘으로 저장하고
꺼낸다({\sl The Art of Computer Programming\/}의 알고리즘 6.4C 참조). 기호 토큰은 한 번 표에
들어가면 결코 지워지지 않는다.

기호 토큰을 이루는 실제 문자들의 나열은 다른 모든 문자열과 함께 배열 |strPool|에 저장된다.
보조 배열 |hash|는 낱말마다 하프워드 필드 둘을 가진 항목들로 이루어진다. 그 가운데 |next(p)|라는
것은 |p|에 해당하는 식별자와 같은 합쳐진 목록에 속하는 다음 식별자를 가리키고, |text(p)|라는 다른
것은 |p|의 식별자의 문자열 번호를 가리킨다. 해시 표의 위치~|p|가 비어 있으면 |text(p)=0|이고,
위치 |p|가 비어 있거나 합쳐진 해시 목록의 끝이면 |next(p)=0|이다.

보조 포인터 변수 |hashUsed|는 |p>=hashUsed|인 모든 위치가 비어 있지 않도록 유지된다. 전역 변수
|stCount|는 통계를 모을 때 지금까지 정의된 기호 토큰의 수를 알려 준다.

배열 |hash|의 처음 256개 위치는 길이가 1인 기호를 위해 남겨 둔다.

또 |eqtb|라는 나란한 배열이 있는데, 여기에는 각 기호 토큰의 현재 등가 값이 들어 있다. 이 배열의
항목은 |eqType|(명령 코드)과 |equiv|(|eqType|을 한정하는 이차 정보)라는 하프워드 둘로 이루어진다.

@<정의@>=
func next(p pointer) halfword         { return hash[p].lh } // 합쳐진 목록의 연결
func setNext(p pointer, v halfword)   { hash[p].lh = v }
func text(p pointer) halfword         { return hash[p].rh } // 기호 토큰 이름의 문자열 번호
func setText(p pointer, v halfword)   { hash[p].rh = v }
func eqType(p pointer) halfword       { return eqtb[p].lh } // 기호 토큰의 현재 ``뜻''
func setEqType(p pointer, v halfword) { eqtb[p].lh = v }
func equiv(p pointer) halfword        { return eqtb[p].rh } // 토큰의 뜻의 매개변수 부분
func setEquiv(p pointer, v halfword)  { eqtb[p].rh = v }

const @!hashBase = 257 // 해싱은 실제로 여기서 시작한다

func hashIsFull() bool { return hashUsed == hashBase } // 모든 위치가 차 있는가?

@ @<전역 변수@>=
var @!hashUsed pointer // |hash|의 할당 포인터
var @!stCount int32 // 알려진 식별자의 전체 수

@ 해시 표의 어떤 항목들은 오류 회복에 쓰이므로 ``얼어붙어'' 있어서 다시 정의할 수 없다.

@<정의@>=
const (
	@!hashTop = hashBase + hashSize // 얼어붙은 영역의 첫 위치
	@!frozenInaccessible = hashTop // 얼어붙은 영역을 지키는 |hash| 위치
	@!frozenRepeatLoop = hashTop + 1 // 루프를 되풀이하는 토큰의 |hash| 위치
	@!frozenRightDelimiter = hashTop + 2 // 영구적인 `\.)'의 |hash| 위치
	@!frozenLeftBracket = hashTop + 3 // 영구적인 `\.['의 |hash| 위치
	@!frozenSlash = hashTop + 4 // 영구적인 `\./'의 |hash| 위치
	@!frozenColon = hashTop + 5 // 영구적인 `\.:'의 |hash| 위치
	@!frozenSemicolon = hashTop + 6 // 영구적인 `\.;'의 |hash| 위치
	@!frozenEndFor = hashTop + 7 // 영구적인 \KW{endfor}의 |hash| 위치
	@!frozenEndDef = hashTop + 8 // 영구적인 \KW{enddef}의 |hash| 위치
	@!frozenFi = hashTop + 9 // 영구적인 \KW{fi}의 |hash| 위치
	@!frozenEndGroup = hashTop + 10 // 영구적인 `\.{endgroup}'의 |hash| 위치
	@!frozenBadVardef = hashTop + 11 // `\.{a bad variable}'의 |hash| 위치
	@!frozenUndefined = hashTop + 12 // 결코 정의되지 않는 |hash| 위치
	@!hashEnd = hashTop + 12 // |hash|와 |eqtb| 배열의 실제 크기
)

@ @<전역 변수@>=
var @!hash [hashEnd + 1]twoHalves // 해시 표; 첨자는 |1 .. hashEnd|
var @!eqtb [hashEnd + 1]twoHalves // 등가물들; 첨자는 |1 .. hashEnd|

@ @<핵심 변수들의...@>=
setNext(1, 0)
setText(1, 0)
setEqType(1, tagToken)
setEquiv(1, null)
for k = 2; k <= hashEnd; k++ {
	hash[k] = hash[1]
	eqtb[k] = eqtb[1]
}

@ 얼어붙은 항목들의 이름은 문자열 번호로 |text|에 들어가므로 문자열 상수의 목록에 넣는다.
그 가운데 `\.{\ INACCESSIBLE}'은 앞에 공백이 있어서 사용자가 결코 칠 수 없는 이름이다.

@<표의 항목들을...@>=
hashUsed = frozenInaccessible // 아무것도 쓰이지 않았다
stCount = 0
setText(frozenBadVardef, str("a bad variable"))
setText(frozenFi, str("fi"))
setText(frozenEndGroup, str("endgroup"))
setText(frozenEndDef, str("enddef"))
setText(frozenEndFor, str("endfor"))
setText(frozenSemicolon, ';')
setText(frozenColon, ':')
setText(frozenSlash, '/')
setText(frozenLeftBracket, '[')
setText(frozenRightDelimiter, ')')
setText(frozenInaccessible, str(" INACCESSIBLE"))
setEqType(frozenRightDelimiter, rightDelimiter)

@ @<번호로 쓰이는 문자열 상수들@>=
"a bad variable", "fi", "endgroup", "enddef", "endfor", " INACCESSIBLE",

@ @<``상수'' 값들이...@>=
if hashEnd+maxInternal > maxHalfword {
	bad = 21
}

@ 다음은 길이가~|l|이고 |buffer[j .. (j+l-1)]|에 나타나는 주어진 문자열과 맞는 식별자를 해시 표에서 찾는
서브루틴이다. 식별자를 찾지 못하면 그것을 넣는다. 그러므로 언제나 찾게 되고, 해당하는 해시 표
주소를 돌려준다.

@<함수들@>=
func idLookup(j, l int32) pointer { // 해시 표를 찾는다
	var h int32 // 해시 코드
	var p pointer // |hash| 배열의 첨자
	var k pointer // |buffer| 배열의 첨자
	if l == 1 {
		@<길이 1인 특별한 경우를 처리하고 |goto found|@>
	}
	@<해시 코드 |h|를 계산한다@>
	p = h + hashBase // 여기서 찾기 시작한다; |0<=h<hashPrime|임에 주목하라
	for {
		if text(p) > 0 {
			if length(text(p)) == l {
				if strEqBuf(text(p), j) {
					goto found
				}
			}
		}
		if next(p) == 0 {
			@<|p| 다음에 새 기호 토큰을 넣고, |p|가 그것을 가리키게 하고 |goto found|@>
		}
		p = next(p)
	}
found:
	return p
}

@ @<길이 1인 특별한...@>=
p = buffer[j] + 1
setText(p, p-1)
goto found

@ 합쳐지는 목록의 방법에서는 충돌한 식별자를 위한 자리를 표의 위쪽 끝부터 아래로 찾아 내려간다.
그래서 서로 다른 해시 코드의 목록들이 한 줄로 ``합쳐질'' 수 있지만, 모든 위치를 다 쓸 때까지
표가 넘치지 않는다.

@<|p| 다음에 새 기호...@>=
if text(p) > 0 {
	for {
		if hashIsFull() {
			overflow("hash size", hashSize)
@:METAFONT capacity exceeded hash size}{\quad hash size@>
		}
		hashUsed--
		if text(hashUsed) == 0 {
			break
		} // |hash|에서 빈 위치를 찾는다
	}
	setNext(p, hashUsed)
	p = hashUsed
}
strRoom(l)
for k = j; k <= j+l-1; k++ {
	appendChar(buffer[k])
}
setText(p, makeString())
strRef[text(p)] = maxStrRef
if stat {
	stCount++
}
goto found

@ 상수 |hashPrime|의 값은 |hashSize|의 대략 85\pct!여야 하고, 소수여야 한다. 해싱 이론에 따르면 찾기가
성공할 때 평균 두 번보다 적게 표를 살필 것으로 기대할 수 있다. [J.~S. 비터, {\sl Journal of the
ACM\/ \bf30} (1983), 231--258 참조.]
@^Vitter, Jeffrey Scott@>

@<해시 코드 |h|를...@>=
h = buffer[j]
for k = j + 1; k <= j+l-1; k++ {
	h = h + h + buffer[k]
	for h >= hashPrime {
		h = h - hashPrime
	}
}

@ @<|eqtb|에서 |p|와 같은...@>=
for q = 1; q <= hashEnd; q++ {
	if equiv(q) == p {
		printNl("EQUIV(")
		printInt(q)
		printChar(')')
	}
}

@ \seclabel{primitive}\MF의 ``원시'' 기호 토큰들을 그 명령 코드(이것이 |eqType|이 된다)와 피연산자(이것이
|equiv|가 된다)와 함께 해시 표에 넣어야 한다. 프로시저 |primitive|가 이 일을 하는데, 어떤 \MF\
사용자도 할 수 없는 방식으로 한다. 이 프로시저가 일을 마치면 전역 변수 |curSym|에 새 |eqtb| 포인터가
들어 있다.

이름 |s|는 \GO/ 문자열로 받아서 (비어 있는) |buffer|로 옮긴 다음 |idLookup|에 넘긴다. 그러면
|idLookup|이 그 이름을 새 문자열로 풀에 넣는다. 그런데 그 이름이 이미 문자열 상수의 목록
|poolLiterals|에 있다면, 같은 문자열을 풀에 두 번 두고 싶지 않으므로 방금 만든 문자열을 버리고
목록의 것을 쓴다. 이 프로시저는 \.{INIMF}에서만 쓰인다.

@<함수들@>=
func primitive(s string, c halfword, o halfword) {
	var j int32 // |buffer|의 첨자
	var l int32 // 문자열의 길이
	l = int32(len(s)) // |s|를 (비어 있는) |buffer|로 옮길 것이다
	for j = 0; j <= l-1; j++ {
		buffer[j] = xord[s[j]]
	}
	curSym = idLookup(0, l)
	if l > 1 {
		for i, lit := range poolLiterals {
			if lit == s { // 문자열을 두 번 두고 싶지 않다
				flushString(strPtr - 1)
				setText(curSym, 256+strNumber(i))
				break
			}
		}
	}
	setEqType(curSym, c)
	setEquiv(curSym, o)
}

@ \MF의 원시 명령 가운데 많은 것은 |equiv|가 필요 없다. 명령 코드 |eqType|만으로 알아볼 수 있기 때문이다.
이런 원시 명령들은 다음과 같이 해시 표에 싣는다.

@<\MF의 원시 명령을...@>=
primitive("..", pathJoin, 0)
@!@:.._}{\.{..} primitive@>
primitive("[", leftBracket, 0)
eqtb[frozenLeftBracket] = eqtb[curSym]
@!@:[ }{\.{[} primitive@>
primitive("]", rightBracket, 0)
@!@:] }{\.{]} primitive@>
primitive("}", rightBrace, 0)
@!@:]]}{\.{\char`\}} primitive@>
primitive("{", leftBrace, 0)
@!@:][}{\.{\char`\{} primitive@>
primitive(":", colon, 0)
eqtb[frozenColon] = eqtb[curSym]
@!@:: }{\.{:} primitive@>
primitive("::", doubleColon, 0)
@!@::: }{\.{::} primitive@>
primitive("||:", bcharLabel, 0)
@!@:::: }{\.{\char'174\char'174:} primitive@>
primitive(":=", assignment, 0)
@!@::=_}{\.{:=} primitive@>
primitive(",", comma, 0)
@!@:, }{\., primitive@>
primitive(";", semicolon, 0)
eqtb[frozenSemicolon] = eqtb[curSym]
@!@:; }{\.; primitive@>
primitive("\\", relax, 0)
@!@:]]\\}{\.{\char`\\} primitive@>
primitive("addto", addToCommand, 0)
@!@:add_to_}{\KW{addto} primitive@>
primitive("at", atToken, 0)
@!@:at_}{\KW{at} primitive@>
primitive("atleast", atLeast, 0)
@!@:at_least_}{\KW{atleast} primitive@>
primitive("begingroup", beginGroup, 0)
bgLoc = curSym
@!@:begin_group_}{\KW{begingroup} primitive@>

@ @<\MF의 원시 명령을...@>=
primitive("controls", controls, 0)
@!@:controls_}{\KW{controls} primitive@>
primitive("cull", cullCommand, 0)
@!@:cull_}{\KW{cull} primitive@>
primitive("curl", curlCommand, 0)
@!@:curl_}{\KW{curl} primitive@>
primitive("delimiters", delimiters, 0)
@!@:delimiters_}{\KW{delimiters} primitive@>
primitive("display", displayCommand, 0)
@!@:display_}{\KW{display} primitive@>
primitive("endgroup", endGroup, 0)
eqtb[frozenEndGroup] = eqtb[curSym]
egLoc = curSym
@!@:endgroup_}{\KW{endgroup} primitive@>
primitive("everyjob", everyJobCommand, 0)
@!@:every_job_}{\KW{everyjob} primitive@>
primitive("exitif", exitTest, 0)
@!@:exit_if_}{\KW{exitif} primitive@>
primitive("expandafter", expandAfter, 0)
@!@:expand_after_}{\KW{expandafter} primitive@>
primitive("from", fromToken, 0)
@!@:from_}{\KW{from} primitive@>
primitive("inwindow", inWindow, 0)
@!@:in_window_}{\KW{inwindow} primitive@>
primitive("interim", interimCommand, 0)
@!@:interim_}{\KW{interim} primitive@>
primitive("let", letCommand, 0)
@!@:let_}{\KW{let} primitive@>
primitive("newinternal", newInternal, 0)
@!@:new_internal_}{\KW{newinternal} primitive@>
primitive("of", ofToken, 0)
@!@:of_}{\KW{of} primitive@>
primitive("openwindow", openWindow, 0)
@!@:open_window_}{\KW{openwindow} primitive@>
primitive("randomseed", randomSeed, 0)
@!@:random_seed_}{\KW{randomseed} primitive@>

@ @<\MF의 원시 명령을...@>=
primitive("save", saveCommand, 0)
@!@:save_}{\KW{save} primitive@>
primitive("scantokens", scanTokens, 0)
@!@:scan_tokens_}{\KW{scantokens} primitive@>
primitive("shipout", shipOutCommand, 0)
@!@:ship_out_}{\KW{shipout} primitive@>
primitive("skipto", skipTo, 0)
@!@:skip_to_}{\KW{skipto} primitive@>
primitive("step", stepToken, 0)
@!@:step_}{\KW{step} primitive@>
primitive("str", strOp, 0)
@!@:str_}{\KW{str} primitive@>
primitive("tension", tension, 0)
@!@:tension_}{\KW{tension} primitive@>
primitive("to", toToken, 0)
@!@:to_}{\KW{to} primitive@>
primitive("until", untilToken, 0)
@!@:until_}{\KW{until} primitive@>

@ 원시 명령마다 짝이 되는 역이 있어서, |eqtb|의 수수께끼 같은 수치 내용을 기호의 꼴로 보일 수
있다. 그래서 이 프로그램에서 |primitive|를 부를 때마다 아래에서 설명할 루틴 |printCmdMod|의 일부가
되는 간단한 코드가 따라온다. 그 코드는 |printCmdMod|의 |switch| 문의 |case| 절들이다.

@<|printCmdMod|에서 원시 명령을 기호로 찍는 경우들@>=
case addToCommand:
	printStr("addto")
case assignment:
	printStr(":=")
case atLeast:
	printStr("atleast")
case atToken:
	printStr("at")
case bcharLabel:
	printStr("||:")
case beginGroup:
	printStr("begingroup")
case colon:
	printStr(":")
case comma:
	printStr(",")
case controls:
	printStr("controls")
case cullCommand:
	printStr("cull")
case curlCommand:
	printStr("curl")
case delimiters:
	printStr("delimiters")
case displayCommand:
	printStr("display")
case doubleColon:
	printStr("::")
case endGroup:
	printStr("endgroup")
case everyJobCommand:
	printStr("everyjob")
case exitTest:
	printStr("exitif")
case expandAfter:
	printStr("expandafter")

@ @<|printCmdMod|에서 원시 명령을...@>=
case fromToken:
	printStr("from")
case inWindow:
	printStr("inwindow")
case interimCommand:
	printStr("interim")
case leftBrace:
	printStr("{")
case leftBracket:
	printStr("[")
case letCommand:
	printStr("let")
case newInternal:
	printStr("newinternal")
case ofToken:
	printStr("of")
case openWindow:
	printStr("openwindow")
case pathJoin:
	printStr("..")
case randomSeed:
	printStr("randomseed")
case relax:
	printChar('\\')
case rightBrace:
	printStr("}")
case rightBracket:
	printStr("]")
case saveCommand:
	printStr("save")
case scanTokens:
	printStr("scantokens")
case semicolon:
	printStr(";")
case shipOutCommand:
	printStr("shipout")

@ @<|printCmdMod|에서 원시 명령을...@>=
case skipTo:
	printStr("skipto")
case stepToken:
	printStr("step")
case strOp:
	printStr("str")
case tension:
	printStr("tension")
case toToken:
	printStr("to")
case untilToken:
	printStr("until")

@ 다른 원시 명령들은 나중에, 그것들의 |eqType|과 |equiv| 값이 더 뜻이 있는 곳에서 다룰 것이다.
이를테면 매크로 정의를 위한 원시 명령들은 매크로를 정의하는 루틴들을 살펴볼 때 싣는다. 각 원시
명령을 어디서 다루었는지는 끝의 찾아보기를 보면 쉽게 찾을 수 있다. 이를테면 |"def"|가 |eqtb|에
들어간 절은 `\KW{def} primitive' 아래에 나와 있다.

@* 토큰 목록.
\MF\ 토큰은 기호이거나 수치이거나 문자열이거나, 매크로 매개변수나 캡슐을 나타낸다. 그래서
@^token@>
내부에서 토큰을 나타내는 방법도 다섯 가지다. (1)~해시 코드가~|p|인 기호 토큰은 |mem|의 한
낱말짜리 노드의 |info| 필드에 든 수 |p|로 나타낸다. (2)~|scaled| 값이~|v|인 수치 토큰은 |mem|의
두 낱말짜리 노드로 나타낸다. 그 |type| 필드는 |known|이고, |nameType| 필드는 |token|이며, |value|
필드에 |v|가 들어 있다. 이 토큰이 한 낱말짜리 노드가 아니라 두 낱말짜리 노드에 있다는 것은 물론
노드의 주소를 보면 분명하다. (3)~문자열 토큰도 두 낱말짜리 노드로 나타낸다. 그 |type| 필드는
|stringType|이고, |nameType| 필드는 |token|이며, |value| 필드에 해당하는 |strNumber|가 들어 있다.
(4)~캡슐은 |nameType=capsule|이고, 그 |type|과 |value| 필드는 (나중에 설명할 방식으로) 임의의 값을
나타낸다. (5)~매크로 매개변수는 한 낱말짜리 노드의 |info| 필드에 나타난다는 점에서 기호 토큰과
비슷하다. 매개변수 가운데 $k$번째 것은 형이 \KW{expr}이면 |exprBase+k|로, \KW{suffix}면 |suffixBase+k|로,
\KW{text}면 |textBase+k|로 나타낸다. (여기서 |0<=k<paramSize|다.) 이 매개변수들의 실제 값은 나중에
보겠지만 따로 스택에 둔다. 상수 |exprBase|, |suffixBase|, |textBase|는 물론 기호 토큰과 여러 형의
매개변수가 헷갈리지 않도록 고른다.

상수 |null|과 |nullCoords|가 같으므로 |value(null)=0|이다. 나중에 이 우연을 이용할 것이다.

덧붙여, 우연 이야기가 나온 김에 말하자면, 노드의 `\\{type}' 필드는 인쇄업자가 말하는 ``활자''(type)와
아무 관계가 없다. 같은 낱말이 이렇게 다른 뜻으로 쓰이는 것은 묘한 일이다.

@<정의@>=
func typ(p pointer) quarterword            { return mem[p].hh.b0 } // 이것이 어떤 종류의 값인지 알려 준다
func setType(p pointer, v quarterword)     { mem[p].hh.b0 = v }
func nameType(p pointer) quarterword       { return mem[p].hh.b1 } // 이 값의 이름에 대한 단서
func setNameType(p pointer, v quarterword) { mem[p].hh.b1 = v }

const @!tokenNodeSize = 2 // 큰 토큰 노드의 낱말 수

func valueLoc(p pointer) pointer       { return p + 1 } // |value| 필드가 든 낱말
func value(p pointer) int32            { return mem[valueLoc(p)].sc } // 큰 토큰 노드에 저장된 값
func setValue(p pointer, v int32)      { mem[valueLoc(p)].sc = v }

const (
	@!exprBase = hashEnd + 1 // 0번째 \KW{expr} 매개변수의 코드
	@!suffixBase = exprBase + paramSize // 0번째 \KW{suffix} 매개변수의 코드
	@!textBase = suffixBase + paramSize // 0번째 \KW{text} 매개변수의 코드
)

@ @<``상수'' 값들이...@>=
if textBase+paramSize > maxHalfword {
	bad = 22
}

@ 수치 토큰은 다음의 하찮은 루틴으로 만든다.

@<함수들@>=
func newNumTok(v scaled) pointer {
	var p pointer // 새 노드
	p = getNode(tokenNodeSize)
	setValue(p, v)
	setType(p, known)
	setNameType(p, token)
	return p
}

@ 토큰 목록은 |mem|의 노드들로 된 한 방향 연결 목록이고, 각 노드에는 토큰 하나와 연결 하나가
들어 있다. 다음은 토큰 목록이 더는 필요 없을 때 그것을 없애는 서브루틴이다. 캡슐에 든 값은
나중에 정의할 |recycleValue|로 재활용한다.

\GO/의 |case|에는 여러 값을 늘어놓을 수 있으므로, 원본이 `\\{unknown\_types}'라는 매크로로
묶은 다섯 형을 여기서는 그대로 늘어놓는다.

@<함수들@>=
func flushTokenList(p pointer) {
	var q pointer // 재활용하고 있는 노드
	for p != null {
		q = p
		p = link(p)
		if q >= hiMemMin {
			freeAvail(q)
		} else {
			switch typ(q) {
			case vacuous, booleanType, known:
				// 아무것도 하지 않는다
			case stringType:
				deleteStrRef(value(q))
			case unknownBoolean, unknownString, unknownPen, unknownPicture, unknownPath,
				penType, pathType, futurePen, pictureType,
				pairType, transformType, dependent, protoDependent, independent:
				recycleValue(q)
			default:
				confusion("token")
@:this can't happen token}{\quad token@>
			}
			freeNode(q, tokenNodeSize)
		}
	}
}

@ 주어진 노드 |p|에서 시작하는 토큰 목록을 기호의 꼴로 찍는 프로시저 |showTokenList|는 이런 관례들을
잘 보여 준다. 보이는 토큰 목록은 참조 횟수로 시작하면 안 된다. 그러나 이 프로시저는 꽤 튼튼하게
만들어서, 메모리 연결이 엉망이거나 |p|가 실제로는 토큰 목록을 가리키지 않더라도 큰 탈이
일어나지 않게 했다.

매개변수 |q|도 하나 더 주어진다. 이 매개변수는 널이거나, 토큰 목록에서 나중에 설명할 어떤 마법 같은
계산이 일어나는 노드를 가리킨다. (기본적으로 |q|가 널이 아닌 것은 오류 메시지를 낼 때 두 줄짜리
문맥 정보를 찍는 경우다. 이때 |q|는 둘째 줄이 시작해야 할 곳에 해당하는 자리를 표시한다.)

찍은 길이가 주어진 한계~|l|을 넘으면 찍기를 멈추고 `\.{\char`\ ETC.}'를 찍는다. 이 프로시저에
들어올 때의 찍은 길이는 |nullTally|라는 주어진 양이라고 가정한다. (프로시저 |showTokenList|는 이따금 캡슐
안의 변수 이름을 찍으려고 스스로를 재귀적으로 부른다.)
@^recursion@>

이상한 항목은 `\.{\char`\ BAD}'처럼 앞에 공백이 붙은 대문자 토큰으로 찍는다.

이웃한 두 토큰을 찍을 때, 둘 사이에 무엇을 넣을지는 앞 토큰의 부류 |class|와 새 토큰의 부류
|c|가 정한다. 같은 부류의 문자들이 이어지면 \MF가 그것을 한 토큰으로 읽으므로(\secref{map} 참조),
둘 사이에 공백을 넣어야 다시 읽을 때 같은 토큰들이 나온다. 다만 글자 부류끼리는 공백 대신 `\..'을
넣어서 `\.{x.a}'처럼 변수 이름을 자연스럽게 찍는다.

@<함수들@>=
func showTokenList(p, q pointer, l, nullTally int32) {
	var class, c smallNumber // 앞의 토큰과 새 토큰의 |charClass|
	var r, v int32 // 임시 레지스터들
	class = percentClass
	tally = nullTally
	for p != null && tally < l {
		if p == q {
			@<마법 같은 계산을 한다@>
		}
		@<토큰 |p|를 보이고 |c|를 그 부류로 놓는다; 문제가 있으면 |return|한다@>
		class = c
		p = link(p)
	}
	if p != null {
		printStr(" ETC.")
	}
@.ETC@>
}

@ @<토큰 |p|를 보이고...@>=
c = letterClass // 기본값
if p < memMin || p > memEnd {
	printStr(" CLOBBERED")
	return
@.CLOBBERED@>
}
if p < hiMemMin {
	@<두 낱말짜리 토큰을 보인다@>
} else {
	r = info(p)
	if r >= exprBase {
		@<매개변수 토큰을 보인다@>
	} else if r < 1 {
		if r == 0 {
			@<집합 첨자를 보인다@>
		} else {
			printStr(" IMPOSSIBLE")
		}
@.IMPOSSIBLE@>
	} else {
		r = text(r)
		if r < 0 || r >= strPtr {
			printStr(" NONEXISTENT")
@.NONEXISTENT@>
		} else {
			@<문자열 |r|를 기호 토큰으로 찍고 |c|를 그 부류로 놓는다@>
		}
	}
}

@ @<두 낱말짜리 토큰을...@>=
if nameType(p) == token {
	if typ(p) == known {
		@<수치 토큰을 보인다@>
	} else if typ(p) != stringType {
		printStr(" BAD")
@.BAD@>
	} else {
		printChar('"')
		slowPrint(value(p))
		printChar('"')
		c = stringClass
	}
} else if nameType(p) != capsule || typ(p) < vacuous || typ(p) > independent {
	printStr(" BAD")
} else {
	printCapsule(p)
	c = rightParenClass
}

@ 음수는 `\.{[-1.5]}'처럼 대괄호에 싸서 찍는다. 그냥 `\.{-1.5}'로 찍으면 다시 읽을 때 빼기 연산자와
양수 두 토큰이 되기 때문이다.

@<수치 토큰을...@>=
if class == digitClass {
	printChar(' ')
}
v = value(p)
if v < 0 {
	if class == leftBracketClass {
		printChar(' ')
	}
	printChar('[')
	printScaled(v)
	printChar(']')
	c = rightBracketClass
} else {
	printScaled(v)
	c = digitClass
}

@ 엄밀히 말하면 진짜 토큰은 결코 |info(p)=0|이 아니다. 그러나 나중에 (속성 노드의 정의에서) 보겠지만
|info(p)=0|이 `\.{[]}'를 나타내게 하면 편리하다.

@<집합 첨자를...@>=
if class == leftBracketClass {
	printChar(' ')
}
printStr("[]")
c = rightBracketClass

@ @<매개변수 토큰을...@>=
if r < suffixBase {
	printStr("(EXPR")
	r = r - (exprBase)
@.EXPR@>
} else if r < textBase {
	printStr("(SUFFIX")
	r = r - (suffixBase)
@.SUFFIX@>
} else {
	printStr("(TEXT")
	r = r - (textBase)
@.TEXT@>
}
printInt(r)
printChar(')')
c = rightParenClass

@ @<문자열 |r|를 기호 토큰으로...@>=
c = charClass[so(strPool[strStart[r]])]
if c == class {
	switch {
	case c == letterClass:
		printChar('.')
	case isolatedClass(c):
		// 아무것도 하지 않는다
	default:
		printChar(' ')
	}
}
slowPrint(r)

@ 원본은 \PASCAL의 |forward| 선언에 관한 관례가 싫어서 |printCapsule|과 |tokenRecycle|을 매개변수
없이 선언하고, 인자를 전역 변수 |g_pointer|로 넘겼다. 프로시저 |showTokenList|가 (한 단계로 묶여 있기는
하지만) 재귀적이고, |flushTokenList|가 문법상으로는(뜻으로는 아니지만) 재귀적이어서 무언가 해야
했기 때문이다. \GO/에서는 함수를 정의하기 전에도 부를 수 있으므로 그런 꾀가 필요 없다. 그래서
|printCapsule|은 캡슐을 인자로 받고, |tokenRecycle|은 할 일이 |recycleValue|를 부르는 것뿐이므로
그 자리에서 바로 |recycleValue|를 부른다.
@^recursion@>

@<함수들@>=
func printCapsule(p pointer) {
	printChar('(')
	printExp(p, 0)
	printChar(')')
}

@ 매크로 정의는 맨 앞에 한 낱말짜리 노드 몇 개가 더 붙은 토큰 목록의 꼴로 \MF의 메모리에 둔다.

첫 노드에는 그 목록이 더는 필요 없게 되는 때를 알려 주는 참조 횟수가 들어 있다. 참조 횟수가 있다는
것을 강조하려고 이 특별한 노드의 |info| 필드를 |refCount| 필드라고 부르기로 한다.
@^reference counts@>

참조 횟수 뒤의 노드 하나나 여럿은 형식 매개변수를 설명한다. 그것들은 매개변수 토큰 0개 이상과 그 뒤에
오는 매크로의 형을 나타내는 코드로 이루어진다.

@<정의@>=
func refCount(p pointer) halfword       { return info(p) } // 매크로 정의나 펜 머리 앞의 참조 횟수
func setRefCount(p pointer, v halfword) { setInfo(p, v) }
func addMacRef(p pointer)               { setRefCount(p, refCount(p)+1) } // 매크로 목록을 새로 참조한다

const (
	@!generalMacro = iota // 매개변수 목록으로 정의한 매크로의 머리말
	@!primaryMacro // \KW{primary} 매개변수를 가진 매크로의 머리말
	@!secondaryMacro // \KW{secondary} 매개변수를 가진 매크로의 머리말
	@!tertiaryMacro // \KW{tertiary} 매개변수를 가진 매크로의 머리말
	@!exprMacro // 구분되지 않은 \KW{expr} 매개변수를 가진 매크로의 머리말
	@!ofMacro // 구분되지 않은 `\KW{expr} |x| \KW{of}~|y|' 매개변수를 가진 매크로의 머리말
	@!suffixMacro // 구분되지 않은 \KW{suffix} 매개변수를 가진 매크로의 머리말
	@!textMacro // 구분되지 않은 \KW{text} 매개변수를 가진 매크로의 머리말
)

@ @<함수들@>=
func deleteMacRef(p pointer) {
	@t\qquad@>// |p|는 참조 하나를 잃는 매크로 목록의 참조 횟수를 가리킨다
	if refCount(p) == null {
		flushTokenList(p)
	} else {
		setRefCount(p, refCount(p)-1)
	}
}

@ 다음 서브루틴은 매크로의 참조 횟수를 가리키는 포인터를 받아 그 매크로를 보인다.

@<함수들@>=
func showMacro(p pointer, q, l int32) {
	var r pointer // 임시 저장소
	p = link(p) // 참조 횟수를 건너뛴다
	for info(p) > textMacro {
		r = link(p)
		setLink(p, null)
		showTokenList(p, null, l, 0)
		setLink(p, r)
		p = r
		if l > 0 {
			l = l - tally
		} else {
			return
		}
	} // `\.{ETC.}'의 찍기를 다스린다
@.ETC@>
	tally = 0
	switch info(p) {
	case generalMacro:
		printStr("->")
@.->@>
	case primaryMacro, secondaryMacro, tertiaryMacro:
		printChar('<')
		printCmdMod(paramType, info(p))
		printStr(">->")
	case exprMacro:
		printStr("<expr>->")
	case ofMacro:
		printStr("<expr>of<primary>->")
	case suffixMacro:
		printStr("<suffix>->")
	case textMacro:
		printStr("<text>->")
	} // 다른 경우는 없다
	showTokenList(link(p), q, l-tally, 0)
}

@* 변수의 자료 구조.
\MF\ 프로그램의 변수는 `\.x'처럼 단순할 수도 있고, `\.{x20a.b}'처럼 배열과 레코드의 구조적 성질을
아우를 수도 있다. \MF\ 사용자는 이를테면 `\.{boolean} \.{x[]a.b}'라고 해서 \.{x20a.b} 같은 변수에
형을 준다. 이제 그런 것이 컴퓨터 안에서 어떻게 나타나는지 공부할 때가 되었다.

변수의 값은 저마다 이어진 두 낱말을 차지한다. 값 노드라고 부르는 두 낱말짜리 노드에 들어 있을
수도 있고, 더 큰 노드의 두 낱말짜리 하위 필드일 수도 있다. 두 낱말 가운데 하나는 |value| 필드라고
부른다. 이것은 정수로서, |scaled| 수치 값이나 다른 형의 양을 나타내는 것을 담는다. (하프워드로 나뉠
수도 있는데, 그때는 |value| 대신 다른 이름으로 부른다.) 다른 낱말은 |type|, |nameType|, |link|라는
하위 필드로 나뉜다. 그 가운데 |type| 필드는 변수의 형을 지정하는 쿼터워드이고, |nameType|은 \MF가 변수의
이름을 (때로는 |link| 필드도 써서) 다시 만들어 낼 수 있게 해 주는 쿼터워드다. 그러므로 값 자체에
실제로 바치는 것은 1.25낱말뿐이고, 나머지 4분의 3낱말은 덧붙은 비용이다. 그러나 그것은 \MF가
성긴 배열을 다루고 뜻있는 진단을 내게 해 주므로 낭비가 아니다.

이 부에서는 변수의 값이 아니라 구조적인 면만 다룬다. 프로그램의 뒷부분이 |type|과 |value| 필드를
바꾸겠지만, 여기서는 그 필드들을 내용을 건드리면 안 되는 검은 상자로 다룬다.

그러나 |type| 필드가 |structured|이면 |value| 필드가 없고, 둘째 낱말은 |attrHead|와 |subscrHead|라는
두 포인터 필드로 나뉜다. 이 필드들은 앞으로 보겠지만 구조 정보를 담은 추가 노드들을 가리킨다.

@<정의@>=
func subscrHeadLoc(p pointer) pointer     { return p + 1 } // |value|, |subscrHead|, |attrHead|가 있는 곳
func attrHead(p pointer) pointer          { return info(subscrHeadLoc(p)) } // 속성 정보를 가리키는 포인터
func setAttrHead(p pointer, v pointer)    { setInfo(subscrHeadLoc(p), v) }
func subscrHead(p pointer) pointer        { return link(subscrHeadLoc(p)) } // 첨자 정보를 가리키는 포인터
func setSubscrHead(p pointer, v pointer)  { setLink(subscrHeadLoc(p), v) }

const @!valueNodeSize = 2 // 값 노드의 낱말 수

@ 속성 노드는 세 낱말이다. 그 가운데 두 낱말에는 앞에서 말한 |type|과 |value| 필드가 들어 있고,
셋째 낱말에는 추가 정보가 들어 있다. 이 속성의 이름을 짓는 토큰의 해시 주소를 담은 |attrLoc| 필드가
있고, 한 단계 위(곧 이 속성이 딸려 있는 수준)의 |structured| 형 값 노드를 가리키는 |parent| 필드도
있다. 속성 노드의 |nameType|은 `|attr|'이다. 그 |link| 필드는 부모가 같은 다음 속성을 가리킨다. 이것들은
늘어나는 순서로 놓여서 |attrLoc(link(p))>attrLoc(p)|이다. 마지막 속성 노드는 상수 |endAttr|로
연결되는데, 그 |attrLoc| 필드는 어떤 올바른 해시 주소보다도 크다. 부모의 |attrHead|는 |nameType|이
|structuredRoot|인 노드를 가리킨다. 이 노드는 널 속성, 곧 부모에 아무 속성도 붙지 않았을 때 관계되는
변수를 나타낸다. 이 |attrHead| 노드에는 부모가 구조화되지 않았다면 무엇이었을지에 따라 값 노드나 첨자
노드나 속성 노드의 필드들이 있다. 그러나 첨자와 속성 필드는 무시되므로 사실상 값 노드의 자료만 담는다.
이 특별한 노드의 |link| 필드는 |attrLoc| 필드가 0인 속성 노드를 가리킨다. 이 노드는 부모에 붙은
집합 첨자 `\.{[]}'를 나타내고, 그 |link| 필드는 특별하지 않은 첫 속성 노드(없으면 |endAttr|)를
가리킨다.

첨자 노드도 마찬가지로 세 낱말을 차지하며, |type|과 |value| 필드에 추가 정보가 더해진다. 그
|nameType|은 |subscr|이다. 이 경우 셋째 낱말은 |subscript| 필드라고 부르는데, |scaled| 정수다.
그 |link| 필드는 첨자가 그다음으로 큰 첨자 노드가 있으면 그것을 가리키고, 없으면 이 수준의 집합 첨자를
위한 속성 노드를 가리킨다. 이 속성 노드에 위로 가는 포인터가 있다는 것을 이미 보았으므로, 부모를
알아낼 수 있다.

부모가 없는 값 노드의 |nameType|은 |root|이고, 그 |link|는 이 값의 이름을 짓는 토큰의 해시 주소다.

@ 다시 말해 변수는 위계 구조를 이루는데, 그 안에는 실이 충분히 이리저리 지나가서 프로그램이 형제와
부모와 자식 사이를 쉽게 오갈 수 있다. 보기를 하나 들면 도움이 될 것이다. (다음 설명을 읽으면서
그림을 그려 보기를 권한다. 생각을 굳히는 데 도움이 될 것이다.) 사용자의 프로그램에서 `\.x'와
`\.{x.a}'와 `\.{x[]b}'와 `\.{x5}'와 `\.{x20b}'가 언급되었고, \.{x[]b}는 \KW{boolean} 형으로
선언되었다고 하자. \.x, \.a, \.b의 해시 주소를 |h(x)|, |h(a)|, |h(b)|라고 하자. 그러면
|eqType(h(x))=tagToken|이고 |equiv(h(x))=p|인데, 여기서 |p|는 |nameType(p)=root|이고 |link(p)=h(x)|인
두 낱말짜리 값 노드다. 또 |type(p)=structured|이고, |attrHead(p)=q|, |subscrHead(p)=r|인데, |q|는 값
노드를, |r|은 첨자 노드를 가리킨다. (아직 따라오고 있는가? 연필로 그림을 그려 보라.) 홀로 선 변수
`\.x'는 |type(q)|와 |value(q)|로 나타난다. 게다가 |nameType(q)=structuredRoot|이고 |link(q)=q1|인데,
|q1|은 `\.{x[]}'를 나타내는 속성 노드를 가리킨다. 그러므로 |nameType(q1)=attr|,
|attrLoc(q1)=collectiveSubscript=0|, |parent(q1)=p|, |type(q1)=structured|, |attrHead(q1)=qq|,
|subscrHead(q1)=qq1|이다. 노드 |qq|는 세 낱말짜리 ``값으로서의 속성'' 노드로서, |type(qq)=numericType|(\.{x5}가
수치라고 가정하자. 노드 |qq|는 속성이 더 붙지 않은 `\.{x[]}'를 나타내기 때문이다), |nameType(qq)=structuredRoot|,
|attrLoc(qq)=0|, |parent(qq)=p|, |link(qq)=qq1|이다. (이제 다음 부분에 주의를 기울이라.) 노드
|qq1|은 아직 한 번도 나타난 적이 없는 `\.{x[][]}'를 나타내는 속성 노드다. 그 |type| 필드는 |undefined|이고,
그 |value| 필드는 정해지지 않았다. |nameType(qq1)=attr|, |attrLoc(qq1)=collectiveSubscript|,
|parent(qq1)=q1|, |link(qq1)=qq2|다. 노드 |qq2|는 `\.{x[]b}'를 나타내므로 |type(qq2)=unknownBoolean|이다.
또 |attrLoc(qq2)=h(b)|, |parent(qq2)=q1|, |nameType(qq2)=attr|, |link(qq2)=endAttr|다.
(색깔 있는 선을 쓰면 그림을 푸는 데 도움이 될지도 모른다.) 노드 |r|은 `\.{x5}'를 나타내는 |type|과
|value|를 가진 첨자 노드다. 여기서 |nameType(r)=subscr|, |subscript(r)=5.0|이고, |link(r)=r1|은 또 하나의
첨자 노드다. 그림을 마무리하려면 |link(r1)|이 무엇인지 맞혀 보라. 포기하는가? 그것은~|q1|이다.
게다가 |subscript(r1)=20.0|, |nameType(r1)=subscr|, |type(r1)=structured|, |attrHead(r1)=qqq|,
|subscrHead(r1)=qqq1|이고, |r1|에 매달린 노드 |qqq|, |qqq1|, |qqq2| 셋으로 일을 마무리한다.
(어쩌면 더 큰 종이로 다시 시작해야 할지도 모른다.) 변수 `\.{x20b}'의 값은 짐작하겠지만
노드~|qqq2=link(qqq1)|에 나타난다. 마찬가지로 `\.{x.a}'의 값은 노드 |q2=link(q1)|에 나타나는데,
여기서 |attrLoc(q2)=h(a)|이고 |parent(q2)=p|다.

@ 크누스의 권유를 받아들여 그림을 그려 보면 다음과 같다. 실선 화살표는 |link|이고, 굵은 화살표는
|attrHead|, 가는 점선 화살표는 |subscrHead|다. 그림이 너무 어지러워지지 않도록 |parent| 포인터는
그리지 않았다. 집합 첨자의 노드 |q1|에서 출발하는 가로줄과 |r1|에서 출발하는 가로줄이 같은 꼴인 데
주목하라. 집합 첨자 `\.{x[]}' 아래의 구조는 실제 첨자 `\.{x20}' 아래의 구조의 본보기 노릇을 한다.
$$\mplibcode
beginfig(7);
save u, v, n, pn, z, nd; numeric u, v; u := 64pt; v := 34pt;
pair z[]; picture nd[]; string pn[];
z1 = (0,0);                                   % p
z2 = (0,-v);  z3 = (u,-v);  z4 = (3u,-v); z5 = (4u,-v);   % q, q1, q2, endAttr
z6 = (u,-2v); z7 = (2u,-2v); z8 = (3u,-2v);   % qq, qq1, qq2
z9 = (0,-3.2v); z10 = (u,-3.2v);              % r, r1
z11 = (u,-4.2v); z12 = (2u,-4.2v); z13 = (3u,-4.2v); % qqq, qqq1, qqq2
nd1 = boxed(btex \strut\.{x} etex, z1);
nd2 = boxed(btex \strut\.{x} etex, z2);
nd3 = boxed(btex \strut\.{x[]} etex, z3);
nd4 = boxed(btex \strut\.{x.a} etex, z4);
nd5 = boxed(btex \strut\ID{endAttr} etex, z5);
nd6 = boxed(btex \strut\.{x[]} etex, z6);
nd7 = boxed(btex \strut\.{x[][]} etex, z7);
nd8 = boxed(btex \strut\.{x[]b} etex, z8);
nd9 = boxed(btex \strut\.{x5} etex, z9);
nd10 = boxed(btex \strut\.{x20} etex, z10);
nd11 = boxed(btex \strut\.{x20} etex, z11);
nd12 = boxed(btex \strut\.{x20[]} etex, z12);
nd13 = boxed(btex \strut\.{x20b} etex, z13);
label.lft(btex $p$ etex, westof(nd1)); label.lft(btex $q$ etex, westof(nd2));
label.ulft(btex $q_1$ etex, ulcorner bbox nd3); label.top(btex $q_2$ etex, northof(nd4));
label.lft(btex $qq$ etex, westof(nd6)); label.top(btex $qq_1$ etex, northof(nd7));
label.top(btex $qq_2$ etex, northof(nd8));
label.lft(btex $r$ etex, westof(nd9)); label.urt(btex $r_1$ etex, urcorner bbox nd10);
label.lft(btex $qqq$ etex, westof(nd11)); label.top(btex $qqq_1$ etex, northof(nd12));
label.top(btex $qqq_2$ etex, northof(nd13));
% link
drawarrow eastof(nd2)--westof(nd3);
drawarrow eastof(nd3)--westof(nd4);
drawarrow eastof(nd4)--westof(nd5);
drawarrow eastof(nd6)--westof(nd7);
drawarrow eastof(nd7)--westof(nd8);
drawarrow eastof(nd8){right}..{up}southof(nd5);
drawarrow eastof(nd9)--westof(nd10);
drawarrow eastof(nd11)--westof(nd12);
drawarrow eastof(nd12)--westof(nd13);
drawarrow eastof(nd13){right}..(4u,-3v)..{up}(southof(nd5)+(4pt,0));
% r1 -> q1
drawarrow (northof(nd10)+(10pt,0)){up}..{up}(southof(nd3)+(10pt,0));
% attrHead
drawarrow southof(nd1)--northof(nd2) withpen pencircle scaled 1.2pt;
drawarrow southof(nd3)--northof(nd6) withpen pencircle scaled 1.2pt;
drawarrow southof(nd10)--northof(nd11) withpen pencircle scaled 1.2pt;
% subscrHead
drawarrow westof(nd1){left}..{down}(-.5u,-2v)..{right}westof(nd9) dashed withdots scaled .6;
drawarrow (southof(nd3)+(-10pt,0)){down}..{right}westof(nd7) dashed withdots scaled .6;
drawarrow (southof(nd10)+(-10pt,0)){down}..(1.3u,-4.7v)..{up}southof(nd12) dashed withdots scaled .6;
endfig;
\endmplibcode$$

앞 문단의 보기로도 일이 환히 보이지 않는다면, 아래의 더 간단한 서브루틴 몇 개를 보면 실제로
일이 어떻게 돌아가는지 드러날 것이다.

이 관례에서 정말로 별난 것은 집합 첨자 속성을 쓴다는 것뿐이다. 그 생각은 배열의 많은 원소가 똑같은
매크로이거나(그러면 따로따로 값을 저장할 필요가 없다) 가능한 속성을 다 갖추지 않았을 때 형 정보를
되풀이하지 않으려는 것이다. 집합 첨자 속성 아래의 구조의 가지들은 매크로 식별자를 빼고는 실제 값을
담지 않는다. 첨자 노드 아래의 구조의 가지들은 그 집합 첨자 속성에 의미 있는 정보를 담지 않는다.

@<정의@>=
func attrLocLoc(p pointer) pointer       { return p + 2 } // |attrLoc|과 |parent| 필드가 있는 곳
func attrLoc(p pointer) halfword         { return info(attrLocLoc(p)) } // 이 속성의 해시 주소
func setAttrLoc(p pointer, v halfword)   { setInfo(attrLocLoc(p), v) }
func parent(p pointer) pointer           { return link(attrLocLoc(p)) } // |structured| 변수를 가리키는 포인터
func setParent(p pointer, v pointer)     { setLink(attrLocLoc(p), v) }
func subscriptLoc(p pointer) pointer     { return p + 2 } // |subscript| 필드가 사는 곳
func subscript(p pointer) scaled         { return mem[subscriptLoc(p)].sc } // 이 변수의 첨자
func setSubscript(p pointer, v scaled)   { mem[subscriptLoc(p)].sc = v }

const (
	@!attrNodeSize = 3 // 속성 노드의 낱말 수
	@!subscrNodeSize = 3 // 첨자 노드의 낱말 수
	@!collectiveSubscript = 0 // 속성 `\.{[]}'의 코드
)

@ @<표의 항목들을...@>=
setAttrLoc(endAttr, hashEnd+1)
setParent(endAttr, null)

@ \KW{pair} 형의 변수는 그 값이 수치 값 둘을 담은 네 낱말짜리 노드를 가리킨다. 첫 값은
|nameType=xPartSector|이고 둘째 값은 |nameType=yPartSector|다. 첫 값의 |link|는 |value|가 이 네
낱말짜리 노드를 가리키는 노드를 거꾸로 가리킨다.

\KW{transform} 형의 변수도 비슷하지만, 이 경우에는 |value|가 값 여섯 개를 담은 열두 낱말짜리 노드를
가리키고, 그 값들은 |xPartSector|, |yPartSector|, |xxPartSector|, |xyPartSector|, |yxPartSector|,
|yyPartSector|로 알아본다.

구조화된 변수 전체를 저장할 때는 |root| 표시를 잠시 |savedRoot|로 바꾼다.

어떤 변수들에는 이름이 없다. 식을 계산하는 동안 임시로 저장하는 데만 쓰인다. 그런 것들을
{\sl 캡슐}이라고 부른다.

@<정의@>=
func xPartLoc(p pointer) pointer  { return p }      // 쌍이나 변환 노드에서 \KW{xpart}가 있는 곳
func yPartLoc(p pointer) pointer  { return p + 2 }  // 쌍이나 변환 노드에서 \KW{ypart}가 있는 곳
func xxPartLoc(p pointer) pointer { return p + 4 }  // 변환 노드에서 \KW{xxpart}가 있는 곳
func xyPartLoc(p pointer) pointer { return p + 6 }  // 변환 노드에서 \KW{xypart}가 있는 곳
func yxPartLoc(p pointer) pointer { return p + 8 }  // 변환 노드에서 \KW{yxpart}가 있는 곳
func yyPartLoc(p pointer) pointer { return p + 10 } // 변환 노드에서 \KW{yypart}가 있는 곳

const (
	@!pairNodeSize = 4 // 쌍 노드의 낱말 수
	@!transformNodeSize = 12 // 변환 노드의 낱말 수
)

@ @<전역 변수@>=
var @!bigNodeSize [pairType + 1]smallNumber // 첨자는 |transformType .. pairType|

@ 배열 |bigNodeSize|에는 \MF가 이따금 알아야 하는 상수 두 개가 들어 있을 뿐이다.

@<핵심 변수들의...@>=
bigNodeSize[transformType] = transformNodeSize
bigNodeSize[pairType] = pairNodeSize

@ 노드 |p|가 |type(p)=pairType|이나 |transformType|이고 |value(p)=null|이면, 프로시저 호출 |initBigNode(p)|는
|p|를 위한 쌍이나 변환 노드를 할당한다. 그런 노드의 낱낱의 부분은 처음에 형이 |independent|다.

@<함수들@>=
func initBigNode(p pointer) {
	var q pointer // 새 노드
	var s smallNumber // 그 크기
	s = bigNodeSize[typ(p)]
	q = getNode(s)
	for {
		s = s - 2
		@<변수 |q+s|를 새로 독립 변수로 만든다@>
		setNameType(q+s, half(s)+xPartSector)
		setLink(q+s, null)
		if s == 0 {
			break
		}
	}
	setLink(q, p)
	setValue(p, q)
}

@ 함수 |idTransform|은 항등 변환을 위한 캡슐을 만든다.

@<함수들@>=
func idTransform() pointer {
	var p, q, r pointer // 목록 조작 레지스터들
	p = getNode(valueNodeSize)
	setType(p, transformType)
	setNameType(p, capsule)
	setValue(p, null)
	initBigNode(p)
	q = value(p)
	r = q + transformNodeSize
	for {
		r = r - 2
		setType(r, known)
		setValue(r, 0)
		if r == q {
			break
		}
	}
	setValue(xxPartLoc(q), unity)
	setValue(yyPartLoc(q), unity)
	return p
}

@ 토큰은 처음 나타날 때 형이 |tagToken|이지만, 변수의 뿌리로 처음 쓰이기 전까지는 |null|을 가리킨다.
다음 서브루틴은 그런 큰 경사가 있을 때 뿌리 노드를 세운다.

@<함수들@>=
func newRoot(x pointer) {
	var p pointer // 새 노드
	p = getNode(valueNodeSize)
	setType(p, undefined)
	setNameType(p, root)
	setLink(p, x)
	setEquiv(x, p)
}

@ 변수를 나타내는 이 관례들은 루틴 |printVariableName|이 잘 보여 준다. 이 루틴은 변수의 두 낱말짜리
값 꾸러미를 가리키는 포인터만 받아서 그 변수의 온전한 이름을 보인다.

@<함수들@>=
func printVariableName(p pointer) {
	var q pointer // 변수의 첨자 부분의 이름을 지을 토큰 목록
	var r pointer // 토큰 목록을 만들 때 쓰는 임시 변수
	for nameType(p) >= xPartSector {
		@<출력 앞에 부분 지정자를 붙인다; 캡슐이면 |return|한다@>
	}
	q = null
	for nameType(p) > savedRoot {
		@<한 단계 올라가며 목록 |q|에 토큰을 쌓고 |p|를 그 부모로 바꾼다@>
	}
	r = getAvail()
	setInfo(r, link(p))
	setLink(r, q)
	if nameType(p) == savedRoot {
		printStr("(SAVED)")
	}
@.SAVED@>
	showTokenList(r, null, elGordo, tally)
	flushTokenList(r)
}

@ @<한 단계 올라가며...@>=
if nameType(p) == subscr {
	r = newNumTok(subscript(p))
	for {
		p = link(p)
		if nameType(p) == attr {
			break
		}
	}
} else if nameType(p) == structuredRoot {
	p = link(p)
	goto found
} else {
	if nameType(p) != attr {
		confusion("var")
	}
@:this can't happen var}{\quad var@>
	r = getAvail()
	setInfo(r, attrLoc(p))
}
setLink(r, q)
q = r
found:
p = parent(p)

@ @<출력 앞에 부분 지정자를...@>=
switch nameType(p) {
case xPartSector:
	printChar('x')
case yPartSector:
	printChar('y')
case xxPartSector:
	printStr("xx")
case xyPartSector:
	printStr("xy")
case yxPartSector:
	printStr("yx")
case yyPartSector:
	printStr("yy")
case capsule:
	printStr("%CAPSULE")
	printInt(p - null)
	return
@.CAPSULE@>
} // 다른 경우는 없다
printStr("part ")
p = link(p - 2*(nameType(p)-xPartSector))

@ 함수 |interesting|은 주어진 변수가 캡슐 안에 있지 않거나, 사용자가 캡슐을 추적하고 싶어 하면
|true|를 돌려준다.

@<함수들@>=
func interesting(p pointer) bool {
	var t smallNumber // |nameType|
	if internal[tracingCapsules] > 0 {
		return true
	}
	t = nameType(p)
	if t >= xPartSector {
		if t != capsule {
			t = nameType(link(p - 2*(t-xPartSector)))
		}
	}
	return t != capsule
}

@ 이제 구조화되지 않은 형을 그와 같은 구조화된 형으로 바꾸는 서브루틴이다. 자랄 수 있는
|structured| 노드를 끼워 넣어서 그렇게 한다. 이 연산은 |nameType(p)|가 |root|나 |subscr|나 |attr|일
때만 한다.

이 프로시저는 구조에서 노드~|p|의 자리를 차지한 새 노드를 가리키는 포인터를 돌려준다. 노드~|p|
자신은 움직이지 않고, 그 |value|나 |type| 필드도 전혀 바뀌지 않는다.

@<함수들@>=
func newStructure(p pointer) pointer {
	var q, r pointer // 목록 조작 레지스터들
	switch nameType(p) {
	case root:
		q = link(p)
		r = getNode(valueNodeSize)
		setEquiv(q, r)
	case subscr:
		@<노드 |p| 자리에 새 첨자 노드 |r|를 잇는다@>
	case attr:
		@<노드 |p| 자리에 새 속성 노드 |r|를 잇는다@>
	default:
		confusion("struct")
@:this can't happen struct}{\quad struct@>
	}
	setLink(r, link(p))
	setType(r, structured)
	setNameType(r, nameType(p))
	setAttrHead(r, p)
	setNameType(p, structuredRoot)
	q = getNode(attrNodeSize)
	setLink(p, q)
	setSubscrHead(r, q)
	setParent(q, r)
	setType(q, undefined)
	setNameType(q, attr)
	setLink(q, endAttr)
	setAttrLoc(q, collectiveSubscript)
	return r
}

@ @<노드 |p| 자리에 새 첨자...@>=
q = p
for {
	q = link(q)
	if nameType(q) == attr {
		break
	}
}
q = parent(q)
r = subscrHeadLoc(q) // |link(r)=subscrHead(q)|
for {
	q = r
	r = link(r)
	if r == p {
		break
	}
}
r = getNode(subscrNodeSize)
setLink(q, r)
setSubscript(r, subscript(p))

@ 속성이 |collectiveSubscript|이면 노드~|p|를 가리키는 포인터가 둘이므로 둘 다 바꾸어야 한다.

@<노드 |p| 자리에 새 속성...@>=
q = parent(p)
r = attrHead(q)
for {
	q = r
	r = link(r)
	if r == p {
		break
	}
}
r = getNode(attrNodeSize)
setLink(q, r)
mem[attrLocLoc(r)] = mem[attrLocLoc(p)] // |attrLoc|과 |parent|를 베낀다
if attrLoc(p) == collectiveSubscript {
	q = subscrHeadLoc(parent(p))
	for link(q) != p {
		q = link(q)
	}
	setLink(q, r)
}

@ 루틴 |findVariable|은 비어 있지 않은 첨자 토큰 목록을 가리키는 포인터~|t|를 받아서, 그에 해당하는
두 낱말짜리 값을 가리키는 포인터를 돌려준다. 이를테면 |t|가 토큰 \.x와 그 뒤에 값~7을 담은 수치
토큰을 가리키면, |findVariable|은 \.{x7}의 값이 메모리의 어디에 저장되어 있는지 찾는다. 이것은
간단한 일처럼 보일 수도 있고, 대개는 그렇다. 다만 \.{x7}이 전에 한 번도 참조된 적이 없을 때는
그렇지 않다. 실제로 \.x는 전에 첨자가 붙은 적도 없을지 모른다. 집합 첨자 정보를 고치는 데서
복잡한 일이 생긴다.

경로~|t|의 어디에서든 매크로 형이 발견되거나 |t|의 첫 항목이 |tagToken|이 아니면 값 |null|을
돌려준다. 그렇지 않으면 |p|는 |undefined<type(p)<structured|인 노드를 가리키는 널이 아닌 포인터가
된다.

@<함수들@>=
func findVariable(t pointer) pointer {
	var p, q, r, s pointer // ``값'' 줄의 노드들
	var pp, qq, rr, ss pointer // ``집합'' 줄의 노드들
	var n int32 // 첨자나 속성
	var saveWord memoryWord // |mem|의 한 낱말을 위한 임시 저장소
@^inner loop@>
	p = info(t)
	t = link(t)
	if eqType(p)%outerTag != tagToken {
		return null
	}
	if equiv(p) == null {
		newRoot(p)
	}
	p = equiv(p)
	pp = p
	for t != null {
		@<노드 |p|와 |pp|가 둘 다 |structured| 형이 되게 한다@>
		if t < hiMemMin {
			@<첨자 |value(t)|를 따라 한 단계 내려간다@>
		} else {
			@<속성 |info(t)|를 따라 한 단계 내려간다@>
		}
		t = link(t)
	}
	@<찾은 노드 |p|의 형을 집합 줄의 |pp|에 맞추고 |p|를 돌려준다; 매크로를 만나면 |null|을 돌려준다@>
}

@ 경로를 다 따라 내려가면, 구조화된 노드에서는 그 |attrHead|가 실제 값이다. 아직 형이 정해지지 않은 변수는 집합
줄에서 선언된 형을 물려받고, 그것도 정해지지 않았으면 수치가 된다.

@<찾은 노드 |p|의 형을 집합 줄의 |pp|에 맞추고 |p|를 돌려준다; 매크로를 만나면 |null|을 돌려준다@>=
if typ(pp) >= structured {
	if typ(pp) == structured {
		pp = attrHead(pp)
	} else {
		return null
	}
}
if typ(p) == structured {
	p = attrHead(p)
}
if typ(p) == undefined {
	if typ(pp) == undefined {
		setType(pp, numericType)
		setValue(pp, null)
	}
	setType(p, typ(pp))
	setValue(p, null)
}
return p

@ 두 포인터 |pp|와 |p|는 함께 시작하지만 첨자가 나오면 갈라진다. 그때 |pp|는~집합 줄에 머무르고 |p|는~실제 첨자
값들을 지나간다.

@<노드 |p|와 |pp|가 둘 다...@>=
if typ(pp) != structured {
	if typ(pp) > structured {
		return null
	}
	ss = newStructure(pp)
	if p == pp {
		p = ss
	}
	pp = ss
} // 이제 |type(pp)=structured|다
if typ(p) != structured { // 그것은 |>structured|일 수 없다
	p = newStructure(p) // 이제 |type(p)=structured|다
}

@ 같은 수준에 첨자가 아주 많을 경우에 대비해서 프로그램의 이 부분은 꽤 빨라야 한다. 그래서 첨자
@^inner loop@>
목록의 끝에 나타나는 낱말에, 그 낱말이 첨자 노드의 일부가 아닌데도 ``무한한'' 값을 넣어 둔다. 이것은
찾기 루프에서 목록의 끝을 따로 검사하지 않으려고 쓰는 보초(sentinel) 기법이다. 첨자 목록의 마지막
노드는 집합 첨자의 속성 노드를 가리키는데, 그 속성 노드에서 |subscript| 필드 자리에 해당하는 낱말은
실은 |attrLoc|과 |parent|를 담은 낱말이다. 그 낱말을 잠시 |elGordo|로 덮어 두었다가 되돌려 놓는다.

@<첨자 |value(t)|를 따라...@>=
n = value(t)
pp = link(attrHead(pp)) // 이제 |attrLoc(pp)=collectiveSubscript|다
q = link(attrHead(p))
saveWord = mem[subscriptLoc(q)]
setSubscript(q, elGordo)
s = subscrHeadLoc(p) // |link(s)=subscrHead(p)|
for {
	r = s
	s = link(s)
	if n <= subscript(s) {
		break
	}
}
if n == subscript(s) {
	p = s
} else {
	p = getNode(subscrNodeSize)
	setLink(r, p)
	setLink(p, s)
	setSubscript(p, n)
	setNameType(p, subscr)
	setType(p, undefined)
}
mem[subscriptLoc(q)] = saveWord

@ @<속성 |info(t)|를 따라...@>=
n = info(t)
ss = attrHead(pp)
for {
	rr = ss
	ss = link(ss)
	if n <= attrLoc(ss) {
		break
	}
}
if n < attrLoc(ss) {
	qq = getNode(attrNodeSize)
	setLink(rr, qq)
	setLink(qq, ss)
	setAttrLoc(qq, n)
	setNameType(qq, attr)
	setType(qq, undefined)
	setParent(qq, pp)
	ss = qq
}
if p == pp {
	p = ss
	pp = ss
} else {
	@<값 줄에서 속성 |n|을 찾거나 새로 만들어 |p|로 놓는다@>
}

@ 두 포인터 |p|와 |pp|가 이미 갈라졌으면 값 줄에서도 같은 속성을 찾는다. 속성 목록은 |attrLoc|이 늘어나는 순서로 놓여 있고
|endAttr|가 보초 노릇을 하므로, 찾기 루프는 목록의 끝을 따로 검사하지 않는다.

@<값 줄에서 속성 |n|을 찾거나 새로 만들어 |p|로 놓는다@>=
pp = ss
s = attrHead(p)
for {
	r = s
	s = link(s)
	if n <= attrLoc(s) {
		break
	}
}
if n == attrLoc(s) {
	p = s
} else {
	q = getNode(attrNodeSize)
	setLink(r, q)
	setLink(q, s)
	setAttrLoc(q, n)
	setNameType(q, attr)
	setType(q, undefined)
	setParent(q, p)
	p = q
}

@ 변수는 형 선언에 나타나거나, 매크로로 정의되거나, 다른 것과 같다고 \KW{let}될 때 이전 값을 잃는다.
어떤 특정한 |type|이나 |value|에 딸린 저장소를 재활용하는 서브루틴은 나중에 정의할 것이다. 지금의
목표는 변수 구조의 일부를 골라서 해제하는 |flushVariable|이라는 더 높은 수준의 과정을 공부하는 것이다.

이 루틴은 `\hbox{\tt numeric x[]a[]b}' 같은 보기 때문에 조금 복잡하다. 이것은 \.{x[i]a[j]b} 꼴의
변수를 모두(그리고 그것들만) 재활용하는 반면, `\hbox{\tt vardef x[]a[]=...}'는 집합 노드 \.{x[]a[]}
자신을 빼고 \.{x[i]a[j]} 뒤에 임의의 첨자가 붙은 꼴의 변수를 모두 버린다. 그런 보기를 다루는 뻔한
방법은 재귀를 쓰는 것이다. 그래서 우리는 그렇게 한다.
@^recursion@>

매개변수 |p|는 변수의 뿌리 정보를 가리키고, 매개변수 |t|는 첨자들을 나타내는 한 낱말짜리 노드들의
목록을 가리킨다. 첨자는 |info=collectiveSubscript|로 나타낸다.

@<함수들@>=
func flushVariable(p, t pointer, discardSuffixes bool) {
	var q, r pointer // 목록 조작
	var n halfword // 맞추어 볼 속성
	for t != null {
		if typ(p) != structured {
			return
		}
		n = info(t)
		t = link(t)
		if n == collectiveSubscript {
			@<모든 실제 첨자에 대해 나머지 접미사를 재귀적으로 치운다@>
		}
		p = attrHead(p)
		for {
			r = p
			p = link(p)
			if attrLoc(p) >= n {
				break
			}
		}
		if attrLoc(p) != n {
			return
		}
	}
	if discardSuffixes {
		flushBelowVariable(p)
	} else {
		if typ(p) == structured {
			p = attrHead(p)
		}
		recycleValue(p)
	}
}

@ 집합 첨자 `\.{[]}'는 모든 첨자를 대표하므로, 실제 첨자 노드마다 나머지 첨자 목록~|t|로 재귀한다. 목록의 끝에
이르렀으면 구조화되지 않은 첨자 노드는 아예 없앤다.

@<모든 실제 첨자에 대해 나머지 접미사를 재귀적으로 치운다@>=
r = subscrHeadLoc(p)
q = link(r) // |q=subscrHead(p)|
for nameType(q) == subscr {
	flushVariable(q, t, discardSuffixes)
	if t == null {
		if typ(q) == structured {
			r = q
		} else {
			setLink(r, link(q))
			freeNode(q, subscrNodeSize)
		}
	} else {
		r = q
	}
	q = link(r)
}

@ 다음 프로시저는 더 간단하다. 이것은 |p| 자신을 빼고 모든 것을 지워 버리고, |p|는 정의되지 않은
상태가 된다.

@<함수들@>=
func flushBelowVariable(p pointer) {
	var q, r pointer // 목록 조작 레지스터들
	if typ(p) != structured {
		recycleValue(p) // 이것이 |type(p)=undefined|로 놓는다
	} else {
		q = subscrHead(p)
		for nameType(q) == subscr {
			flushBelowVariable(q)
			r = q
			q = link(q)
			freeNode(r, subscrNodeSize)
		}
		r = attrHead(p)
		q = link(r)
		recycleValue(r)
		if nameType(p) <= savedRoot {
			freeNode(r, valueNodeSize)
		} else {
			freeNode(r, subscrNodeSize) // |subscrNodeSize=attrNodeSize|라고 가정한다
		}
		for {
			flushBelowVariable(q)
			r = q
			q = link(q)
			freeNode(r, attrNodeSize)
			if q == endAttr {
				break
			}
		}
		setType(p, undefined)
	}
}

@ 변수에 새 값을 대입하기 바로 전에 이전 값을 재활용하고 정의되지 않은 상태로 만든다.
루틴 |undType|은 재활용하기 전의 현재 형을 바탕으로, 어떤 형의 정의되지 않은 값을 주어야 할지
정한다.

@<함수들@>=
func undType(p pointer) smallNumber {
	switch typ(p) {
	case undefined, vacuous:
		return undefined
	case booleanType, unknownBoolean:
		return unknownBoolean
	case stringType, unknownString:
		return unknownString
	case penType, unknownPen, futurePen:
		return unknownPen
	case pathType, unknownPath:
		return unknownPath
	case pictureType, unknownPicture:
		return unknownPicture
	case transformType, pairType, numericType:
		return typ(p)
	case known, dependent, protoDependent, independent:
		return numericType
	} // 다른 경우는 없다
	panic("undType")
}

@ 루틴 |clearSymbol|은 기호 토큰의 등가물을 다시 정의하고 싶을 때 쓴다. 그 기호에 지금 붙어 있는
변수 구조나 매크로 정의를 모두 없애야 한다. 매개변수 |saving|이 참이면 딸린 구조를 없애는 대신
저장해 둔다.

@<함수들@>=
func clearSymbol(p pointer, saving bool) {
	var q pointer // |equiv(p)|
	q = equiv(p)
	switch eqType(p) % outerTag {
	case definedMacro, secondaryPrimaryMacro, tertiarySecondaryMacro, expressionTertiaryMacro:
		if !saving {
			deleteMacRef(q)
		}
	case tagToken:
		if q != null {
			if saving {
				setNameType(q, savedRoot)
			} else {
				flushBelowVariable(q)
				freeNode(q, valueNodeSize)
			}
		}
	default:
		// 아무것도 하지 않는다
	}
	eqtb[p] = eqtb[frozenUndefined]
}

@* 등가물 저장과 복원.
\KW{begingroup}과 \KW{endgroup}이 주는 둥지 구조 덕분에 |eqtb| 항목들을 저장했다가 되돌릴 수 있으므로,
어려움 없이 임시로 바꿀 수 있다. 사용자가 현재 값을 저장하라고 하면 \MF는 그 값을 ``저장 스택''에
넣는다. 나중에 \KW{endgroup}이 나타나면 옛 값들을 저장 스택에서 꺼내 원래 자리에 되돌려 놓는다.

저장 스택은 세 종류의 항목을 담은 연결 목록이고, 항목의 종류는 |info| 필드로 구별한다. 포인터 |p|가 저장된
항목을 가리키면

\smallskip\hang
항목이 |info(p)=0|이면 그룹 경계를 나타낸다. \KW{begingroup}마다 그런 항목 하나를 저장 스택에 보태고,
\KW{endgroup}마다 가장 최근의 그런 항목이 없어질 때까지 스택을 잘라 낸다.

\smallskip\hang
항목이 |info(p)=q|이고 |1<=q<=hashEnd|이면 |mem[p+1]|에 |eqtb[q]|의 이전 내용이 들어 있다는 뜻이다. 그런
저장 스택 항목은 \KW{save} 명령이 만든다.

\smallskip\hang
항목이 |info(p)=hashEnd+q|이고 |q>0|이면 |value(p)|는 |q|번 내부 매개변수에 되돌려 놓을 |scaled| 정수다.
그런 항목은 \KW{interim} 명령이 만든다.

\smallskip\noindent
전역 변수 |savePtr|는 저장 스택의 맨 위 항목을 가리킨다.

@<정의@>=
const @!saveNodeSize = 2 // 경계가 아닌 저장 스택 노드의 낱말 수

func savedEquiv(p pointer) twoHalves        { return mem[p+1].hh } // |eqtb| 항목이 저장되는 곳
func setSavedEquiv(p pointer, v twoHalves)  { mem[p+1].hh = v }

func saveBoundaryItem() (p pointer) { // 그룹 경계 항목을 쌓는다
	p = getAvail()
	setInfo(p, 0)
	setLink(p, savePtr)
	savePtr = p
	return
}

@ @<전역 변수@>=
var @!savePtr pointer // 가장 최근에 저장한 항목

@ @<핵심 변수들의...@>=
savePtr = null

@ 루틴 |saveVariable|은 해시 주소 |q|를 받아서, 이 주소를 그 현재 등가물과 함께 저장 스택에
챙겨 두고, 토큰~|q|가 마치 갓 태어난 것처럼 행동하게 만든다.

그러나 |savePtr=null|이면 아무것도 쌓지 않는다. 프로그램이 그룹 안에 있지 않을 때는 스택에서
무엇을 꺼낼 방법이 없으므로 공간을 낭비할 까닭이 없다.

@<함수들@>=
func saveVariable(q pointer) {
	var p pointer // 임시 레지스터
	if savePtr != null {
		p = getNode(saveNodeSize)
		setInfo(p, q)
		setLink(p, savePtr)
		setSavedEquiv(p, eqtb[q])
		savePtr = p
	}
	clearSymbol(q, savePtr != null)
}

@ 비슷하게, |saveInternal|은 |tracingPens| 같은 내부 양의 위치 |q|를 받는다. 이것은 셋째 종류의 저장
스택 항목을 만든다.

@<함수들@>=
func saveInternal(q halfword) {
	var p pointer // 저장 스택의 새 항목
	if savePtr != null {
		p = getNode(saveNodeSize)
		setInfo(p, hashEnd+q)
		setLink(p, savePtr)
		setValue(p, internal[q])
		savePtr = p
	}
}

@ 그룹이 끝나면 루틴 |unsave|가 저장된 등가물들을 모두 거꾸로 되돌린다. 이 루틴은 저장 스택에 경계
항목이 적어도 하나 있을 때에만 불린다.

@<함수들@>=
func unsave() {
	var q pointer // 저장된 항목의 첨자
	var p pointer // 임시 레지스터
	for info(savePtr) != 0 {
		q = info(savePtr)
		if q > hashEnd {
			if internal[tracingRestores] > 0 {
				beginDiagnostic()
				printNl("{restoring ")
				slowPrint(intName[q-(hashEnd)])
				printChar('=')
				printScaled(value(savePtr))
				printChar('}')
				endDiagnostic(false)
			}
			internal[q-(hashEnd)] = value(savePtr)
		} else {
			if internal[tracingRestores] > 0 {
				beginDiagnostic()
				printNl("{restoring ")
				slowPrint(text(q))
				printChar('}')
				endDiagnostic(false)
			}
			clearSymbol(q, false)
			eqtb[q] = savedEquiv(savePtr)
			if eqType(q)%outerTag == tagToken {
				p = equiv(q)
				if p != null {
					setNameType(p, root)
				}
			}
		}
		p = link(savePtr)
		freeNode(savePtr, saveNodeSize)
		savePtr = p
	}
	p = link(savePtr)
	freeAvail(savePtr)
	savePtr = p
}

@* 경로의 자료 구조.
\MF\ 사용자가 경로를 지정하면 \MF는 그에 딸린 삼차 스플라인 곡선을 위한 매듭과 조절점의 목록을
만든다. 매듭이 $z_0$, $z_1$, \dots, $z_n$이면 조절점 $z_k^+$와 $z_{k+1}^-$가 있어서, 매듭 $z_k$와
$z_{k+1}$ 사이의 삼차 스플라인은 베지에의 공식
@:Bezier}{B\'ezier, Pierre Etienne@>
$$\eqalign{z(t)&=B(z_k,z_k^+,z_{k+1}^-,z_{k+1};t)\cr
&=(1-t)^3z_k+3(1-t)^2tz_k^++3(1-t)t^2z_{k+1}^-+t^3z_{k+1}\cr}$$
으로 정의된다. 여기서 |0<=t<=1|이다.

이 곡선은 $z_k$에서 $z_k^+$ 쪽을 향해 출발해서 $z_{k+1}^-$ 쪽에서 $z_{k+1}$로 들어온다. 곡선은
언제나 네 점이 이루는 볼록 껍질 안에 있고, 조절점 자체는 대개 곡선 위에 있지 않다. 아래 그림은
매듭 둘과 그 사이의 조절점 둘을 보인다. 회색 선은 ``조절 다각형''이다.
$$\mplibcode
beginfig(8);
save u, a, b, c, d; numeric u; pair a, b, c, d; u := 30pt;
a := (0,0); b := (1.5u, 2.5u); c := (5u, 2.8u); d := (6u, .5u);
draw a--b--c--d withcolor .7white;
draw a..controls b and c..d withpen pencircle scaled 1pt;
dot(a); dot(d); odot(b); odot(c);
label.bot(btex $z_k$ etex, a); label.bot(btex $z_{k+1}$ etex, d);
label.ulft(btex $z_k^+$ etex, b); label.urt(btex $z_{k+1}^-$ etex, c);
endfig;
\endmplibcode$$

매듭 $z_k$마다 일곱 낱말짜리 노드가 하나 있다. 그 노드에는 제어 정보 한 낱말과, $z_k^-$와 $z_k$와
$z_k^+$의 |x|와 |y| 좌표를 위한 여섯 낱말이 들어 있다. 제어 정보는 |leftType|과 |rightType| 필드에
나타나는데, 저마다 노드의 첫 낱말의 4분의 1을 차지한다. 이것들은 곡선이 매듭에 들어올 때와 매듭을
떠날 때의 성질을 지정한다. 다음 매듭을 가리키는 하프워드 |link| 필드도 있다.

경로가 닫힌 윤곽이면 매듭 0과 |n|은 같은 것이다. 곧 매듭 |n-1|의 |link|가 매듭~0을 가리킨다. 그러나
경로가 닫혀 있지 않으면 매듭~0의 |leftType|과 매듭~|n|의 |rightType|이 |endpoint|다. 이 경우에는
매듭~|n|의 |link|가 매듭~0을 가리키고, 조절점 $z_0^-$와 $z_n^+$는 쓰이지 않는다.

@<정의@>=
func leftType(p pointer) quarterword         { return mem[p].hh.b0 } // 이 매듭으로 들어오는 경로의 성질
func setLeftType(p pointer, v quarterword)   { mem[p].hh.b0 = v }
func rightType(p pointer) quarterword        { return mem[p].hh.b1 } // 이 매듭을 떠나는 경로의 성질
func setRightType(p pointer, v quarterword)  { mem[p].hh.b1 = v }

const @!endpoint = 0 // 경로 처음의 |leftType|과 경로 끝의 |rightType|

func xCoord(p pointer) scaled       { return mem[p+1].sc } // 이 매듭의 |x| 좌표
func setXCoord(p pointer, v scaled) { mem[p+1].sc = v }
func yCoord(p pointer) scaled       { return mem[p+2].sc } // 이 매듭의 |y| 좌표
func setYCoord(p pointer, v scaled) { mem[p+2].sc = v }
func leftX(p pointer) scaled        { return mem[p+3].sc } // 앞 조절점의 |x| 좌표
func setLeftX(p pointer, v scaled)  { mem[p+3].sc = v }
func leftY(p pointer) scaled        { return mem[p+4].sc } // 앞 조절점의 |y| 좌표
func setLeftY(p pointer, v scaled)  { mem[p+4].sc = v }
func rightX(p pointer) scaled       { return mem[p+5].sc } // 다음 조절점의 |x| 좌표
func setRightX(p pointer, v scaled) { mem[p+5].sc = v }
func rightY(p pointer) scaled       { return mem[p+6].sc } // 다음 조절점의 |y| 좌표
func setRightY(p pointer, v scaled) { mem[p+6].sc = v }

const @!knotNodeSize = 7 // 매듭 노드의 낱말 수

@ 베지에 조절점을 계산하기 전에는, 그것들이 결국 차지할 메모리 공간에 그것들을 계산하는 데 쓸 수 있는
정보가 들어 있다. 네 가지 경우가 있다.

\yskip
\textindent{$\bullet$} 형이 |rightType=open|이면 곡선은 매듭에 들어온 것과 같은 방향으로 떠나야 한다.
\MF가 알맞은 방향을 알아낼 것이다.

\yskip
\textindent{$\bullet$} 형이 |rightType=curl|이면 곡선은 다음 매듭에 들어가는 각과 |rightCurl|에 저장된 휨
매개변수에 따라 정해지는 방향으로 매듭을 떠나야 한다.

\yskip
\textindent{$\bullet$} 형이 |rightType=given|이면 곡선은 |rightGiven|에 |angle|로 저장된 0이 아닌 방향으로
매듭을 떠나야 한다.

\yskip
\textindent{$\bullet$} 형이 |rightType=explicit|이면 이 매듭을 떠나는 베지에 조절점이 이미 계산되었다. 그것은
|rightX|와 |rightY| 필드에 있다.

\yskip\noindent
형 |leftType|의 규칙도 비슷하지만, 이것은 매듭에 들어오는 곡선을 가리키고, \\{right} 필드 대신
\\{left} 필드를 가리킨다.

형이 |explicit|이 아닌 조절점은 |leftTension|과 |rightTension| 필드의 ``긴장'' 매개변수를 바탕으로 고른다.
`\KW{atleast}' 선택 사항은 음의 긴장 값으로 나타낸다.
@:at_least_}{\KW{atleast} primitive@>

이를테면 \MF\ 경로 명세
$$\.{z0..z1..tension atleast 1..\{curl 2\}z2..z3\{-1,-2\}..tension
  3 and 4..p}$$
는 다음 여섯 매듭으로 나타난다. 여기서 \.p는 경로 `\.{z4..controls z45 and z54..z5}'다.
\def\lodash{\hbox to 1.1em{\thinspace\hrulefill\thinspace}}
$$\vbox{\halign{#\hfil&&\qquad#\hfil\cr
|leftType|&\\{left} 정보&|xCoord,yCoord|&|rightType|&\\{right} 정보\cr
\noalign{\yskip}
|endpoint|&\lodash$,\,$\lodash&$x_0,y_0$&|curl|&$1.0,1.0$\cr
|open|&\lodash$,1.0$&$x_1,y_1$&|open|&\lodash$,-1.0$\cr
|curl|&$2.0,-1.0$&$x_2,y_2$&|curl|&$2.0,1.0$\cr
|given|&$d,1.0$&$x_3,y_3$&|given|&$d,3.0$\cr
|open|&\lodash$,4.0$&$x_4,y_4$&|explicit|&$x_{45},y_{45}$\cr
|explicit|&$x_{54},y_{54}$&$x_5,y_5$&|endpoint|&\lodash$,\,$\lodash\cr}}$$
여기서 |d|는 |nArg(-unity,-two)|를 불러 얻는 |angle|이다. 물론 이 보기는 보통의 사용자가 쓸 법한
어떤 것보다도 복잡하다.

\MF\ 경로 문법의 꼴 때문에 이 형들은 어떤 제약을 만족해야 한다.
(i)~|open| 형은 |endpoint|나 |given|이나 |curl|과 같은 노드에 함께 나타나지 않는다.
(ii)~노드의 |rightType|이 |explicit|일 때, 그리고 오직 그때에만 다음 노드의 |leftType|이 |explicit|이다.
(iii)~|endpoint| 형은 앞에서 말한 대로 양 끝에만 나타난다.

@<정의@>=
func leftCurl(p pointer) scaled          { return leftX(p) } // 이 매듭에 들어올 때의 휨 정보
func setLeftCurl(p pointer, v scaled)    { setLeftX(p, v) }
func leftGiven(p pointer) angle          { return leftX(p) } // 이 매듭에 들어올 때 주어진 방향
func setLeftGiven(p pointer, v angle)    { setLeftX(p, v) }
func leftTension(p pointer) scaled       { return leftY(p) } // 이 매듭에 들어올 때의 긴장 정보
func setLeftTension(p pointer, v scaled) { setLeftY(p, v) }
func rightCurl(p pointer) scaled          { return rightX(p) } // 이 매듭을 떠날 때의 휨 정보
func setRightCurl(p pointer, v scaled)    { setRightX(p, v) }
func rightGiven(p pointer) angle          { return rightX(p) } // 이 매듭을 떠날 때 주어진 방향
func setRightGiven(p pointer, v angle)    { setRightX(p, v) }
func rightTension(p pointer) scaled       { return rightY(p) } // 이 매듭을 떠날 때의 긴장 정보
func setRightTension(p pointer, v scaled) { setRightY(p, v) }

const (
	@!explicit = 1 // 조절점을 알 때의 |leftType|이나 |rightType|
	@!given = 2 // 방향이 주어졌을 때의 |leftType|이나 |rightType|
	@!curl = 3 // 휨을 원할 때의 |leftType|이나 |rightType|
	@!open = 4 // \MF가 방향을 골라야 할 때의 |leftType|이나 |rightType|
)

@ 다음은 주어진 매듭 목록을 기호의 꼴로 찍는 진단 루틴이다. 이것은 앞에서 말한 관례들을 보여 주고,
\MF를 디버깅하는 동안 일어날 수 있는 이상한 점들을 검사한다.

@<함수들@>=
func printPath(h pointer, s any, nuline bool) {
	var p, q pointer // 목록을 따라가는 데 쓴다
	printDiagnostic("Path", s, nuline)
	printLn()
@.Path at line...@>
	p = h
	for {
		q = link(p)
		if p == null || q == null {
			printNl("???")
			goto done // 이런 일은 일어나지 않는다
@.???@>
		}
		@<인접한 매듭 |p|와 |q|에 관한 정보를 찍는다@>
		p = q
		if p != h || leftType(h) != endpoint {
			@<점 두 개를 찍고, 있으면 |given|이나 |curl|을 찍는다@>
		}
		if p == h {
			break
		}
	}
	if leftType(h) != endpoint {
		printStr("cycle")
	}
done:
	endDiagnostic(true)
}

@ @<인접한 매듭 |p|와 |q|에...@>=
printTwo(xCoord(p), yCoord(p))
switch rightType(p) {
case endpoint:
	if leftType(p) == open {
		printStr("{open?}") // 일어날 수 없다
	}
@.open?@>
	if leftType(q) != endpoint || q != h {
		q = null // 오류를 일으킨다
	}
	goto done1
case explicit:
	@<|p|와 |q| 사이의 조절점들을 찍고 |goto done1|@>
case open:
	@<|open|으로 시작하는 곡선에 관한 정보를 찍는다@>
case curl, given:
	@<|curl|이나 |given|으로 시작하는 곡선에 관한 정보를 찍는다@>
default:
	printStr("???") // 일어날 수 없다
@.???@>
}
if leftType(q) <= explicit {
	printStr("..control?") // 일어날 수 없다
@.control?@>
} else if rightTension(p) != unity || leftTension(q) != unity {
	@<|p|와 |q| 사이의 긴장을 찍는다@>
}
done1:

@ 함수 |nSinCos|는 |fraction| 결과를 내는데 그것을 |scaled|처럼 찍으므로, |given| 방향 벡터의 크기는
4096이 된다.

@<점 두 개를 찍고...@>=
printNl(" ..")
if leftType(p) == given {
	nSinCos(leftGiven(p))
	printChar('{')
	printScaled(nCos)
	printChar(',')
	printScaled(nSin)
	printChar('}')
} else if leftType(p) == curl {
	printStr("{curl ")
	printScaled(leftCurl(p))
	printChar('}')
}

@ @<|p|와 |q| 사이의 긴장을...@>=
printStr("..tension ")
if rightTension(p) < 0 {
	printStr("atleast")
}
printScaled(abs(rightTension(p)))
if rightTension(p) != leftTension(q) {
	printStr(" and ")
	if leftTension(q) < 0 {
		printStr("atleast")
	}
	printScaled(abs(leftTension(q)))
}

@ @<|p|와 |q| 사이의 조절점들을...@>=
printStr("..controls ")
printTwo(rightX(p), rightY(p))
printStr(" and ")
if leftType(q) != explicit {
	printStr("??") // 일어날 수 없다
@.??@>
} else {
	printTwo(leftX(q), leftY(q))
}
goto done1

@ @<|open|으로 시작하는...@>=
if leftType(p) != explicit && leftType(p) != open {
	printStr("{open?}") // 일어날 수 없다
}
@.open?@>

@ 휨 1은 드러나게 보여 주어서, \MF의 기본 휨이 있다는 것을 사용자가 분명히 보게 한다.

@<|curl|이나 |given|으로...@>=
if leftType(p) == open {
	printStr("??") // 일어날 수 없다
}
@.??@>
if rightType(p) == curl {
	printStr("{curl ")
	printScaled(rightCurl(p))
} else {
	nSinCos(rightGiven(p))
	printChar('{')
	printScaled(nCos)
	printChar(',')
	printScaled(nSin)
}
printChar('}')

@ 매듭 노드를 복제하고 싶으면 |copyKnot|이라고 하면 된다.

@<함수들@>=
func copyKnot(p pointer) pointer {
	var q pointer // 복사본
	var k int32 // 매듭 노드의 낱말들을 차례로 돈다; |0 .. knotNodeSize-1|
	q = getNode(knotNodeSize)
	for k = 0; k <= knotNodeSize-1; k++ {
		mem[q+k] = mem[p+k]
	}
	return q
}

@ 루틴 |copyPath|는 주어진 경로의 복제를 만든다.

@<함수들@>=
func copyPath(p pointer) pointer {
	var q, pp, qq pointer // 목록 조작을 위해
	q = getNode(knotNodeSize) // 이것이 |p|에 해당할 것이다
	qq = q
	pp = p
	for {
		setLeftType(qq, leftType(pp))
		setRightType(qq, rightType(pp))
		setXCoord(qq, xCoord(pp))
		setYCoord(qq, yCoord(pp))
		setLeftX(qq, leftX(pp))
		setLeftY(qq, leftY(pp))
		setRightX(qq, rightX(pp))
		setRightY(qq, rightY(pp))
		if link(pp) == p {
			setLink(qq, q)
			return q
		}
		setLink(qq, getNode(knotNodeSize))
		qq = link(qq)
		pp = link(pp)
	}
}

@ 비슷하게, 경로의 {\sl 역\/}을 베끼는 방법도 있다. 이 프로시저는 경로가 순환이면 복사본의 첫 노드를
가리키는 포인터를 돌려주지만, 순환이 아닌 복사본이면 마지막 노드를 가리키는 포인터를 돌려준다. 전역
변수 |pathTail|은 원래 경로의 마지막 노드를 가리키게 된다. 이 꾀를 쓰면 `\KW{doublepath}'를 구현하기가
더 쉬워진다. 함수의 이름 |htapYpoc|은 |copyPath|를 거꾸로 쓴 것이다.

모든 노드의 형은 |endpoint|나 |explicit|뿐이라고 가정한다.

@<함수들@>=
func htapYpoc(p pointer) pointer {
	var q, pp, qq, rr pointer // 목록 조작을 위해
	q = getNode(knotNodeSize) // 이것이 |p|에 해당할 것이다
	qq = q
	pp = p
	for {
		setRightType(qq, leftType(pp))
		setLeftType(qq, rightType(pp))
		setXCoord(qq, xCoord(pp))
		setYCoord(qq, yCoord(pp))
		setRightX(qq, leftX(pp))
		setRightY(qq, leftY(pp))
		setLeftX(qq, rightX(pp))
		setLeftY(qq, rightY(pp))
		if link(pp) == p {
			setLink(q, qq)
			pathTail = pp
			return q
		}
		rr = getNode(knotNodeSize)
		setLink(rr, qq)
		qq = rr
		pp = link(pp)
	}
}

@ @<전역 변수@>=
var @!pathTail pointer // 경로의 처음으로 이어지는 노드

@ 매듭 노드들의 순환 목록이 더는 필요 없으면 다음 서브루틴을 불러 재활용할 수 있다.

@<함수들@>=
func tossKnotList(p pointer) {
	var q pointer // 해제하고 있는 노드
	var r pointer // 다음 노드
	q = p
	for {
		r = link(q)
		freeNode(q, knotNodeSize)
		q = r
		if q == p {
			break
		}
	}
}

@* 조절점 고르기.
이제 우리는 \MF의 더 어려운 루틴 가운데 하나로 파고들어야 한다. 사용자가 각과 조절점을 직접 지정하지
않았을 때 곡선의 스플라인들을 위해 그것들을 고르는 프로시저 |makeChoices|다. 이 프로시저의 매개변수는
앞에서 설명한 매듭과 경로 정보의 목록을 가리킨다.

경로는 ``꺾인 점'' 매듭에서 서로 독립인 조각들로 나뉜다. 꺾인 점이란 왼쪽 각과 오른쪽 각이 둘 다
어떤 식으로든 미리 지정된(곧 |leftType|과 |rightType|이 둘 다 |open|은 아닌) 매듭이다.

@<함수들@>=
func makeChoices(knots pointer) {
	var h pointer // 첫 꺾인 점
	var p, q pointer // 처리하고 있는 이웃한 꺾인 점들
	var k, n int32 // 현재 매듭 번호와 마지막 매듭 번호; |0 .. pathSize|
	var s, t pointer // 목록을 따라가는 레지스터들
	var delx, dely scaled // |open|이 |explicit|을 만나는 방향
	var sine, cosine fraction // 여러 각의 삼각 함수
	checkArith() // |arithError=false|임을 확실히 한다
	if internal[tracingChoices] > 0 {
		printPath(knots, ", before choices", true)
	}
	@<이웃한 매듭이 같으면 그 둘을 명시적으로 잇는다@>
	@<경로의 첫 꺾인 점 |h|를 찾는다; 경로가 끊김 없는 순환이면 인공 꺾인 점을 넣는다@>
	p = h
	for {
		@<|p|와 다음 꺾인 점 사이의 조절점들을 채우고, |p|를 그 꺾인 점으로 나아가게 한다@>
		if p == h {
			break
		}
	}
	if internal[tracingChoices] > 0 {
		printPath(knots, ", after choices", true)
	}
	if arithError {
		@<조절점을 고르는 동안 뜻밖의 문제가 생겼다고 알린다@>
	}
}

@ @<조절점을 고르는 동안...@>=
printErr("Some number got too big")
@.Some number got too big@>
help2("The path that I just computed is out of range.",
	"So it will probably look funny. Proceed, for a laugh.")
putGetError()
arithError = false

@ 좌표가 같은 매듭 둘이 잇달아 나오면 언제나 명시적인 ``곡선''으로 잇는다. 그 조절점은 매듭과
같다.

@<이웃한 매듭이 같으면...@>=
p = knots
for {
	q = link(p)
	if xCoord(p) == xCoord(q) && yCoord(p) == yCoord(q) && rightType(p) > explicit {
		setRightType(p, explicit)
		if leftType(p) == open {
			setLeftType(p, curl)
			setLeftCurl(p, unity)
		}
		setLeftType(q, explicit)
		if rightType(q) == open {
			setRightType(q, curl)
			setRightCurl(q, unity)
		}
		setRightX(p, xCoord(p))
		setLeftX(q, xCoord(p))
		setRightY(p, yCoord(p))
		setLeftY(q, yCoord(p))
	}
	p = q
	if p == knots {
		break
	}
}

@ 꺾인 점이 하나도 없으면 순환 전체에 걸쳐 방향 각을 계산해야 한다. 이 경우 첫 노드의 |leftType|을
잠시 |endCycle|로 바꾼다.

@<정의@>=
const @!endCycle = open + 1

@ @<경로의 첫 꺾인 점...@>=
h = knots
for {
	if leftType(h) != open {
		break
	}
	if rightType(h) != open {
		break
	}
	h = link(h)
	if h == knots {
		setLeftType(h, endCycle)
		break
	}
}

@ 여기서 |rightType(p)<given|이고 |q=link(p)|이면 |rightType(p)=leftType(q)=explicit|이거나 |endpoint|여야 한다.

@<|p|와 다음 꺾인 점 사이의...@>=
q = link(p)
if rightType(p) >= given {
	for leftType(q) == open && rightType(q) == open {
		q = link(q)
	}
	@<이웃한 꺾인 점 |p|와 |q| 사이의 조절 정보를 채운다@>
}
p = q

@ \seclabel{hobby}조절점을 고르는 방식을 더 들여다보기 전에 그 바탕에 깔린 이론을 생각해 보아야 한다. 프로시저 |makeChoices|에
구현된 기본 생각은 존 하비가 내놓은 것인데, 그는 매듭에서의 ``모조 곡률''(mock curvature)이라는 개념을
@^Hobby, John Douglas@>
들여왔다. 각은 매듭을 지날 때 모조 곡률이 보존되도록 고르는데, 이렇게 하면 아주 훌륭한 결과가 나온다는
것이 밝혀졌다.

필요한 공식을 간단히 하는 표기 몇 가지를 들여오면 편리하다. 매듭 |k|와 |k+1| 사이의 (0이 아닌) 거리를
$d_{k,k+1}=\vert z\k-z_k\vert$라고 하고,
$${z\k-z_k\over z_k-z_{k-1}}={d_{k,k+1}\over d_{k-1,k}}e^{i\psi_k}$$
라고 하자. 그러면 $z_{k-1}$에서 $z_k$를 거쳐 $z\k$로 가는 꺾은선은 각~$\psi_k$만큼 왼쪽으로 돈다.
또 $\vert\psi_k\vert\le180^\circ$라고 가정한다. 매듭 $z_k$에서 $z\k$로 가는 스플라인의 조절점은
$$\eqalign{z_k^+&=z_k+
  \textstyle{1\over3}\rho_k e^{i\theta_k}(z\k-z_k),\cr
 z\k^-&=z\k-
  \textstyle{1\over3}\sigma\k e^{-i\phi\k}(z\k-z_k)\cr}$$
로 나타낸다. 여기서 $\rho_k$와 $\sigma\k$는 곡선의 처음과 끝에서의 음이 아닌 ``속도 비''이고,
$\theta_k$와 $\phi\k$는 그에 해당하는 ``어긋남 각''이다. 곡선이 중간 매듭~|k|를 들어온 방향 그대로
떠날 때면 언제나 이 각들은 조건
$$\theta_k+\phi_k+\psi_k=0\eqno(*)$$
을 만족한다.

아래 그림이 이 각들을 보인다. 회색 꺾은선이 매듭들을 잇는 현이고, 굵은 선이 곡선이다. 매듭 $z_k$에서
곡선의 접선(가는 선)은 들어오는 현에서 $-\phi_k$만큼, 나가는 현에서 $\theta_k$만큼 돌아가 있다. 이
그림에서는 $\theta_k$와 $\phi_k$가 둘 다 음수이고 $\psi_k$는 양수다. 세 각의 합이 0이라는
조건~$(*)$은 접선이 하나뿐이라는 말을 각으로 옮긴 것에 지나지 않는다.
$$\mplibcode
beginfig(9);
save u, z, c, dt, a, b; numeric u, dt, a, b; pair z[]; path c; u := 34pt;
z0 = (0,0); z1 = (4u, .4u); z2 = (6.5u, 3u);
c = z0..z1..z2;
a := angle(z1-z0); b := angle(z2-z1); dt := angle(direction 1 of c);
draw z0--z1--z2 withcolor .65white;
draw z1--(z1 + 1.6u*dir a) dashed evenly withcolor .65white;
draw (z1 - 1.3u*dir dt)--(z1 + 1.9u*dir dt) withpen pencircle scaled .3pt;
draw c withpen pencircle scaled 1.1pt;
drawarrow anglearc(z1, a, b, 1.45u) withpen pencircle scaled .4pt;
label.urt(btex $\psi_k$ etex, z1 + 1.45u*dir(.7[a,b]));
drawarrow anglearc(z1, dt, a, .95u) withpen pencircle scaled .4pt;
label.rt(btex $\phi_k$ etex, z1 + .95u*dir(.5[a,dt]));
drawarrow anglearc(z1, b, dt, 1.15u) withpen pencircle scaled .4pt;
label.top(btex $\theta_k$ etex, z1 + 1.15u*dir(.5[b,dt]));
dot(z0); dot(z1); dot(z2);
label.bot(btex $z_{k-1}$ etex, z0); label.bot(btex $z_k$ etex, z1); label.rt(btex $z_{k+1}$ etex, z2);
endfig;
\endmplibcode$$

@ 곡선의 시작점과 끝점에서의 ``긴장''의 역수를 $\alpha_k$와 $\beta\k$라고 하자. 이것은
$\rho_k=\alpha_k f(\theta_k,\phi\k)$이고 $\sigma\k=\beta\k f(\phi\k,\theta_k)$라는 뜻이다. 여기서
$f(\theta,\phi)$는 서브루틴 |velocity|에 정의된 \MF의 표준 속도 함수다(\secref{velocity}). 삼차 스플라인
$B(z_k^{\phantom+},z_k^+, z\k^-,z\k^{\phantom+};t)$의 곡률은 |t=0|과 |t=1|에서 각각
@^curvature@>
$${2\sigma\k\sin(\theta_k+\phi\k)-6\sin\theta_k\over\rho_k^2d_{k,k+1}}
\qquad\hbox{과}\qquad
{2\rho_k\sin(\theta_k+\phi\k)-6\sin\phi\k\over\sigma\k^2d_{k,k+1}}$$
이다. 모조 곡률은 $\theta_k$와~$\phi\k$가 작을 때 이차 항을 버리면 극한에서 나오는, 이 참 곡률의 일차
근사다.
@^mock curvature@>
표준 속도 함수는 $$f(\theta,\phi)=1+O(\theta^2+\theta\phi+\phi^2)$$를 만족하므로, 모조 곡률은 각각
$${2\beta\k(\theta_k+\phi\k)-6\theta_k\over\alpha_k^2d_{k,k+1}}
\qquad\hbox{과}\qquad
{2\alpha_k(\theta_k+\phi\k)-6\phi\k\over\beta\k^2d_{k,k+1}}\eqno(**)$$
이다.

긴장이 크면($\alpha$와 $\beta$가 작으면) 조절점이 매듭에 가까워져서 곡선이 현 쪽으로 팽팽하게 당겨진다.
아래 그림은 같은 두 점을 같은 방향($60^\circ$로 출발해서 $-60^\circ$로 도착)으로 잇되 긴장만 바꾼
곡선들이다. 바깥에서 안쪽으로 차례로 \.{tension} 0.75, 1, 1.5, 3이다. 0.75는 \MF가 허용하는 가장 작은
긴장이다.
$$\mplibcode
beginfig(10);
save u, i; numeric u; u := 40pt;
i := 0;
for tt = .75, 1, 1.5, 3:
  draw (0,0){dir 60} .. tension tt .. {dir -60}(4u,0)
    withpen pencircle scaled (if tt=1: 1.1pt else: .5pt fi);
endfor
dot((0,0)); dot((4u,0));
label.bot(btex $z_0$ etex, (0,0)); label.bot(btex $z_1$ etex, (4u,0));
endfig;
\endmplibcode$$

@ 꺾임 각 $\psi_k$는 주어져 있고, 식 $(*)$은 $\theta_k$를 알면 $\phi_k$를 정하므로, 각을 고르는 일은
본질적으로 각 $\theta_k$에 알맞은 값을 고르는 것이다. 식~$(*)$을 써서 $(**)$에서 $\phi$ 변수들을
없애면 다음 꼴의 일차 방정식 체계를 얻는다.
$$A_k\theta_{k-1}+(B_k+C_k)\theta_k+D_k\theta\k=-B_k\psi_k-D_k\psi\k,$$
여기서
$$A_k={\alpha_{k-1}\over\beta_k^2d_{k-1,k}},
\qquad B_k={3-\alpha_{k-1}\over\beta_k^2d_{k-1,k}},
\qquad C_k={3-\beta\k\over\alpha_k^2d_{k,k+1}},
\qquad D_k={\beta\k\over\alpha_k^2d_{k,k+1}}$$
이다. 긴장은 언제나 $3\over4$ 이상이므로 각 $\alpha$와~$\beta$는 많아야 $4\over3$이다. 따라서
$B_k\ge{5\over4}A_k$이고 $C_k\ge{5\over4}D_k$이다. 그러므로 이 방정식들은 대각 지배적이고, 따라서 유일한
해를 가진다. 게다가 대개는 긴장이 1이어서 $B_k=2A_k$이고 $C_k=2D_k$다. 이 덕분에 해가 수치적으로
안정하고, 지수적으로 잦아드는 효과가 있다. 매듭 $k\pm j$의 자료는 매듭~$k$의 각에 $O(2^{-j})$의
인수만큼만 영향을 준다.

@ 그러나 순환이 아닌 경로의 첫 매듭과 마지막 매듭에서의 각도 생각해야 한다. 이 각들은 명시적으로
주어질 수도 있고, ``휨''(curl)의 양으로 간접적으로 지정될 수도 있다.

매듭 $z_0$에서 시작해서 $z_n$에서 끝나는 순환이 아닌 경로에서 각을 정해야 한다고 하자. 그러면 $0<k<n$에
대해
$$A_k\theta_{k-1}+(B_k+C_k)\theta_k+D_k\theta_{k+1}=R_k$$
꼴의 방정식들이 주어져 있고, $k=0$과 $k=n$에 대해서도 같은 꼴의 방정식을 들여오면 편리하다. 그때
$$A_0=B_0=C_n=D_n=0$$
이다. 각 $\theta_0$이 주어진 값 $E_0$을 가져야 한다면 그냥 $C_0=1$, $D_0=0$, $R_0=E_0$으로 정의한다.
그렇지 않으면 $z_0$에 휨 매개변수 $\gamma_0$이 지정되어 있다. 이것은 $z_0$에서의 모조 곡률이 $z_1$에서의
모조 곡률의 $\gamma_0$배여야 한다는 뜻이다. 곧
$${2\beta_1(\theta_0+\phi_1)-6\theta_0\over\alpha_0^2d_{01}}
=\gamma_0{2\alpha_0(\theta_0+\phi_1)-6\phi_1\over\beta_1^2d_{01}}$$
이다. 이 방정식은
$$(\alpha_0\chi_0+3-\beta_1)\theta_0+
 \bigl((3-\alpha_0)\chi_0+\beta_1\bigr)\theta_1=
 -\bigl((3-\alpha_0)\chi_0+\beta_1\bigr)\psi_1$$
로 간단해진다. 여기서 $\chi_0=\alpha_0^2\gamma_0/\beta_1^2$이다. 그러므로 $C_0=\chi_0\alpha_0+3-\beta_1$,
$D_0=(3-\alpha_0)\chi_0+\beta_1$, $R_0=-D_0\psi_1$로 놓을 수 있다. 휨이 $\gamma_0\ge0$이면 $C_0>0$이고
$C_0B_1-A_1D_0>0$임을 보일 수 있으므로, 일차 방정식은 여전히 정칙이다.

마지막 각 $\phi_n$을 정해야 할 수도 있고 그렇지 않을 수도 있는 오른쪽 끝에서도 비슷하게 생각하면 된다.
여기서는 $\psi_n=0$으로 놓으면 편리하다. 그러면 $\theta_n=-\phi_n$이다. 명시적인 방정식 $\theta_n=E_n$이 있거나,
$$\bigl((3-\beta_n)\chi_n+\alpha_{n-1}\bigr)\theta_{n-1}+
(\beta_n\chi_n+3-\alpha_{n-1})\theta_n=0,\qquad
  \chi_n={\beta_n^2\gamma_n\over\alpha_{n-1}^2}$$
이 있다.

프로시저 |makeChoices|가 각을 고를 때는 이 일차 방정식들의 계수를 계산한 다음 방정식들을 풀어야 한다. 계수를
계산하려면 주어진 꺾임 각~$\psi_k$의 아크탄젠트를 계산해야 한다. 방정식을 풀고 나면 고른 방향
$\theta_k$를 본질적으로 사인과 코사인을 계산해서 조절점의 꼴로 되돌린다.

휨이 무엇을 하는지는 그림으로 보는 것이 가장 빠르다. 아래 그림은 같은 세 점을 잇는 경로
`\.{z0\{curl $\gamma$\}..z1..\{curl $\gamma$\}z2}'를 $\gamma=0$, 1, 4로 그린 것이다. 휨이 0이면 끝점에서의
모조 곡률이 0이 되어 곡선이 끝으로 갈수록 곧게 펴진다. 휨이 클수록 곡선은 끝에서 더 세게 휜다.
\MF의 기본값은 1이다.
$$\mplibcode
beginfig(11);
save u; numeric u; u := 40pt;
for g = 0, 1, 4:
  draw (0,0){curl g} .. (2u,1.2u) .. {curl g}(4u,0)
    withpen pencircle scaled (if g=1: 1.1pt else: .5pt fi);
endfor
dot((0,0)); dot((2u,1.2u)); dot((4u,0));
label.bot(btex $z_0$ etex, (0,0)); label.top(btex $z_1$ etex, (2u,1.2u));
label.bot(btex $z_2$ etex, (4u,0));
label.lft(btex $\gamma=0$ etex, (.35u,.95u));
endfig;
\endmplibcode$$

@ 좋다, 이제 |makeChoices|의 어려운 선택을 할 준비가 되었다. 일의 대부분은 |solveChoices|라는 보조
프로시저에 넘긴다. 이 프로시저는 |makeChoices|가 지나치게 길어지지 않도록 들여온 것이다.

@<이웃한 꺾인 점 |p|와 |q| 사이의...@>=
@<꺾임 각 $\psi_k$와 거리 $d_{k,k+1}$을 계산하고, $n$을 경로의 길이로 놓는다@>
@<꺾인 점의 |open| 형을 없앤다@>
solveChoices(p, q, n)

@ 나중에 여러 번 필요한 양들은 미리 계산해 두면 편리하다. 배열 |deltaX[k]|와 |deltaY[k]|의 값은
$z\k-z_k$의 좌표가 되고, 이 벡터의 크기는 |delta[k]=@t$d_{k,k+1}$@>|가 된다. 두 벡터 $z_k-z_{k-1}$과 $z\k-z_k$
사이의 경로 각 $\psi_k$는 |psi[k]|에 저장한다.

@<전역 변수@>=
var @!deltaX, @!deltaY, @!delta [pathSize + 1]scaled // 매듭 사이의 차
var @!psi [pathSize + 1]angle // 꺾임 각; 첨자는 |1 .. pathSize|

@ 꺾임 각 $\psi_k$는 앞 현의 방향을 $x$축에 맞추도록 돌린 좌표계에서 다음 현의 편각이다. 곧 앞 현의
방향 코사인과 사인으로 다음 현의 벡터를 거꾸로 돌린 다음 |nArg|로 편각을 잰다.

@<꺾임 각 $\psi_k$와...@>=
k = 0
s = p
n = pathSize
for {
	t = link(s)
	deltaX[k] = xCoord(t) - xCoord(s)
	deltaY[k] = yCoord(t) - yCoord(s)
	delta[k] = pythAdd(deltaX[k], deltaY[k])
	if k > 0 {
		sine = makeFraction(deltaY[k-1], delta[k-1])
		cosine = makeFraction(deltaX[k-1], delta[k-1])
		psi[k] = nArg(takeFraction(deltaX[k], cosine)+takeFraction(deltaY[k], sine),
			takeFraction(deltaY[k], cosine)-takeFraction(deltaX[k], sine))
	}
@:METAFONT capacity exceeded path size}{\quad path size@>
	k++
	s = t
	if k == pathSize {
		overflow("path size", pathSize)
	}
	if s == q {
		n = k
	}
	if k >= n && leftType(s) != endCycle {
		break
	}
}
if k == n {
	psi[n] = 0
} else {
	psi[k] = psi[1]
}

@ 코드의 이 지점에 이르면 |rightType(p)|는 |given|이거나 |curl|이거나 |open|이다. 그것이 |open|이면
|leftType(p)=endCycle|이거나 |leftType(p)=explicit|이어야 한다. 뒤의 경우에는 |open| 형을 |given|으로
바꾼다. 그러나 이 매듭에 들어오는 속도가 0이면 들어오는 방향을 모르므로 |open| 형을 |curl|로 바꾼다.

비슷하게, |leftType(q)|는 |given|이거나 |curl|이거나 |open|이거나 |endCycle|이다. 그 가운데 |open|인 경우는
|given|이나 |curl|로 줄인다.

@<꺾인 점의 |open| 형을...@>=
if leftType(q) == open {
	delx = rightX(q) - xCoord(q)
	dely = rightY(q) - yCoord(q)
	if delx == 0 && dely == 0 {
		setLeftType(q, curl)
		setLeftCurl(q, unity)
	} else {
		setLeftType(q, given)
		setLeftGiven(q, nArg(delx, dely))
	}
}
if rightType(p) == open && leftType(p) == explicit {
	delx = xCoord(p) - leftX(p)
	dely = yCoord(p) - leftY(p)
	if delx == 0 && dely == 0 {
		setRightType(p, curl)
		setRightCurl(p, unity)
	} else {
		setRightType(p, given)
		setRightGiven(p, nArg(delx, dely))
	}
}

@ 일차 방정식은 |n>1|일 때면 언제나 풀어야 하고, |n=1|이고 꺾인 점 가운데 꼭 하나에 휨이 있을 때도
풀어야 한다. 가장 간단한 경우는 |n=1|이고 두 꺾인 점에 모두 휨이 있을 때다. 그때는 그냥 직선을 그린다.

그러나 간단한 경우들을 짜기 전에 일반적인 경우를 마주하는 것이 낫겠다. 어차피 언젠가는 다루어야 하고,
일반적인 경우를 보면 간단한 경우들을 어떻게 다루는 것이 가장 좋은지 통찰을 얻을 수 있을 것이기 때문이다.

순환이 없으면 풀어야 할 일차 방정식은 삼중 대각 체계를 이루고, 가우스 소거법의 표준 기법을 적용해서
그 체계를
$$\theta_0+u_0\theta_1=v_0,\quad
\theta_1+u_1\theta_2=v_1,\quad\ldots,\quad
\theta_{n-1}+u_{n-1}\theta_n=v_{n-1},\quad
\theta_n=v_n$$
꼴의 방정식들의 나열로 바꿀 수 있다. 방정식들을 만들어 내면서 동시에 이 대각화를 할 수 있다. 일단
$\theta_n$을 알면 $\theta_{n-1}$, \dots, $\theta_1$, $\theta_0$을 정하기는 쉽다. 그렇게 방정식이 풀린다.

순환이 있으면 절차가 조금 더 복잡하지만 기본 생각은 거의 같다. 순환인 경우에는 오른쪽 변이 그냥
$v_k$가 아니라 $v_k+w_k\theta_0$이 되고, $u_0=v_0=0$, $w_0=1$로 과정을 시작한다. 마지막 방정식은
$\theta_n=v_n$이 아니라 $\theta_n+u_n\theta_1=v_n+w_n\theta_0$이 된다. 알맞은 마무리 루틴이 $\theta_n=
\theta_0$이라는 사실을 고려해서 체계에서 $w$를 없애고, 그다음에는 앞에서처럼 해를 얻을 수 있다.

계수 $u_k$, $v_k$, $w_k$를 계산하는 동안 세 포인터 변수 |r|, |s|,~|t|는 각각 매듭 |k-1|, |k|, |k+1|을
가리킨다. 계수 $u$와 $w$는 $2^{28}$로 눈금을 매기므로, 곧 형이 |fraction|이다. 한편 $\theta$와 $v$는 형이
|angle|이다.

@<전역 변수@>=
var @!theta [pathSize + 1]angle // $\theta_k$의 값들
var @!uu [pathSize + 1]fraction // $u_k$의 값들
var @!vv [pathSize + 1]angle // $v_k$의 값들
var @!ww [pathSize + 1]fraction // $w_k$의 값들

@ 우리 앞의 문제는 첫 방정식을 세우거나 방정식이 필요 없다는 것을 깨달아서 일을 굴러가게 하는 것, 그리고
이 초기화를 전체 계산에 알맞은 틀에 맞추는 것이다.

@<함수들@>=
func solveChoices(p, q pointer, n halfword) {
	var k int32 // 현재 매듭 번호; |0 .. pathSize|
	var r, s, t pointer // 목록을 따라가는 레지스터들
	var aa, bb, cc, ff, acc fraction // 임시 레지스터들
	var dd, ee scaled // 마찬가지이지만 |scaled|
	var lt, rt scaled // 긴장 값들
	k = 0
	s = p
	for {
		t = link(s)
		if k == 0 {
			@<일차 방정식을 시작하거나, 풀 필요가 없으면 조절점을 놓고 |return|한다@>
		} else {
			switch leftType(s) {
			case endCycle, open:
				@<$z_k$의 모조 곡률 방정식을 세운다; 순환이 끝났으면 $\theta_n=\theta_0$으로 놓고 |goto found|@>
			case curl:
				@<$\theta_n$에서 휨의 방정식을 세우고 |goto found|@>
			case given:
				@<$\theta_n$의 주어진 값을 계산하고 |goto found|@>
			} // 다른 경우는 없다
		}
		r = s
		s = t
		k++
	}
found:
	@<각 고르기를 마치고 조절점을 넣는다@>
}

@ 루프를 처음 돌 때는 |k=0|이고 |r|은 아직 정해지지 않았다. 첫 일차 방정식이 있다면 그것은 $A_0=B_0=0$이다.

@<일차 방정식을 시작하거나, 풀 필요가 없으면 조절점을 놓고 |return|한다@>=
switch rightType(s) {
case given:
	if leftType(t) == given {
		@<주어진 방향 둘의 간단한 경우로 줄이고 |return|한다@>
	} else {
		@<$\theta_0$의 주어진 값에 대한 방정식을 세운다@>
	}
case curl:
	if leftType(t) == curl {
		@<직선이라는 간단한 경우로 줄이고 |return|한다@>
	} else {
		@<$\theta_0$에서 휨의 방정식을 세운다@>
	}
case open:
	uu[0] = 0
	vv[0] = 0
	ww[0] = fractionOne // 이것이 순환을 시작한다
} // 다른 경우는 없다

@ 매듭 $z_k$에서 모조 곡률이 같아야 한다는 것을 지정하는 일반 방정식은 앞에서 이끌어 낸 대로
$$A_k\theta_{k-1}+(B_k+C_k)\theta_k+D_k\theta\k=-B_k\psi_k-D_k\psi\k$$
이다. 우리는 이것을 이미 이끌어 낸 방정식 $\theta_{k-1}+u_{k-1}\theta_k=v_{k-1}+w_{k-1}\theta_0$과
결합해서 새 방정식 $\theta_k+u_k\theta\k=v_k+w_k\theta_0$을 얻고 싶다. 그것은 방정식
$$(B_k-u_{k-1}A_k+C_k)\theta_k+D_k\theta\k=-B_k\psi_k-D_k\psi\k-A_kv_{k-1}
    -A_kw_{k-1}\theta_0$$
을 $B_k-u_{k-1}A_k+C_k$로 나누면 된다. 요령은 넘침의 위험을 피하면서 알맞은 정밀도를 지키도록 고정
소수점 산술로 조심스럽게 하는 것이다.

계산은 중간 양들을 위한 임시 저장소 노릇을 하는 여러 레지스터에서 한다. 그 레지스터들은 |solveChoices|의
지역 변수로 앞에서 선언했다.

@<$z_k$의 모조 곡률 방정식을 세운다; 순환이 끝났으면 $\theta_n=\theta_0$으로 놓고 |goto found|@>=
@<값 $\\{aa}$, $\\{bb}$, $\\{cc}$, $\\{dd}$, $\\{ee}$를 계산한다@>
@<비 $\\{ff}=C_k/(C_k+B_k-u_{k-1}A_k)$를 계산한다@>
uu[k] = takeFraction(ff, bb)
@<$v_k$와 $w_k$의 값을 계산한다@>
if leftType(s) == endCycle {
	@<$\theta_n$을 $\theta_0$과 같게 고치고 |goto found|@>
}

@ 여기서 계산하는 값은 $\\{aa}=A_k/B_k$, $\\{bb}=D_k/C_k$, $\\{dd}=(3-\alpha_{k-1})d_{k,k+1}$,
$\\{ee}=(3-\beta\k)d_{k-1,k}$, $\\{cc}=(B_k-u_{k-1}A_k)/B_k$다.
긴장 값은 결코 3/4보다 작지 않으므로, 여기서 계산하는 값 |aa|와 |bb|는 결코 4/5보다 크지 않다.

@<값 $\\{aa}$, $\\{bb}$, $\\{cc}$, $\\{dd}$, $\\{ee}$를 계산한다@>=
if abs(rightTension(r)) == unity {
	aa = fractionHalf
	dd = 2 * delta[k]
} else {
	aa = makeFraction(unity, 3*abs(rightTension(r))-unity)
	dd = takeFraction(delta[k], fractionThree-makeFraction(unity, abs(rightTension(r))))
}
if abs(leftTension(t)) == unity {
	bb = fractionHalf
	ee = 2 * delta[k-1]
} else {
	bb = makeFraction(unity, 3*abs(leftTension(t))-unity)
	ee = takeFraction(delta[k-1], fractionThree-makeFraction(unity, abs(leftTension(t))))
}
cc = fractionOne - takeFraction(uu[k-1], aa)

@ 앞에서 계산한 양들 덕분에, 이 단계에서 계산할 비는
$$\beta_k^2\cdot\\{ee}\over\beta_k^2\cdot\\{ee}+\alpha_k^2\cdot
  \\{cc}\cdot\\{dd}$$
꼴로 쓸 수 있다. 이 단계를 마치고 나면 |dd|와 |ee|의 값은 더 필요 없다.

@<비 $\\{ff}=C_k/...@>=
dd = takeFraction(dd, cc)
lt = abs(leftTension(s))
rt = abs(rightTension(s))
if lt != rt { // $\beta_k^{-1}\ne\alpha_k^{-1}$
	if lt < rt {
		ff = makeFraction(lt, rt)
		ff = takeFraction(ff, ff) // $\alpha_k^2/\beta_k^2$
		dd = takeFraction(dd, ff)
	} else {
		ff = makeFraction(rt, lt)
		ff = takeFraction(ff, ff) // $\beta_k^2/\alpha_k^2$
		ee = takeFraction(ee, ff)
	}
}
ff = makeFraction(ee, ee+dd)

@ 계수 $u_{k-1}$의 값은 $k=1$이고 앞의 방정식이 휨으로 지정된 경우를 빼면 |<=1|이다. 그 경우에는 넘침을
막으려고 특별한 계산 방법을 써야 한다.

다행히 이 ``어려운'' 경우에는 계산이 오히려 더 간단해진다. 휨 방정식은 $w_0=0$이고 $v_0=-u_0\psi_1$로
만들므로, $-B_1\psi_1-A_1v_0=-(B_1-u_0A_1)\psi_1=-\\{cc}\cdot B_1\psi_1$이다.

@<$v_k$와 $w_k$의 값을...@>=
acc = -takeFraction(psi[k+1], uu[k])
if rightType(r) == curl {
	ww[k] = 0
	vv[k] = acc - takeFraction(psi[1], fractionOne-ff)
} else {
	ff = makeFraction(fractionOne-ff, cc) // 이것은 $B_k/(C_k+B_k-u_{k-1}A_k)<5$다
	acc = acc - takeFraction(psi[k], ff)
	ff = takeFraction(ff, aa) // 이것은 $A_k/(C_k+B_k-u_{k-1}A_k)$다
	vv[k] = acc - takeFraction(vv[k-1], ff)
	if ww[k-1] == 0 {
		ww[k] = 0
	} else {
		ww[k] = -takeFraction(ww[k-1], ff)
	}
}

@ 순환 하나를 다 돌고 나면 |1<=k<=n|에 대해 $\theta_k+u_k\theta\k=v_k+w_k\theta_0$이다. 우리는
$\theta_n$의 값을 정하고, 체계를 |0<=k<n|에 대한 $\theta_k+u_k\theta\k=v_k$ 꼴로 줄여서, 순환인 경우를
순환이 없는 것처럼 마무리하고 싶다.

다음 코드의 생각은
$$\eqalign{\theta_n&=v_n+w_n\theta_0-u_n\theta_1=\cdots\cr
&=v_n+w_n\theta_0-u_n\bigl(v_1+w_1\theta_0-u_1(v_2+\cdots
  -u_{n-2}(v_{n-1}+w_{n-1}\theta_0-u_{n-1}\theta_0)\ldots{})\bigr)\cr}$$
임을 관찰하는 것이다. 그러면 $\theta_n=\theta_0$에 대해 풀 수 있다.

@<$\theta_n$을 $\theta_0$과 같게...@>=
aa = 0
bb = fractionOne // 우리는 |k=n|이다
for {
	k--
	if k == 0 {
		k = n
	}
	aa = vv[k] - takeFraction(aa, uu[k])
	bb = ww[k] - takeFraction(bb, uu[k])
	if k == n {
		break
	}
} // 이제 $\theta_n=\\{aa}+\\{bb}\cdot\theta_n$이다
aa = makeFraction(aa, fractionOne-bb)
theta[n] = aa
vv[0] = aa
for k = 1; k <= n-1; k++ {
	vv[k] = vv[k] + takeFraction(aa, ww[k])
}
goto found

@ 함수 |reduceAngle|은 각을 $\pm180^\circ$ 범위로 줄인다.

@<정의@>=
func reduceAngle(a angle) angle {
	if abs(a) > oneEightyDeg {
		if a > 0 {
			return a - threeSixtyDeg
		}
		return a + threeSixtyDeg
	}
	return a
}

@ @<$\theta_n$의 주어진 값을...@>=
theta[n] = reduceAngle(leftGiven(s) - nArg(deltaX[n-1], deltaY[n-1]))
goto found

@ @<$\theta_0$의 주어진 값에...@>=
vv[0] = reduceAngle(rightGiven(s) - nArg(deltaX[0], deltaY[0]))
uu[0] = 0
ww[0] = 0

@ 긴장이 둘 다 1이면 $\alpha=\beta=1$이므로 아래 함수 |curlRatio|의 값은 $(2\gamma+1)/(\gamma+2)$로
간단해진다.

@<$\theta_0$에서 휨의...@>=
cc = rightCurl(s)
lt = abs(leftTension(t))
rt = abs(rightTension(s))
if rt == unity && lt == unity {
	uu[0] = makeFraction(cc+cc+unity, cc+two)
} else {
	uu[0] = curlRatio(cc, rt, lt)
}
vv[0] = -takeFraction(psi[1], uu[0])
ww[0] = 0

@ @<$\theta_n$에서 휨의...@>=
cc = leftCurl(s)
lt = abs(leftTension(s))
rt = abs(rightTension(r))
if rt == unity && lt == unity {
	ff = makeFraction(cc+cc+unity, cc+two)
} else {
	ff = curlRatio(cc, lt, rt)
}
theta[n] = -makeFraction(takeFraction(vv[n-1], ff), fractionOne-takeFraction(ff, uu[n-1]))
goto found

@ 서브루틴 |curlRatio|는 인자가 셋인데, 앞의 표기를 따르면 $\gamma$, $\alpha^{-1}$, $\beta^{-1}$이라고
부르는 것이 자연스럽다. 이것은
$${(3-\alpha)\alpha^2\gamma+\beta^3\over
  \alpha^3\gamma+(3-\beta)\beta^2}$$
을 계산하는 조금 지루한 프로그램이고, 결과가 4를 넘으면 4로 줄인다. (이렇게 휨을 줄이는 것은 휨과
긴장이 둘 다 클 때에만 필요하다.) 또 $\alpha$와 $\beta$의 값은 많아야~4/3이다.

@<함수들@>=
func curlRatio(gamma, aTension, bTension scaled) fraction {
	var alpha, beta, num, denom, ff fraction // 레지스터들
	alpha = makeFraction(unity, aTension)
	beta = makeFraction(unity, bTension)
	if alpha <= beta {
		ff = makeFraction(alpha, beta)
		ff = takeFraction(ff, ff)
		gamma = takeFraction(gamma, ff)
		beta = beta / 0o10000 // |fraction|을 |scaled|로 바꾼다
		denom = takeFraction(gamma, alpha) + three - beta
		num = takeFraction(gamma, fractionThree-alpha) + beta
	} else {
		ff = makeFraction(beta, alpha)
		ff = takeFraction(ff, ff)
		beta = takeFraction(beta, ff) / 0o10000 // |fraction|을 |scaled|로 바꾼다
		denom = takeFraction(gamma, alpha) + (ff / 1365) - beta // $1365\approx 2^{12}/3$
		num = takeFraction(gamma, fractionThree-alpha) + beta
	}
	if num >= denom+denom+denom+denom {
		return fractionFour
	}
	return makeFraction(num, denom)
}

@ 이제 마지막 직선 주로다. 뒤에서부터 대입해서 $\theta_k$를 모두 구한 다음, 각 조각의 양 끝 각
$\theta_k$와 $\phi\k=-\psi\k-\theta\k$의 사인과 코사인으로 조절점을 놓는다.

@<각 고르기를 마치고...@>=
for k = n - 1; k >= 0; k-- {
	theta[k] = vv[k] - takeFraction(theta[k+1], uu[k])
}
s = p
k = 0
for {
	t = link(s)
	nSinCos(theta[k])
	st = nSin
	ct = nCos
	nSinCos(-psi[k+1] - theta[k+1])
	sf = nSin
	cf = nCos
	setControls(s, t, k)
	k++
	s = t
	if k == n {
		break
	}
}

@ 루틴 |setControls|는 이웃한 노드 |p|와~|q| 한 쌍에 실제로 조절점을 넣는다. 이 계산에 필요한
$\sin\theta$, $\cos\theta$, $\sin\phi$, $\cos\phi$의 값은 전역 변수에 기록해 둔다.

@<전역 변수@>=
var @!st, @!ct, @!sf, @!cf fraction // 사인과 코사인

@ 조절점의 공식은 앞에서 본 $z_k^+=z_k+{1\over3}\rho_ke^{i\theta_k}(z\k-z_k)$를 좌표로 풀어 쓴 것이다.
함수 |velocity|가 $\rho_k/3$을 돌려주므로(\secref{velocity}) 따로 3으로 나눌 필요가 없다.

@<함수들@>=
func setControls(p, q pointer, k int32) {
	var rr, ss fraction // 긴장의 세 배로 나눈 속도
	var lt, rt scaled // 긴장
	var sine fraction // $\sin(\theta+\phi)$
	lt = abs(leftTension(q))
	rt = abs(rightTension(p))
	rr = velocity(st, ct, sf, cf, rt)
	ss = velocity(sf, cf, st, ct, lt)
	if rightTension(p) < 0 || leftTension(q) < 0 {
		@<필요하면 속도를 줄여서 경계 삼각형 안에 머무르게 한다@>
	}
	setRightX(p, xCoord(p)+takeFraction(takeFraction(deltaX[k], ct)-takeFraction(deltaY[k], st), rr))
	setRightY(p, yCoord(p)+takeFraction(takeFraction(deltaY[k], ct)+takeFraction(deltaX[k], st), rr))
	setLeftX(q, xCoord(q)-takeFraction(takeFraction(deltaX[k], cf)+takeFraction(deltaY[k], sf), ss))
	setLeftY(q, yCoord(q)-takeFraction(takeFraction(deltaY[k], cf)-takeFraction(deltaX[k], sf), ss))
	setRightType(p, explicit)
	setLeftType(q, explicit)
}

@ 유계 조건 $\\{rr}\le\sin\phi\,/\sin(\theta+\phi)$와 $\\{ss}\le\sin\theta\,/\sin(\theta+\phi)$는
$\sin\theta$, $\sin\phi$, $\sin(\theta+\phi)$가 모두 부호가 같을 때 지켜야 한다. 그렇지 않으면 ``경계
삼각형''이 없다. 경계 삼각형이란 두 매듭과, 두 매듭에서 그은 접선의 교점이 이루는 삼각형이다.
명세 \.{tension atleast}는 곡선이 이 삼각형 밖으로 불룩 나가지 않게 하라는 뜻이다.

@<필요하면 속도를 줄여서...@>=
if (st >= 0 && sf >= 0) || (st <= 0 && sf <= 0) {
	sine = takeFraction(abs(st), cf) + takeFraction(abs(sf), ct)
	if sine > 0 {
		sine = takeFraction(sine, fractionOne+unity) // 안전 계수
		if rightTension(p) < 0 {
			if abVsCd(abs(sf), fractionOne, rr, sine) < 0 {
				rr = makeFraction(abs(sf), sine)
			}
		}
		if leftTension(q) < 0 {
			if abVsCd(abs(st), fractionOne, ss, sine) < 0 {
				ss = makeFraction(abs(st), sine)
			}
		}
	}
}

@ 간단한 경우들만 남았다.

@<주어진 방향 둘의...@>=
aa = nArg(deltaX[0], deltaY[0])
nSinCos(rightGiven(p) - aa)
ct = nCos
st = nSin
nSinCos(leftGiven(q) - aa)
cf = nCos
sf = -nSin
setControls(p, q, 0)
return

@ 직선의 조절점은 현을 삼등분하는 두 점이다. 긴장이 1이 아니면 그 점들을 매듭 쪽으로 당긴다.
삼등분할 때 $\pm1$을 더하는 것은 나눗셈을 0에서 먼 쪽으로 반올림해서 결과가 부호에 대해 대칭이 되게
하려는 것이다.

@<직선이라는 간단한...@>=
setRightType(p, explicit)
setLeftType(q, explicit)
lt = abs(leftTension(q))
rt = abs(rightTension(p))
if rt == unity {
	if deltaX[0] >= 0 {
		setRightX(p, xCoord(p)+((deltaX[0]+1)/3))
	} else {
		setRightX(p, xCoord(p)+((deltaX[0]-1)/3))
	}
	if deltaY[0] >= 0 {
		setRightY(p, yCoord(p)+((deltaY[0]+1)/3))
	} else {
		setRightY(p, yCoord(p)+((deltaY[0]-1)/3))
	}
} else {
	ff = makeFraction(unity, 3*rt) // $\alpha/3$
	setRightX(p, xCoord(p)+takeFraction(deltaX[0], ff))
	setRightY(p, yCoord(p)+takeFraction(deltaY[0], ff))
}
if lt == unity {
	if deltaX[0] >= 0 {
		setLeftX(q, xCoord(q)-((deltaX[0]+1)/3))
	} else {
		setLeftX(q, xCoord(q)-((deltaX[0]-1)/3))
	}
	if deltaY[0] >= 0 {
		setLeftY(q, yCoord(q)-((deltaY[0]+1)/3))
	} else {
		setLeftY(q, yCoord(q)-((deltaY[0]-1)/3))
	}
} else {
	ff = makeFraction(unity, 3*lt) // $\beta/3$
	setLeftX(q, xCoord(q)-takeFraction(deltaX[0], ff))
	setLeftY(q, yCoord(q)-takeFraction(deltaY[0], ff))
}
return

@* 이산 움직임 만들기.
\MF의 다음 부분의 목적은 매개변수 다항 함수 $z(t)$로 기술된 곡선의 이산 근사를 계산하는 것이다.
높은 수준의 구성을 떠받치려면 효율적인 ``엔진''이 필요하므로 낮은 수준부터 시작하자.

서브루틴들은 대부분 한 가지 주제, 곧 {\sl 이분법\/}의 변주를 바탕으로 한다. 번스타인 다항식
@^Bernshte{\u\i}n, Serge{\u\i} Natanovich@>
$$B(z_0,z_1,\ldots,z_n;t)=\sum_k{n\choose k}t^k(1-t)^{n-k}z_k$$
이 주어지면 그 범위를 다음과 같이 편리하게 둘로 나눌 수 있다.

\smallskip
\textindent{1)} 모든 |0<=k<=n|에 대해 $z_k^{(0)}=z_k$로 놓는다.

\smallskip
\textindent{2)} 각 |0<=j<n|과 |0<=k<n-j|에 대해 $z_k^{(j+1)}={1\over2}(z_k^{(j)}+z\k^{(j)})$로 놓는다.

\smallskip\noindent
그러면
$$B(z_0,z_1,\ldots,z_n;t)=B(z_0^{(0)},z_0^{(1)},\ldots,z_0^{(n)};2t)
 =B(z_0^{(n)},z_1^{(n-1)},\ldots,z_n^{(0)};2t-1)$$
이다. 이 공식은 범위 $0\le t\le{1\over2}$와 ${1\over2}\le t\le1$에서 쓸 다항식의 계수를 준다.

이것은 흔히 드 카스텔조(de Casteljau)의 알고리즘이라고 부르는 것이다. 삼차($n=3$)의 경우를 그림으로
보면 이렇다. 이웃한 조절점의 가운뎃점을 거듭 잡아 나가면 맨 마지막 가운뎃점 $z_0^{(3)}$이 곡선의
한가운데 점 $B({1\over2})$가 되고, 왼쪽 반의 조절점은 $z_0^{(0)}$, $z_0^{(1)}$, $z_0^{(2)}$,
$z_0^{(3)}$이고 오른쪽 반의 조절점은 $z_0^{(3)}$, $z_1^{(2)}$, $z_2^{(1)}$, $z_3^{(0)}$이다.
$$\mplibcode
beginfig(12);
save u, a, b, c, d, ab, bc, cd, abc, bcd, m; numeric u;
pair a, b, c, d, ab, bc, cd, abc, bcd, m; u := 32pt;
a := (0,0); b := (1u, 3u); c := (5u, 3.4u); d := (6.5u, .3u);
ab := .5[a,b]; bc := .5[b,c]; cd := .5[c,d];
abc := .5[ab,bc]; bcd := .5[bc,cd]; m := .5[abc,bcd];
draw a--b--c--d withcolor .7white;
draw ab--bc--cd withcolor .7white;
draw abc--bcd withcolor .7white;
draw a..controls b and c..d withpen pencircle scaled 1pt;
dot(a); dot(d); odot(b); odot(c); odot(ab); odot(bc); odot(cd); odot(abc); odot(bcd); dot(m);
label.bot(btex $z_0$ etex, a); label.ulft(btex $z_1$ etex, b);
label.urt(btex $z_2$ etex, c); label.bot(btex $z_3$ etex, d);
label.lft(btex $z_0^{(1)}$ etex, ab); label.top(btex $z_1^{(1)}$ etex, bc);
label.rt(btex $z_2^{(1)}$ etex, cd);
label.lft(btex $z_0^{(2)}$ etex, abc); label.rt(btex $z_1^{(2)}$ etex, bcd);
label.bot(btex $z_0^{(3)}$ etex, m);
endfig;
\endmplibcode$$

우리의 응용에서는 다항식의 값을 실제로 계산하지 않고도 다항식의 관련 성질을 이끌어 낼 수 있는 수들로
간접적으로 일할 수 있을 때가 대부분일 것이다. 실제 수 $z_0$, $z_1$, \dots,~$z_n$ 대신 |1<=k<=n|에 대해
계수 $Z_k=2^l(z_k-z_{k-1})$을 다룰 것이고, |l|의 값은 이분할 때마다 1씩 늘어난다. 이 기법은 이분에
필요한 계산의 양을 줄이고 계산의 정확도도 높인다(이분할 때마다 정밀도 한 비트를 얻기 때문이다). 실제로
이분 과정은 이제 한 단계 짧아진다.

\smallskip
\textindent{$1'$)} 모든 |1<=k<=n|에 대해 $Z_k^{(1)}=Z_k$로 놓는다.

\smallskip
\textindent{$2'$)} 각 |1<=j<n|과 |1<=k<=n-j|에 대해 $Z_k^{(j+1)}={1\over2}(Z_k^{(j)}+Z\k^{(j)})$로 놓는다.

\smallskip\noindent
이분한 뒤의 두 부분 구간을 위한 계수 $(Z'_1,\ldots,Z'_n)$과 $(Z''_1,\ldots,Z''_n)$은 각각
$$(Z_1^{(1)},Z_1^{(2)},\ldots,Z_1^{(n)}),\qquad(Z_1^{(n)},Z_2^{(n-1)},\ldots,Z_n^{(1)})$$
이다. 그리고
이분한 구간에 알맞은 $z_0$의 값은 $z'_0=z_0$과 $z''_0=z_0+(Z'_1+Z'_2+\cdots+Z'_n)/2^{l+1}$이다.

단계 $2'$에는 2로 나누는 일이 들어 있어서 단계마다 많아야 $1\over2$의 계산 오차가 생긴다. 그러므로 이분을
$l$~단계 하고 나면 정수 $Z_k$는 참값과 많아야 $(n-1)l/2$만큼 다르다. 계수 $Z$가 $z$보다 정밀도 비트를 $l$개
더 가진다는 것을 생각하면 이 오차율은 충분히 받아들일 만하다. 또한 $Z$는 유계로 머문다는 데 주목하라.
임의로 큰~$l$에 대해 항등식 $Z_k=2^l(z_k-z_{k-1})$이 성립하는데도 정수 넘침의 위험이 없다.

사실 $Z$가 유계로 머문다는 것만이 아니라 거의 같아진다는 것도 보일 수 있다. 계수 $Z$들은 차수가 하나 낮은
다항식의 조절점이기 때문이다. 처음에 $\vert Z\k-Z_k\vert\le M$이면, 반올림 오차가 있더라도 이분을
$l$~단계 하고 나면 $\vert Z\k-Z_k\vert\le\lceil M/2^l\rceil$임을 증명할 수 있다. 증명은 다음과 같다[레인과
리센펠드, {\sl IEEE Trans.\ on Pattern Analysis and Machine Intelligence\/ \bf PAMI-2} (1980), 35--46 참조].
@^Lane, Jeffrey Michael@>
@^Riesenfeld, Richard Franklin@>
이분하기 전에 $\vert Z\k-Z_k\vert\le M$이라고 가정하고, 이분한 뒤에 $\vert Z\k-Z_k\vert\le\lceil M/2\rceil$임을
증명하고 싶다. 먼저 $j$에 대한 귀납법으로 모든 $j$와~$k$에 대해 $\vert Z\k^{(j)}-Z_k^{(j)}\vert\le M$임을
보인다. 이것은 반올림 규칙 $\\{half}(x)=\lfloor x/2\rfloor$와 $\\{half}(x)={\rm sign}(x)\lfloor\vert x/2\vert\rfloor$
둘 다에 대해
$$\bigl\vert\\{half}(a+b)-\\{half}(b+c)\bigr\vert\le
 \max\bigl(\vert a-b\vert,\vert b-c\vert\bigr)$$
가 성립한다는 사실에서 나온다. (두 값 $\vert a-b\vert$와 $\vert b-c\vert$가 같으면 $a+b$와 $b+c$는 둘 다 짝수이거나
둘 다 홀수다. 반올림 오차는 서로 지워지거나 두 수를 서로 가까워지게 한다. 그러므로
$$\eqalign{\bigl\vert\\{half}(a+b)-\\{half}(b+c)\bigr\vert
&\le\textstyle\bigl\vert{1\over2}(a+b)-{1\over2}(b+c)\bigr\vert\cr
&=\textstyle\bigl\vert{1\over2}(a-b)+{1\over2}(b-c)\bigr\vert
\le\max\bigl(\vert a-b\vert,\vert b-c\vert\bigr)\cr}$$
가 되어 원하는 대로다. 두 값 $\vert a-b\vert$와 $\vert b-c\vert$가 다르면 더 간단한 논증이 통한다.) 이제
$\vert Z_1^{(j+1)}-Z_1^{(j)}\vert\le\bigl\lfloor{1\over2}\vert Z_2^{(j)}-Z_1^{(j)}\vert+{1\over2}\bigr\rfloor
\le\bigl\lfloor{1\over2}(M+1)\bigr\rfloor=\lceil M/2\rceil$임을 쉽게 알 수 있다.

이분에 관한 또 하나의 재미있는 사실은 항등식
$$Z_1'+\cdots+Z_n'+Z_1''+\cdots+Z_n''=2(Z_1+\cdots+Z_n+E)$$
다. 여기서 $E$는 반으로 나누는 연산들에서 생긴 반올림 오차의 합이다($\vert E\vert\le n(n-1)/4$).

@ \seclabel{rook-moves}우리는 나중에 복소 삼차식 $z(t)=B(z_0,z_1,z_2,z_3;t)$를 화소화하는 문제를 다음의 더 간단한
문제로 줄일 것이다. 단조 비감소인 두 실수 삼차식 $x(t)=B(x_0,x_1,x_2,x_3;t)$와 $y(t)=B(y_0,y_1,y_2,y_3;t)$가
주어질 때, 정수 점들의 집합
$$P=\bigl\{\bigl(\lfloor x(t)\rfloor,\lfloor y(t)\rfloor\bigr)
\bigm\vert 0\le t\le 1\bigr\}$$
을 정하라. 그런데 문제는 실은 이렇게 깔끔하지 않다. 경로가 정수 점 $(a,b)$를 아주 가까이 지나가면,
계산 오차 때문에 $P$에 실제로는 $(a,b-1)$이 들어가야 하는데 $(a-1,b)$가 들어 있다고 생각할 수도 있다.
게다가 경로가 정수 점 $(a-1,b-1)$과 $(a,b)$를 {\sl 정확히\/} 지나간다면, $P$가 위나 오른쪽으로 가는
``룩 움직임''(rook move)만으로 기술될 수 있도록 두 점 $(a-1,b)$나 $(a,b-1)$ 가운데 하나를 $P$가 담기를
바랄 것이다. 점 $(a-1,b-1)$에서 $(a,b)$로 가는 대각선 움직임은 허용하지 않는다.

그러므로 우리가 계산하려는 집합 $P$는 위 공식에 기술된 집합의 근사일 뿐이다. 그것은 오른쪽 움직임
$\lfloor x(1)\rfloor-\lfloor x(0)\rfloor$번과 위쪽 움직임 $\lfloor y(1)\rfloor-\lfloor y(0)\rfloor$번이 어떤
순서로 섞인 것으로 이루어진다. 우리가 할 일은 알맞은 순서를 알아내는 것이다.

아래 그림에서 회색 칸들이 곡선이 지나가는 칸들의 집합 $P$이고, 칸의 가운데를 잇는 계단이 룩 움직임의
나열이다. 위로 한 칸, 오른쪽으로 한 칸씩만 움직이므로 계단은 언제나 회색 칸들 위로만 지나간다.
$$\mplibcode
beginfig(13);
save u, c, zz, i, j, pi, pj, st; numeric u, i, j, pi, pj; path c, st; pair zz; u := 22pt;
c := (.3,.4){dir 10}..(2.6,1.3)..(4.2,3.1)..{dir 70}(5.6,5.5);
pi := floor xpart point 0 of c; pj := floor ypart point 0 of c;
st := (pi+.5, pj+.5);
for t = 0 step 1/600 until length c:
  zz := point t of c;
  i := floor xpart zz; j := floor ypart zz;
  fill ((0,0)--(1,0)--(1,1)--(0,1)--cycle) shifted (i,j) scaled u withcolor .85white;
  if (i<>pi) or (j<>pj): st := st -- (i+.5, j+.5); pi := i; pj := j; fi
endfor
for i = 0 upto 6: draw (i*u,0)--(i*u,6u) withpen pencircle scaled .2pt; endfor
for j = 0 upto 6: draw (0,j*u)--(6u,j*u) withpen pencircle scaled .2pt; endfor
draw c scaled u withpen pencircle scaled 1.1pt;
draw st scaled u withpen pencircle scaled .5pt dashed evenly;
endfig;
\endmplibcode$$

이때 $x(0)=x_0$, $x(1)=x_3$, $y(0)=y_0$, $y(1)=y_3$임을 떠올리면 다음의 재귀적 전략이 저절로 떠오른다.

\smallskip
만일 $\lfloor x_0\rfloor=\lfloor x_3\rfloor$이면 위로 $\lfloor y_3\rfloor-\lfloor y_0\rfloor$걸음 간다.

그렇지 않고 $\lfloor y_0\rfloor=\lfloor y_3\rfloor$이면 오른쪽으로 $\lfloor x_3\rfloor-\lfloor x_0\rfloor$걸음 간다.

그렇지 않으면 현재의 삼차식들을 이분하고 두 반쪽에 같은 과정을 되풀이한다.

\yskip\noindent
직관에 호소하는 이 공식화는 문제를 완전히 풀지는 못한다. 결코 끝나지 않을 수도 있기 때문이다. 이를테면
$(x_0,x_1,x_2,x_3)=(y_0,y_1,y_2,y_3)$이면 한 걸음도 {\sl 결코\/} 가지 않는다는 것을 알기는 어렵지 않다!
그러나 조금만 조심하면 이 어려움을 이겨 낼 수 있다. 그러니 그런 세부를 걱정하기 전에 말한 대로의
알고리즘에 살을 붙여 나가자.

앞에서 논의한 이분하고 두 배 하기 전략을 따르면 $(x_0,x_1,x_2,x_3)$을 $(X_1,X_2,X_3)$으로 나타내는 것이
좋겠다. 여기서 어떤~$l$에 대해 $X_k=2^l(x_k-x_{k-1})$이다. 좌표 $x$가 |scaled|이므로 처음에는 $l=16$이다.
알고리즘의 다른 면을 다루려면 양 $m=\lfloor x_3\rfloor-\lfloor x_0\rfloor$와 $R=2^l(x_0\bmod 1)$도 유지하고
싶을 것이다. 비슷하게 $(y_0,y_1,y_2,y_3)$은 $(Y_1,Y_2,Y_3)$과 $n=\lfloor y_3\rfloor-\lfloor y_0\rfloor$와
$S=2^l(y_0\bmod 1)$로 나타낸다. 그러면 알고리즘은 이제 다음 꼴이 된다.

\smallskip
만일 $m=0$이면 위로 $n$걸음 간다.

그렇지 않고 $n=0$이면 오른쪽으로 $m$걸음 간다.

그렇지 않으면 현재의 삼차식들을 이분하고 두 반쪽에 같은 과정을 되풀이한다.

\smallskip\noindent
값 $(X_1,X_2,X_3,m,R,l)$의 이분 과정은 본질적으로 다음 공식들로 줄어든다.
$$\vbox{\halign{$#\hfil$\cr
X_2'=\\{half}(X_1+X_2),\quad
X_2''=\\{half}(X_2+X_3),\quad
X_3'=\\{half}(X_2'+X_2''),\cr
X_1'=X_1,\quad
X_1''=X_3',\quad
X_3''=X_3,\cr
R'=2R,\quad
T=X_1'+X_2'+X_3'+R',\quad
R''=T\bmod 2^{l+1},\cr
m'=\lfloor T/2^{l+1}\rfloor,\quad
m''=m-m'.\cr}}$$

@ 특히 $m=n=1$이면 두 갈래, 곧 (위,\thinspace 오른쪽)과 (오른쪽,\thinspace 위) 가운데 하나를 고르기만 하면
되므로 계산을 빠르게 할 수 있다. 그런데 $(X_1,X_2,X_3,R)$과 $(Y_1,Y_2,Y_3,S)$의 값을 보고 옳은 결정을 내리는
간단하고 직접적인 방법은 없는 것 같다. 그러나 이분 과정을 간소하게 할 수는 있고, 이분할 때마다 두
자손 가운데 하나만 살펴보면 된다는 사실을 이용할 수 있다. 게다가 앞에서 관찰했듯이 이분을 여러 단계
하고 나면 $X$들과 $Y$들은 거의 같아지므로, 곡선이 본질적으로 직선이라고 가정해도 된다. (덧붙여 이것이
앞에서 말한 끝없는 재귀의 문제를 푼다.)

$$m=\bigl\lfloor(X_1+X_2+X_3+R+E)\,/\,2^l\bigr\rfloor$$
임을 보일 수 있다. 여기서 $E$는 쌓인 반올림 오차로서 그 절댓값은 많아야 $3\cdot(2^{l-16}-1)$이다. 우리는
$X$들이 $2^{28}$보다 작도록 할 것이다. 그러므로 $l=30$이면 |m<=1|이어야 한다. 이것은 $l=30$이 될 때까지는
특별한 경우 $m=n=1$에 반드시 이른다는 것을 증명한다. 게다가 재귀가 아직 잦아들지 않았다면 $l=30$은 직선
근사를 하기에 알맞은 때다. 그때 $X$들 사이의 최대 차이는 $<2^{14}$이고, 이것은 원래의 눈금으로 $<1$의
오차에 해당하기 때문이다. (달리 말하면, 이분할 때마다 곡선은 직선에 두 비트씩 가까워지므로, 28비트
정확도에는 이분 14번이면 충분하다.)

직선인 경우, 곡선이 먼저 오른쪽으로 가고 그다음 위로 가는 것은 $(T-2^l)(2^l-S)>(U-2^l)(2^l-R)$일 때,
그리고 오직 그때뿐이다. 여기서 $T=X_1+X_2+X_3+R$이고 $U=Y_1+Y_2+Y_3+S$이다. 실제 곡선은 본질적으로
$(R/2^l,S/2^l)$에서 $(T/2^l,U/2^l)$로 가므로, 우리는 $(1,1)$이 이 두 점을 잇는 직선보다 위에 있는지를
검사하는 것이다. (이 공식은 $(1,1)$이 정확히 그 직선 위에 있지 않다고 가정한다.)

@ 삼차 곡선이 정수 점을 정확히 지나가는 애매한 경우에 동점을 깨는 문제를 우리는 대충 넘어갔다. \MF는
좌표 $(x,y)$가 실은 조금 흔든 값 $(x+\xi,y+\eta)$를 나타낸다고 가정해서 이 문제를 교묘히 피한다. 여기서
$\xi$와~$\eta$는 무한소인데, 그 부호가 $x$나~$y$가 정확한 정수일 때 무엇을 할지 정한다. 앞의 공식들에서
$\lfloor x\rfloor$와~$\lfloor y\rfloor$는 실은 $\lfloor x+\xi\rfloor$와 $\lfloor y+\eta\rfloor$로 읽어야 한다.

좌표 $x$가 |scaled| 값이면 $\xi>0$일 때 $\lfloor x+\xi\rfloor=\lfloor x\rfloor$이고, $\xi<0$일 때
$\lfloor x+\xi\rfloor=\lfloor x-2^{-16}\rfloor$이다. 무한소 $\xi$를 정수 |xiCorr|로 나타내면 편리한데, 이것은
$\xi>0$이면~0, $\xi<0$이면~1로 정의한다. 그러면 이를테면 정수 $\lfloor x+\xi\rfloor$는
|floorUnscaled(x-xiCorr)|로 계산할 수 있다. 비슷하게 $\eta$는 |etaCorr|로 나타내면 편리하다.

우리의 응용에서 $\xi-\eta$의 부호는 언제나 $\xi$의 부호와 같다. 그러므로 동점인 경우에는 앞에서 말한
직선의 규칙을 다음과 같이 고쳐야 한다. 직선이 먼저 오른쪽으로 가고 그다음 위로 가는 것은
$(T-2^l)(2^l-S)+\xi>(U-2^l)(2^l-R)$일 때, 그리고 오직 그때뿐이다. 그리고 이 관계는
|abVsCd|$(T-2^l,2^l-S,U-2^l,2^l-R)-|xiCorr|\ge0$일 때, 그리고 오직 그때에만 성립한다.

이 반올림 관례는 대칭이다. 곧 산술이 정확하다면 $(x_0,x_1,x_2,x_3,y_0,y_1,y_2,y_3,\xi,\eta)$에서 얻는
화소화된 움직임은 $(-x_3,-x_2,-x_1,-x_0,-y_3,-y_2,-y_1,-y_0,-\xi,-\eta)$에서 얻을 움직임과 정확히 서로
보완하는 것이 된다. 그러나 이분 과정의 잘라내기 오차가 대칭을 깨뜨릴 수도 있다. 데이터를 반으로 나눌 때
|xiCorr|나 |etaCorr|를 더하면 잃어버린 대칭의 상당 부분을 되찾을 수 있다.

@ 또 하나의 가능성을 말해 두어야 한다. 이 알고리즘은 $t$가 0에서 1로 바뀔 때 비감소인 삼차 다항식
$B(x_0,x_1,x_2,x_3;t)$에만 적용된다. 이 조건은 $x_0\le x_1$이고 $x_2\le x_3$이며, $x_1\le x_2$이거나
$(x_1-x_2)^2\le(x_1-x_0)(x_3-x_2)$일 때, 그리고 오직 그때에만 성립한다. 이분을 완벽하게 정확히 한다면 이
관계들은 불변으로 남을 것이다. 그러나 반올림 오차가 끼어들 수 있으므로, 이분 알고리즘이 단조인 처음
조건에서 단조가 아닌 부분 문제를 만들어 낼 수 있다. 그러면 앞에서 기술한 알고리즘에서 $m$이나~$n$이
음수가 될 잠재적 위험이 생긴다.

이를테면 $(x_1-x_0,x_2-x_1,x_3-x_2)=(X_1,X_2,X_3)=(7,-16,39)$로 시작하면 $16^2<7\cdot39$이므로 해당하는
다항식은 단조다. 그러나 이분 알고리즘은 왼쪽 자손 $(7,-5,3)$을 만드는데, 이것은 단조가 아니다. 그
오른쪽 자손은~$(0,-1,3)$이다.

\def\xt{{\tilde x}}
다행히 이런 반올림 오차가 알고리즘을 비극적인 실수로 이끄는 일은 결코 없다는 것을 증명할 수 있다. 모든
단계에서 우리는 어떤 단조 다항식 $B(x_0,x_1,x_2,x_3)$을 근사하는 삼차 다항식 $B(\xt_0,\xt_1,\xt_2,\xt_3)$에
해당하는 수들을 다룬다. 쌓인 오차는 $\vert x_k-\xt_k\vert<\epsilon=3\cdot2^{-16}$이 되도록 다스려진다.
재귀의 어떤 단계에서 이분을 한다면 $m=\lfloor\xt_3\rfloor-\lfloor\xt_0\rfloor>0$이고, 알고리즘은
$m'=\lfloor\bar x\rfloor-\lfloor\xt_0\rfloor$이고 $m''=\lfloor\xt_3\rfloor-\lfloor\bar x\rfloor$가 되는 이분 값
$\bar x$를 계산한다. 우리는 $m'$도 $m''$도 음수일 수 없음을 증명하고 싶다. 값 $\bar x$는 구간 $[x_0,x_3]$의
어떤 값의 근사이므로 $\bar x>x_0-\epsilon$이고 $\bar x<x_3+\epsilon$이며, 따라서 $\bar x>\xt_0-2\epsilon$이고
$\bar x<\xt_3+2\epsilon$이다. 만일 $m'$이 음수라면 $\xt_0\bmod 1<2\epsilon$이어야 하고, $m''$이 음수라면
$\xt_3\bmod 1>1-2\epsilon$이어야 한다. 어느 경우든 조건 $\lfloor\xt_3\rfloor-\lfloor\xt_0\rfloor>0$에서
$\xt_3-\xt_0>1-2\epsilon$이 나오고, 따라서 $x_3-x_0>1-4\epsilon$이다. 그러나 $B(x_0,x_1,x_2,x_3;t)$가 단조
삼차식이면 $B(x_0,x_1,x_2,x_3;{1\over2})$는 언제나 $.06[x_0,x_3]$과 $.94[x_0,x_3]$ 사이에 있음을 보일 수 있다.
그리고 $\bar x$가 그런 수의 $\epsilon$ 안에 있는 것은 불가능하다. 모순이다! (상수 .06은 실은
$(2-\sqrt3\,)/4$이다. 가장 나쁜 경우는 $B(0,2-\sqrt3,1-\sqrt3,3;t)$ 같은 다항식에서 일어난다.)

@ 좋다. 긴 이론적 서론으로 이분하고 두 배 하기 알고리즘이 정당하다는 것을 밝혔으니, 이제 실제로 짤 준비가
되었다. 그러나 출력의 꼴은 아직 논의하지 않았다.

나중에 논의할 까닭으로, 출력은 다음과 같이 기록하면 편리하다. 위로 한 걸음 가는 것은 목록에 `1'을
덧붙이는 것으로 나타내고, 오른쪽으로 한 걸음 가는 것은 목록의 끝에 있는 원소에 1을 더하는 것으로
나타낸다. 이를테면 ``(위, 오른쪽, 오른쪽, 위, 오른쪽)''의 최종 효과는 $(3,2)$를 덧붙이는 것이다. 목록의
원소 하나는 곧 한 행(row)에서 오른쪽으로 간 거리에 1을 더한 것이다.

이 목록은 |move|라는 전역 배열에 둔다. 알고리즘을 시작하기 전에 \MF는 이 목록이 배열의 경계를 넘지 않도록
$\\{movePtr}+\lfloor y_3\rfloor-\lfloor y_0\rfloor\le\\{moveSize}$인지 검사해야 한다.

@<전역 변수@>=
var @!move [moveSize + 1]int32 // 기록한 움직임들
var @!movePtr int32 // |move| 목록에 든 항목의 수; |0 .. moveSize|

@ 이분이 일어나면 오른쪽 부분 구간에 해당하는 부분 문제를 |bisectStack|에 ``밀어 넣고'', 우리는 왼쪽
부분 구간에 대해 계속 일한다. 그러므로 |bisectStack|에는 아직 손대지 않은 부분 문제의
$(X_1,X_2,X_3,R,m,Y_1,Y_2,Y_3,S,n,l)$ 값들이 들어 있다.

스택에는 한꺼번에 많아야 부분 문제 15개가 있다(곧 $l=15$,~16, \dots,~29에 대해서다). 그러나 이 스택은 더
복잡한 이분 알고리즘에도 쓰이므로 그보다 크다.

스택에 넣는 각 양의 자리는 |bisectPtr|에서의 오프셋으로 나타낸다. 이를테면 쌓인 $X_1$의 값은
|bisectStack[bisectPtr+stackX1]|이다.

@<정의@>=
const (
	@!stackX1 = iota // 쌓인 $X_1$의 값
	@!stackX2 // 쌓인 $X_2$의 값
	@!stackX3 // 쌓인 $X_3$의 값
	@!stackR // 쌓인 $R$의 값
	@!stackM // 쌓인 $m$의 값
	@!stackY1 // 쌓인 $Y_1$의 값
	@!stackY2 // 쌓인 $Y_2$의 값
	@!stackY3 // 쌓인 $Y_3$의 값
	@!stackS // 쌓인 $S$의 값
	@!stackN // 쌓인 $n$의 값
	@!stackL // 쌓인 $l$의 값
	@!moveIncrement // |makeMoves|가 밀어 넣는 항목의 수
)

@ @<전역 변수@>=
var @!bisectStack [bistackSize + 1]int32
var @!bisectPtr int32 // |0 .. bistackSize|

@ @<``상수'' 값들이...@>=
if 15*moveIncrement > bistackSize {
	bad = 31
}

@ 서브루틴 |makeMoves|는 단조 비감소 다항식을 나타내는 |scaled| 값 $(x_0,x_1,x_2,x_3)$과 $(y_0,y_1,y_2,y_3)$을
받는다. 이것은 앞에서 설명한 대로 오른쪽 움직임 $\lfloor x_3+\xi\rfloor-\lfloor x_0+\xi\rfloor$번과 위쪽 움직임
$\lfloor y_3+\eta\rfloor-\lfloor y_0+\eta\rfloor$번을 만든다. (여기서 $\lfloor x+\xi\rfloor$는 $x$를 눈금 없는
정수로 볼 때 실은 $\lfloor x/2^{16}-|xiCorr|\rfloor$를 뜻한다.) 눈금 없는 정수 $x_k$와~$y_k$의 절댓값은
$2^{28}$보다 작아야 한다.

이 프로시저를 부를 때는 $|movePtr| + \lfloor y_3+\eta\rfloor - \lfloor y_0+\eta\rfloor < |moveSize|$라고
가정하므로 배열 |move|의 용량을 넘지 않는다.

이 프로시저의 변수 |r|과 |s|는 앞에서 논의한 이론의 $R-|xiCorr|$과 $S-|etaCorr|$을 나타낸다.

@<함수들@>=
func makeMoves(xx0, xx1, xx2, xx3, yy0, yy1, yy2, yy3 scaled, xiCorr, etaCorr smallNumber) {
	var x1, x2, x3, m, r, y1, y2, y3, n, s, l int32 // 앞에서 설명한 이분 변수들
	var q, t, u, x2a, x3a, y2a, y3a int32 // 추가 임시 레지스터들
	if xx3 < xx0 || yy3 < yy0 {
		confusion("m")
	}
@:this can't happen m}{\quad m@>
	l = 16
	bisectPtr = 0
	x1 = xx1 - xx0
	x2 = xx2 - xx1
	x3 = xx3 - xx2
	if xx0 >= xiCorr {
		r = (xx0 - xiCorr) % unity
	} else {
		r = unity - 1 - ((-xx0 + xiCorr - 1) % unity)
	}
	m = (xx3 - xx0 + r) / unity
	y1 = yy1 - yy0
	y2 = yy2 - yy1
	y3 = yy3 - yy2
	if yy0 >= etaCorr {
		s = (yy0 - etaCorr) % unity
	} else {
		s = unity - 1 - ((-yy0 + etaCorr - 1) % unity)
	}
	n = (yy3 - yy0 + s) / unity
	if xx3-xx0 >= fractionOne || yy3-yy0 >= fractionOne {
		@<넘침 문제를 피하려고 변수들을 2로 나눈다@>
	}
	for {
		@<현재 부분 구간의 움직임을 만든다; 이분이 필요하면 뒤 절반을 스택에 넣고 |continue|@>
		if bisectPtr == 0 {
			return
		}
		@<스택에서 |makeMoves|의 부분 문제를 하나 꺼낸다@>
	}
}

@ @<스택에서 |makeMoves|의...@>=
bisectPtr = bisectPtr - moveIncrement
x1 = bisectStack[bisectPtr+stackX1]
x2 = bisectStack[bisectPtr+stackX2]
x3 = bisectStack[bisectPtr+stackX3]
r = bisectStack[bisectPtr+stackR]
m = bisectStack[bisectPtr+stackM]
y1 = bisectStack[bisectPtr+stackY1]
y2 = bisectStack[bisectPtr+stackY2]
y3 = bisectStack[bisectPtr+stackY3]
s = bisectStack[bisectPtr+stackS]
n = bisectStack[bisectPtr+stackN]
l = bisectStack[bisectPtr+stackL]

@ 우리의 변수 |(x1,x2,x3)|은 앞에서 전개한 이론의 표기 $(X_1,X_2,X_3)$에 해당한다. 이상한 상황에서
정수 넘침을 피하려면 이것들을 $2^{28}$보다 작게 유지해야 한다. 이를테면 $x_0=-2^{28}+2^{16}-1$이고
$x_1=x_2=x_3=2^{28}-1$인 자료는 그러지 않으면 문제가 될 것이다. 그러므로 악의적인 사용자를 막기 위해서라도
코드의 이 부분이 필요하다.

@<넘침 문제를 피하려고...@>=
x1 = half(x1 + xiCorr)
x2 = half(x2 + xiCorr)
x3 = half(x3 + xiCorr)
r = half(r + xiCorr)
y1 = half(y1 + etaCorr)
y2 = half(y2 + etaCorr)
y3 = half(y3 + etaCorr)
s = half(s + etaCorr)
l = 15

@ 이분을 할 때는 왼쪽 반을 변수들에 남기고 오른쪽 반을 스택에 넣은 다음, \GO/의 |continue|로 루프의
처음으로 돌아가 왼쪽 반을 다룬다.

@<현재 부분 구간의 움직임을...@>=
if m == 0 {
	@<위로 |n|걸음 간다@>
} else if n == 0 {
	@<오른쪽으로 |m|걸음 간다@>
} else if m+n == 2 {
	@<두 종류의 움직임을 하나씩 한다@>
} else {
	l++
	bisectStack[bisectPtr+stackL] = l
	bisectStack[bisectPtr+stackX3] = x3
	bisectStack[bisectPtr+stackX2] = half(x2 + x3 + xiCorr)
	x2 = half(x1 + x2 + xiCorr)
	x3 = half(x2 + bisectStack[bisectPtr+stackX2] + xiCorr)
	bisectStack[bisectPtr+stackX1] = x3
	r = r + r + xiCorr
	t = x1 + x2 + x3 + r
	q = t / twoToThe[l]
	bisectStack[bisectPtr+stackR] = t % twoToThe[l]
	bisectStack[bisectPtr+stackM] = m - q
	m = q
	bisectStack[bisectPtr+stackY3] = y3
	bisectStack[bisectPtr+stackY2] = half(y2 + y3 + etaCorr)
	y2 = half(y1 + y2 + etaCorr)
	y3 = half(y2 + bisectStack[bisectPtr+stackY2] + etaCorr)
	bisectStack[bisectPtr+stackY1] = y3
	s = s + s + etaCorr
	u = y1 + y2 + y3 + s
	q = u / twoToThe[l]
	bisectStack[bisectPtr+stackS] = u % twoToThe[l]
	bisectStack[bisectPtr+stackN] = n - q
	n = q
	bisectPtr = bisectPtr + moveIncrement
	continue
}

@ @<위로 |n|걸음 간다@>=
for n > 0 {
	movePtr++
	move[movePtr] = 1
	n--
}

@ @<오른쪽으로 |m|걸음 간다@>=
move[movePtr] = move[movePtr] + m

@ 여기서는 |r|과 |s|를 $2^l-R$과 $2^l-S$로 바꾸어 둔다. 그러면 이분한 왼쪽 반에서 $T<r$인지는 왼쪽 반이
$x$ 방향으로 다음 정수에 이르지 못하는지를 뜻하고, $U<s$인지는 $y$ 방향으로 그렇다는 것을 뜻한다. 둘 다
이르지 못하면 결정은 오른쪽 반에 달렸으므로 그리로 옮겨 가고, 하나만 이르면 그쪽 움직임이 먼저다.

@<두 종류의 움직임을...@>=
r = twoToThe[l] - r
s = twoToThe[l] - s
for l < 30 {
	x3a = x3
	x2a = half(x2 + x3 + xiCorr)
	x2 = half(x1 + x2 + xiCorr)
	x3 = half(x2 + x2a + xiCorr)
	t = x1 + x2 + x3
	r = r + r - xiCorr
	y3a = y3
	y2a = half(y2 + y3 + etaCorr)
	y2 = half(y1 + y2 + etaCorr)
	y3 = half(y2 + y2a + etaCorr)
	u = y1 + y2 + y3
	s = s + s - etaCorr
	if t < r {
		if u < s {
			@<오른쪽 부분 구간으로 옮겨 간다@>
		} else {
			@<위로 갔다가 오른쪽으로 간다@>
			goto done
		}
	} else if u < s {
		@<오른쪽으로 갔다가 위로 간다@>
		goto done
	}
	l++
}
r = r - xiCorr
s = s - etaCorr
if abVsCd(x1+x2+x3, s, y1+y2+y3, r)-xiCorr >= 0 {
	@<오른쪽으로 갔다가 위로...@>
} else {
	@<위로 갔다가 오른쪽으로...@>
}
done:

@ @<오른쪽 부분 구간으로...@>=
x1 = x3
x2 = x2a
x3 = x3a
r = r - t
y1 = y3
y2 = y2a
y3 = y3a
s = s - u

@ @<오른쪽으로 갔다가 위로...@>=
move[movePtr]++
movePtr++
move[movePtr] = 1

@ @<위로 갔다가 오른쪽으로...@>=
movePtr++
move[movePtr] = 2

@ 프로시저 |makeMoves|가 일을 한 다음에는, 아마 같은 팔분면을 향하는 여러 곡선에 대해 일을 한 다음에는, 배열
|move|에 ``매끄럽게 하기'' 연산을 할 수도 있다. 이것은 곡선을 반올림 오차 없이 화소화했을 때에도 생길 수
있는 눈에 거슬리는 작은 흠을 없앤다.

매끄럽게 하는 과정은 |move[b .. t]|의 정수 $a_0\ldots a_n$을 다음과 같이 정의되는 ``매끄러워진'' 정수
$a_0'\ldots a_n'$으로 바꾼다.
$$a_k'=a_k+\delta\k-\delta_k;\qquad
\delta_k=\cases{+1,&$1<k<n$이고 $a_{k-2}\ge a_{k-1}\ll a_k\ge a\k$일 때;\cr
-1,&$1<k<n$이고 $a_{k-2}\le a_{k-1}\gg a_k\le a\k$일 때;\cr
0,&그 밖의 경우.\cr}$$
여기서 $a\ll b$는 $a\le b-2$를 뜻하고, $a\gg b$는 $a\ge b+2$를 뜻한다.

곧 행의 길이가 갑자기 두 칸 이상 늘었다가 도로 줄어들지 않는 ``혹''이 있으면, 늘어난 행에서 한 칸을 떼어
앞 행에 붙인다. 이 매끄럽게 하기 연산은 대칭이다. 곧 $a_0\ldots a_n$이 $a_0'\ldots a_n'$으로 매끄러워지면
거꾸로 된 나열 $a_n\ldots a_0$은 $a_n'\ldots a_0'$으로 매끄러워지고, 보완하는 나열
$(m-a_0)\ldots(m-a_n)$은 $(m-a_0')\ldots(m-a_n')$으로 매끄러워진다. 또 $\delta_0=\delta_{n+1}=0$이므로
$a_0'+\cdots+a_n'=a_0+\cdots+a_n$이다.

@<함수들@>=
func smoothMoves(b, t int32) {
	var k int32 // |move|의 첨자; |1 .. moveSize|
	var a, aa, aaa int32 // |move[k]|, |move[k-1]|, |move[k-2]|의 원래 값
	if t-b >= 3 {
		k = b + 2
		aa = move[k-1]
		aaa = move[k-2]
		for {
			a = move[k]
			if abs(a-aa) > 1 {
				@<|move[k-1]|과 |move[k]|를 $\delta_k$만큼 늘이고 줄인다@>
			}
			k++
			aaa = aa
			aa = a
			if k == t {
				break
			}
		}
	}
}

@ @<|move[k-1]|과 |move[k]|를...@>=
if a > aa {
	if aaa >= aa && a >= move[k+1] {
		move[k-1]++
		move[k] = a - 1
	}
} else {
	if aaa <= aa && a <= move[k+1] {
		move[k-1]--
		move[k] = a + 1
	}
}

@* 가장자리 구조.
이제 사용자가 실제로 ``볼'' 수 있는 것, 곧 화소 사이의 가장자리(edge)를 나타내는 \MF의 내부 방식에
이르렀다. 화소마다 정수 무게가 있는데, 그것은 그 화소의 왼쪽에 있는 모든 가장자리의 무게를 더해서
얻는다. 가장자리는 대부분 무게가 없으므로 \MF는 0이 아닌 가장자리 무게만 나타낸다. 이렇게 하면
2차원 자료를 나타내는데도 저장 공간의 요구가 포인트당 화소 수에 대해 선형으로만 늘어난다. (실은
바탕 해상도에 대한 의존도는 $n\log n$의 차수지만, $\log n$ 인수는 최대 래스터 크기에 대한 암묵적인
제약 속에 묻혀 있다.) 각 행의 가장자리 무게를 모두 더하면 0이어야 한다.

가장자리 무게의 자료 구조는 작고 유연해야 하면서도 효율적인 갱신과 표시 연산을 떠받쳐야 한다. 우리는
메모리에 서로 다른 가장자리 구조를 한꺼번에 여럿 둘 수 있기를 바라고, 컴퓨터가 그것들을 비교적 쉽게
옮기고, 뒤집고, 합칠 수 있기를 바란다.

이 문제에 대한 \MF의 해법은 0이 아닌 가장자리 무게마다 한 낱말짜리 노드 하나, 그리고 잇닿은 행들의
집합에서 행마다 두 낱말짜리 노드 하나를 쓴다. 구조 전체에 관한 전역 정보를 주는 머리 노드도 하나 있다.

아래 그림의 왼쪽은 두 행에 걸친 작은 그림이다. 회색 화소의 무게는 1이고 흰 화소는 0이다. 무게가
바뀌는 곳에만 세로 가장자리가 있는데, 무게가 늘어나는 곳(왼쪽 경계)에는 $+1$을, 줄어드는 곳(오른쪽
경계)에는 $-1$을 단다. 화소의 무게는 그 왼쪽의 가장자리 무게들의 합이다. 오른쪽은 같은 구조를 \MF가
\KW{show}할 때 찍는 꼴(|printEdges|, \secref{print-edges})이다. 가장자리마다 $x$ 좌표 $m$을 찍고 그 뒤에
무게만큼 `\.+'나 `\.-'를 붙인다.
$$\mplibcode
beginfig(14);
save u; numeric u; u := 18pt;
for k = 1, 2, 3: fill ((k,1)--(k+1,1)--(k+1,2)--(k,2)--cycle) scaled u withcolor .8white; endfor
for k = 0, 1, 4, 5: fill ((k,0)--(k+1,0)--(k+1,1)--(k,1)--cycle) scaled u withcolor .8white; endfor
for i = 0 upto 7: draw (i*u,0)--(i*u,2u) withpen pencircle scaled .2pt; endfor
for j = 0 upto 2: draw (0,j*u)--(7u,j*u) withpen pencircle scaled .2pt; endfor
draw ((1,1)--(1,2)) scaled u withpen pencircle scaled 1.6pt;
draw ((4,1)--(4,2)) scaled u withpen pencircle scaled 1.6pt;
draw ((0,0)--(0,1)) scaled u withpen pencircle scaled 1.6pt;
draw ((2,0)--(2,1)) scaled u withpen pencircle scaled 1.6pt;
draw ((4,0)--(4,1)) scaled u withpen pencircle scaled 1.6pt;
draw ((6,0)--(6,1)) scaled u withpen pencircle scaled 1.6pt;
label.top(btex \sevenrm$+1$ etex, (1u,2u)); label.top(btex \sevenrm$-1$ etex, (4u,2u));
label.bot(btex \sevenrm$+1$ etex, (0,0)); label.bot(btex \sevenrm$-1$ etex, (2u,0));
label.bot(btex \sevenrm$+1$ etex, (4u,0)); label.bot(btex \sevenrm$-1$ etex, (6u,0));
label.lft(btex \ninepoint 행 1 etex, (-3pt,1.5u)); label.lft(btex \ninepoint 행 0 etex, (-12pt,.5u));
label.rt(btex \vbox{\halign{\tt#\hfil\cr row 1: \char'174\ 1+ 4-\cr row 0: \char'174\ 0+ 2- 4+ 6-\cr}} etex, (8.5u,u));
endfig;
\endmplibcode$$

@ 먼저 가장자리 무게 노드를 생각해 보자. 그런 노드의 |info| 필드에는 $m$~값과 무게~$w$가 둘 다 $8m+w+c$의
꼴로 들어 있다. 여기서 $c$는 머리에 있는 자료에 따라 정해지는 상수다. 상수 $c$는 나중에 자세히 살펴보겠다. 지금은
$m$과~$w$가 음수일 수 있다는 사실과, |info| 필드의 값이 |minHalfword|와 |maxHalfword| 사이여야 한다는
사실을 보완하는 방법이라고만 생각하는 것이 좋다. 여기서 $m$ 값은 눈금 없는 $x$~좌표이므로 $\vert m\vert<4096$을
만족한다. 무게 $w$의 값은 언제나 범위 $1\le\vert w\vert\le3$에 있다. 그리고 |info| 필드의 자료는
|ho(info(p))=info(p)-minHalfword|를 꺼내 이 음이 아닌 수를 8로 나누어 풀 수 있다. 상수~$c$는 이 나눗셈의
나머지가 $4+w$가 되도록 고른다. 그러므로 이를테면 나머지~3은 가장자리 무게 $w=-1$에 해당한다.

가장자리 구조의 각 행에는 그런 가장자리 무게 노드들의 목록이 둘 있는데, |sorted| 목록과 |unsorted|
목록이라고 부른다. 둘 다 보통의 방식으로 |link| 필드로 이어진다. 둘의 차이는 |sorted| 목록에서는 언제나
|info(p)<=info(link(p))|이지만 |unsorted| 목록의 원소들에는 그런 제약이 없다는 것이다. 이렇게 구별하는
까닭은 가장자리 무게 목록을 갱신하는 동안 줄곧 정렬된 순서로 유지하려면 쓸데없이 오래 걸리기 때문이다.
그러나 한 행 전체를 $m$~값의 순서대로 왼쪽에서 오른쪽으로 처리해야 할 때는, 정렬되지 않은 원소들로 된
짧은 목록을 정렬해서 정렬된 동료들 사이의 제자리에 합쳐 넣기가 꽤 쉽고 빠르다. 게다가 |unsorted| 목록이
비어 있다는 사실을 때로는 유리하게 쓸 수 있다. 어떤 행이 마지막으로 정렬된 뒤로 바뀌지 않았다는 결론을
내릴 수 있기 때문이다.

정렬된 목록 |sorted|의 마지막 |link|는 |sentinel|인데, 이것은 |info| 필드가 본질적으로 무한대인 특별한 한
낱말짜리 노드를 가리킨다. 이것이 정렬하고 합치는 연산을 쉽게 해 준다. 한편 |unsorted| 목록의 마지막 |link|는
|null|이거나 |void|다. 값 |void=null+1|은 바뀌지 않은 자료를 다시 표시하지 않으려고 쓴다. 어떤 행을 표시했을
때마다 그 행의 정렬되지 않은 목록의 머리에 |void| 값을 넣어 둔다.

@<정의@>=
const (
	@!zeroW = 4
	@!void = null + 1
)

@ @<표의 항목들을...@>=
setInfo(sentinel, maxHalfword) // |link(sentinel)=null|

@ 행 자체는 연결 필드 넷을 담은 행 머리 노드로 나타낸다. 넷 가운데 둘, 곧 |sorted|와 |unsorted|는 방금
말한 가장자리 무게 목록의 첫 항목을 가리킨다. 다른 둘, 곧 |link|와 |knil|은 이웃한 두 행의 머리를
가리킨다. 포인터 |p|가 행 번호~|n|의 머리를 가리키면, |link(p)|는 위로 행~|n+1|의 머리를 가리키고 |knil(p)|는
아래로 행~|n-1|의 머리를 가리킨다. 이 이중 연결 덕분에 잇닿은 행들을 위로든 아래로든 편리하게 옮겨 다닐
수 있다. 늘 그렇듯이 모든 행 머리~|p|에 대해 |link(knil(p))=knil(link(p))=p|이다.

주어진 |n| 값에 딸린 행에는 격자점 |(m,n)|과 |(m,n+1)| 사이를 지나는 가장자리들의 무게가 들어 있다.

@<정의@>=
func knil(p pointer) pointer              { return info(p) } // 이중 연결 목록에서 |link| 필드의 역
func setKnil(p pointer, v pointer)        { setInfo(p, v) }
func sortedLoc(p pointer) pointer         { return p + 1 } // |sorted| 연결 필드가 사는 곳
func sorted(p pointer) pointer            { return link(sortedLoc(p)) } // 정렬된 가장자리 무게 목록의 처음
func setSorted(p pointer, v pointer)      { setLink(sortedLoc(p), v) }
func unsorted(p pointer) pointer          { return info(p + 1) } // 정렬되지 않은 가장자리 무게 목록의 처음
func setUnsorted(p pointer, v pointer)    { setInfo(p+1, v) }

const @!rowNodeSize = 2 // 행 머리 노드의 낱말 수

@ 가장자리 구조의 주 머리 노드 |h|에는 맨 위 행의 위와 맨 아래 행의 아래로 그것을 잇는 |link|와 |knil|
필드가 있다. 또 가장자리 자료의 현재 범위를 묶는 |mMin|, |mMax|, |nMin|, |nMax|라는 필드도 있다.
가장자리 무게 노드의 모든 |m| 값은 |mMin(h)-4096|과 |mMax(h)-4096| 사이(양 끝 포함)에 있어야 한다. 게다가
|knil(h)|가 가리키는 맨 위 행 머리는 행 번호 |nMax(h)-4096|의 것이고, |link(h)|가 가리키는 맨 아래 행
머리는 행 번호 |nMin(h)-4096|의 것이다.

모든 가장자리 무게 자료에 쓰이는 오프셋 상수 |c|는 |mOffset(h)|로 암묵적으로 나타낸다. 그 실제 값은
$$\hbox{|c=minHalfword+zeroW+8*mOffset(h)|}$$
이다. 가장자리 구조 전체를 $(\Delta m,\Delta n)$만큼 옮기려면 |nMin(h)|와 |nMax(h)|에 $\Delta n$을 더하고,
|mMin(h)|와 |mMax(h)|에 $\Delta m$을 더하고, |mOffset(h)|에서 $\Delta m$을 빼기만 하면 된다는 데 주목하라.
다른 가장자리 자료는 하나도 고칠 필요가 없다. 처음에 |mOffset| 필드는~4096이지만, 사용자가 그런 옮김을
요청하면 바뀐다. 이 다섯 필드의 내용은 언제나 양수이고 8192보다 작아야 한다. 실은 |nMax|는 8191보다 작아야
한다. 게다가 가장자리 무게 노드의 |info| 필드가 하프워드에 들어가도록 |mMin+mOffset-4096|과
|mMax+mOffset-4096|도 0과 8192 사이(양 끝 제외)에 있어야 한다.

가장자리 구조의 머리 노드에는 |lastWindow(h)|와 |lastWindowTime(h)|라는 조금 별난 필드 둘도 있다. 이
구조를 사용자의 화면의 창~|k|에 표시할 때, 그 창이 |t|번 갱신된 다음이라면 \MF는 |lastWindow(h)=k|와
|lastWindowTime(h)=t|로 놓는다. 또 정렬되지 않은 무게가 있으면 정렬된 것들과 합친 다음 모든 행 머리~|p|에
대해 |unsorted(p)=void|로 놓는다. 그 뒤에 같은 창에 표시할 때는, 그동안 그 창이 다른 일에 쓰이지 않았다면
|unsorted| 목록이 여전히 |void|인 행들을 다시 표시하지 않아도 된다.

행 |nPos(h)-4096|의 행 머리를 가리키는 포인터는 |nRover(h)|에 있다. 가장자리 구조를 갱신하는 알고리즘들은
대부분 행을 마구잡이로 참조하지 않고도 해낸다. 대개 서로 이웃한 행이나 현재 |nPos| 행에 이웃한 행에
접근하기 때문이다. 예외: |link(h)=h|이면(그래서 가장자리 구조에 행이 하나도 없으면) |nRover(h)=h|이고
|nPos(h)|는 상관이 없다.

@<정의@>=
const @!zeroField = 4096 // 좌표를 양수로 만들려고 더하는 양

func nMin(p pointer) halfword                { return info(p + 1) } // 있는 가장 작은 행 번호에 |zeroField|를 더한 것
func setNMin(p pointer, v halfword)          { setInfo(p+1, v) }
func nMax(p pointer) halfword                { return link(p + 1) } // 있는 가장 큰 행 번호에 |zeroField|를 더한 것
func setNMax(p pointer, v halfword)          { setLink(p+1, v) }
func mMin(p pointer) halfword                { return info(p + 2) } // 있는 가장 작은 열 번호에 |zeroField|를 더한 것
func setMMin(p pointer, v halfword)          { setInfo(p+2, v) }
func mMax(p pointer) halfword                { return link(p + 2) } // 있는 가장 큰 열 번호에 |zeroField|를 더한 것
func setMMax(p pointer, v halfword)          { setLink(p+2, v) }
func mOffset(p pointer) halfword             { return info(p + 3) } // 가장자리 무게 노드의 $m$ 자료의 옮김
func setMOffset(p pointer, v halfword)       { setInfo(p+3, v) }
func lastWindow(p pointer) halfword          { return link(p + 3) } // 마지막 표시는 이 창에 했다
func setLastWindow(p pointer, v halfword)    { setLink(p+3, v) }
func lastWindowTime(p pointer) int32         { return mem[p+4].sc } // 창을 이만큼 갱신한 다음에
func setLastWindowTime(p pointer, v int32)   { mem[p+4].sc = v }
func nPos(p pointer) halfword                { return info(p + 5) } // |nRover|에 있는 행에 |zeroField|를 더한 것
func setNPos(p pointer, v halfword)          { setInfo(p+5, v) }
func nRover(p pointer) pointer               { return link(p + 5) } // 최근에 참조한 행
func setNRover(p pointer, v pointer)         { setLink(p+5, v) }

const @!edgeHeaderSize = 6 // 가장자리 구조 머리의 낱말 수

func validRange(x int32) bool { return abs(x-4096) < 4096 } // |x|가 0과 8192 사이(양 끝 제외)에 있는가?
func emptyEdges(p pointer) bool { return link(p) == p } // 이 가장자리 머리에 행이 하나도 없는가?

@ @<함수들@>=
func initEdges(h pointer) { // 가장자리 머리를 널 값으로 초기화한다
	setKnil(h, h)
	setLink(h, h)
	setNMin(h, zeroField+4095)
	setNMax(h, zeroField-4095)
	setMMin(h, zeroField+4095)
	setMMax(h, zeroField-4095)
	setMOffset(h, zeroField)
	setLastWindow(h, 0)
	setLastWindowTime(h, 0)
	setNRover(h, h)
	setNPos(h, 0)
}

@ 특정한 가장자리 구조에 많은 일을 할 때는 그 주 머리를 가리키는 포인터를 전역 변수 |curEdges|에 심어
둔다. 그러면 서브루틴 사이에서 이 포인터를 매개변수로 거듭거듭 넘기지 않아도 된다.

비슷하게, |curWt|는 여러 프로시저가 한꺼번에 쓰고 있는 전역 무게다.

@<전역 변수@>=
var @!curEdges pointer // 지금 관심 있는 가장자리 구조
var @!curWt int32 // 지금 관심 있는 가장자리 무게

@ 루틴 |fixOffset|은 |curEdges|의 가장자리 무게 노드를 모두 돌면서 그 |info| 필드에 상수를 더해서
|mOffset(curEdges)|를 |zeroField|로 되돌릴 수 있게 한다. (이것은 오프셋이 너무 커지거나 너무 작아진
드문 경우에만 필요하다.)

@<함수들@>=
func fixOffset() {
	var p, q pointer // 목록을 훑는 것들
	var delta int32 // 바뀌는 양
	delta = 8 * (mOffset(curEdges) - zeroField)
	setMOffset(curEdges, zeroField)
	q = link(curEdges)
	for q != curEdges {
		p = sorted(q)
		for p != sentinel {
			setInfo(p, info(p)-delta)
			p = link(p)
		}
		p = unsorted(q)
		for p > void {
			setInfo(p, info(p)-delta)
			p = link(p)
		}
		q = link(q)
	}
}

@ 루틴 |edgePrep|는 |curEdges| 구조가 좌표가 |ml<=m<=mr|과 |nl<=n<=nr-1|을 만족하는 새 자료를 받아들일
준비를 하게 한다. 여기서 |-4096<ml<=mr<4096|이고 |-4096<nl<=nr<4096|이라고 가정한다. 이것은 |mMin|,
|mMax|, |nMin|, |nMax|를 알맞게 고치고, 필요하면 빈 행들을 새로 보탠다.

@<함수들@>=
func edgePrep(ml, mr, nl, nr int32) {
	var delta halfword // 바뀌는 양
	var p, q pointer // 목록 조작을 위해
	ml = ml + zeroField
	mr = mr + zeroField
	nl = nl + zeroField
	nr = nr - 1 + zeroField
	if ml < mMin(curEdges) {
		setMMin(curEdges, ml)
	}
	if mr > mMax(curEdges) {
		setMMax(curEdges, mr)
	}
	if !validRange(mMin(curEdges)+mOffset(curEdges)-zeroField) ||
		!validRange(mMax(curEdges)+mOffset(curEdges)-zeroField) {
		fixOffset()
	}
	if emptyEdges(curEdges) { // 행이 하나도 없다
		setNMin(curEdges, nr+1)
		setNMax(curEdges, nr)
	}
	if nl < nMin(curEdges) {
		@<맨 아래에 빈 행을 꼭 |nMin(curEdges)-nl|개 넣는다@>
	}
	if nr > nMax(curEdges) {
		@<맨 위에 빈 행을 꼭 |nr-nMax(curEdges)|개 넣는다@>
	}
}

@ @<맨 아래에 빈 행을...@>=
delta = nMin(curEdges) - nl
setNMin(curEdges, nl)
p = link(curEdges)
for {
	q = getNode(rowNodeSize)
	setSorted(q, sentinel)
	setUnsorted(q, void)
	setKnil(p, q)
	setLink(q, p)
	p = q
	delta--
	if delta == 0 {
		break
	}
}
setKnil(p, curEdges)
setLink(curEdges, p)
if nRover(curEdges) == curEdges {
	setNPos(curEdges, nl-1)
}

@ @<맨 위에 빈 행을...@>=
delta = nr - nMax(curEdges)
setNMax(curEdges, nr)
p = knil(curEdges)
for {
	q = getNode(rowNodeSize)
	setSorted(q, sentinel)
	setUnsorted(q, void)
	setLink(p, q)
	setKnil(q, p)
	p = q
	delta--
	if delta == 0 {
		break
	}
}
setLink(p, curEdges)
setKnil(curEdges, p)
if nRover(curEdges) == curEdges {
	setNPos(curEdges, nr+1)
}

@ \seclabel{print-edges}서브루틴 |printEdges|는 `\KW{show}' 명령에 쓰려고 가장자리 구조를 기호로 그려 보인다. 가장자리 구조는
꽤 커질 수 있으므로 상당히 간결한 출력 꼴을 골랐다. 각 행에서 세로 막대 `\.{\char'174}'의 왼쪽에는
정렬되지 않은 무게들이, 오른쪽에는 정렬된 무게들이 나온다.

@<함수들@>=
func printEdges(s any, nuline bool, xOff, yOff int32) {
	var p, q, r pointer // 목록을 따라가는 데 쓴다
	var n int32 // 행 번호
	printDiagnostic("Edge structure", s, nuline)
	p = knil(curEdges)
	n = nMax(curEdges) - zeroField
	for p != curEdges {
		q = unsorted(p)
		r = sorted(p)
		if q > void || r != sentinel {
			printNl("row ")
			printInt(n + yOff)
			printChar(':')
			for q > void {
				printWeight(q, xOff)
				q = link(q)
			}
			printStr(" |")
			for r != sentinel {
				printWeight(r, xOff)
				r = link(r)
			}
		}
		p = knil(p)
		n--
	}
	endDiagnostic(true)
}

@ @<함수들@>=
func printWeight(q pointer, xOff int32) {
	var w, m int32 // 푼 무게와 좌표
	var d int32 // 임시 자료 레지스터
	d = ho(info(q))
	w = d % 8
	m = (d / 8) - mOffset(curEdges)
	if fileOffset > maxPrintLine-9 {
		printNl(" ")
	} else {
		printChar(' ')
	}
	printInt(m + xOff)
	for w > zeroW {
		printChar('+')
		w--
	}
	for w < zeroW {
		printChar('-')
		w++
	}
}

@ 다음은 가장자리 구조를 베끼는 하찮은 서브루틴이다. (주어진 구조가 너무 거대하지 않기를 바라자.)

@<함수들@>=
func copyEdges(h pointer) pointer {
	var p, r pointer // 주어진 구조를 따라가는 변수들
	var hh, pp, qq, rr, ss pointer // 새 구조를 따라가는 변수들
	hh = getNode(edgeHeaderSize)
	mem[hh+1] = mem[h+1]
	mem[hh+2] = mem[h+2]
	mem[hh+3] = mem[h+3]
	mem[hh+4] = mem[h+4] // 이제 |nMin|, |nMax|, |mMin|, |mMax|, |mOffset|,
	@t\qquad@>// |lastWindow|, |lastWindowTime|을 베꼈다
	setNPos(hh, nMax(hh)+1)
	setNRover(hh, hh)
	p = link(h)
	qq = hh
	for p != h {
		pp = getNode(rowNodeSize)
		setLink(qq, pp)
		setKnil(pp, qq)
		@<|p|의 |sorted|와 |unsorted| 목록을 둘 다 |pp|로 베낀다@>
		p = link(p)
		qq = pp
	}
	setLink(qq, hh)
	setKnil(hh, qq)
	return hh
}

@ @<|p|의 |sorted|와 |unsorted| 목록을...@>=
r = sorted(p)
rr = sortedLoc(pp) // |link(rr)=sorted(pp)|
for r != sentinel {
	ss = getAvail()
	setLink(rr, ss)
	rr = ss
	setInfo(rr, info(r))
	r = link(r)
}
setLink(rr, sentinel)
r = unsorted(p)
rr = tempHead
for r > void {
	ss = getAvail()
	setLink(rr, ss)
	rr = ss
	setInfo(rr, info(r))
	r = link(r)
}
setLink(rr, r)
setUnsorted(pp, link(tempHead))

@ 또 하나의 하찮은 루틴은 행이 적어도 하나 있다고 가정하고 |curEdges|를 |x|축에 대해 뒤집는다(곧
모든 |y| 좌표의 부호를 바꾼다). 행들의 위아래 순서만 뒤집으면 된다.

@<함수들@>=
func yReflectEdges() {
	var p, q, r pointer // 목록 조작 레지스터들
	p = nMin(curEdges)
	setNMin(curEdges, zeroField+zeroField-1-nMax(curEdges))
	setNMax(curEdges, zeroField+zeroField-1-p)
	setNPos(curEdges, zeroField+zeroField-1-nPos(curEdges))
	p = link(curEdges)
	q = curEdges // 우리는 |p!=q|라고 가정한다
	for {
		r = link(p)
		setLink(p, q)
		setKnil(q, p)
		q = p
		p = r
		if q == curEdges {
			break
		}
	}
	setLastWindowTime(curEdges, 0)
}

@ 그림을 |y|축에 대해 뒤집는 것은 조금 더 어렵지만 그리 어렵지는 않다.

@<함수들@>=
func xReflectEdges() {
	var p, q, r, s pointer // 목록 조작 레지스터들
	var m int32 // |info| 필드를 이 수에 대해 뒤집는다
	p = mMin(curEdges)
	setMMin(curEdges, zeroField+zeroField-mMax(curEdges))
	setMMax(curEdges, zeroField+zeroField-p)
	m = (zeroField+mOffset(curEdges))*8 + zeroW + minHalfword + zeroW + minHalfword
	setMOffset(curEdges, zeroField)
	p = link(curEdges)
	for {
		@<|sorted(p)|의 가장자리와 무게 자료를 뒤집는다@>
		@<|unsorted(p)|의 가장자리와 무게 자료를 뒤집는다@>
		p = link(p)
		if p == curEdges {
			break
		}
	}
	setLastWindowTime(curEdges, 0)
}

@ 여기서는 $x$~좌표의 부호를 바꿀 때 무게의 부호도 바꾸고 싶다. 다행히 이것은 둘 가운데 하나만 바꾸는 것보다
오히려 쉽다. 상수에서 $8m+w$를 빼면 $m$과 $w$의 부호가 함께 바뀌기 때문이다.

@<|unsorted(p)|의 가장자리와...@>=
q = unsorted(p)
for q > void {
	setInfo(q, m-info(q))
	q = link(q)
}

@ 연결 목록의 순서를 뒤집는 것은 한 스택에서 노드들을 꺼내 다른 스택에 쌓는 과정으로 생각하는 것이
가장 좋다. 여기서는 스택~|q|에서 꺼내 스택~|r|에 쌓는다.

@<|sorted(p)|의 가장자리와...@>=
q = sorted(p)
r = sentinel
for q != sentinel {
	s = link(q)
	setLink(q, r)
	r = q
	setInfo(r, m-info(q))
	q = s
}
setSorted(p, r)

@ 이제 비어 있지 않은 가장자리 구조의 $y$~좌표를 모두 작은 정수 $s>1$배 해 보자.

@<함수들@>=
func yScaleEdges(s int32) {
	var p, q, pp, r, rr, ss pointer // 목록 조작 레지스터들
	var t int32 // 복제 계수기
	if s*(nMax(curEdges)+1-zeroField) >= 4096 || s*(nMin(curEdges)-zeroField) <= -4096 {
		printErr("Scaled picture would be too big")
@.Scaled picture...big@>
		help3("I can't yscale the picture as requested---it would",
			"make some coordinates too large or too small.",
			"Proceed, and I'll omit the transformation.")
		putGetError()
	} else {
		setNMax(curEdges, s*(nMax(curEdges)+1-zeroField)-1+zeroField)
		setNMin(curEdges, s*(nMin(curEdges)-zeroField)+zeroField)
		@<모든 행을 꼭 $s$번 복제한다@>
		setLastWindowTime(curEdges, 0)
	}
}

@ @<모든 행을 꼭...@>=
p = curEdges
for {
	q = p
	p = link(p)
	for t = 2; t <= s; t++ {
		pp = getNode(rowNodeSize)
		setLink(q, pp)
		setKnil(p, pp)
		setLink(pp, p)
		setKnil(pp, q)
		q = pp
		@<|p|의 |sorted|와 |unsorted| 목록을...@>
	}
	if link(p) == curEdges {
		break
	}
}

@ 물론 다음 일은 $x$~좌표를 늘이는 것이다.

@<함수들@>=
func xScaleEdges(s int32) {
	var p, q pointer // 목록 조작 레지스터들
	var t int32 // 푼 |info| 필드; |0 .. 65535|
	var w int32 // 푼 무게; |0 .. 7|
	var delta int32 // 늘인 |info|에 더하는 양
	if s*(mMax(curEdges)-zeroField) >= 4096 || s*(mMin(curEdges)-zeroField) <= -4096 {
		printErr("Scaled picture would be too big")
@.Scaled picture...big@>
		help3("I can't xscale the picture as requested---it would",
			"make some coordinates too large or too small.",
			"Proceed, and I'll omit the transformation.")
		putGetError()
	} else if mMax(curEdges) != zeroField || mMin(curEdges) != zeroField {
		setMMax(curEdges, s*(mMax(curEdges)-zeroField)+zeroField)
		setMMin(curEdges, s*(mMin(curEdges)-zeroField)+zeroField)
		delta = 8*(zeroField-s*mOffset(curEdges)) + minHalfword
		setMOffset(curEdges, zeroField)
		@<각 행의 $x$~좌표를 $s$배 한다@>
		setLastWindowTime(curEdges, 0)
	}
}

@ 배율이 |s<4096|임을 알므로 곱셈은 넘칠 수 없다.

@<각 행의 $x$~좌표를...@>=
q = link(curEdges)
for {
	p = sorted(q)
	for p != sentinel {
		t = ho(info(p))
		w = t % 8
		setInfo(p, (t-w)*s+w+delta)
		p = link(p)
	}
	p = unsorted(q)
	for p > void {
		t = ho(info(p))
		w = t % 8
		setInfo(p, (t-w)*s+w+delta)
		p = link(p)
	}
	q = link(q)
	if q == curEdges {
		break
	}
}

@ 다음은 다른 것은 바꾸지 않고 모든 무게의 부호를 바꾸는 루틴이다. 필드 |info|의 나머지가 $4+w$이므로
$8-2(4+w)=-2w$를 더하면 나머지가 $4-w$가 된다.

@<함수들@>=
func negateEdges(h pointer) {
	var p, q, r, s, t, u pointer // 구조를 훑는 것들
	p = link(h)
	for p != h {
		q = unsorted(p)
		for q > void {
			setInfo(q, 8-2*((ho(info(q)))%8)+info(q))
			q = link(q)
		}
		q = sorted(p)
		if q != sentinel {
			for {
				setInfo(q, 8-2*((ho(info(q)))%8)+info(q))
				q = link(q)
				if q == sentinel {
					break
				}
			}
			@<목록 |sorted(p)|를 다시 정렬된 상태로 둔다@>
		}
		p = link(p)
	}
	setLastWindowTime(h, 0)
}

@ 이 절의 코드를 빼도 \MF는 돌아갈 것이다. 좌표 |m|으로만 정렬되고 무게 |w|로는 정렬되지 않은 가장자리와 무게
자료의 목록으로도 올바르게 동작하는 데 충분하기 때문이다. 그러나 저자는 프로그램을 지금보다 더 까다롭게
만들지 않기로 했다. 프로시저 |negateEdges|는 그리 자주 필요하지 않기 때문이다. 그래서 더 말하기 쉬운 조건인
``|sorted| 목록을 완전히 정렬된 상태로 둔다''를 계산을 더 해서라도 지키는 것이다.

부호를 바꾸면 같은 |m|에 있는 무게들의 순서만 뒤집히므로, 같은 |m|을 가진 노드들의 묶음마다 그 안의
순서를 뒤집으면 된다.

@<목록 |sorted(p)|를 다시...@>=
u = sortedLoc(p)
q = link(u)
r = q
s = link(r) // |q=sorted(p)|
for {
	if info(s) > info(r) {
		setLink(u, q)
		if s == sentinel {
			break
		}
		u = r
		q = s
		r = q
		s = link(r)
	} else {
		t = s
		s = link(t)
		setLink(t, q)
		q = t
	}
}
setLink(r, sentinel)

@ 한 행의 |unsorted| 가장자리들은 |sortEdges|라는 서브루틴으로 |sorted|인 것들에 합친다. 정렬되지 않은
목록은 꽤 짧을 것으로 보므로 간단한 끼워 넣기 정렬을 쓴 다음 합친다. 다만 정렬되지 않은 목록이 비어
있지 않다고 가정한다.

@<함수들@>=
func sortEdges(h pointer) { // |h|는 행 머리다
	var k halfword // |info(q)|와 비교하는 열쇠 레지스터
	var p, q, r, s pointer
	r = unsorted(h)
	setUnsorted(h, null)
	p = link(r)
	setLink(r, sentinel)
	setLink(tempHead, r)
	for p > void { // 노드 |p|를 |tempHead|에서 시작하는 목록에 정렬해 넣는다
		k = info(p)
		q = tempHead
		for {
			r = q
			q = link(r)
			if k <= info(q) {
				break
			}
		}
		setLink(r, p)
		r = link(p)
		setLink(p, q)
		p = r
	}
	@<|tempHead| 목록을 |sorted(h)|에 합친다@>
}

@ 이 단계에서는 |sorted(h)=link(sortedLoc(h))|라는 사실을 쓴다.

@<|tempHead| 목록을...@>=
r = sortedLoc(h)
q = link(r)
p = link(tempHead)
for {
	k = info(p)
	for k > info(q) {
		r = q
		q = link(r)
	}
	setLink(r, p)
	s = link(p)
	setLink(p, q)
	if s == sentinel {
		break
	}
	r = p
	p = s
}

@ 프로시저 |cullEdges|는 화소 무게를 모두 |wOut|이나~|wIn|으로 만들어서 가장자리 구조를 ``최적화''한다.
연산 뒤의 무게는 그 전에 무게가 닫힌 구간 |[wLo,wHi]| 안에 있었을 때, 그리고 오직 그때에만 |wIn|이 된다.
여기서 |wLo<=wHi|이다. 두 무게 |wOut|과 |wIn| 가운데 하나는 0이고 다른 하나는 $\pm1$, $\pm2$, $\pm3$이다. 매개변수는
무게가 0인 화소가 무게 0으로 남도록 주어진다. (다행한 일이다. 그런 화소는 무한히 많기 때문이다.)

이 프로시저는 |mMin|, |mMax|, |nMin|, |nMax|를 고쳐서 결과 자료의 가장 빡빡한 경계도 계산한다.

@<함수들@>=
func cullEdges(wLo, wHi, wOut, wIn int32) {
	var p, q, r, s pointer // 목록 조작을 위해
	var w int32 // 추린 뒤의 새 무게
	var d int32 // 풀기 위한 자료 레지스터
	var m int32 // 앞의 열 번호; |mOffset|을 포함한다
	var mm int32 // 다음 열 번호; |mOffset|을 포함한다
	var ww int32 // 추리기 전에 쌓인 무게
	var prevW int32 // 열 |m| 앞의 |w|의 값
	var n, minN, maxN pointer // 현재 행 번호와 극단의 행 번호들
	var minD, maxD pointer // 새 가장자리와 무게 자료의 극단값들
	minD = maxHalfword
	maxD = minHalfword
	minN = maxHalfword
	maxN = minHalfword
	p = link(curEdges)
	n = nMin(curEdges)
	for p != curEdges {
		if unsorted(p) > void {
			sortEdges(p)
		}
		if sorted(p) != sentinel {
			@<|sorted(p)|에서 쓸데없는 가장자리 무게 항목들을 추려 낸다@>
		}
		p = link(p)
		n++
	}
	@<맨 위와 맨 아래의 빈 행들을 지운다; 머리의 경곗값들을 고친다@>
	setLastWindowTime(curEdges, 0)
}

@ 이 단계에서 |sorted| 목록 전체를 쓸 수 있는 메모리로 돌려주고, (잠시) |tempHead|에서 시작하는 새 목록을
만든다. 같은 열에 가장자리가 여럿 있을 수 있으므로 실제로 추리는 곳보다 앞을 내다보아야 한다. 그래서
되풀이를 시작하고 멈추는 것이 조금 까다롭다.

@<|sorted(p)|에서 쓸데없는...@>=
r = tempHead
q = sorted(p)
ww = 0
m = 1000000
prevW = 0
for {
	if q == sentinel {
		mm = 1000000
	} else {
		d = ho(info(q))
		mm = d / 8
		ww = ww + (d % 8) - zeroW
	}
	if mm > m {
		@<새 화소 무게가 바뀌었으면 가장자리 |m|에 가장자리 무게를 넣는다@>
		if q == sentinel {
			break
		}
	}
	m = mm
	if ww >= wLo && ww <= wHi {
		w = wIn
	} else {
		w = wOut
	}
	s = link(q)
	freeAvail(q)
	q = s
}
setLink(r, sentinel)
setSorted(p, link(tempHead))
if r != tempHead {
	@<최대와 최소의 양을 고친다@>
}

@ @<새 화소 무게가 바뀌었으면...@>=
if w != prevW {
	s = getAvail()
	setLink(r, s)
	setInfo(s, 8*m+minHalfword+zeroW+w-prevW)
	r = s
	prevW = w
}

@ @<최대와 최소의 양을...@>=
if minN == maxHalfword {
	minN = n
}
maxN = n
if minD > info(link(tempHead)) {
	minD = info(link(tempHead))
}
if maxD < info(r) {
	maxD = info(r)
}

@ @<맨 위와 맨 아래의 빈 행들을...@>=
if minN > maxN {
	@<행 머리들을 모두 지운다@>
} else {
	n = nMin(curEdges)
	setNMin(curEdges, minN)
	for minN > n {
		p = link(curEdges)
		setLink(curEdges, link(p))
		setKnil(link(p), curEdges)
		freeNode(p, rowNodeSize)
		n++
	}
	n = nMax(curEdges)
	setNMax(curEdges, maxN)
	setNPos(curEdges, maxN+1)
	setNRover(curEdges, curEdges)
	for maxN < n {
		p = knil(curEdges)
		setKnil(curEdges, knil(p))
		setLink(knil(p), curEdges)
		freeNode(p, rowNodeSize)
		n--
	}
	setMMin(curEdges, ((ho(minD))/8)-mOffset(curEdges)+zeroField)
	setMMax(curEdges, ((ho(maxD))/8)-mOffset(curEdges)+zeroField)
}

@ 가장자리가 모두 추려져 없어지면 여기에 온다.

@<행 머리들을 모두...@>=
p = link(curEdges)
for p != curEdges {
	q = link(p)
	freeNode(p, rowNodeSize)
	p = q
}
initEdges(curEdges)

@ 가장자리 구조를 바꾸는 루틴 가운데 마지막이자 가장 어렵고---또 가장 재미있는!---것은 행과 열의
노릇을 맞바꾸는 |xySwapEdges|다. 이 일은, 행으로 이어진 세로 가장자리만 담은 가장자리 구조가 주어질 때,
암묵적인 화소 무게를 바꾸지 않으면서 열로 이어진 가로 가장자리만 담은 가장자리 구조를 만드는 일로 볼 수
있다.

이웃한 두 행이 주어지면 그 ``사이''에 있는 가로 가장자리를 정하기는 어렵지 않다. 세로로 이웃한 화소의
무게가 다른 곳을 찾아서, 무게의 차를 담은 가로 가장자리를 넣으면 된다. 이렇게 정한 가로 가장자리는
저마다 알맞은 연결 목록에 넣어야 한다. 이 연결 목록들에는 마구잡이로 접근할 수 있어야 하므로 그 목록
머리들을 배열 |move|에 둔다. 주어진 가장자리 구조를 위에서 아래로 처리하면 만들어지는 목록들은 이미
순서대로 놓이므로 정렬할 필요가 없다.

다음 알고리즘은 존 하비가 내놓은 생각 몇 가지를 쓴다. 이것은 가장자리 구조가 널이 아니라고, 곧
@^Hobby, John Douglas@>
|link(curEdges)!=curEdges|이고 따라서 |mMax(curEdges)>=mMin(curEdges)|라고 가정한다.

@<함수들@>=
func xySwapEdges() { // |curEdges|에서 |x|와 |y|를 맞바꾼다
	var mMagic, nMagic int32 // 오프셋을 반영하는 특별한 값들
	var p, q, r, s pointer // 주어진 구조를 훑는 포인터들
	var mSpread int32 // |mMax|와 |mMin|의 차
	var j, jj int32 // |move|의 첨자들; |0 .. moveSize|
	var m, mm int32 // 세로 가장자리에서의 |m| 값들
	var pd, rd int32 // 가장자리와 무게 노드의 자료 필드들
	var pm, rm int32 // 가장자리와 무게 노드의 |m| 값들
	var w int32 // 쌓인 무게의 차
	var ww int32 // |w| 가운데 노드 하나에 저장할 수 있는 만큼
	var dw int32 // |w|에 더할 증분
	var extras int32 // 무게를 |>3|으로 만드는 추가 노드의 수
	var xw int32 // 추가 노드의 추가 무게; |-3 .. 3|
	var k int32 // 추가 노드를 넣는 루프 계수기
	@<새 가장자리 목록 머리들의 배열을 초기화한다@>
	@<맨 위와 맨 아래에 빈 행을 넣고, |p|를 새 맨 위 행으로 놓는다@>
	@<마법의 오프셋 값들을 계산한다@>
	for {
		q = knil(p)
		if unsorted(q) > void {
			sortEdges(q)
		}
		@<이웃한 행 |p,q|가 정하는 가로 가장자리들을 넣고, 행~|p|를 없앤다@>
		p = q
		nMagic = nMagic - 8
		if knil(p) == curEdges {
			break
		}
	}
	freeNode(p, rowNodeSize) // 이제 원래의 행들이 모두 재활용되었다
	@<새 가장자리를 반영하도록 머리를 고친다@>
}

@ 여기서는 |link| 항목을 최신 상태로 두려고 애쓰지 않는다. 이 프로시저는 이전의 가장자리 구조를 없애면서
|knil| 필드만 보기 때문이다.

@<맨 위와 맨 아래에 빈 행을...@>=
p = getNode(rowNodeSize)
setSorted(p, sentinel)
setUnsorted(p, null)
setKnil(p, curEdges)
setKnil(link(curEdges), p) // 새 맨 아래 행
p = getNode(rowNodeSize)
setSorted(p, sentinel)
setKnil(p, knil(curEdges)) // 새 맨 위 행

@ 새 목록들은 나중에 |sorted| 목록이 되므로 빈 목록은 |sentinel|로 초기화한다.

@<새 가장자리 목록 머리들의...@>=
mSpread = mMax(curEdges) - mMin(curEdges) // 가정에 따라 이것은 |>=0|이다
if mSpread > moveSize {
	overflow("move table size", moveSize)
}
@:METAFONT capacity exceeded move table size}{\quad move table size@>
for j = 0; j <= mSpread; j++ {
	move[j] = sentinel
}

@ 무게를 비교하는 지점에서 변수 |w|에는 행~|p|에서 이미 지나간 가장자리들의 쌓인 무게에서 행~|q|에서 이미
지나간 가장자리들의 쌓인 무게를 뺀 것이 들어 있다. 곧 |w|는 지금 열에서 위 화소와 아래 화소의 무게 차다.
두 행의 가장자리 목록을 왼쪽에서 오른쪽으로 합치면서 걸어가는 것이다.

@<이웃한 행 |p,q|가 정하는...@>=
r = sorted(p)
freeNode(p, rowNodeSize)
p = r
pd = ho(info(p))
pm = pd / 8
r = sorted(q)
rd = ho(info(r))
rm = rd / 8
w = 0
for {
	if pm < rm {
		mm = pm
	} else {
		mm = rm
	}
	if w != 0 {
		@<|m|과~|mm| 사이에 무게 |w|인 가로 가장자리들을 넣는다@>
	}
	if pd < rd {
		dw = (pd % 8) - zeroW
		@<포인터 |p|를 다음 세로 가장자리로 나아가게 하고, 앞의 것은 없앤다@>
	} else {
		if r == sentinel {
			break
		} // |rd=pd=ho(maxHalfword)|
		dw = -((rd % 8) - zeroW)
		@<포인터 |r|을 다음 세로 가장자리로 나아가게 한다@>
	}
	m = mm
	w = w + dw
}

@ @<포인터 |r|을 다음...@>=
r = link(r)
rd = ho(info(r))
rm = rd / 8

@ @<포인터 |p|를 다음...@>=
s = link(p)
freeAvail(p)
p = s
pd = ho(info(p))
pm = pd / 8

@ 우리 자료 구조의 여러 오프셋 때문에, 다음 코드가 돌아가게 하려면 어떤 ``마법의'' 값들이 필요하다.
당분간은 그 정확한 값을 걱정하지 말자. 코드가 어떻게 생겼는지 본 다음에 |mMagic|과 |nMagic|을 계산할
것이다.

@ 가장자리 하나의 무게는 많아야 3이므로, 무게가 더 큰 가로 가장자리는 노드 여러 개로 나누어 넣는다.

@<|m|과~|mm| 사이에...@>=
if m != mm {
	if mm-mMagic >= moveSize {
		confusion("xy")
	}
@:this can't happen xy}{\quad xy@>
	extras = (abs(w) - 1) / 3
	if extras > 0 {
		if w > 0 {
			xw = +3
		} else {
			xw = -3
		}
		ww = w - extras*xw
	} else {
		ww = w
	}
	for {
		j = m - mMagic
		for k = 1; k <= extras; k++ {
			s = getAvail()
			setInfo(s, nMagic+xw)
			setLink(s, move[j])
			move[j] = s
		}
		s = getAvail()
		setInfo(s, nMagic+ww)
		setLink(s, move[j])
		move[j] = s
		m++
		if m == mm {
			break
		}
	}
}

@ 이 단계를 시작할 때 |move[mSpread]=sentinel|이다. 열 |mMax(curEdges)|의 오른쪽으로 뻗는 가로 가장자리는
없기 때문이다.

@<새 가장자리를 반영하도록...@>=
move[mSpread] = 0
j = 0
for move[j] == sentinel {
	j++
}
if j == mSpread {
	initEdges(curEdges) // 가장자리 무게가 모두 0이다
} else {
	mm = mMin(curEdges)
	setMMin(curEdges, nMin(curEdges))
	setMMax(curEdges, nMax(curEdges)+1)
	setMOffset(curEdges, zeroField)
	jj = mSpread - 1
	for move[jj] == sentinel {
		jj--
	}
	setNMin(curEdges, j+mm)
	setNMax(curEdges, jj+mm)
	q = curEdges
	for {
		p = getNode(rowNodeSize)
		setLink(q, p)
		setKnil(p, q)
		setSorted(p, move[j])
		setUnsorted(p, null)
		j++
		q = p
		if j > jj {
			break
		}
	}
	setLink(q, curEdges)
	setKnil(curEdges, q)
	setNPos(curEdges, nMax(curEdges)+1)
	setNRover(curEdges, curEdges)
	setLastWindowTime(curEdges, 0)
}

@ 마법의 값 |mMagic|과 |nMagic|은 앞의 코드를 작은 보기에 시험해 보면 알아낼 수 있다. 간단한 경우에 제대로
돌아가면 일반적으로도 제대로 돌아갈 것이다.

@<마법의 오프셋 값들을...@>=
mMagic = mMin(curEdges) + mOffset(curEdges) - zeroField
nMagic = 8*nMax(curEdges) + 8 + zeroW + minHalfword

@ 이제 주어진 가장자리 구조의 가장자리들을 |curEdges|에 합치는 서브루틴을 보자. 주어진 가장자리 구조는
가장자리를 모두 잃는다.

@<함수들@>=
func mergeEdges(h pointer) {
	var p, q, r, pp, qq, rr pointer // 목록 조작 레지스터들
	var n int32 // 행 번호
	var k halfword // |info(q)|와 비교하는 열쇠 레지스터
	var delta int32 // 가장자리와 무게 자료의 변화
	if link(h) != h {
		if mMin(h) < mMin(curEdges) || mMax(h) > mMax(curEdges) ||
			nMin(h) < nMin(curEdges) || nMax(h) > nMax(curEdges) {
			edgePrep(mMin(h)-zeroField, mMax(h)-zeroField, nMin(h)-zeroField, nMax(h)-zeroField+1)
		}
		if mOffset(h) != mOffset(curEdges) {
			@<오프셋의 차이를 반영하도록 |h|의 자료를 고친다@>
		}
		n = nMin(curEdges)
		p = link(curEdges)
		pp = link(h)
		for n < nMin(h) {
			n++
			p = link(p)
		}
		for {
			@<행 |pp|를 행 |p|에 합친다@>
			pp = link(pp)
			p = link(p)
			if pp == h {
				break
			}
		}
	}
}

@ @<오프셋의 차이를 반영하도록...@>=
pp = link(h)
delta = 8 * (mOffset(curEdges) - mOffset(h))
for {
	qq = sorted(pp)
	for qq != sentinel {
		setInfo(qq, info(qq)+delta)
		qq = link(qq)
	}
	qq = unsorted(pp)
	for qq > void {
		setInfo(qq, info(qq)+delta)
		qq = link(qq)
	}
	pp = link(pp)
	if pp == h {
		break
	}
}

@ 두 목록 |sorted|와 |unsorted|는 따로 합친다. 이 단계를 마치면 행~|pp|에는 가장자리가 하나도 남지 않는다.
모두 행~|p|에 합쳐졌기 때문이다.

@<행 |pp|를...@>=
qq = unsorted(pp)
if qq > void {
	if unsorted(p) <= void {
		setUnsorted(p, qq)
	} else {
		for link(qq) > void {
			qq = link(qq)
		}
		setLink(qq, unsorted(p))
		setUnsorted(p, unsorted(pp))
	}
}
setUnsorted(pp, null)
qq = sorted(pp)
if qq != sentinel {
	if unsorted(p) == void {
		setUnsorted(p, null)
	}
	setSorted(pp, sentinel)
	r = sortedLoc(p)
	q = link(r) // |q=sorted(p)|
	if q == sentinel {
		setSorted(p, qq)
	} else {
		for {
			k = info(qq)
			for k > info(q) {
				r = q
				q = link(r)
			}
			setLink(r, qq)
			rr = link(qq)
			setLink(qq, q)
			if rr == sentinel {
				break
			}
			r = qq
			qq = rr
		}
	}
}

@ 루틴 |totalWeight|는 주어진 가장자리 구조의 화소 무게를 모두 더한 값을 계산한다. 이것이 모든 가장자리에
걸쳐 $(-w)$ 곱하기 $x$를 더한 것이라는 증명은 어렵지 않다. 여기서 $w$와~$x$는 가장자리에 저장된 무게와
$x$~좌표다. 가장자리 구조에 가장자리가 174,762개보다 많지 않은 한 $2^{31}$보다 작으므로, 이 양이 |int32|
레지스터의 크기를 넘칠 걱정은 하지 않아도 된다. 그러나 이것을 |scaled| 정수로 계산하려고 해서는 안 된다.
가장자리 넷만으로도 거의 $12\times 2^{12}$의 전체 무게가 나올 수 있기 때문이다.

@<함수들@>=
func totalWeight(h pointer) int32 { // |h|는 가장자리 머리다
	var p, q pointer // 주어진 구조를 훑는 변수들
	var n int32 // 지금까지 쌓인 합계
	var m int32 // 오프셋을 포함해서 꾸린 $x$와 $w$ 값; |0 .. 65535|
	n = 0
	p = link(h)
	for p != h {
		q = sorted(p)
		for q != sentinel {
			@<노드 |q|가 전체 무게에 기여하는 것을 더하고, |q=link(q)|로 놓는다@>
		}
		q = unsorted(p)
		for q > void {
			@<노드 |q|가 전체 무게에...@>
		}
		p = link(p)
	}
	return n
}

@ 가장자리 구조 전체를 옮겨도 전체 무게는 바뀌지 않으므로 $x$ 좌표에 오프셋을 더할 필요는 없다.
비슷하게 |zeroField|를 뺄 필요도 없다.

@<노드 |q|가 전체 무게에...@>=
m = ho(info(q))
n = n - ((m % 8) - zeroW)*(m/8)
q = link(q)

@ 지금까지 우리는 가장자리가 실제로 있다고 가정하고 가장자리 구조에 많은 일을 했지만, 처음에 가장자리가
어떻게 만들어지는지는 보지 않았다. 이제 새 가장자리를 만드는 문제로 눈을 돌리자.

내부 양 |tracingEdges|가 양수이면 \MF는 새 가장자리를 계산하는 대로 표시한다. 그런 자료를 적당히 간결하게 하려고,
경로가 $90^\circ$나 $180^\circ$로 꺾이는 점들만 늘어놓는다.

추적 알고리즘은 쓸데없는 자료를 걸러 내려고 지난 이력의 일부를 기억해야 한다. 세 변수 |traceX|, |traceY|,
|traceYy|가 이 이력을 준다. 마지막으로 찍은 좌표는 |(traceX,traceY)|였고, 앞에서 추적한 가장자리는
|(traceX,traceYy)|에서 끝났다. 아무것도 추적하기 전에는 |traceX=-4096|이다.

@<전역 변수@>=
var @!traceX int32 // 추적에서 가장 최근에 보인 $x$~좌표
var @!traceY int32 // 추적에서 가장 최근에 보인 $y$~좌표
var @!traceYy int32 // 가장 최근에 만난 $y$~좌표

@ 가장자리 추적은 루틴 |beginEdgeTracing|이 시작하고, |traceACorner| 루틴이 이어 가고, |endEdgeTracing|
루틴이 끝낸다.

@<함수들@>=
func beginEdgeTracing() {
	printDiagnostic("Tracing edges", "", true)
	printStr(" (weight ")
	printInt(curWt)
	printChar(')')
	traceX = -4096
}

func traceACorner() {
	if fileOffset > maxPrintLine-13 {
		printNl("")
	}
	printChar('(')
	printInt(traceX)
	printChar(',')
	printInt(traceYy)
	printChar(')')
	traceY = traceYy
}

func endEdgeTracing() {
	if traceX == -4096 {
		printNl("(No new edges added.)")
@.No new edges added@>
	} else {
		traceACorner()
		printChar('.')
	}
	endDiagnostic(true)
}

@ 행~|n|의 노드~|r|의 |info| 필드에 새 가장자리 무게를 막 넣은 다음에는, 다음 루틴이 진행 중인 추적을
이어 간다.

@<함수들@>=
func traceNewEdge(r pointer, n int32) {
	var d int32 // 임시 자료 레지스터
	var w int32 // 가장자리 넘어감에 딸린 무게; |-3 .. 3|
	var m, n0, n1 int32 // 열과 행 번호들
	d = ho(info(r))
	w = (d % 8) - zeroW
	m = (d / 8) - mOffset(curEdges)
	if w == curWt {
		n0 = n + 1
		n1 = n
	} else {
		n0 = n
		n1 = n + 1
	} // 가장자리는 |(m,n0)|에서 |(m,n1)|로 간다
	if m != traceX {
		if traceX == -4096 {
			printNl("")
			traceYy = n0
		} else if traceYy != n0 {
			printChar('?') // 일어나지 않아야 한다
		} else {
			traceACorner()
		}
		traceX = m
		traceACorner()
	} else {
		if n0 != traceYy {
			printChar('!') // 일어나지 않아야 한다
		}
		if (n0 < n1 && traceY > traceYy) || (n0 > n1 && traceY < traceYy) {
			traceACorner()
		}
	}
	traceYy = n1
}

@ 가장자리 구조에 새 가장자리 무게를 넣는 방법 하나는 다음 루틴을 쓰는 것이다. 이것은 그냥 |(x0,y0)|에서
|(x1,y1)|으로 직선을 긋는다. 더 정확히 말하면, $t$가 0에서 1로 바뀌는 동안 이산 경로
$\bigl(\lfloor t[x_0,x_1]+{1\over2}+\epsilon\rfloor,\lfloor t[y_0,y_1]+{1\over2}+\epsilon\delta\rfloor\bigr)$의
가장자리들에 무게를 들여온다. 여기서 $\epsilon$과 $\delta$는 아주 작은 양수다.

구조의 머리는 |curEdges|라고 가정한다. 아래쪽 가장자리의 무게는 |curWt|이고 위쪽 가장자리의 무게는
|-curWt|다.

물론 이 서브루틴은 결국 온전한 순환을 그리는 다른 서브루틴들과 함께 불릴 것이므로, 어떤 행을 표시할
때든 그 행의 가장자리 무게의 합은 0이 될 것이다.

@<함수들@>=
func lineEdges(x0, y0, x1, y1 scaled) {
	var m0, n0, m1, n1 int32 // 반올림하고 눈금을 없앤 좌표들
	var delx, dely scaled // 직선의 좌표 차
	var yt scaled // 반올림하면 |y0|과 같아지는 가장 작은 |y| 좌표
	var tx scaled // |x|의 잠정적인 변화
	var p, r pointer // 목록 조작 레지스터들
	var base int32 // 가장자리와 무게 자료에 더하는 양
	var n int32 // 현재 행 번호
	n0 = roundUnscaled(y0)
	n1 = roundUnscaled(y1)
	if n0 != n1 {
		m0 = roundUnscaled(x0)
		m1 = roundUnscaled(x1)
		delx = x1 - x0
		dely = y1 - y0
		yt = n0*unity - halfUnit
		y0 = y0 - yt
		y1 = y1 - yt
		if n0 < n1 {
			@<직선의 위쪽 가장자리들을 넣는다@>
		} else {
			@<직선의 아래쪽 가장자리들을 넣는다@>
		}
		setNRover(curEdges, p)
		setNPos(curEdges, n+zeroField)
	}
}

@ 여기서는 반올림 오차의 영향을 조심스럽게 지운다.

@<직선의 위쪽 가장자리들을...@>=
base = 8*mOffset(curEdges) + minHalfword + zeroW - curWt
if m0 <= m1 {
	edgePrep(m0, m1, n0, n1)
} else {
	edgePrep(m1, m0, n0, n1)
}
@<|p|가 가리키는 행 |n0|으로 옮겨 간다@>
y0 = unity - y0
for {
	r = getAvail()
	setLink(r, unsorted(p))
	setUnsorted(p, r)
	tx = takeFraction(delx, makeFraction(y0, dely))
	if abVsCd(delx, y0, dely, tx) < 0 {
		tx--
	} // 이제 $|tx|=\lfloor|y0|\cdot|delx|/|dely|\rfloor$이다
	setInfo(r, 8*roundUnscaled(x0+tx)+base)
	y1 = y1 - unity
	if internal[tracingEdges] > 0 {
		traceNewEdge(r, n)
	}
	if y1 < unity {
		break
	}
	p = link(p)
	y0 = y0 + unity
	n++
}

@ @<직선의 아래쪽 가장자리들을...@>=
base = 8*mOffset(curEdges) + minHalfword + zeroW + curWt
if m0 <= m1 {
	edgePrep(m0, m1, n1, n0)
} else {
	edgePrep(m1, m0, n1, n0)
}
n0--
@<|p|가 가리키는 행 |n0|으로...@>
for {
	r = getAvail()
	setLink(r, unsorted(p))
	setUnsorted(p, r)
	tx = takeFraction(delx, makeFraction(y0, dely))
	if abVsCd(delx, y0, dely, tx) < 0 {
		tx++
	} // |dely<0|이므로 이제 $|tx|=\lceil|y0|\cdot|delx|/|dely|\rceil$이다
	setInfo(r, 8*roundUnscaled(x0-tx)+base)
	y1 = y1 + unity
	if internal[tracingEdges] > 0 {
		traceNewEdge(r, n)
	}
	if y1 >= 0 {
		break
	}
	p = knil(p)
	y0 = y0 + unity
	n--
}

@ @<|p|가 가리키는 행 |n0|으로...@>=
n = nPos(curEdges) - zeroField
p = nRover(curEdges)
if n != n0 {
	if n < n0 {
		for {
			n++
			p = link(p)
			if n == n0 {
				break
			}
		}
	} else {
		for {
			n--
			p = knil(p)
			if n == n0 {
				break
			}
		}
	}
}

@ \seclabel{move-to-edges}\MF는 대부분의 가장자리를 서브루틴 |moveToEdges|로 가장자리 구조에 넣는다. 이 루틴은 배열 |move|에
저장된 자료로 ``룩 움직임''의 나열을 지정한다. 이 움직임들의 시작점 |(m0,n0)|과 끝점 |(m1,n1)|은 첫
팔분면의 관점에서 본 것으로 매개변수로 주어진다. 그러나 움직임은 주어진 팔분면으로 돌려야 한다. (팔분면
변환은 나중에 아주 자세히 공부할 것이다. 독자는 팔분면의 신비를 터득한 뒤에 프로그램의 이 부분으로 돌아오고
싶을지도 모른다.)

룩 움직임 자체는 |firstOctant|의 관점에서 다음과 같이 정의된다. ``|0<=k<n1-n0|에 대해 오른쪽으로
|move[k]|걸음 가고, 그다음 위로 한 걸음 간다. 그다음 오른쪽으로 |move[n1-n0]|걸음 가고 멈춘다.''
범위 |0<=k<=n1-n0|에 대한 |move[k]|의 합은 |m1-m0|과 같다.

루틴 |lineEdges|에서처럼, 움직임을 알맞은 팔분면 방향으로 돌린 다음 모든 아래쪽 가장자리의 무게로
|+curWt|를, 모든 위쪽 가장자리의 무게로 |-curWt|를 쓴다.

@ 생각할 주요 경우는 둘이다. 첫째인 \\{fast\_case}는 팔분면 1, 4, 5, 8의 방향으로 가는 움직임을 위한 것이고,
둘째인 \\{slow\_case}는 팔분면 2, 3, 6, 7을 향하는 움직임을 위한 것이다. 뒤의 방향들은 위쪽이나 아래쪽 가장자리를
더 많이 만들므로 비교적 성가시다. 가로로 가는 곡선은 가장자리를 하나도 만들지 않지만, 세로로 가는 곡선은
많은 행을 건드린다.

\GO/의 |goto|는 레이블이 이름 공간을 따로 가지므로, 원본이 레이블 번호로 정의한 상수들은 필요 없다.
네 경우는 레이블 |fastCaseUp|, |fastCaseDown|, |slowCaseUp|, |slowCaseDown|이 된다.

@<함수들@>=
func moveToEdges(m0, n0, m1, n1 int32) {
	var delta int32 // |move| 자료의 범위; |0 .. moveSize|
	var k int32 // |move|의 첨자; |0 .. moveSize|
	var p, r pointer // 목록 조작 레지스터들
	var dx int32 // |x|가 1 바뀔 때 가장자리 무게 |info|의 변화
	var edgeAndWeight int32 // 넣을 |info|
	var j int32 // 잇달아 일어나는 세로 움직임의 수
	var n int32 // |p|가 가리키는 현재 행
	var sum int32 // 디버깅할 때 움직임의 합을 검사하는 데 쓴다
	delta = n1 - n0
	@<디버깅할 때는 움직임의 합이 |m1-m0|인지 검사한다@>
	@<|octant|에 따라 준비하고 알맞은 경우로 간다@>
fastCaseUp:
	@<첫째나 넷째 팔분면의 가장자리를 넣고 |goto done|@>
fastCaseDown:
	@<다섯째나 여덟째 팔분면의 가장자리를 넣고 |goto done|@>
slowCaseUp:
	@<둘째나 셋째 팔분면의 가장자리를 넣고 |goto done|@>
slowCaseDown:
	@<여섯째나 일곱째 팔분면의 가장자리를 넣고 |goto done|@>
done:
	setNPos(curEdges, n+zeroField)
	setNRover(curEdges, p)
}

@ @<디버깅할 때는 움직임의 합이 |m1-m0|인지 검사한다@>=
if debug {
	sum = move[0]
	for k = 1; k <= delta; k++ {
		sum = sum + abs(move[k])
	}
	if sum != m1-m0 {
		confusion("0")
	}
}
@:this can't happen 0}{\quad 0@>

@ 현재 팔분면 코드는 전역 변수에 있다. 이를테면 |octant=thirdOctant|이면, 북쪽에서 북서쪽 방향으로 가는
곡선을 내부 계산을 위해 돌려서 |move| 자료가 동쪽에서 북동쪽 방향으로 가게 했다는 뜻이다. 우리는
가장자리 구조를 갱신하면서 그 회전을 되돌리고 싶다.

@<전역 변수@>=
var @!octant int32 // 지금 관심 있는 팔분면; |firstOctant .. sixthOctant|

@ @<|octant|에 따라 준비하고...@>=
switch octant {
case firstOctant:
	dx = 8
	edgePrep(m0, m1, n0, n1)
	goto fastCaseUp
case secondOctant:
	dx = 8
	edgePrep(n0, n1, m0, m1)
	goto slowCaseUp
case thirdOctant:
	dx = -8
	edgePrep(-n1, -n0, m0, m1)
	n0 = -n0
	goto slowCaseUp
case fourthOctant:
	dx = -8
	edgePrep(-m1, -m0, n0, n1)
	m0 = -m0
	goto fastCaseUp
case fifthOctant:
	dx = -8
	edgePrep(-m1, -m0, -n1, -n0)
	m0 = -m0
	goto fastCaseDown
case sixthOctant:
	dx = -8
	edgePrep(-n1, -n0, -m1, -m0)
	n0 = -n0
	goto slowCaseDown
case seventhOctant:
	dx = 8
	edgePrep(n0, n1, -m1, -m0)
	goto slowCaseDown
case eighthOctant:
	dx = 8
	edgePrep(m0, m1, -n1, -n0)
	goto fastCaseDown
} // 팔분면은 여덟 개뿐이다

@ @<첫째나 넷째 팔분면의...@>=
@<|p|가 가리키는 행 |n0|으로...@>
if delta > 0 {
	k = 0
	edgeAndWeight = 8*(m0+mOffset(curEdges)) + minHalfword + zeroW - curWt
	for {
		edgeAndWeight = edgeAndWeight + dx*move[k]
		r = fastGetAvail()
		setLink(r, unsorted(p))
		setInfo(r, edgeAndWeight)
		if internal[tracingEdges] > 0 {
			traceNewEdge(r, n)
		}
		setUnsorted(p, r)
		p = link(p)
		k++
		n++
		if k == delta {
			break
		}
	}
}
goto done

@ @<다섯째나 여덟째 팔분면의...@>=
n0 = -n0 - 1
@<|p|가 가리키는 행 |n0|으로...@>
if delta > 0 {
	k = 0
	edgeAndWeight = 8*(m0+mOffset(curEdges)) + minHalfword + zeroW + curWt
	for {
		edgeAndWeight = edgeAndWeight + dx*move[k]
		r = fastGetAvail()
		setLink(r, unsorted(p))
		setInfo(r, edgeAndWeight)
		if internal[tracingEdges] > 0 {
			traceNewEdge(r, n)
		}
		setUnsorted(p, r)
		p = knil(p)
		k++
		n--
		if k == delta {
			break
		}
	}
}
goto done

@ @<둘째나 셋째 팔분면의...@>=
edgeAndWeight = 8*(n0+mOffset(curEdges)) + minHalfword + zeroW - curWt
n0 = m0
k = 0
@<|p|가 가리키는 행 |n0|으로...@>
for {
	j = move[k]
	for j > 0 {
		r = fastGetAvail()
		setLink(r, unsorted(p))
		setInfo(r, edgeAndWeight)
		if internal[tracingEdges] > 0 {
			traceNewEdge(r, n)
		}
		setUnsorted(p, r)
		p = link(p)
		j--
		n++
	}
	edgeAndWeight = edgeAndWeight + dx
	k++
	if k > delta {
		break
	}
}
goto done

@ @<여섯째나 일곱째 팔분면의...@>=
edgeAndWeight = 8*(n0+mOffset(curEdges)) + minHalfword + zeroW + curWt
n0 = -m0 - 1
k = 0
@<|p|가 가리키는 행 |n0|으로...@>
for {
	j = move[k]
	for j > 0 {
		r = fastGetAvail()
		setLink(r, unsorted(p))
		setInfo(r, edgeAndWeight)
		if internal[tracingEdges] > 0 {
			traceNewEdge(r, n)
		}
		setUnsorted(p, r)
		p = knil(p)
		j--
		n--
	}
	edgeAndWeight = edgeAndWeight + dx
	k++
	if k > delta {
		break
	}
}
goto done

@ 가장자리 구조를 만드는 모든 고된 일은 다음 서브루틴이 되돌린다.

@<함수들@>=
func tossEdges(h pointer) {
	var p, q pointer // 목록 조작을 위해
	q = link(h)
	for q != h {
		flushList(sorted(q))
		if unsorted(q) > void {
			flushList(unsorted(q))
		}
		p = q
		q = link(q)
		freeNode(p, rowNodeSize)
	}
	freeNode(h, edgeHeaderSize)
}

@* 팔분면으로 나누기.
\MF는 경로를 화소화할 때 문제를 ``첫 팔분면'' 방향으로 가는 경로라는 특별한 경우로 줄인다. 곧
화소화하는 삼차식 $z(t)=\bigl(x(t),y(t)\bigr)$는 저마다 $0\le y'(t)\le x'(t)$라는 성질을 가진다. 이렇게
가정하면 움직이는 방향을 거듭 검사해야 할 때보다 화소화가 더 간단하고 빨라진다.

곡선 $z(t)$가 삼차이면 $x'(t)$와 $y'(t)$는 이차이므로, 네 다항식 $x'(t)$, $y'(t)$, $x'(t)-y'(t)$,
$x'(t)+y'(t)$는 저마다 많아야 두 번 0을 지나간다. 주어진 삼차식을 그곳들에서 나누면 많아야 아홉 개의
부분 구간을 얻는데, 그 각각에서는 $x'(t)$, $y'(t)$, $x'(t)-y'(t)$, $x'(t)+y'(t)$가 모두 부호가 일정하다.
필요에 따라 $x\swap-x$, $y\swap-y$, $x\swap y$를 하면 이 부분 구간 각각에서 곡선이 온전히 첫 팔분면
방향으로 가도록 바꿀 수 있다. (덧붙여 $x'(t)=16(2t-1)^2+2(2t-1)-1$이고 $y'(t)=8(2t-1)^2+4(2t-1)$인
삼차식은 실제로 부분 구간 아홉 개로 나뉨을 보일 수 있다.)

아래 그림은 매끄러운 닫힌 곡선 하나를 팔분면 경계에서 나눈 모습이다. 점은 접선의 방향이
$0^\circ$, $45^\circ$, \dots, $315^\circ$인 곳이고, 그 사이의 조각마다 곡선이 나아가는 팔분면의 이름이
적혀 있다. 이름은 |printSpec|이 쓰는 나침반 방향(\secref{octant-dir})이다.
$$\mplibcode
beginfig(15);
save u, c, t, tt, m, zz, d; numeric u, t[], tt; path c; pair zz, d; u := 28pt;
c := ((0,0){right}..(4,1)..(3.5,3.2)..(-.5,2.6)..cycle) scaled u;
draw c withpen pencircle scaled 1pt;
for k = 0 upto 7: t[k] := directiontime dir(45k) of c; endfor
t[8] := t[0] + length c;
for k = 0 upto 7:
  dot(point t[k] of c);
  tt := if t[k+1] < t[k]: t[k+1] + length c else: t[k+1] fi;
  zz := point (.5[t[k],tt]) of c;
  d := direction (.5[t[k],tt]) of c;
  label(if k=0: btex \.{ENE} etex elseif k=1: btex \.{NNE} etex
        elseif k=2: btex \.{NNW} etex elseif k=3: btex \.{WNW} etex
        elseif k=4: btex \.{WSW} etex elseif k=5: btex \.{SSW} etex
        elseif k=6: btex \.{SSE} etex else: btex \.{ESE} etex fi,
        zz + 12pt*unitvector(d rotated -90));
endfor
endfig;
\endmplibcode$$

@ 첫 팔분면의 움직임을 가정할 수 있도록 좌표를 돌리는 변환은 서브루틴 |skew|가 정의한다. 이 루틴은
주어진 팔분면에 알맞은 값을 전역 변수 |curX|와 |curY|에 넣는다. (팔분면은 서브루틴 |nArg|에서처럼
부호화한다.)

첫 팔분면의 움직임이 세워지면 이 변환은 |(x,y)|를 |(x-y,y)|로 바꾸어 좌표를 ``비스듬하게'' 한다. 실제로
곡선을 화소화할 때는 비스듬한 좌표가 다루기에 얼마쯤 더 좋다는 것이 밝혀졌다. 첫 팔분면에서는
$0\le y'\le x'$이므로 비스듬한 좌표에서는 두 좌표가 모두 단조 비감소가 되어, 19부의 |makeMoves|를 바로
쓸 수 있기 때문이다.

@<함수들@>=
func skew(x, y scaled, octant smallNumber) {
	switch octant {
	case firstOctant:
		curX, curY = x-y, y
	case secondOctant:
		curX, curY = y-x, x
	case thirdOctant:
		curX, curY = y+x, -x
	case fourthOctant:
		curX, curY = -x-y, y
	case fifthOctant:
		curX, curY = -x+y, -y
	case sixthOctant:
		curX, curY = -y+x, -x
	case seventhOctant:
		curX, curY = -y-x, x
	case eighthOctant:
		curX, curY = x+y, -y
	} // 다른 경우는 없다
}

@ 거꾸로, 다음 서브루틴은 팔분면 코드와 함께 첫 팔분면으로 옮겨지고 비스듬해진 다음의 점의 좌표
|(x,y)|가 주어질 때, 그 점의 원래 좌표 값을 |curX|와 |curY|에 넣는다.

@<함수들@>=
func unskew(x, y scaled, octant smallNumber) {
	switch octant {
	case firstOctant:
		curX, curY = x+y, y
	case secondOctant:
		curX, curY = y, x+y
	case thirdOctant:
		curX, curY = -y, x+y
	case fourthOctant:
		curX, curY = -x-y, y
	case fifthOctant:
		curX, curY = -x-y, -y
	case sixthOctant:
		curX, curY = -y, -x-y
	case seventhOctant:
		curX, curY = y, -x-y
	case eighthOctant:
		curX, curY = x+y, -y
	} // 다른 경우는 없다
}

@ @<전역 변수@>=
var @!curX, @!curY scaled // |skew|, |unskew|와 몇몇 다른 루틴의 출력

@ 비스듬하고 돌아간 좌표로 바꾸는 일은 단계적으로 일어나고, 변환의 어떤 지점에서는 곡선이 첫
{\sl 사분면\/}으로 가도록 $x$나 $y$ 좌표의 부호를 바꾸어 두었을 것이다. 이 지점에서 관련된 ``팔분면''
코드는 |firstOctant|(변환을 하지 않았을 때)이거나 |fourthOctant=firstOctant+negateX|($x$의 부호를
바꾸었을 때)이거나 |fifthOctant=firstOctant+negateX+negateY|(둘 다 바꾸었을 때)이거나
|eighthOctant=firstOctant+negateY|($y$의 부호를 바꾸었을 때)다. 루틴 |abnegate|는 이 변환들 가운데 하나에서
다른 하나로 바꾸어야 할 때 쓴다.

@<함수들@>=
func abnegate(x, y scaled, octantBefore, octantAfter smallNumber) {
	if odd(octantBefore) == odd(octantAfter) {
		curX = x
	} else {
		curX = -x
	}
	if (octantBefore > negateY) == (octantAfter > negateY) {
		curY = y
	} else {
		curY = -y
	}
}

@ 이제 나누기에 쓸모 있는 서브루틴이다. 이차 다항식 $B(a,b,c;t)$가 주어지면 함수 |crossingPoint|는
$B(a,b,c;t)$가 양수에서 음수로 바뀌는 0과~1 사이의 유일한 |fraction| 값 |t|를 돌려주고, 그런 값이 없으면
|t=fractionOne+1|을 돌려준다. 계수가 |a<0|이면(그래서 $B(a,b,c;t)$가 |t=0|에서 이미 음수이면) |crossingPoint|는
값 0을 돌려준다.

@<함수들@>=
func crossingPoint(a, b, c int32) fraction {
	var d int32 // 재귀 계수기
	var x, xx, x0, x1, x2 int32 // 이분을 위한 임시 레지스터들
	const noCrossing, oneCrossing, zeroCrossing = fractionOne + 1, fractionOne, 0
	if a < 0 {
		return zeroCrossing
	}
	if c >= 0 {
		if b >= 0 {
			if c > 0 {
				return noCrossing
			} else if a == 0 && b == 0 {
				return noCrossing
			} else {
				return oneCrossing
			}
		}
		if a == 0 {
			return zeroCrossing
		}
	} else if a == 0 {
		if b <= 0 {
			return zeroCrossing
		}
	}
	@<이분법으로 넘어가는 점을 찾되, 있으면 그것을 돌려준다@>
}

@ 차수가 $n=2$일 때는 일반적인 이분법이 아주 간단하므로 |crossingPoint|는 시간이 많이 들지 않는다. 재귀의 각
단계에서 |l|과~|j|로 정의되는 부분 구간이 있어서 $B(a,b,c;2^{-l}(j+t))=B(x_0,x_1,x_2;t)$이고, 우리는
$x_0\ge0$이고 $\min(x_1,x_2)<0$인 부분 구간으로 ``좁혀 들어가고'' 싶다.

계산의 목적에는 |l|과~|j|의 값을 한 변수 $d=2^l+j$로 합치는 것이 편리하다. 그러면 이분 연산은 그냥
$d$를 두 배 하고 어쩌면 1을 더하는 것에 해당하기 때문이다. 게다가 이분의 앞의 관례를 조금 고쳐서 변수
$X_0=2^lx_0$, $X_1=2^l(x_0-x_1)$, $X_2=2^l(x_1-x_2)$를 유지하는 것이 편리하다고 밝혀진다. 이 변수들로는
조건 $x_0\ge0$과 $\min(x_1,x_2)<0$이 $\max(X_1,X_1+X_2)>X_0\ge0$과 같다.

다음 코드는 불변 관계 $0\le|x0|<\max(|x1|,|x1|+|x2|)$, $\vert|x1|\vert<2^{30}$, $\vert|x2|\vert<2^{30}$을
지킨다. 그리고 입력이 $a<2^{30}$, $\vert a-b\vert<2^{30}$, $\vert b-c\vert<2^{30}$을 만족하면 산술 넘침이
일어나지 않도록 짜여 있다.

@<이분법으로 넘어가는 점을...@>=
d = 1
x0 = a
x1 = a - b
x2 = b - c
for {
	x = half(x1 + x2)
	if x1-x0 > x0 {
		x2 = x
		x0 += x0
		d += d
	} else {
		xx = x1 + x - x0
		if xx > x0 {
			x2 = x
			x0 += x0
			d += d
		} else {
			x0 = x0 - xx
			if x <= x0 {
				if x+x2 <= x0 {
					return noCrossing
				}
			}
			x1 = x
			d = d + d + 1
		}
	}
	if d >= fractionOne {
		break
	}
}
return d - fractionOne

@ 팔분면 나누기는 순환, 곧 닫힌 경로에만 적용한다. ``순환 명세''(cycle spec)는 한 팔분면에 속하는 조각들로
@!@^cycle spec@>
나뉜 순환의 삼차 곡선과 팔분면 사상의 명세를 담은 자료 구조다. 이것은 경로를 나타내는 것과 비슷하게 온통
매듭 노드로 이루어진다. 그러나 |explicit| 형의 표시는 더 많은 정보를 주는 양수로 바뀌었다. 또 팔분면
경계에 |endpoint| 자료가 더 들어간다.

삼차 다항식은 매듭 목록의 이웃한 노드 |p|와~|q|에 나타나는 조절점 넷으로 나타난다는 것을 떠올리자.
그 |x|~좌표는 |xCoord(p)|, |rightX(p)|, |leftX(q)|, |xCoord(q)|이고 |y|~좌표도 비슷하다. 이것을 ``|p| 다음의
삼차식''이나 ``|p|와~|q| 사이의 삼차식''이나 ``|q| 앞의 삼차식''이라고 부르기로 한다.

순환 명세는 삼차 곡선과 팔분면 경계가 섞인 순환 목록이다. 삼차식처럼 팔분면 경계도 이웃한 매듭 노드 |p|와~|q|로
나타낸다. 그런 경우에는 |rightType(p)=leftType(q)=endpoint|이고, 필드 |rightX(p)|, |rightY(p)|, |leftX(q)|,
|leftY(q)|는 각각 |rightOctant(p)|, |rightTransition(p)|, |leftOctant(q)|, |leftTransition(q)|라는 다른
필드로 바뀐다. 이를테면 곡선의 방향이 셋째 팔분면에서 넷째 팔분면으로 옮겨 가면 경계 노드들에는
|rightOctant(p)=thirdOctant|, |leftOctant(q)=fourthOctant|, |rightTransition(p)=leftTransition(q)=diagonal|이
들어 있다. 이 가운데 |diagonal| 넘어감은 팔분면 1~\AM~2, 3~\AM~4, 5~\AM~6, 7~\AM~8 사이를 옮겨 갈 때 일어나고, |axis|
넘어감은 팔분면 8~\AM~1, 2~\AM~3, 4~\AM~5, 6~\AM~7 사이를 옮겨 갈 때 일어난다. (이런 넘어감 정보는
중복이지만 편리하다.) 필드 |xCoord(p)|와 |yCoord(p)|에는 셋째 팔분면에서 첫 팔분면으로 돌린 다음의 넘어감
점의 좌표가 들어 있다. 곧 참 좌표가 $(x,y)$이면 노드~|p|에는 좌표 $(y,-x)$가 나타난다. 비슷하게 넘어감
뒤에는 넷째 팔분면 변환이 적용되었을 것이므로 |xCoord(q)=@t$-x$@>|이고 |yCoord(q)=y|다.

노드 |p|와 |q| 사이의 삼차식은 필드 |rightType(p)|와 |leftType(q)|에 양수를 담는다. 값 |endpoint|가 0이므로 이것으로
삼차식과 팔분면 경계를 구별할 수 있다. 순환 명세를 만드는 동안 |rightType(p)|의 값은 현재 팔분면 코드다.
나중에 순환의 포락선(envelope)을 계산할 때는 펜 오프셋의 위치를 가리키게 된다. 원래의 순환 경로의
$k$번째 단계의 어떤 부분 구간에서 나온 삼차식은 |leftType(q)=k|를 가진다.

@<정의@>=
func rightOctant(p pointer) int32            { return rightX(p) } // 넘어감 앞의 팔분면 코드
func setRightOctant(p pointer, v int32)      { setRightX(p, v) }
func leftOctant(p pointer) int32             { return leftX(p) } // 넘어감 뒤의 팔분면
func setLeftOctant(p pointer, v int32)       { setLeftX(p, v) }
func rightTransition(p pointer) int32        { return rightY(p) } // 넘어감의 종류
func setRightTransition(p pointer, v int32)  { setRightY(p, v) }
func leftTransition(p pointer) int32         { return leftY(p) } // 마찬가지; |axis|나 |diagonal|
func setLeftTransition(p pointer, v int32)   { setLeftY(p, v) }

const (
	@!axis = 0 // $x'$축이나 $y'$축을 가로지르는 넘어감
	@!diagonal = 1 // $y'=\pm x'$인 곳의 넘어감
)

@ 다음은 순환 명세를 기호의 꼴로 찍어서 어떤 나누기가 이루어졌는지 볼 수 있게 하는 루틴이다. 점의 좌표는
\MF의 내부 ``돌아간'' 꼴에서 바깥의 ``참'' 꼴로 되돌려 찍는다. 전역 변수~|curSpec|은 팔분면 경계가
시작된 바로 뒤의 매듭, 곧 |leftType(curSpec)=endpoint|인 매듭을 가리켜야 한다.

@<정의@>=
func printTwoTrue(x, y scaled, octant smallNumber) { // 참 좌표로 찍는다
	unskew(x, y, octant)
	printTwo(curX, curY)
}

@ @<함수들@>=
func printSpec(s any) {
	var p, q pointer // 목록을 따라가는 데 쓴다
	var octant smallNumber // 현재 팔분면 코드
	printDiagnostic("Cycle spec", s, true)
@.Cycle spec at line...@>
	p = curSpec
	octant = leftOctant(p)
	printLn()
	printTwoTrue(xCoord(curSpec), yCoord(curSpec), octant)
	printStr(" % beginning in octant `")
	for {
		printStr(octantDir[octant])
		printChar('\'')
		for {
			q = link(p)
			if rightType(p) == endpoint {
				break
			}
			@<|p|와 |q| 사이의 삼차식을 찍는다@>
			p = q
		}
		if q == curSpec {
			break
		}
		p = q
		octant = leftOctant(p)
		printNl("% entering octant `")
	}
@.entering the nth octant@>
	printNl(" & cycle")
	endDiagnostic(true)
}

@ \seclabel{octant-dir}팔분면 방향의 기호 이름은 배열 |octantDir|에 둔다. 이 이름들은 찍기만 하므로 \GO/ 문자열이다.

@<전역 변수@>=
var @!octantDir [sixthOctant + 1]string // 첨자는 |firstOctant .. sixthOctant|

@ @<핵심 변수들의...@>=
octantDir[firstOctant] = "ENE"
octantDir[secondOctant] = "NNE"
octantDir[thirdOctant] = "NNW"
octantDir[fourthOctant] = "WNW"
octantDir[fifthOctant] = "WSW"
octantDir[sixthOctant] = "SSW"
octantDir[seventhOctant] = "SSE"
octantDir[eighthOctant] = "ESE"

@ @<|p|와 |q| 사이의 삼차식을 찍는다@>=
printNl("   ..controls ")
printTwoTrue(rightX(p), rightY(p), octant)
printStr(" and ")
printTwoTrue(leftX(q), leftY(q), octant)
printNl(" ..")
printTwoTrue(xCoord(q), yCoord(q), octant)
printStr(" % segment ")
printInt(leftType(q) - 1)

@ 사용자가 ``이상한 경로''를 알아보도록 돕기 위해 명세를 훨씬 간결하게 찍은 판도 있다.

@<함수들@>=
func printStrange(s any) {
	var p pointer // 목록을 따라가는 데 쓴다
	var f pointer // 순환에서 출발점
	var q pointer // 찍을 팔분면 경계
	var t int32 // 조각 번호에 1을 더한 것
	if interaction == errorStopMode {
		wakeUpTerminal()
	}
	printNl(">")
@.>\relax@>
	@<출발점 |f|를 찾는다@>
	@<|f| 앞의 팔분면 경계 |q|를 정한다@>
	t = 0
	for {
		if leftType(p) != endpoint {
			if leftType(p) != t {
				t = leftType(p)
				printChar(' ')
				printInt(t - 1)
			}
			if q != null {
				@<|q|에서 시작하는 꺾음들이 있으면 찍고, |q|를 나아가게 한다@>
				printChar(' ')
				printStr(octantDir[leftOctant(q)])
				q = null
			}
		} else if q == null {
			q = p
		}
		p = link(p)
		if p == f {
			break
		}
	}
	printChar(' ')
	printInt(leftType(p) - 1)
	if q != null {
		@<|q|에서 시작하는 꺾음들이...@>
	}
	printErr(s)
}

@ 순환의 조각 번호가 $t_1$, $t_2$, \dots, $t_m$이고 |m<=maxQuarterword|이면, 많아야 $k$의 값 하나를
빼고는 $t_{k-1}\le t_k$다. 예외가 없으면 $f$는 $t_1$을 가리키고, 예외가 있으면 그 예외인~$t_k$를 가리킨다.

조각 번호는 적어도 하나 있다(곧 언제나 $m>0$이다). 루틴 |printStrange|는 온통 ``죽은'' 순환을 보이라고 불리는
일이 결코 없기 때문이다.

@<출발점 |f|를...@>=
p = curSpec
t = maxQuarterword + 1
for {
	p = link(p)
	if leftType(p) != endpoint {
		if leftType(p) < t {
			f = p
		}
		t = leftType(p)
	}
	if p == curSpec {
		break
	}
}

@ @<|f| 앞의 팔분면 경계...@>=
p = curSpec
q = p
for {
	p = link(p)
	if leftType(p) == endpoint {
		q = p
	}
	if p == f {
		break
	}
}

@ 팔분면 경계 둘이 이웃해 있으면 경로는 움직이지 않고 방향만 바꾸고 있는 것이다. 그런 팔분면 방향은
괄호 안에 보인다.

@<|q|에서 시작하는 꺾음들이...@>=
if leftType(link(q)) == endpoint {
	printStr(" (")
	printStr(octantDir[leftOctant(q)])
	q = link(q)
	for leftType(link(q)) == endpoint {
		printChar(' ')
		printStr(octantDir[leftOctant(q)])
		q = link(q)
	}
	printChar(')')
}

@ 루틴 |makeSpec|이 경로를 팔분면으로 나눈다. 순환 경로를 가리키는 포인터 |curSpec|이 주어지면 |makeSpec|은
경로 자료를 주물러서 그에 해당하는 순환 명세를 가리키는 포인터를 돌려준다. 결과에서는 ``죽은'' 삼차식(곧
출발점에서 전혀 움직이지 않는 삼차식)이 모두 없어진다.
@!@^dead cubics@>

루틴 |makeSpec|의 생각은 꽤 간단하다. 각 삼차식을 먼저 필요하면 한 팔분면에 속하는 조각들로 나누고, 그다음
팔분면 경계를 끼워 넣는다. 그러나 이 변환의 세부 가운데 몇몇은 그리 뻔하지 않다.

내부 양이 |autorounding>0|이면 |curPen|이라고 부르는 펜에 대해 중요한 접선 방향들이 ``좋은'' 점에서 일어나도록
경로를 고친다.

결과 명세의 모든 |x|와 |y| 좌표는 절댓값이 많아야 $2^{28}-|halfUnit|-1-|safetyMargin|$이다. 돌려주는
포인터는 |printSpec|이 요구하듯이 어떤 팔분면의 시작을 가리킨다.

@<함수들@>=
func makeSpec(h pointer, safetyMargin scaled, tracing int32) pointer {
	@t\qquad@>// 경로를 순환 명세로 바꾼다
	var p, q, r, s pointer // 목록을 따라가는 데 쓴다
	var k int32 // 경로 조각의 일련번호, 또는 팔분면 코드
	var chopped int32 // 자료를 잘랐으면 양수, 자료가 위험하게 크면 음수
	var o1, o2 smallNumber // 팔분면 번호들
	var clockwise bool // 시계 방향으로 돌아야 하나?
	var dx1, dy1, dx2, dy2 int32 // 뾰족점에서 가는 방향들
	var dmax, del int32 // 임시 레지스터들
	curSpec = h
	if tracing > 0 {
		printPath(curSpec, ", before subdivision into octants", true)
	}
	maxAllowed = fractionOne - halfUnit - 1 - safetyMargin
	@<|maxAllowed|를 넘는 좌표 값을 모두 잘라 내고, 각 |leftType| 필드에 조각 번호를 찍는다@>
	quadrantSubdivide() // 각 삼차식을 사분면에 속하는 조각들로 나눈다
	if internal[autorounding] > 0 && chopped == 0 {
		xyRound()
	}
	octantSubdivide() // 나누기를 마친다
	if internal[autorounding] > unity && chopped == 0 {
		diagRound()
	}
	@<죽은 삼차식들을 없앤다@>
	@<팔분면 경계를 끼워 넣고 꺾임 수를 계산한다@>
	for leftType(curSpec) != endpoint {
		curSpec = link(curSpec)
	}
	@<추적이 요청되었으면 나눈 명세를 보이고, 그것을 돌려준다@>
}

@ 명세를 보일 때는 자동 반올림을 몇 번 했는지 함께 알린다.

@<추적이 요청되었으면 나눈 명세를 보이고, 그것을 돌려준다@>=
if tracing > 0 {
	if internal[autorounding] <= 0 || chopped != 0 {
		printSpec(", after subdivision")
	} else if internal[autorounding] > unity {
		printSpec(", after subdivision and double autorounding")
	} else {
		printSpec(", after subdivision and autorounding")
	}
}
return curSpec

@ 루틴 |makeSpec|에는 재미있는 부수 효과가 있다. 전역 변수 |turningNumber|를 주어진 순환 경로의 접선
벡터가 원점을 감은 횟수로 놓는다.

또 하나의 전역 변수 |curSpec|은 만들어지고 있는 명세를 가리킨다. 여러 서브루틴이 그것에 손을 대야 하기
때문이다.

그리고 나중에 보겠지만 반올림 결정에 영향을 주는 전역 변수가 둘 있는데, |curPen|과 |curPathType|이라고
부른다. 뒤의 것은 |makeSpec|을 이중 경로에 적용할 때 |doublePathCode|가 된다.

@<정의@>=
const (
	@!doublePathCode = 0 // `\KW{doublepath}'의 명령 수식자
	@!contourCode = 1 // `\KW{contour}'의 명령 수식자
	@!alsoCode = 2 // `\KW{also}'의 명령 수식자
)

@ @<전역 변수@>=
var @!curSpec pointer // |makeSpec|의 주된 출력
var @!turningNumber int32 // |makeSpec|의 또 하나의 출력
var @!curPen pointer // |makeSpec|의 암묵적인 입력; 자동 반올림에 쓴다
var @!curPathType int32 // 마찬가지; |doublePathCode .. contourCode|
var @!maxAllowed scaled // 좌표는 많아야 이만큼 커야 한다

@ 먼저 간단한 전처리 단계를 한다. 여기서 넣는 조각 번호는 부분 구간들로 나뉘는 삼차식의 모든 자손에게
퍼진다. 이 번호들은 0이 아니어야 하지만, 그 밖에는 진단 목적으로만 있다. ``시간 구간'' |(t-1) .. t|를
나타내는 |p|에서~|q|로 가는 삼차식은 대개 |leftType(q)=t|를 가진다. 다만 |t|가 너무 커서 쿼터워드에
넣을 수 없을 때는 그렇지 않다.

@ 좌표를 잘라 내는 일은 프로크루스테스의 침대처럼 너무 긴 것을 잘라 맞춘다. 그 일을 하는 작은 함수
|procrustes|는 이 절에서만 쓰이므로 함수 리터럴로 둔다. 그것은 좌표 하나를 받아 잘라 낸 값을 돌려준다.

@<|maxAllowed|를 넘는 좌표 값을...@>=
procrustes := func(x scaled) scaled {
	if abs(x) >= dmax {
		if abs(x) > maxAllowed {
			chopped = 1
			if x > 0 {
				x = maxAllowed
			} else {
				x = -maxAllowed
			}
		} else if chopped == 0 {
			chopped = -1
		}
	}
	return x
}
p = curSpec
k = 1
chopped = 0
dmax = half(maxAllowed)
for {
	setLeftX(p, procrustes(leftX(p)))
	setLeftY(p, procrustes(leftY(p)))
	setXCoord(p, procrustes(xCoord(p)))
	setYCoord(p, procrustes(yCoord(p)))
	setRightX(p, procrustes(rightX(p)))
	setRightY(p, procrustes(rightY(p)))
	p = link(p)
	setLeftType(p, k)
	if k < maxQuarterword {
		k++
	} else {
		k = 1
	}
	if p == curSpec {
		break
	}
}
@<좌표를 잘라 냈으면 오류를 알린다@>

@ 변수 |chopped|가 양수이면 실제로 잘라 낸 좌표가 있었다는 뜻이다. 음수이면 좌표가 |maxAllowed|의 절반을 넘었을 뿐이어서
오류는 아니다. 그래도 |chopped|가 0이 아니면 뒤에서 자동 반올림을 하지 않는다. 그렇게 큰 좌표를 반올림하면 넘칠 수
있기 때문이다.

@<좌표를 잘라 냈으면 오류를 알린다@>=
if chopped > 0 {
	printErr("Curve out of range")
@.Curve out of range@>
	help4("At least one of the coordinates in the path I'm about to",
		"digitize was really huge (potentially bigger than 4095).",
		"So I've cut it back to the maximum size.",
		"The results will probably be pretty wild.")
	putGetError()
}

@ 자료 구조를 어지럽히고 자동 반올림을 방해하는 일정한 ``죽은'' 삼차식을 없애야 할 수도 있다.

@<함수들@>=
func removeCubic(p pointer) { // |p| 다음의 삼차식을 없앤다
	var q pointer // 사라지는 노드
	q = link(p)
	setRightType(p, rightType(q))
	setLink(p, link(q))
	setXCoord(p, xCoord(q))
	setYCoord(p, yCoord(q))
	setRightX(p, rightX(q))
	setRightY(p, rightY(q))
	freeNode(q, knotNodeSize)
}

@ 나누기 과정은 먼저 필요하면 $x\swap-x$를 바꾸어 $x'\ge0$이 되게 하고, 그다음 필요하면 $y\swap-y$를
바꾸어 $y'\ge0$이 되게 하고, 끝으로 필요하면 $x\swap y$를 바꾸어 $x'\ge y'$이 되게 한다.

팔분면 코드는 이를테면 |thirdOctant=firstOctant+negateX+switchXAndY|가 되도록 정의되었음을 떠올리자.
프로그램은 ``이중 부호 바꿈''을 다루려고 |negateX<negateY<switchXAndY|라는 사실을 쓴다. 어떤 팔분면 코드 |c|가 |negateX|나
|negateY|는 담을 수 있지만 |switchXAndY|는 담지 않는다면, |y|의 부호를 바꾸면 |c|는 |c<=negateY|인지
|c>negateY|인지에 따라 |c+negateY|나 |c-negateY|로 바뀐다. 팔분면 코드는 언제나 0보다 크다.

첫 단계는 |x|와 |y|에 대해서만 나누는 것이다. 그래야 $x'$과 $y'$을 비교하기 전에 가로와 세로의 자동
반올림을 할 수 있다.

바깥 루프를 다시 시작하는 일은 루프의 레이블 |nextCubic|에 대한 |continue|로 한다. 안쪽의 루프 안에서도
바깥 루프로 가야 하기 때문이다.

@<함수들@>=
func quadrantSubdivide() {
	var p, q, r, s, pp, qq pointer // 목록을 따라가는 데 쓴다
	var firstX, firstY scaled // 노드 |curSpec|의 부호를 바꾸지 않은 좌표
	var del1, del2, del3, del, dmax scaled // 삼차식에서 이끌어 낸 이차식의
	@t\qquad@>// 조절점에 비례하는 양들
	var t fraction // 이차식이 0을 지나는 곳
	var destX, destY scaled // 현재 삼차식에서 |x|와 |y|의 마지막 값
	var constantX bool // |p|와 |q| 사이에서 |x|가 일정한가?
	p = curSpec
	firstX = xCoord(curSpec)
	firstY = yCoord(curSpec)
nextCubic:
	for {
		q = link(p)
		@<|p|와 |q| 사이의 삼차식을 나누어 그 결과가 오른쪽 반평면으로 가게 한다@>
		@<|p|와 |q| 사이의 삼차식들을 첫 사분면으로 나눈다; 죽었으면 |return|이나 |continue nextCubic|@>
		p = q
		if p == curSpec {
			break
		}
	}
}

@ 세 나누기 과정은 비슷하므로 첫째(가장 간단한 것)를 공부하면 대강의 생각을 얻을 수 있다. 계산은
번스타인 다항식의 도함수가 $B'(z_0,z_1,\ldots,z_n;t)=nB(z_1-z_0,\ldots,z_n-z_{n-1};t)$를 만족한다는 사실을 쓴다.

이 루틴을 시작할 때 |rightType(p)|는 |explicit|이다. 우리는 |rightType(p)=firstOctant|로 놓아야 한다. 그러나
|explicit=firstOctant|이므로 아무 대입도 하지 않는다. 저자는 여기서 이런 꼼수를 쓴 것을 사과한다. 순수함을
위해서만 중복 계산을 하기는 참 어렵다.

@<|p|와 |q| 사이의 삼차식을 나누어 그 결과가 오른쪽...@>=
if q == curSpec {
	destX = firstX
	destY = firstY
} else {
	destX = xCoord(q)
	destY = yCoord(q)
}
del1 = rightX(p) - xCoord(p)
del2 = leftX(q) - rightX(p)
del3 = destX - leftX(q)
@<정확도를 높이려고 |del1|, |del2|, |del3|를 키우고, |del|을 그 가운데 0이 아닌 첫 것으로 놓는다@>
if del == 0 {
	constantX = true
} else {
	constantX = false
	if del < 0 {
		@<|p|와~|q| 사이의 삼차식의 |x| 좌표를 보완한다@>
	}
	t = crossingPoint(del1, del2, del3)
	if t < fractionOne {
		@<$x'$에 대해 삼차식을 나누되, 두 번 나눌 수도 있다@>
	}
}

@ 만일 |del1=del2=del3=0|이면 이 절의 제목을 따를 수 없다. 그 경우에는 그냥 |del=0|으로 놓는다.
@^inner loop@>

@<정확도를 높이려고...@>=
if del1 != 0 {
	del = del1
} else if del2 != 0 {
	del = del2
} else {
	del = del3
}
if del != 0 {
	dmax = abs(del1)
	if abs(del2) > dmax {
		dmax = abs(del2)
	}
	if abs(del3) > dmax {
		dmax = abs(del3)
	}
	for dmax < fractionHalf {
		dmax += dmax
		del1 += del1
		del2 += del2
		del3 += del3
	}
}

@ 루틴 |makeSpec|의 나누기 단계 동안 노드~|q|의 |xCoord|와 |yCoord| 필드는 |rightType(p)|에 적힌 팔분면에 맞게
바뀌지 않는다. 그것들은 |rightType(q)|와 어울리는 채로 남아 있다. 그러나 |leftX(q)|와 |leftY(q)|는
|rightType(p)|를 따른다.

@<|p|와~|q| 사이의 삼차식의 |x| 좌표를...@>=
setXCoord(p, -xCoord(p))
setRightX(p, -rightX(p))
setLeftX(q, -leftX(q))
del1 = -del1
del2 = -del2
del3 = -del3
destX = -destX
setRightType(p, firstOctant+negateX)

@ 삼차식을 |fraction| 값 |t|에서 나누면 두 삼차식을 얻는데, 그 베지에 조절점은 이분 과정을 일반화해서
얻는다. 공식 `$z_k^{(j+1)}={1\over2}(z_k^{(j)}+z\k^{(j)})$'가 `$z_k^{(j+1)}=t[z_k^{(j)},z\k^{(j)}]$'가 된다.

함수 |tOfTheWay(a,b,t)|가 |a-(a-b)*t|, 곧 |t[a,b]|를 계산하도록 정의하면 편리하다.

인자가 |0<=t<=1|이면 양 |t[a,b]|는 반올림 오차가 있더라도 언제나 |a|와~|b| 사이에 있다. 우리의 서브루틴은 항등식
|t[a,b]+t[b,a]=a+b|도 지킨다.

@<정의@>=
func tOfTheWay(a, b int32, t fraction) int32 { return a - takeFraction(a-b, t) }

@ @<함수들@>=
func splitCubic(p pointer, t fraction, xq, yq scaled) { // |p| 다음의 삼차식을 나눈다
	var v scaled // 중간 값
	var q, r pointer // 목록 조작을 위해
	q = link(p)
	r = getNode(knotNodeSize)
	setLink(p, r)
	setLink(r, q)
	setLeftType(r, leftType(q))
	setRightType(r, rightType(p))
	v = tOfTheWay(rightX(p), leftX(q), t)
	setRightX(p, tOfTheWay(xCoord(p), rightX(p), t))
	setLeftX(q, tOfTheWay(leftX(q), xq, t))
	setLeftX(r, tOfTheWay(rightX(p), v, t))
	setRightX(r, tOfTheWay(v, leftX(q), t))
	setXCoord(r, tOfTheWay(leftX(r), rightX(r), t))
	v = tOfTheWay(rightY(p), leftY(q), t)
	setRightY(p, tOfTheWay(yCoord(p), rightY(p), t))
	setLeftY(q, tOfTheWay(leftY(q), yq, t))
	setLeftY(r, tOfTheWay(rightY(p), v, t))
	setRightY(r, tOfTheWay(v, leftY(q), t))
	setYCoord(r, tOfTheWay(leftY(r), rightY(r), t))
}

@ 도함수 $x'(t)$는 이차식이므로 많아야 두 번 0을 지날 수 있다. 0을 지날 때는, 반올림 오차 때문에 나눈 삼차식의
도함수가 0이 아닌 것처럼 보이는 경우에 대비해서, 나누는 점에서 도함수가 정말 0이 되도록 이중으로
확인한다. 또 나눈 삼차식이 단조인지도 확인한다.

@<$x'$에 대해 삼차식을 나누되...@>=
splitCubic(p, t, destX, destY)
r = link(p)
if rightType(r) > negateX {
	setRightType(r, firstOctant)
} else {
	setRightType(r, firstOctant+negateX)
}
if xCoord(r) < xCoord(p) {
	setXCoord(r, xCoord(p))
}
setLeftX(r, xCoord(r))
if rightX(p) > xCoord(r) {
	setRightX(p, xCoord(r))
} // 언제나 |xCoord(p)<=rightX(p)|다
setXCoord(r, -xCoord(r))
setRightX(r, xCoord(r))
setLeftX(q, -leftX(q))
destX = -destX
del2 = tOfTheWay(del2, del3, t) // 이제 |0,del2,del3|이 나머지 구간에서 $x'$을 나타낸다
if del2 > 0 {
	del2 = 0
}
t = crossingPoint(0, -del2, -del3)
if t < fractionOne {
	@<$x'$에 대해 삼차식을 두 번째로 나눈다@>
} else {
	if xCoord(r) > destX {
		setXCoord(r, destX)
		setLeftX(r, -xCoord(r))
		setRightX(r, xCoord(r))
	}
	if leftX(q) > destX {
		setLeftX(q, destX)
	} else if leftX(q) < xCoord(r) {
		setLeftX(q, xCoord(r))
	}
}

@ @<$x'$에 대해 삼차식을 두 번째로...@>=
splitCubic(r, t, destX, destY)
s = link(r)
if xCoord(s) < destX {
	setXCoord(s, destX)
}
if xCoord(s) < xCoord(r) {
	setXCoord(s, xCoord(r))
}
setRightType(s, rightType(p))
setLeftX(s, xCoord(s)) // 이제 |xCoord(r)=rightX(r)<=leftX(s)|다
if leftX(q) < destX {
	setLeftX(q, -destX)
} else if leftX(q) > xCoord(s) {
	setLeftX(q, -xCoord(s))
} else {
	setLeftX(q, -leftX(q))
}
setXCoord(s, -xCoord(s))
setRightX(s, xCoord(s))

@ 도함수 $y'$에 대해 나누는 과정은 $x'$에 대해 나누는 과정과 같은데, |p|와~|q| 사이에 이제 삼차식이 둘이나 셋
나타날 수 있다는 점이 조금 더 복잡하다.

@<|p|와 |q| 사이의 삼차식들을 첫 사분면으로 나눈다; 죽었으면 |return|이나 |continue nextCubic|@>=
pp = p
for {
	qq = link(pp)
	abnegate(xCoord(qq), yCoord(qq), rightType(qq), rightType(pp))
	destX = curX
	destY = curY
	del1 = rightY(pp) - yCoord(pp)
	del2 = leftY(qq) - rightY(pp)
	del3 = destY - leftY(qq)
	@<정확도를 높이려고...@>
	if del != 0 { // 모두 0은 아니었다
		if del < 0 {
			@<|pp|와~|qq| 사이의 삼차식의 |y| 좌표를 보완한다@>
		}
		t = crossingPoint(del1, del2, del3)
		if t < fractionOne {
			@<$y'$에 대해 삼차식을 나누되, 두 번 나눌 수도 있다@>
		}
	} else {
		@<|y|가 일정할 때의 특별한 일을 한다; 죽은 삼차식을 없앴으면 |return|이나 |continue nextCubic|@>
	}
	pp = qq
	if pp == q {
		break
	}
}
if constantX {
	@<|y|가 줄어드는 조각들의 팔분면 코드를 바로잡는다@>
}

@ @<|pp|와~|qq| 사이의 삼차식의 |y| 좌표를...@>=
setYCoord(pp, -yCoord(pp))
setRightY(pp, -rightY(pp))
setLeftY(qq, -leftY(qq))
del1 = -del1
del2 = -del2
del3 = -del3
destY = -destY
setRightType(pp, rightType(pp)+negateY)

@ @<$y'$에 대해 삼차식을 나누되...@>=
splitCubic(pp, t, destX, destY)
r = link(pp)
if rightType(r) > negateY {
	setRightType(r, rightType(r)-negateY)
} else {
	setRightType(r, rightType(r)+negateY)
}
if yCoord(r) < yCoord(pp) {
	setYCoord(r, yCoord(pp))
}
setLeftY(r, yCoord(r))
if rightY(pp) > yCoord(r) {
	setRightY(pp, yCoord(r))
} // 언제나 |yCoord(pp)<=rightY(pp)|다
setYCoord(r, -yCoord(r))
setRightY(r, yCoord(r))
setLeftY(qq, -leftY(qq))
destY = -destY
@<새 매듭 |r|의 $x$~좌표를 맞추고 이웃 조절점이 단조성을 어기지 않게 한다@>
del2 = tOfTheWay(del2, del3, t) // 이제 |0,del2,del3|이 나머지 구간에서 $y'$을 나타낸다
if del2 > 0 {
	del2 = 0
}
t = crossingPoint(0, -del2, -del3)
if t < fractionOne {
	@<$y'$에 대해 삼차식을 두 번째로 나눈다@>
} else {
	if yCoord(r) > destY {
		setYCoord(r, destY)
		setLeftY(r, -yCoord(r))
		setRightY(r, yCoord(r))
	}
	if leftY(qq) > destY {
		setLeftY(qq, destY)
	} else if leftY(qq) < yCoord(r) {
		setLeftY(qq, yCoord(r))
	}
}

@ 나눈 점 |r|의 $x$~좌표는 |pp|와 목적지 사이에 있어야 한다. 반올림 오차로 이것이 깨졌으면 |r|을 옮기고 |r| 둘레의 조절점들도 그에 맞게 당긴다.

@<새 매듭 |r|의 $x$~좌표를 맞추고 이웃 조절점이 단조성을 어기지 않게 한다@>=
if xCoord(r) < xCoord(pp) {
	setXCoord(r, xCoord(pp))
} else if xCoord(r) > destX {
	setXCoord(r, destX)
}
if leftX(r) > xCoord(r) {
	setLeftX(r, xCoord(r))
	if rightX(pp) > xCoord(r) {
		setRightX(pp, xCoord(r))
	}
}
if rightX(r) < xCoord(r) {
	setRightX(r, xCoord(r))
	if leftX(qq) < xCoord(r) {
		setLeftX(qq, xCoord(r))
	}
}

@ @<$y'$에 대해 삼차식을 두 번째로...@>=
splitCubic(r, t, destX, destY)
s = link(r)
if yCoord(s) < destY {
	setYCoord(s, destY)
}
if yCoord(s) < yCoord(r) {
	setYCoord(s, yCoord(r))
}
setRightType(s, rightType(pp))
setLeftY(s, yCoord(s)) // 이제 |yCoord(r)=rightY(r)<=leftY(s)|다
if leftY(qq) < destY {
	setLeftY(qq, -destY)
} else if leftY(qq) > yCoord(s) {
	setLeftY(qq, -yCoord(s))
} else {
	setLeftY(qq, -leftY(qq))
}
setYCoord(s, -yCoord(s))
setRightY(s, yCoord(s))
if xCoord(s) < xCoord(r) {
	setXCoord(s, xCoord(r))
} else if xCoord(s) > destX {
	setXCoord(s, destX)
}
if leftX(s) > xCoord(s) {
	setLeftX(s, xCoord(s))
	if rightX(r) > xCoord(s) {
		setRightX(r, xCoord(s))
	}
}
if rightX(s) < xCoord(s) {
	setRightX(s, xCoord(s))
	if leftX(qq) < xCoord(s) {
		setLeftX(qq, xCoord(s))
	}
}

@ 삼차식이 $y$에서 일정하고 $x$에서 늘어나면 우리는 그것을 첫 팔분면으로 가는 것으로 분류했다. 삼차식이
$y$에서 일정하고 $x$에서 줄어들면 그것을 (넷째가 아니라) 다섯째 팔분면으로 가는 것으로 분류하는 것이
바람직하다. 경로를 뒤집을 때 팔분면 번호가 4만큼 바뀌어야만 자동 반올림이 이중 경로에 대해 일관되기
때문이다. 그래서 $y$ 좌표가 일정하지만 곡선이 $x$에서 줄어들 때 $y$ 좌표의 부호를 바꾼다. 이렇게 하면
병적인 경로를 빼고는 원하는 결과가 나온다.

삼차식이 ``죽었으면'', 곧 |x|와 |y|에서 모두 일정하면, 그것이 경로 전체에서 유일한 삼차식이 아닌 한 그것을
없앤다. 그것이 마지막 삼차식이 아니었으면 |continue nextCubic|으로 바깥 루프를 다시 시작한다. 그래야
검사 |p=curSpec|이 모든 삼차식을 처리했다고 잘못 암시하지 않는다.

@<|y|가 일정할 때...@>=
if constantX { // |p=pp|, |q=qq|이고 삼차식은 죽었다
	if q != p {
		removeCubic(p) // 죽은 순환을 없애고 노드 |q|를 재활용한다
		if curSpec != q {
			continue nextCubic
		}
		curSpec = p
		return // 마지막 삼차식이 죽어서 사라졌다
	}
} else if !odd(rightType(pp)) { // $x$ 좌표의 부호를 바꾸었다
	@<|pp|와~|qq| 사이의 삼차식의 |y| 좌표를...@>
}

@ 좌표 |x|가 일정하고 |y|가 줄어들 때도 팔분면 코드를 비슷하게 바로잡을 만하다.

@<|y|가 줄어드는 조각들의...@>=
pp = p
for {
	qq = link(pp)
	if rightType(pp) > negateY { // $y$ 좌표의 부호를 바꾸었다
		setRightType(pp, rightType(pp)+negateX)
		setXCoord(pp, -xCoord(pp))
		setRightX(pp, -rightX(pp))
		setLeftX(qq, -leftX(qq))
	}
	pp = qq
	if pp == q {
		break
	}
}

@ 끝으로, $x'\ge y'$이 되게 나누는 과정은 다른 두 나누기와 비슷한데, 새로운 꼬임이 몇 개 있다. 이때
좌표를 비스듬하게 한다.

@<함수들@>=
func octantSubdivide() {
	var p, q, r, s pointer // 목록을 따라가는 데 쓴다
	var del1, del2, del3, del, dmax scaled // 삼차식에서 이끌어 낸 이차식의
	@t\qquad@>// 조절점에 비례하는 양들
	var t fraction // 이차식이 0을 지나는 곳
	var destX, destY scaled // 현재 삼차식에서 |x|와 |y|의 마지막 값
	p = curSpec
	for {
		q = link(p)
		setXCoord(p, xCoord(p)-yCoord(p))
		setRightX(p, rightX(p)-rightY(p))
		setLeftX(q, leftX(q)-leftY(q))
		@<|p|와 |q| 사이의 삼차식을 나누어 그 결과가 첫 팔분면으로 가게 한다@>
		p = q
		if p == curSpec {
			break
		}
	}
}

@ @<|p|와 |q| 사이의 삼차식을 나누어 그 결과가 첫 팔분면...@>=
@<변수 |(del1,del2,del3)|이 $x'-y'$을 나타내게 놓는다@>
@<정확도를 높이려고...@>
if del != 0 { // 모두 0은 아니었다
	if del < 0 {
		@<|p|와~|q| 사이의 삼차식의 |x|와 |y| 좌표를 맞바꾼다@>
	}
	t = crossingPoint(del1, del2, del3)
	if t < fractionOne {
		@<$x'-y'$에 대해 삼차식을 나누되, 두 번 나눌 수도 있다@>
	}
}

@ @<변수 |(del1,del2,del3)|이 $x'-y'$을...@>=
if q == curSpec {
	unskew(xCoord(q), yCoord(q), rightType(q))
	skew(curX, curY, rightType(p))
	destX = curX
	destY = curY
} else {
	abnegate(xCoord(q), yCoord(q), rightType(q), rightType(p))
	destX = curX - curY
	destY = curY
}
del1 = rightX(p) - xCoord(p)
del2 = leftX(q) - rightX(p)
del3 = destX - leftX(q)

@ 좌표가 비스듬하므로 여기서 맞바꾸는 것은 그냥 |x|와 |y| 값을 맞바꾸는 것이 아니다. 비스듬한 좌표
$(x-y,y)$에서는 $x$와 $y$를 맞바꾼 것이 $(y-x,x)=(-(x-y),(x-y)+y)$이므로, 대입문 셋이 아니라 둘로 할 수
있어서 보통의 맞바꿈보다 오히려 쉽다.

@<|p|와~|q| 사이의 삼차식의 |x|와 |y| 좌표를...@>=
setYCoord(p, xCoord(p)+yCoord(p))
setXCoord(p, -xCoord(p))
setRightY(p, rightX(p)+rightY(p))
setRightX(p, -rightX(p))
setLeftY(q, leftX(q)+leftY(q))
setLeftX(q, -leftX(q))
del1 = -del1
del2 = -del2
del3 = -del3
destY = destX + destY
destX = -destX
setRightType(p, rightType(p)+switchXAndY)

@ 고약한 반올림 오차가 단조성의 가정을 무너뜨리지 않도록 조금 지루한 경우 분석을 여기서 한다.

@<$x'-y'$에 대해 삼차식을 나누되...@>=
splitCubic(p, t, destX, destY)
r = link(p)
if rightType(r) > switchXAndY {
	setRightType(r, rightType(r)-switchXAndY)
} else {
	setRightType(r, rightType(r)+switchXAndY)
}
@<새 매듭 |r|의 $y$~좌표를 맞추고 이웃 조절점이 단조성을 어기지 않게 한다@>
@<새 매듭 |r|의 $x$~좌표를 맞추고 |r|부터 |q|까지의 좌표를 맞바꾼다@>
if rightY(r) < yCoord(r) {
	setRightY(r, yCoord(r))
	if leftY(q) < yCoord(r) {
		setLeftY(q, yCoord(r))
	}
}
del2 = tOfTheWay(del2, del3, t) // 이제 |0,del2,del3|이 나머지 구간에서 $x'-y'$을 나타낸다
if del2 > 0 {
	del2 = 0
}
t = crossingPoint(0, -del2, -del3)
if t < fractionOne {
	@<$x'-y'$에 대해 삼차식을 두 번째로 나눈다@>
} else {
	if xCoord(r) > destX {
		setXCoord(r, destX)
		setLeftX(r, -xCoord(r))
		setRightX(r, xCoord(r))
	}
	if leftX(q) > destX {
		setLeftX(q, destX)
	} else if leftX(q) < xCoord(r) {
		setLeftX(q, xCoord(r))
	}
}

@ 그다음 $x$~좌표를 맞추고, |r|에서 |q|까지의 부분은 다음 팔분면에 속하므로 앞에서처럼 $x$와 $y$를 맞바꾼다.

@<새 매듭 |r|의 $x$~좌표를 맞추고 |r|부터 |q|까지의 좌표를 맞바꾼다@>=
if xCoord(r) < xCoord(p) {
	setXCoord(r, xCoord(p))
} else if xCoord(r)+yCoord(r) > destX+destY {
	setXCoord(r, destX+destY-yCoord(r))
}
setLeftX(r, xCoord(r))
if rightX(p) > xCoord(r) {
	setRightX(p, xCoord(r))
} // 언제나 |xCoord(p)<=rightX(p)|다
setYCoord(r, yCoord(r)+xCoord(r))
setRightY(r, rightY(r)+xCoord(r))
setXCoord(r, -xCoord(r))
setRightX(r, xCoord(r))
setLeftY(q, leftY(q)+leftX(q))
setLeftX(q, -leftX(q))
destY = destY + destX
destX = -destX

@ 나눈 점 |r|의 $y$~좌표는 |p|와 목적지 사이에 있어야 하고, $x+y$는 목적지의 $x+y$를 넘으면 안 된다. 반올림 오차 때문에 이 조건이 깨졌으면 |r|을 옮기고, |r| 둘레의 조절점들도 그에 맞게 당긴다.

@<새 매듭 |r|의 $y$~좌표를 맞추고 이웃 조절점이 단조성을 어기지 않게 한다@>=
if yCoord(r) < yCoord(p) {
	setYCoord(r, yCoord(p))
} else if yCoord(r) > destY {
	setYCoord(r, destY)
}
if xCoord(p)+yCoord(r) > destX+destY {
	setYCoord(r, destX+destY-xCoord(p))
}
if leftY(r) > yCoord(r) {
	setLeftY(r, yCoord(r))
	if rightY(p) > yCoord(r) {
		setRightY(p, yCoord(r))
	}
}
if rightY(r) < yCoord(r) {
	setRightY(r, yCoord(r))
	if leftY(q) < yCoord(r) {
		setLeftY(q, yCoord(r))
	}
}

@ @<$x'-y'$에 대해 삼차식을 두 번째로...@>=
splitCubic(r, t, destX, destY)
s = link(r)
@<새 매듭 |s|의 $y$~좌표를 맞추고 이웃 조절점이 단조성을 어기지 않게 한다@>
if xCoord(s)+yCoord(s) > destX+destY {
	setXCoord(s, destX+destY-yCoord(s))
} else {
	if xCoord(s) < destX {
		setXCoord(s, destX)
	}
	if xCoord(s) < xCoord(r) {
		setXCoord(s, xCoord(r))
	}
}
setRightType(s, rightType(p))
setLeftX(s, xCoord(s)) // 이제 |xCoord(r)=rightX(r)<=leftX(s)|다
if leftX(q) < destX {
	setLeftY(q, leftY(q)+destX)
	setLeftX(q, -destX)
} else if leftX(q) > xCoord(s) {
	setLeftY(q, leftY(q)+xCoord(s))
	setLeftX(q, -xCoord(s))
} else {
	setLeftY(q, leftY(q)+leftX(q))
	setLeftX(q, -leftX(q))
}
setYCoord(s, yCoord(s)+xCoord(s))
setRightY(s, rightY(s)+xCoord(s))
setXCoord(s, -xCoord(s))
setRightX(s, xCoord(s))
if rightY(s) < yCoord(s) {
	setRightY(s, yCoord(s))
	if leftY(q) < yCoord(s) {
		setLeftY(q, yCoord(s))
	}
}

@ 두 번째로 나눈 점 |s|에 대해서도 |r|에서 한 것과 같은 일을 한다.

@<새 매듭 |s|의 $y$~좌표를 맞추고 이웃 조절점이 단조성을 어기지 않게 한다@>=
if yCoord(s) < yCoord(r) {
	setYCoord(s, yCoord(r))
} else if yCoord(s) > destY {
	setYCoord(s, destY)
}
if xCoord(r)+yCoord(s) > destX+destY {
	setYCoord(s, destX+destY-xCoord(r))
}
if leftY(s) > yCoord(s) {
	setLeftY(s, yCoord(s))
	if rightY(r) > yCoord(s) {
		setRightY(r, yCoord(s))
	}
}
if rightY(s) < yCoord(s) {
	setRightY(s, yCoord(s))
	if leftY(q) < yCoord(s) {
		setLeftY(q, yCoord(s))
	}
}

@ \seclabel{autorounding}이제 ``자동 반올림''(autorounding)을 생각할 때다. 이것은 곡선을 화소화한 뒤에 알맞은 모습이 나오는 곳에서
가로, 세로, 대각선 접선이 일어나게 하려는 것이다.

첫 일은 도함수 $x'(t)$가 0을 지날 때 |x(t)|에 가로 펜 오프셋을 더한 것이 현재 ``낱알 크기''(granularity)의
정수배가 되도록 고치는 것이다. 주어진 순환 경로에는 $x'(t)\ge0$인 영역과 $x'(t)\le0$인 영역이 있다. 루틴
|quadrantSubdivide|는 경로 좌표가 비스듬해지기 전에 일을 시작하지만, 그 가운데 몇몇은 부호가 바뀌었을 수
있다. 도함수가 $x'(t)\ge0$인 영역에서는 |rightType=firstOctant|이거나 |rightType=eighthOctant|이고, $x'(t)\le0$인
영역에서는 |rightType=fifthOctant|이거나 |rightType=fourthOctant|다.

그런 영역 안에서 바뀐 $x$ 값들은 이를테면 $x_0$에서 $x_1$까지 단조롭게 늘어난다. 우리는 그 영역의 모든 $x$
좌표에 일차 변환을 적용해서, 변환한 다음에는 $x$ 값들이 round$(x_0)$에서 round$(x_1)$까지 단조롭게 늘어나게
하고 싶다.

이 반올림 방식은 아주 간단하게 들리고 대개는 그렇다. 그러나 일을 더 어렵게 할 수 있는 복잡한 일이 몇 가지
생길 수 있다. 첫째로, $x'$이 결코 0이 되지 않고 0을 불연속으로 건너뛰는 뾰족점에서는 자동 반올림이 알맞지
않다. 둘째로, 현재 펜이 비대칭이어서 곡선의 서로 다른 부분에서 $x$ 좌표를 달리 반올림해야 할 수도 있다.
이런 사정 때문에 $x_0\le x_1$인데도 round$(x_0)$이 round$(x_1)$보다 클 수도 있다. 그럴 때는 일차 변환을 하고
싶지 않다. 게다가 round$(x_1)-\hbox{round} (x_0)$이 양수이지만 $x_1-x_0$보다 훨씬 클 수도 있다. 그러면 변환이
곡선을 심하게 일그러뜨릴 수 있으므로 역시 피하고 싶다. 끝으로, 반올림한 점들은 이웃한 영역 사이에서 일관되어야
하므로 이웃을 모르고는 한 영역을 변환할 수 없다.

@ 이 모든 복잡한 일을 다루려면 먼저 순환 전체를 보고 ``안전한'' 반올림 $x$ 값을 골라야 한다. 다음 프로시저가 이
일을 한다. 반올림 전의 값 $m$개 $(b_0,b_1,\ldots,b_{m-1})$과, 반올림 뒤에 바람직할 그에 대응하는 값 $m$개
$(a_0,a_1,\ldots,a_{m-1})$이 주어지면, 루틴 |makeSafe|는 필요한 만큼 $a$를 $b$로 되돌려서 그 뒤에는
$0\le(a\k-a_k)/(b\k-b_k)\le2$가 되게 한다. 이것은 입력의 순환 치환, 뒤집기, 부호 바꿈에 대해 대칭이다.
(프로그램은 |a|, |b|, ~|m| 대신 |after|, |before|, |curRoundingPtr|라는 이름을 쓴다.)

@<함수들@>=
func makeSafe() {
	var k int32 // 입력 목록을 차례로 돈다; |0 .. maxWiggle|
	var allSafe bool // 지금까지 모든 것이 괜찮아 보이는가?
	var nextA scaled // |after[k]|가 바뀌었을 수도 있기 전의 값
	var deltaA, deltaB scaled // |after[k+1]-after[k]|와 |before[k+1]-before[k]|
	before[curRoundingPtr] = before[0] // 처음으로 감는다
	nodeToRound[curRoundingPtr] = nodeToRound[0]
	for {
		after[curRoundingPtr] = after[0]
		allSafe = true
		nextA = after[0]
		for k = 0; k <= curRoundingPtr-1; k++ {
			deltaB = before[k+1] - before[k]
			if deltaB >= 0 {
				deltaA = after[k+1] - nextA
			} else {
				deltaA = nextA - after[k+1]
			}
			nextA = after[k+1]
			if deltaA < 0 || deltaA > abs(deltaB+deltaB) {
				allSafe = false
				after[k] = before[k]
				if k == curRoundingPtr-1 {
					after[0] = before[0]
				} else {
					after[k+1] = before[k+1]
				}
			}
		}
		if allSafe {
			break
		}
	}
}

@ 프로시저 |makeSafe|가 쓰는 전역 배열에는 현재 매듭 목록을 가리키는 포인터들의 배열이 딸려 있다.

@<전역 변수@>=
var @!before, @!after [maxWiggle + 1]scaled // |makeSafe|를 위한 자료
var @!nodeToRound [maxWiggle + 1]pointer // 경로를 거꾸로 가리킨다
var @!curRoundingPtr int32 // 몇 개를 쓰고 있나; |0 .. maxWiggle|
var @!maxRoundingPtr int32 // 몇 개를 썼었나; |0 .. maxWiggle|

@ @<핵심 변수들의...@>=
maxRoundingPtr = 0

@ 새 항목은 루틴 |beforeAndAfter|로 표에 넣는다.

@<함수들@>=
func beforeAndAfter(b, a scaled, p pointer) {
	if curRoundingPtr == maxRoundingPtr {
		if maxRoundingPtr < maxWiggle {
			maxRoundingPtr++
		} else {
			overflow("rounding table size", maxWiggle)
		}
	}
@:METAFONT capacity exceeded rounding table size}{\quad rounding table size@>
	after[curRoundingPtr] = a
	before[curRoundingPtr] = b
	nodeToRound[curRoundingPtr] = p
	curRoundingPtr++
}

@ 내부 양 |internal[granularity]| 대신 |curGran|이라는 전역 변수를 쓴다. 양수임이 보장된 수로 일하고 싶기 때문이다.

@<전역 변수@>=
var @!curGran scaled // 현재 낱알 크기(보통은 |unity|다)

@ 함수 |goodVal|은 |a+o|가 |curGran|의 배수라는 성질을 가지면서 될 수 있는 대로 |b|에 가까운 수 |a|를
계산한다.

낱알 크기 |curGran|이 짝수라고 가정하면(실제로 모든 합리적인 응용에서 그것은 |unity|의 배수일 것이다) 항등식
|goodVal(-b-1,-o)=-goodVal(b,o)|가 성립한다.

@<함수들@>=
func goodVal(b, o scaled) scaled {
	var a scaled // 누산기
	a = b + o
	if a >= 0 {
		a = a - (a % curGran) - o
	} else {
		a = a + ((-(a + 1)) % curGran) - curGran + 1 - o
	}
	if b-a < a+curGran-b {
		return a
	}
	return a + curGran
}

@ 이중 경로를 반올림할 때 펜의 두께가 낱알 크기의 배수가 아니면 서로 맞서는 두 경향 사이에서 타협해야 할
수도 있다. 존 하비가 내놓은 다음의 ``타협'' 조정은 그 궁지에서 가장 좋게 빠져나가는 길을 찾는다.
@^Hobby, John Douglas@>
(우리 응용에서는 |curGran|을 법으로 한 값만 상관있으므로, 결과는 본질적으로 |u|와~|v|에 대해 대칭이 된다.)

@<함수들@>=
func compromise(u, v scaled) scaled {
	return half(goodVal(u+u, -u-v))
}

@ 그러면 다음이 앞에서 설명한 대로 $x$ 좌표를 반올림하는 프로시저다. 이것은 $y$ 좌표에 대해서도 독립적으로
같은 일을 한다.

@<함수들@>=
func xyRound() {
	var p, q pointer // 목록 조작 레지스터들
	var b, a scaled // 반올림 전과 뒤의 값
	var penEdge scaled // 반올림을 다스리는 오프셋
	var alpha fraction // 일차 변환의 계수
	curGran = abs(internal[granularity])
	if curGran == 0 {
		curGran = unity
	}
	p = curSpec
	curRoundingPtr = 0
	for {
		q = link(p)
		@<노드 |q|가 |x| 좌표의 넘어감 점이면 그 반올림 전과 뒤의 좌표를 계산해서 저장한다@>
		p = q
		if p == curSpec {
			break
		}
	}
	if curRoundingPtr > 0 {
		@<|x| 좌표를 변환한다@>
	}
	p = curSpec
	curRoundingPtr = 0
	for {
		q = link(p)
		@<노드 |q|가 |y| 좌표의 넘어감 점이면 그 반올림 전과 뒤의 좌표를 계산해서 저장한다@>
		p = q
		if p == curSpec {
			break
		}
	}
	if curRoundingPtr > 0 {
		@<|y| 좌표를 변환한다@>
	}
}

@ 좌표 |x|의 부호를 바꾸었으면 |octant| 코드는 짝수다. 넘어감 노드에서의 도함수 계산에는 .01화소(곧 |scaled|
단위 655)까지의 오차를 허용한다.

@<노드 |q|가 |x| 좌표의...@>=
if odd(rightType(p)) != odd(rightType(q)) {
	if odd(rightType(q)) {
		b = xCoord(q)
	} else {
		b = -xCoord(q)
	}
	if abs(xCoord(q)-rightX(q)) < 655 || abs(xCoord(q)+leftX(q)) < 655 {
		@<현재 펜에 따라 반올림 전과 뒤의 |x| 값을 계산한다@>
	} else {
		a = b
	}
	if abs(a) > maxAllowed {
		if a > 0 {
			a = maxAllowed
		} else {
			a = -maxAllowed
		}
	}
	beforeAndAfter(b, a, q)
}

@ 펜의 자료 표현을 공부할 때 알게 되겠지만, 현재 펜의 서쪽 가장자리의 |x|~좌표는
$$\hbox{|yCoord(link(curPen+seventhOctant))|}$$
이고, 다른 중요한 오프셋에도 비슷한 방법으로 이를 수 있다.

@<정의@>=
func northEdge(p pointer) scaled { return yCoord(link(p + fourthOctant)) }
func southEdge(p pointer) scaled { return yCoord(link(p + firstOctant)) }
func eastEdge(p pointer) scaled  { return yCoord(link(p + secondOctant)) }
func westEdge(p pointer) scaled  { return yCoord(link(p + seventhOctant)) }

@ @<현재 펜에 따라 반올림 전과 뒤의 |x|...@>=
if curPen == nullPen {
	penEdge = 0
} else if curPathType == doublePathCode {
	penEdge = compromise(eastEdge(curPen), westEdge(curPen))
} else if odd(rightType(q)) {
	penEdge = westEdge(curPen)
} else {
	penEdge = eastEdge(curPen)
}
a = goodVal(b, penEdge)

@ 여기서 고정 소수점 산술로 계산하는 단조 변환은, $\vert b-b'\vert<2^{28}$인 한, 반올림 오차가 있더라도
이웃한 |before| 값 $(b,b')$을 이웃한 |after| 값 $(a,a')$으로 옮긴다는 보장이 있다.

@<|x| 좌표를 변환한다@>=
makeSafe()
for {
	curRoundingPtr--
	if after[curRoundingPtr] != before[curRoundingPtr] ||
		after[curRoundingPtr+1] != before[curRoundingPtr+1] {
		p = nodeToRound[curRoundingPtr]
		if odd(rightType(p)) {
			b = before[curRoundingPtr]
			a = after[curRoundingPtr]
		} else {
			b = -before[curRoundingPtr]
			a = -after[curRoundingPtr]
		}
		if before[curRoundingPtr] == before[curRoundingPtr+1] {
			alpha = fractionOne
		} else {
			alpha = makeFraction(after[curRoundingPtr+1]-after[curRoundingPtr],
				before[curRoundingPtr+1]-before[curRoundingPtr])
		}
		for {
			setXCoord(p, takeFraction(alpha, xCoord(p)-b)+a)
			setRightX(p, takeFraction(alpha, rightX(p)-b)+a)
			p = link(p)
			setLeftX(p, takeFraction(alpha, leftX(p)-b)+a)
			if p == nodeToRound[curRoundingPtr+1] {
				break
			}
		}
	}
	if curRoundingPtr == 0 {
		break
	}
}

@ 좌표 |y|의 부호를 바꾸었으면 |octant| 코드는 |>negateY|다. 그 밖에는 이 루틴들은 방금 본 |x| 좌표의 루틴들과
본질적으로 같다.

@<노드 |q|가 |y| 좌표의...@>=
if (rightType(p) > negateY) != (rightType(q) > negateY) {
	if rightType(q) <= negateY {
		b = yCoord(q)
	} else {
		b = -yCoord(q)
	}
	if abs(yCoord(q)-rightY(q)) < 655 || abs(yCoord(q)+leftY(q)) < 655 {
		@<현재 펜에 따라 반올림 전과 뒤의 |y| 값을 계산한다@>
	} else {
		a = b
	}
	if abs(a) > maxAllowed {
		if a > 0 {
			a = maxAllowed
		} else {
			a = -maxAllowed
		}
	}
	beforeAndAfter(b, a, q)
}

@ @<현재 펜에 따라 반올림 전과 뒤의 |y|...@>=
if curPen == nullPen {
	penEdge = 0
} else if curPathType == doublePathCode {
	penEdge = compromise(northEdge(curPen), southEdge(curPen))
} else if rightType(q) <= negateY {
	penEdge = southEdge(curPen)
} else {
	penEdge = northEdge(curPen)
}
a = goodVal(b, penEdge)

@ @<|y| 좌표를 변환한다@>=
makeSafe()
for {
	curRoundingPtr--
	if after[curRoundingPtr] != before[curRoundingPtr] ||
		after[curRoundingPtr+1] != before[curRoundingPtr+1] {
		p = nodeToRound[curRoundingPtr]
		if rightType(p) <= negateY {
			b = before[curRoundingPtr]
			a = after[curRoundingPtr]
		} else {
			b = -before[curRoundingPtr]
			a = -after[curRoundingPtr]
		}
		if before[curRoundingPtr] == before[curRoundingPtr+1] {
			alpha = fractionOne
		} else {
			alpha = makeFraction(after[curRoundingPtr+1]-after[curRoundingPtr],
				before[curRoundingPtr+1]-before[curRoundingPtr])
		}
		for {
			setYCoord(p, takeFraction(alpha, yCoord(p)-b)+a)
			setRightY(p, takeFraction(alpha, rightY(p)-b)+a)
			p = link(p)
			setLeftY(p, takeFraction(alpha, leftY(p)-b)+a)
			if p == nodeToRound[curRoundingPtr+1] {
				break
			}
		}
	}
	if curRoundingPtr == 0 {
		break
	}
}

@ 대각선 접선에서의 반올림은 팔분면 나누기가 끝난 다음, 그러니까 좌표가 비스듬해진 다음에 일어난다.
세부는 조금 까다롭다. 비스듬한 좌표가 낱알 크기의 정수배의 한가운데에 있는 점으로 반올림하고 싶기
때문이다. 게다가 반올림하면 두 좌표가 모두 바뀐다. 이것은 |x|와 |y| 모두에서 안전을 보장하도록 |makeSafe|
루틴을 일반화한 것이 필요하다는 뜻이다.

이런 추가 복잡함에도 불구하고, 루틴의 기본 구조가 앞의 것과 같다는 사실에서 위안을 얻을 수 있다.

@<함수들@>=
func diagRound() {
	var p, q, pp pointer // 목록 조작 레지스터들
	var b, a, bb, aa, d, c, dd, cc scaled // 반올림 전과 뒤의 값들
	var penEdge scaled // 반올림을 다스리는 오프셋
	var alpha, beta fraction // 일차 변환의 계수들
	var nextA scaled // |after[k]|가 바뀌었을 수도 있기 전의 값
	var allSafe bool // 지금까지 모든 것이 괜찮아 보이는가?
	var k int32 // 반올림 전과 뒤의 값들을 차례로 돈다; |0 .. maxWiggle|
	var firstX, firstY scaled // 반올림 전의 좌표
	p = curSpec
	curRoundingPtr = 0
	for {
		q = link(p)
		@<노드 |q|가 팔분면 사이의 넘어감 점이면 그 반올림 전과 뒤의 좌표를 계산해서 저장한다@>
		p = q
		if p == curSpec {
			break
		}
	}
	if curRoundingPtr > 0 {
		@<비스듬한 좌표를 변환한다@>
	}
}

@ 팔분면 코드가 |switchXAndY|보다 크면 반올림 전과 뒤의 표에서 비스듬한 |x| 좌표의 부호를 바꾼다.

@<노드 |q|가 팔분면 사이의...@>=
if rightType(p) != rightType(q) {
	if rightType(q) > switchXAndY {
		b = -xCoord(q)
	} else {
		b = xCoord(q)
	}
	if abs(rightType(q)-rightType(p)) == switchXAndY {
		if abs(xCoord(q)-rightX(q)) < 655 || abs(xCoord(q)+leftX(q)) < 655 {
			@<대각선 넘어감에서 좋은 좌표를 계산한다@>
		} else {
			a = b
		}
	} else {
		a = b
	}
	beforeAndAfter(b, a, q)
}

@ 코드 번호가 짝수인 팔분면에서는 $x$의 부호가 바뀌었다. 우리는 애매한 경우를 위로가 아니라 아래로
반올림해서, 그 반올림이 코드 번호가 홀수인 팔분면과 일관되게 하고 싶다. 이 아래쪽 치우침은 |goodVal|의 첫
인자에서 1을 빼서 얻을 수 있다.

@<정의@>=
func diagOffset(k int32) scaled { return xCoord(knil(link(curPen + k))) }

@ @<대각선 넘어감에서...@>=
if curPen == nullPen {
	penEdge = 0
} else if curPathType == doublePathCode {
	@<타협한 |penEdge|를 계산한다@>
} else if rightType(q) <= switchXAndY {
	penEdge = diagOffset(rightType(q))
} else {
	penEdge = -diagOffset(rightType(q))
}
if odd(rightType(q)) {
	a = goodVal(b, penEdge+half(curGran))
} else {
	a = goodVal(b-1, penEdge+half(curGran))
}

@ (이 타협한 오프셋들을 되풀이해서 계산하는 것은 아까운 일인 것 같다. 낱알 크기가 일정했다면 저자는 그것들을
펜 자료 구조에 바로 저장했을 것이다.)

@<타협한 |penEdge|를...@>=
switch rightType(q) {
case firstOctant, secondOctant:
	penEdge = compromise(diagOffset(firstOctant), -diagOffset(fifthOctant))
case fifthOctant, sixthOctant:
	penEdge = -compromise(diagOffset(firstOctant), -diagOffset(fifthOctant))
case thirdOctant, fourthOctant:
	penEdge = compromise(diagOffset(fourthOctant), -diagOffset(eighthOctant))
case seventhOctant, eighthOctant:
	penEdge = -compromise(diagOffset(fourthOctant), -diagOffset(eighthOctant))
} // 다른 경우는 없다

@ @<비스듬한 좌표를 변환한다@>=
p = nodeToRound[0]
firstX = xCoord(p)
firstY = yCoord(p)
@<대각선 반올림이 모두 안전한지 확인한다@>
for k = 0; k <= curRoundingPtr-1; k++ {
	a = after[k]
	b = before[k]
	aa = after[k+1]
	bb = before[k+1]
	if a != b || aa != bb {
		p = nodeToRound[k]
		pp = nodeToRound[k+1]
		@<두 좌표의 반올림 전과 뒤의 값을 정한다@>
		if b == bb {
			alpha = fractionOne
		} else {
			alpha = makeFraction(aa-a, bb-b)
		}
		if d == dd {
			beta = fractionOne
		} else {
			beta = makeFraction(cc-c, dd-d)
		}
		for {
			setXCoord(p, takeFraction(alpha, xCoord(p)-b)+a)
			setYCoord(p, takeFraction(beta, yCoord(p)-d)+c)
			setRightX(p, takeFraction(alpha, rightX(p)-b)+a)
			setRightY(p, takeFraction(beta, rightY(p)-d)+c)
			p = link(p)
			setLeftX(p, takeFraction(alpha, leftX(p)-b)+a)
			setLeftY(p, takeFraction(beta, leftY(p)-d)+c)
			if p == pp {
				break
			}
		}
	}
}

@ 노드 |p|에서는 좌표 |(b,d)|가 |(a,c)|로 반올림되고, 노드 |pp|에서는 좌표 |(bb,dd)|가 |(aa,cc)|로
반올림된다. (노드 |pp|의 값들은 노드 |p|의 관례와 맞도록 변환한다.)

만일 |aa!=bb|이면 |abs(rightType(p)-rightType(pp))=switchXAndY|임을 안다.

@<두 좌표의 반올림 전과 뒤의...@>=
if aa == bb {
	if pp == nodeToRound[0] {
		unskew(firstX, firstY, rightType(pp))
	} else {
		unskew(xCoord(pp), yCoord(pp), rightType(pp))
	}
	skew(curX, curY, rightType(p))
	bb = curX
	aa = bb
	dd = curY
	cc = dd
	if rightType(p) > switchXAndY {
		b = -b
		a = -a
	}
} else {
	@<대각선 넘어감 점 |pp|의 반올림 전과 뒤의 $y$~좌표를 계산한다@>
}
d = yCoord(p)
if odd(a - b) {
	if rightType(p) > switchXAndY {
		c = d - half(a-b-1)
	} else {
		c = d - half(a-b+1)
	}
} else {
	c = d - half(a-b)
}

@ 만일 |aa!=bb|이면 두 노드 사이에 $x$와 $y$를 맞바꾸는 팔분면 경계가 있다. 그러면 노드 |pp|의 좌표는 대각선 위에 있으므로 반올림하기
전과 뒤의 $y$~좌표를 $x$~좌표의 차로부터 정한다. 차가 홀수이면 팔분면에 따라 반올림 방향을 달리한다.

@<대각선 넘어감 점 |pp|의 반올림 전과 뒤의 $y$~좌표를 계산한다@>=
if rightType(p) > switchXAndY {
	bb = -bb
	aa = -aa
	b = -b
	a = -a
}
if pp == nodeToRound[0] {
	dd = firstY - bb
} else {
	dd = yCoord(pp) - bb
}
if odd(aa - bb) {
	if rightType(p) > switchXAndY {
		cc = dd - half(aa-bb+1)
	} else {
		cc = dd - half(aa-bb-1)
	}
} else {
	cc = dd - half(aa-bb)
}

@ @<대각선 반올림이 모두...@>=
before[curRoundingPtr] = before[0] // |makeSafe| 참조
nodeToRound[curRoundingPtr] = nodeToRound[0]
for {
	after[curRoundingPtr] = after[0]
	allSafe = true
	nextA = after[0]
	for k = 0; k <= curRoundingPtr-1; k++ {
		a = nextA
		b = before[k]
		nextA = after[k+1]
		aa = nextA
		bb = before[k+1]
		if a != b || aa != bb {
			p = nodeToRound[k]
			pp = nodeToRound[k+1]
			@<두 좌표의 반올림 전과 뒤의...@>
			if aa < a || cc < c || aa-a > 2*(bb-b) || cc-c > 2*(dd-d) {
				allSafe = false
				after[k] = before[k]
				if k == curRoundingPtr-1 {
					after[0] = before[0]
				} else {
					after[k+1] = before[k+1]
				}
			}
		}
	}
	if allSafe {
		break
	}
}

@ 여기서는 ``죽은'' 삼차식, 곧 |t|가~바뀌어도 전혀 움직이지 않는 다항식을 없앤다. 나누기 과정이 그런 것을
들여왔을 수도 있기 때문이다. 그러나 순환이 점 하나로 줄어들면 죽은 삼차식 하나가 남는데, 그것은 나중에야
없앤다.

@<죽은 삼차식들을...@>=
p = curSpec
for {
	q = link(p)
	if p != q {
		if xCoord(p) == rightX(p) && yCoord(p) == rightY(p) &&
			xCoord(p) == leftX(q) && yCoord(p) == leftY(q) {
			unskew(xCoord(q), yCoord(q), rightType(q))
			skew(curX, curY, rightType(p))
			if xCoord(p) == curX && yCoord(p) == curY {
				removeCubic(p) // |p| 다음의 삼차식을 없앤다
				if q != curSpec {
					continue
				}
				curSpec = p
				q = p
			}
		}
	}
	p = q
	if p == curSpec {
		break
	}
}

@ 끝으로 |makeSpec|의 마지막 단계에 이르렀다. 서로 다른 팔분면으로 움직이는 삼차식들 사이에 경계 노드를
끼워 넣는 것이다. 남은 주된 복잡함은 팔분면이 이웃하지 않는 잇단 삼차식들에서 생긴다. 그런 날카로운 꺾임에는
팔분면 경계를 둘 이상 끼워 넣어야 포락선을 만드는 루틴이 돌아간다.

이 목적에는 팔분면의 수 번호와 그레이 코드 사이를 바꾸는 표가 있으면 좋다.

@<전역 변수@>=
var @!octantNumber [sixthOctant + 1]int32 // 첨자는 팔분면 코드; 값은 |1 .. 8|
var @!octantCode [9]int32 // 첨자는 |1 .. 8|; 값은 팔분면 코드

@ @<핵심 변수들의...@>=
octantCode[1] = firstOctant
octantCode[2] = secondOctant
octantCode[3] = thirdOctant
octantCode[4] = fourthOctant
octantCode[5] = fifthOctant
octantCode[6] = sixthOctant
octantCode[7] = seventhOctant
octantCode[8] = eighthOctant
for k = 1; k <= 8; k++ {
	octantNumber[octantCode[k]] = k
}

@ 경계를 끼워 넣는 주 루프는 잇단 노드 셋 |p,q,r|을 다룬다.

@<팔분면 경계를 끼워 넣고...@>=
turningNumber = 0
p = curSpec
q = link(p)
for {
	r = link(q)
	if rightType(p) != rightType(q) || q == r {
		@<|q| 바로 앞에 팔분면 경계 노드를 하나 이상 끼워 넣는다@>
	}
	p = q
	q = r
	if p == curSpec {
		break
	}
}

@ 여기서는 서브루틴 |newBoundary|가 쓸모 있다. 이것은 주어진 팔분면 코드로 새 노드의 좌표를 변환해서, 주어진
노드 |p| 바로 뒤에 새 경계 노드를 끼워 넣는다. ``넘어감'' 필드는 여기서 계산하지 않는다.

@<함수들@>=
func newBoundary(p pointer, octant smallNumber) {
	var q, r pointer // 목록 조작을 위해
	q = link(p) // |rightType(q)!=endpoint|라고 가정한다
	r = getNode(knotNodeSize)
	setLink(r, q)
	setLink(p, r)
	setLeftType(r, leftType(q)) // 그러나 |leftType(q)=endpoint|일 수도 있다
	setLeftX(r, leftX(q))
	setLeftY(r, leftY(q))
	setRightType(r, endpoint)
	setLeftType(q, endpoint)
	setRightOctant(r, octant)
	setLeftOctant(q, rightType(q))
	unskew(xCoord(q), yCoord(q), rightType(q))
	skew(curX, curY, octant)
	setXCoord(r, curX)
	setYCoord(r, curY)
}

@ 경우 |q=r|은 |p=q=r=curSpec|일 때, 그리고 오직 그때에만 일어난다. 그때 우리는 여덟 걸음에 걸쳐
$360^\circ$를 돌고 나서 외톨이 죽은 삼차식을 없애고 싶다. 아래 프로그램은 어쩌다 보니 그 경우에도 돌아가지만,
독자가 그 까닭을 알아차리기를 기대하지는 않는다.

@<|q| 바로 앞에 팔분면 경계...@>=
newBoundary(p, rightType(p))
s = link(p)
o1 = octantNumber[rightType(p)]
o2 = octantNumber[rightType(q)]
switch o2 - o1 {
case 1, -7, 7, -1:
	goto done
case 2, -6:
	clockwise = false
case 3, -5, 4, -4, 5, -3:
	@<시계 방향으로 갈지 말지 정한다@>
case 6, -2:
	clockwise = true
case 0:
	clockwise = revTurns
} // 다른 경우는 없다
@<경계 노드를 더 끼워 넣고, |goto done|@>
done:
if q == r {
	q = link(q)
	r = q
	p = s
	setLink(s, q)
	setLeftOctant(q, rightOctant(q))
	setLeftType(q, endpoint)
	freeNode(curSpec, knotNodeSize)
	curSpec = q
}
@<넘어감 필드를 바로잡고 꺾임 수를 고친다@>

@ 경로가 팔분면 넷을 건너뛸 때는 까다로운 문제가 생긴다. 곡선의 방향이 $180^\circ$나, 그 차이가 아마 반올림
오차 때문일 만큼 $180^\circ$에 아주 가까운 각만큼 바뀌었다면 시계 반대 방향으로 돌고 싶고, 그렇지 않으면
$180^\circ$보다 작은 각만큼 돌고 싶다. 곡선이 팔분면 셋만 건너뛴 것처럼 보일 때도 이 결정을 해야 한다. 곡선이
넷째 팔분면에서 방향 $(-1,0)$에 다가간 다음 방향 $(+1,0)$에서 첫 팔분면으로 떠날 수도 있기 때문이다.

다음 코드는 들어오는 방향 |(dx1,dy1)|과 나가는 방향 |(dx2,dy2)|를 분석해서 이 문제를 푼다.

@<시계 방향으로 갈지...@>=
@<들어오는 방향과 나가는 방향을 계산한다@>
unskew(dx1, dy1, rightType(p))
del = pythAdd(curX, curY)
dx1 = makeFraction(curX, del)
dy1 = makeFraction(curY, del) // $\cos\theta_1$과 $\sin\theta_1$
unskew(dx2, dy2, rightType(q))
del = pythAdd(curX, curY)
dx2 = makeFraction(curX, del)
dy2 = makeFraction(curY, del) // $\cos\theta_2$와 $\sin\theta_2$
del = takeFraction(dx1, dy2) - takeFraction(dx2, dy1) // $\sin(\theta_2-\theta_1)$
if del > 4684844 {
	clockwise = false
} else if del < -4684844 {
	clockwise = true // $2^{28}\cdot\sin 1^\circ\approx4684844.68$
} else {
	clockwise = revTurns
}

@ 전역 변수 |revTurns|가 |true|이면 방금 계산한 되돌아 돌기는 시계 반대 방향이 아니라 시계 방향이 된다.
이 변수는 대개 |false|다.

@<전역 변수@>=
var @!revTurns bool // 되돌아 돌기를 영국식으로 할까?

@ @<핵심 변수들의...@>=
revTurns = false

@ @<들어오는 방향과...@>=
dx1 = xCoord(s) - leftX(s)
dy1 = yCoord(s) - leftY(s)
if dx1 == 0 && dy1 == 0 {
	dx1 = xCoord(s) - rightX(p)
	dy1 = yCoord(s) - rightY(p)
	if dx1 == 0 && dy1 == 0 {
		dx1 = xCoord(s) - xCoord(p)
		dy1 = yCoord(s) - yCoord(p)
	} // 그리고 둘 다 0일 수는 {\sl 없다}
}
dmax = abs(dx1)
if abs(dy1) > dmax {
	dmax = abs(dy1)
}
for dmax < fractionOne {
	dmax += dmax
	dx1 += dx1
	dy1 += dy1
}
@<나가는 방향 |(dx2,dy2)|를 구한다@>

@ 나가는 방향도 들어오는 방향과 같은 방식으로 구한다. 조절점이 매듭과 겹치면 다음 조절점을, 그것도 겹치면 다음 매듭을 본다. 다만 다음 매듭의 좌표는 이웃 팔분면에서 비스듬히 바뀌었을 수 있으므로 현재 팔분면의 좌표로 되돌려 쓴다.

@<나가는 방향 |(dx2,dy2)|를 구한다@>=
dx2 = rightX(q) - xCoord(q)
dy2 = rightY(q) - yCoord(q)
if dx2 == 0 && dy2 == 0 {
	dx2 = leftX(r) - xCoord(q)
	dy2 = leftY(r) - yCoord(q)
	if dx2 == 0 && dy2 == 0 {
		if rightType(r) == endpoint {
			curX = xCoord(r)
			curY = yCoord(r)
		} else {
			unskew(xCoord(r), yCoord(r), rightType(r))
			skew(curX, curY, rightType(q))
		}
		dx2 = curX - xCoord(q)
		dy2 = curY - yCoord(q)
	} // 그리고 둘 다 0일 수는 {\sl 없다}
}
dmax = abs(dx2)
if abs(dy2) > dmax {
	dmax = abs(dy2)
}
for dmax < fractionOne {
	dmax += dmax
	dx2 += dx2
	dy2 += dy2
}

@ @<경계 노드를 더 끼워...@>=
for {
	if clockwise {
		if o1 == 1 {
			o1 = 8
		} else {
			o1--
		}
	} else if o1 == 8 {
		o1 = 1
	} else {
		o1++
	}
	if o1 == o2 {
		goto done
	}
	newBoundary(s, octantCode[o1])
	s = link(s)
	setLeftOctant(s, rightOctant(s))
}

@ 이제 방금 |link(p)|와~|q| 사이에 끼워 넣은 팔분면 경계 노드들의 |leftTransition|과 |rightTransition|
필드에, 이웃한 팔분면 사이의 중복된 넘어감 정보를 넣는 일이 남았다. 꺾임 수는 이 넘어감들로부터 쉽게
계산된다. 팔분면 8에서 1로 넘어가면 한 바퀴를 시계 반대 방향으로 돈 것이다.

@<넘어감 필드를 바로잡고...@>=
p = link(p)
for {
	s = link(p)
	o1 = octantNumber[rightOctant(p)]
	o2 = octantNumber[leftOctant(s)]
	if abs(o1-o2) == 1 {
		if o2 < o1 {
			o2 = o1
		}
		if odd(o2) {
			setRightTransition(p, axis)
		} else {
			setRightTransition(p, diagonal)
		}
	} else {
		if o1 == 8 {
			turningNumber++
		} else {
			turningNumber--
		}
		setRightTransition(p, axis)
	}
	setLeftTransition(s, rightTransition(p))
	p = s
	if p == q {
		break
	}
}

@* 윤곽 칠하기.
움직임을 만들고 순환 경로를 순환 명세로 바꾸는 낮은 수준의 장치가 갖추어졌으니, 이제 화소화한 경로를
칠하는 데 거의 다 왔다. 필요한 것은 순환 명세를 따라 걸으며 전체 과정을 다스리는 높은 수준의 루틴뿐이다.

우리의 전체 목표는 정수 점 $\bigl(\round(x(t)),\round(y(t))\bigr)$들을 찍고 그것들을 룩 움직임으로 잇는
것이다. 이때 $t$가~바뀌는 동안 $\round(x(t))$와 $\round(y(t))$가 한 정수에서 다른 정수로 동시에 뛰지는
않는다고 가정한다. 이 룩 움직임들이 칠할 윤곽의 가장자리가 된다. 원래의 좌표를 변환해서, 우리는 이 문제를
첫 팔분면 방향으로 가는 곡선, 곧 $0\le y'(t)\le x'(t)$인 곡선의 경우로 줄였다.

그 결과로, 칠해지는 화소는 대체로 그 중심이 곡선 안에 있는 화소다. 곡선 위의 점을 가장 가까운 격자점으로
반올림해서 잇는 것은, 화소의 가운데를 지나는 선을 기준으로 안팎을 가르는 것과 같기 때문이다. 아래 그림의
회색 화소들은 원 안에 중심(작은 점)이 있는 것들이고, 굵은 계단은 그 화소들의 둘레다.
$$\mplibcode
beginfig(16);
save u, cx, cy, r, h, xl, xr, i; numeric u, cx, cy, r, h, xl, xr, i; u := 16pt;
cx := 4.15; cy := 3.9; r := 3.35;
for j = 0 upto 7:
  h := j + .5 - cy;
  if abs(h) < r:
    xl := cx - sqrt(r*r - h*h); xr := cx + sqrt(r*r - h*h);
    for i = ceiling(xl - .5) upto floor(xr - .5):
      fill ((0,0)--(1,0)--(1,1)--(0,1)--cycle) shifted (i,j) scaled u withcolor .8white;
    endfor
  fi
endfor
for i = 0 upto 8: draw (i*u,0)--(i*u,8u) withpen pencircle scaled .2pt; endfor
for j = 0 upto 8: draw (0,j*u)--(8u,j*u) withpen pencircle scaled .2pt; endfor
for i = 0 upto 7: for j = 0 upto 7:
  fill fullcircle scaled 1.6pt shifted ((i+.5)*u,(j+.5)*u);
endfor endfor
draw fullcircle scaled (2r*u) shifted (cx*u, cy*u) withpen pencircle scaled 1pt;
endfig;
\endmplibcode$$

\def\xtilde{{\tilde x}} \def\ytilde{{\tilde y}}
또 하나의 변환이 문제를 더욱 간단하게 한다. 점 $(x,y)$를 $(\xtilde,\ytilde)=(x-y,y+{1\over2})$로 바꾼 좌표로
일할 때 {\sl 치우친 좌표\/}(biased coordinates)로 일한다고 말하기로 하자. 곡선이 첫 팔분면 방향으로 가면,
그에 해당하는 치우친 좌표의 곡선은 첫 {\sl 사분면\/} 방향으로 간다. 뒤의 조건은 $x$와~$y$에 대해
대칭이므로 알고리즘을 설계하는 데 이점이 있다. 루틴 |makeSpec|은 비스듬한 좌표 $(x-y,y)$를 주므로, 둘째
성분에 그냥 $1\over2$를 더하면 치우친 좌표를 얻는다.

치우친 좌표에 관한 가장 중요한 사실은, 반올림한 치우치지 않은 경로 $\bigl(\round(x(t)),\round(y(t))\bigr)$를
잘라 낸 치우친 경로 $\bigl(\lfloor\xtilde(t)\rfloor,\lfloor\ytilde(t)\rfloor\bigr)$와 처음과 마지막 끝점에 관한
정보로부터 정할 수 있다는 것이다. 반올림하지 않은 치우치지 않은 경로가 $(x_0,y_0)$에서 시작해서
$(x_1,y_1)$에서 끝나면, 반올림한 치우치지 않은 경로는 다음 구성으로 얻어진다는 것을 (잘라 낸 치우친 경로의
길이에 대한 귀납법으로) 증명할 수 있다.

\yskip\textindent{1)} $\bigl(\round(x_0),\round(y_0)\bigr)$에서 시작한다.

\yskip\textindent{2)} 만일 $(x_0+{1\over2})\bmod1\ge(y_0+{1\over2})\bmod1$이면 오른쪽으로 한 걸음 간다.

\yskip\textindent{3)} 경로 $\bigl(\lfloor\xtilde(t)\rfloor,\lfloor\ytilde(t)\rfloor\bigr)$가 위로 한 걸음 갈
때마다(곧 $\lfloor\xtilde(t+\epsilon)\rfloor=\lfloor\xtilde(t)\rfloor$이고
$\lfloor\ytilde(t+\epsilon)\rfloor=\lfloor\ytilde(t)\rfloor+1$일 때마다) 위로 한 걸음 가고 그다음 오른쪽으로
한 걸음 간다.

\yskip\textindent{4)} 경로 $\bigl(\lfloor\xtilde(t)\rfloor,\lfloor\ytilde(t)\rfloor\bigr)$가 오른쪽으로 한 걸음
갈 때마다(곧 $\lfloor\xtilde(t+\epsilon)\rfloor=\lfloor\xtilde(t)\rfloor+1$이고
$\lfloor\ytilde(t+\epsilon)\rfloor=\lfloor\ytilde(t)\rfloor$일 때마다) 오른쪽으로 한 걸음 간다.

\yskip\textindent{5)} 끝으로 $(x_1+{1\over2})\bmod1\ge(y_1+{1\over2})\bmod1$이면 왼쪽으로 한 걸음 간다(그래서
앞의 오른쪽 한 걸음을 지운다). 이제 점 $\bigl(\round(x_1),\round(y_1)\bigr)$에 있게 된다.

@ 두 값 $\round(x(t))$와 $\round(y(t))$가 동시에 뛰지 않는다는 가정을 정당화하려고, 좌표 쌍 $(x,y)$가 실제로는
$(x+\epsilon,y+\epsilon\delta)$를 나타낸다고 생각하기로 한다. 여기서 $\epsilon$과 $\delta$는 아주 작은
양수다. 너무 작아서 그 정확한 값은 결코 상관이 없다. 이 관례 덕분에 반올림이 모호하지 않게 된다. 주어진
눈금 수~$(x,y)$에 가장 가까운 정수 점이 언제나 유일하기 때문이다.

\MF가 ``첫 팔분면'' 방향에서만 일하도록 좌표를 변환할 때는 $x$의 부호 바꿈, $y$의 부호 바꿈, $x$와~$y$의
맞바꿈이 들어간다. 일관된 값을 얻으려면 반올림 관례도 그에 맞게 고쳐야 한다. 이를테면 셋째 팔분면 곡선이
첫 팔분면 방향으로 가도록 좌표를 변환했다고 하자. 우리 자료 구조의 비스듬한 좌표 $(x,y)$는 비스듬하지 않은
좌표 $(-y,x+y)$를 나타내는데, 그것은 실제로 $(-y+\epsilon,x+y+\epsilon\delta)$다. 그러므로 우리는 비스듬한
좌표가 $(x,y)$ 대신 $(x+\epsilon+\epsilon\delta,y-\epsilon)$인 것처럼 반올림해야 한다. 다음 표는 반올림을
결정할 때 비스듬한 좌표를 어떻게 흔들어야 하는지 보인다.
$$\vcenter{\halign{#\hfil&&\quad$#$\hfil&\hskip4em#\hfil\cr
|firstOctant|&(x+\epsilon-\epsilon\delta,y+\epsilon\delta)&
 |fifthOctant|&(x-\epsilon+\epsilon\delta,y-\epsilon\delta)\cr
|secondOctant|&(x-\epsilon+\epsilon\delta,y+\epsilon)&
 |sixthOctant|&(x+\epsilon-\epsilon\delta,y-\epsilon)\cr
|thirdOctant|&(x+\epsilon+\epsilon\delta,y-\epsilon)&
 |seventhOctant|&(x-\epsilon-\epsilon\delta,y+\epsilon)\cr
|fourthOctant|&(x-\epsilon-\epsilon\delta,y+\epsilon\delta)&
 |eighthOctant|&(x+\epsilon+\epsilon\delta,y-\epsilon\delta)\cr}}$$

어느 팔분면에서든 반올림 연산이 꽤 쉽도록 작은 배열 넷을 마련한다.

@<전역 변수@>=
var @!yCorr, @!xyCorr, @!zCorr [sixthOctant + 1]int32 // 값은 |0 .. 1|
var @!xCorr [sixthOctant + 1]int32 // 값은 |-1 .. 1|

@ 여기서 |xyCorr|는 비스듬한 좌표의 $x$ 성분을 무한소만큼 줄여야 할 때, 그리고 오직 그때에만 1이다. 표 |yCorr|도
비슷하지만 $y$ 성분을 위한 것이다. 다른 표들은 조건
$$(x+y+|halfUnit|)\bmod|unity|\ge(y+|halfUnit|)\bmod|unity|$$
가 조건
$$(x+y+|halfUnit|-|xCorr|-|yCorr|)\bmod|unity|\ge
  (y+|halfUnit|-|yCorr|)\bmod|unity|+|zCorr|$$
로 제대로 흔들리도록 정한다.

@<핵심 변수들의...@>=
xCorr[firstOctant] = 0
yCorr[firstOctant] = 0
xyCorr[firstOctant] = 0
xCorr[secondOctant] = 0
yCorr[secondOctant] = 0
xyCorr[secondOctant] = 1
xCorr[thirdOctant] = -1
yCorr[thirdOctant] = 1
xyCorr[thirdOctant] = 0
xCorr[fourthOctant] = 1
yCorr[fourthOctant] = 0
xyCorr[fourthOctant] = 1
xCorr[fifthOctant] = 0
yCorr[fifthOctant] = 1
xyCorr[fifthOctant] = 1
xCorr[sixthOctant] = 0
yCorr[sixthOctant] = 1
xyCorr[sixthOctant] = 0
xCorr[seventhOctant] = 1
yCorr[seventhOctant] = 0
xyCorr[seventhOctant] = 1
xCorr[eighthOctant] = -1
yCorr[eighthOctant] = 1
xyCorr[eighthOctant] = 0
for k = 1; k <= 8; k++ {
	zCorr[k] = xyCorr[k] - xCorr[k]
}

@ 다음은 끝점에서의 반올림의 세부를 다루는 프로시저다. 비스듬한 좌표 |(x,y)|가 주어지면, 현재 |octant|를
고려해서 |(m1,n1)|을 그에 해당하는 반올림한 격자점으로 놓는다. 또 $(x+y+{1\over2})\bmod1\ge(y+{1\over2})\bmod1$이면
전역 변수 |d1|을 1로 놓는다.

@<함수들@>=
func endRound(x, y scaled) {
	y = y + halfUnit - yCorr[octant]
	x = x + y - xCorr[octant]
	m1 = floorUnscaled(x)
	n1 = floorUnscaled(y)
	if x-unity*m1 >= y-unity*n1+zCorr[octant] {
		d1 = 1
	} else {
		d1 = 0
	}
}

@ 프로시저 |endRound|의 출력 |(m1,n1,d1)|은 이따금 |(m0,n0,d0)|으로 옮겨진다.

@<전역 변수@>=
var @!m0, @!n0, @!m1, @!n1 int32 // 격자점 좌표들
var @!d0, @!d1 int32 // 옮김 보정; |0 .. 1|

@ 이제 주어진 순환 명세~|h|가 둘러싼 화소들을 칠할 준비가 되었다. 그 순환을 나타내는 매듭 목록은 이
과정에서 없어진다. 결과 자료를 모두 받는 가장자리 구조는 |curEdges|이고, 가장자리의 무게는 |curWt|다.

@<함수들@>=
func fillSpec(h pointer) {
	var p, q, r, s pointer // 목록을 따라가는 데 쓴다
	if internal[tracingEdges] > 0 {
		beginEdgeTracing()
	}
	p = h // |leftType(h)=endpoint|라고 가정한다
	for {
		octant = leftOctant(p)
		@<변수 |q|를 현재 팔분면의 끝에 있는 노드로 놓는다@>
		if q != p {
			@<처음과 마지막 격자점 |(m0,n0)|과 |(m1,n1)|을 정한다@>
			@<현재 팔분면의 움직임을 만든다@>
			moveToEdges(m0, n0, m1, n1)
		}
		p = link(q)
		if p == h {
			break
		}
	}
	tossKnotList(h)
	if internal[tracingEdges] > 0 {
		endEdgeTracing()
	}
}

@ @<변수 |q|를 현재 팔분면의...@>=
q = p
for rightType(q) != endpoint {
	q = link(q)
}

@ @<처음과 마지막 격자점...@>=
endRound(xCoord(p), yCoord(p))
m0 = m1
n0 = n1
d0 = d1
endRound(xCoord(q), yCoord(q))

@ 끝으로 이 부의 맨 처음에 설명한 다섯 단계 과정을 한다. 대입 |move[0]=d0|이 단계 2)이고, |makeMoves|가 단계 3)과
4)를, |move[movePtr]|에서 |d1|을 빼는 것이 단계 5)를 한다.

@<현재 팔분면의 움직임을...@>=
if n1-n0 >= moveSize {
	overflow("move table size", moveSize)
}
@:METAFONT capacity exceeded move table size}{\quad move table size@>
move[0] = d0
movePtr = 0
r = p
for {
	s = link(r)
	makeMoves(xCoord(r), rightX(r), leftX(s), xCoord(s),
		yCoord(r)+halfUnit, rightY(r)+halfUnit, leftY(s)+halfUnit,
		yCoord(s)+halfUnit, xyCorr[octant], yCorr[octant])
	r = s
	if r == q {
		break
	}
}
move[movePtr] = move[movePtr] - d1
if internal[smoothing] > 0 {
	smoothMoves(0, movePtr)
}

@* 다각형 펜.
프로그램의 다음 몇 부는 ``포락선''(envelope)에 딸린 추가의 복잡한 일들을 다루고, 그 끝에서 경계가 볼록
다각형인 펜에 대해 윤곽을 칠하는 알고리즘에 이른다. 이 알고리즘 밑에 깔린 수학은 레오 기바스, 라일 램쇼,
호르헤 스톨피가 전개한 자취(tracing) 이론의 간단한 면들을 바탕으로 한다[``A kinetic framework for
computational geometry,'' {\sl Proc.\ IEEE Symp.\ Foundations of Computer Science\/ \bf24} (1983), 100--111].
@^Guibas, Leonidas Ioannis@>
@^Ramshaw, Lyle Harold@>
@^Stolfi, Jorge@>

다각형의 꼭짓점이 시계 반대 방향 순서로 $w_0$, $w_1$, \dots, $w_{n-1}$, $w_n=w_0$이면, 볼록성 조건은
사람이 $w_0$에서 $w_1$을 거쳐 $\cdots$ $w_n$까지 갈 때 각 꼭짓점에서 ``왼쪽으로 돈다''는 것을 요구한다.
포락선은 주어진 곡선 $z(t)$가 방향 $w_k-w_{k-1}$과 $w\k-w_k$ 사이에 있는 방향 $z'(t)$로 가고 있을 때 그
곡선을 $w_k$만큼 옮겨서 얻는다. 곡선의 방향 $z'(t)$가 늘어나 $w\k-w_k$를 지나는 때~$t$에는 옮긴 곡선을
그리는 것을 잠시 멈추고 $z(t)+w_k$에서 $z(t)+w\k$로 가는 직선을 끼워 넣는다. 이 직선은 옮긴 곡선에 접한다는
데 주목하라. 비슷하게, 곡선의 방향이 줄어들어 $w_k-w_{k-1}$을 지나면 그리기를 멈추고 $z(t)+w_k$에서
$z(t)+w_{k-1}$로 가는 직선을 끼워 넣는다. 뒤의 직선은 실은 ``뒷걸음'' 단계로서, \MF의 가정 아래에서는 최종
포락선의 일부가 되지 않는다. 이 구성의 결과는 곡선과 직선 조각이 번갈아 이어진 연속 경로다. 실제로는
조각들이 대개 아주 짧아서 곡선에 녹아든다. 어쨌든 화소화한 경로는 어느 것이든 화소화한 직선들의 나열로
나타낼 수 있다.

포락선에 대한 이 접근의 가장 멋진 점은 이미 전개한 팔분면 나누기 과정과 완벽하게 어울린다는 것이다.
포락선은 우리가 그릴 때 곡선 자체와 같은 방향으로 가므로, 어떤 오프셋을 더하는지에만 조심하면 된다.
뒷걸음 움직임은 문제를 일으키지만, 그것을 다루는 괜찮은 방법이 있다는 것을 보게 될 것이다.

@ 우리는 팔분면 방향마다 하나씩 오프셋의 목록 여덟 개를 유지해서 펜을 나타낸다. 곡선이 새 팔분면으로 들어가는
경계 점에서의 오프셋은 두 팔분면의 목록에 모두 나타난다. 그러면 포락선이 필요 없던 더 간단한 경우에 했듯이,
원래 다각형의 조각 가운데 방향이 첫 팔분면을 향하는 것들만 생각하면 된다.

보기를 하나 들면 이 상황이 분명해질 것이다. 꼭짓점이 $w_0=(0,-1)$, $w_1=(3,-1)$, $w_2=(6,1)$, $w_3=(1,2)$인
사각형을 생각하자. 아래 그림에서 각 변 옆에 그 변의 방향이 속하는 팔분면을 적었다.
$$\mplibcode
beginfig(17);
save u, w; numeric u; pair w[]; u := 26pt;
w0 = (0,-1); w1 = (3,-1); w2 = (6,1); w3 = (1,2);
fill (w0--w1--w2--w3--cycle) scaled u withcolor .9white;
draw (w0--w1--w2--w3--cycle) scaled u withpen pencircle scaled .8pt;
for k = 0 upto 3: dot(w[k] scaled u); endfor
label.llft(btex $w_0$ etex, w0 scaled u); label.lrt(btex $w_1$ etex, w1 scaled u);
label.rt(btex $w_2$ etex, w2 scaled u); label.ulft(btex $w_3$ etex, w3 scaled u);
label.bot(btex \.{ENE} etex, .5[w0,w1] scaled u);
label.lrt(btex \.{ENE} etex, .5[w1,w2] scaled u);
label.top(btex \.{WNW} etex, .5[w2,w3] scaled u);
label.lft(btex \.{SSW} etex, .5[w3,w0] scaled u);
endfig;
\endmplibcode$$
첫 팔분면으로 가는 곡선은 기울기가 0으로 떨어져 여덟째 팔분면으로 넘어가지 않는 한 $w_1$이나 $w_2$만큼
옮겨진다. 넘어가는 경우에는 팔분면 경계를 지날 때 $w_0$으로 바꾸어야 한다. 첫 팔분면의 목록에는 오프셋
셋 $w_0$, $w_1$,~$w_2$가 들어간다. 관례로, 팔분면 사이의 각이 명시적으로 나타나지 않으면 경계 오프셋을
겹쳐 넣는다. 이 경우에는 목록 끝에 기울기가~1인 명시적인 선이 없으므로 온전한 목록은
$$w_0\;w_1\;w_2\;w_2\;=\;(0,-1)\;(3,-1)\;(6,1)\;(6,1)$$
이다. 좌표 $(u,v)$ 대신 비스듬한 좌표 $(u-v,v)$를 쓰면 목록
$$w_0\;w_1\;w_2\;w_2\;\mapsto\;(1,-1)\;(4,-1)\;(5,1)\;(5,1)$$
을 얻는데, 이것이 실제로 자료 구조에 나타나는 것이다. 둘째 팔분면에는 오프셋이 하나뿐이다. 그것을 두 번
늘어놓고(둘째 팔분면이 첫째처럼 보이도록 좌표를 맞바꾸어서), 그 좌표를 비스듬하게 해서
$$\tabskip\centering
\halign to\hsize{$\hfil#\;\mapsto\;{}$\tabskip=0pt&
  $#\hfil$&\quad #\hfil\tabskip\centering\cr
w_2\;w_2&(-5,6)\;(-5,6)\cr
\noalign{\vskip\belowdisplayskip
\vbox{\noindent\strut 를 곡선이 둘째 팔분면으로 갈 때 쓸, 바꾸고 비스듬하게 한 오프셋의 목록으로 얻는다.
비슷하게 다음 목록들을 갖게 될 것이다.\strut}
\vskip\abovedisplayskip}
w_2\;w_2&(7,-6)\;(7,-6)&셋째;\cr
w_2\;w_2\;w_3\;w_3&(-7,1)\;(-7,1)\;(-3,2)\;(-3,2)&넷째;\cr
w_3\;w_3&(1,-2)\;(1,-2)&다섯째;\cr
w_3\;w_3\;w_0\;w_0&(-1,1)\;(-1,1)\;(1,0)\;(1,0)&여섯째;\cr
w_0\;w_0&(1,0)\;(1,0)&일곱째;\cr
w_0\;w_0&(-1,1)\;(-1,1)&여덟째.\cr}$$
여기서 $w_1$은 첫 팔분면의 안쪽에 있는 것으로 보고 여덟째 팔분면에는 넣지 않았다는 데 주목하라. 똑같이
$w_0$을 첫 팔분면의 목록에서 빼서 여덟째 목록에 넣을 수도 있었다. 그러면 첫 팔분면의 목록은
$$w_1\;w_1\;w_2\;w_2\;\mapsto\;(4,-1)\;(4,-1)\;(5,1)\;(5,1)$$
이 되고 여덟째 팔분면의 목록은
$$w_0\;w_0\;w_1\;\mapsto\;(-1,1)\;(-1,1)\;(2,1)$$
이 되었을 것이다.

실은 복잡한 일이 하나 더 있다. 짝수 번째 팔분면에서는 오프셋의 순서가 거꾸로다. 그런 팔분면에서는 좌표
변환이 시계 반대 방향과 시계 방향을 뒤바꾸었기 때문이다. 이를테면 넷째 팔분면의 오프셋은 실제로는 $w_2$,
$w_2$, $w_3$,~$w_3$이 아니라 $w_3$, $w_3$, $w_2$,~$w_2$다.

@ 일반적으로 한 팔분면의 오프셋 목록은 (각 목록에서 아래 첨자를 다시 매기면)
$$w_0\;\;w_1\;\;\ldots\;\;w_n\;\;w_{n+1}$$
꼴이다. 여기서 $w_0$과 $w_{n+1}$은 이웃한 목록과 함께 갖는 오프셋이다. 그리고 $w_0=w_1$이거나 $w_n=w_{n+1}$인
경우가 잦지만, 다른 $w$들은 서로 다르다. 기울기~0과 방향 $w_2-w_1$ 사이로 가는 곡선은 오프셋~$w_1$을 쓰고,
$1<k<n$에 대해 방향 $w_k-w_{k-1}$과 $w\k-w_k$ 사이로 가는 곡선은 오프셋~$w_k$를 쓰고, 방향 $w_n-w_{n-1}$과
기울기~1(비스듬하게 한 뒤에는 실은 기울기~$\infty$) 사이로 가는 곡선은 오프셋~$w_n$을 쓴다. 짝수 번째
팔분면에서는 오프셋을 거꾸로 늘어놓았으므로 방향이 실은 $w\k-w_k$ 대신 $w_k-w\k$다.

각 오프셋 $w_k$는 비스듬한 좌표 $(u_k-v_k,v_k)$로 나타낸다. 여기서 $(u_k,v_k)$는 $w_k$를 첫 팔분면으로
변장하도록 돌린 다음의 표현이다.

@ 펜 다각형의 맨 위 자료 구조는 열 낱말짜리 노드로서, 참조 횟수 하나와 그 뒤의 오프셋 목록 여덟 개를 가리키는
포인터들, 그 뒤의 펜의 값 범위를 나타내는 것으로 이루어진다.
@^reference counts@>

포인터 |p|가~그런 노드를 가리키고, 이를테면 넷째 팔분면의 오프셋 목록에 항목 $w_0$, $w_1$, \dots, $w_n$,~$w_{n+1}$이
있으면, |info(p+fourthOctant)|는~$n$과 같고 |link(p+fourthOctant)|는 $w_0$을 담은 오프셋 노드를 가리킨다.
메모리 위치 |p+fourthOctant|를 넷째 팔분면의 펜 오프셋 목록의 {\sl 머리\/}라고 부른다. 이것은 짝수 번째
팔분면이므로 $w_0$은 다섯째 팔분면과 함께 가는 오프셋이고, $w_{n+1}$은 셋째와 함께 간다.

오프셋 목록의 원소들은 이중으로 연결된 세 낱말짜리 노드로서, |xCoord|와 |yCoord| 필드에 좌표를 담는다.
두 연결 필드는 |link|와 |knil|이라고 부른다. 포인터 |w|가~$w_k$의 노드를 가리키면 |link(w)|와 |knil(w)|는 각각
$w\k$와~$w_{k-1}$의 노드를 가리킨다. 또 |h|가 목록 머리이면 |link(h)|는~$w_0$의 노드를 가리키고
|knil(link(h))|는 $w_{n+1}$의 노드를 가리킨다.

펜 머리 노드의 열째 낱말에는 비스듬하지 않은 모든 펜 오프셋 가운데 $x$나 $y$ 좌표의 최대 절댓값이 들어 있다.

펜 머리 노드의 |link| 필드는 펜이 점 하나일 때, 그리고 오직 그때에만 |null|이어야 한다.

@<정의@>=
const (
	@!penNodeSize = 10
	@!coordNodeSize = 3
)

func maxOffset(p pointer) scaled       { return mem[p+9].sc }
func setMaxOffset(p pointer, v scaled) { mem[p+9].sc = v }

@ 서브루틴 |printPen|은 \MF의 복잡한 내부 오프셋 표현으로부터 다각형의 꼭짓점들을 다시 만들어서 이 관례들을
보여 준다.

@<함수들@>=
func printPen(p pointer, s any, nuline bool) {
	var nothingPrinted bool // 아직 아무 일도 없었나?
	var k int32 // 팔분면 번호; |1 .. 8|
	var h pointer // 오프셋 목록의 머리
	var m, n int32 // 오프셋 첨자들
	var w, ww pointer // 오프셋 목록을 훑는 포인터들
	printDiagnostic("Pen polygon", s, nuline)
	nothingPrinted = true
	printLn()
	for k = 1; k <= 8; k++ {
		octant = octantCode[k]
		h = p + octant
		n = info(h)
		w = link(h)
		if !odd(k) {
			w = knil(w) // 짝수 팔분면에서는 $w_{n+1}$에서 시작한다
		}
		for m = 1; m <= n+1; m++ {
			if odd(k) {
				ww = link(w)
			} else {
				ww = knil(w)
			}
			if xCoord(ww) != xCoord(w) || yCoord(ww) != yCoord(w) {
				@<노드 |ww|의 비스듬하지 않고 돌리지 않은 좌표를 찍는다@>
			}
			w = ww
		}
	}
	if nothingPrinted {
		w = link(p + firstOctant)
		printTwo(xCoord(w)+yCoord(w), yCoord(w))
	}
	printNl(" .. cycle")
	endDiagnostic(true)
}

@ @<노드 |ww|의 비스듬하지 않고 돌리지 않은 좌표를 찍는다@>=
if nothingPrinted {
	nothingPrinted = false
} else {
	printNl(" .. ")
}
printTwoTrue(xCoord(ww), yCoord(ww), octant)

@ 꼭짓점이 $(0,0)$ 하나뿐인 널 펜 다각형은 오류 회복을 위해 미리 선언해 둔다. 아래의 프로시저 |tossPen|은
이것을 결코 메모리에서 지우지 않으므로 제대로 된 참조 횟수가 필요 없다.
@^reference counts@>

@<표의 항목들을...@>=
setRefCount(nullPen, null)
setLink(nullPen, null)
setInfo(nullPen+1, 1)
setLink(nullPen+1, nullCoords)
for k = nullPen + 2; k <= nullPen+8; k++ {
	mem[k] = mem[nullPen+1]
}
setMaxOffset(nullPen, 0)
setLink(nullCoords, nullCoords)
setKnil(nullCoords, nullCoords)
setXCoord(nullCoords, 0)
setYCoord(nullCoords, 0)

@ 다음은 이중 연결 목록에서 오프셋의 복사본을 그 복제의 |link| 쪽에 끼워 넣는 하찮은 서브루틴이다.

@<함수들@>=
func dupOffset(w pointer) {
	var r pointer // 새 노드
	r = getNode(coordNodeSize)
	setXCoord(r, xCoord(w))
	setYCoord(r, yCoord(w))
	setLink(r, link(w))
	setKnil(link(w), r)
	setKnil(r, w)
	setLink(w, r)
}

@ 다음 알고리즘은 조금 더 재미있다. 순환 경로의 매듭 목록을 |xCoord|, |yCoord|, |link| 필드만 보고 나머지는
무시해서 펜 다각형으로 바꾼다. 주어진 경로의 꼭짓점들이 볼록 다각형을 정의하지 않으면 오류 메시지를 내고
널 펜을 돌려준다.

@<함수들@>=
func makePen(h pointer) pointer {
	var o, oo, k smallNumber // 팔분면 번호들---옛것, 새것, 현재의 것
	var p pointer // 새 펜의 맨 위 노드
	var q, r, s, w, hh pointer // 목록 조작을 위해
	var n int32 // 오프셋 계수기
	var dx, dy scaled // 다각형의 방향
	var mc scaled // 가장 큰 좌표
	@<팔분면 코드를 찍고 최대 오프셋을 구하고 |hh|를 정한다; 문제가 있으면 |goto notFound|@>
	if mc >= fractionOne-halfUnit {
		goto notFound
	}
	p = getNode(penNodeSize)
	q = hh
	setMaxOffset(p, mc)
	setRefCount(p, null)
	if link(q) != q {
		setLink(p, null+1)
	}
	for k = 1; k <= 8; k++ {
		@<|k|번째 팔분면의 오프셋 목록을 만든다@>
	}
	goto found
notFound:
	p = nullPen
	@<나쁜 펜 경로를 나무란다@>
found:
	if internal[tracingPens] > 0 {
		printPen(p, " (newly created)", true)
	}
	return p
}

@ @<나쁜 펜 경로를...@>=
if mc >= fractionOne-halfUnit {
	printErr("Pen too large")
@.Pen too large@>
	help2("The cycle you specified has a coordinate of 4095.5 or more.",
		"So I've replaced it by the trivial path `(0,0)..cycle'.")
} else {
	printErr("Pen cycle must be convex")
@.Pen cycle must be convex@>
	help3("The cycle you specified either has consecutive equal points",
		"or turns right or turns through more than 360 degrees.",
		"So I've replaced it by the trivial path `(0,0)..cycle'.")
}
putGetError()

@ 순환에서 팔분면 번호가 앞의 노드보다 작은 노드는 꼭 하나 있어야 한다. 그것이 노드~|hh|다.

여기의 루프는 모든 경우에 끝나지만 그 증명은 조금 까다롭다. 순환에 서로 다른 $y$~좌표가 적어도 둘 있으면,
순환의 서로 다른 점에서 |o>4|와 |o<=4|가 될 것이다. 그렇지 않으면 서로 다른 $x$~좌표가 적어도 둘 있고, 어딘가에서
|o>2|, 어딘가에서 |o<=2|가 될 것이다.

@<팔분면 코드를 찍고 최대 오프셋을 구하고 |hh|를 정한다; 문제가 있으면 |goto notFound|@>=
q = h
r = link(q)
mc = abs(xCoord(h))
if q == r {
	hh = h
	setRightType(h, 0) // 이 꾀는 아래에서 설명한다
	if mc < abs(yCoord(h)) {
		mc = abs(yCoord(h))
	}
} else {
	o = 0
	hh = null
	for {
		@<|mc|와 변의 방향 |(dx,dy)|를 구한다; 점이 겹치거나 오른쪽으로 돌면 |goto notFound|@>
		@<방향 |(dx,dy)|의 팔분면 코드를 정한다@>
		setRightType(q, octant)
		oo = octantNumber[octant]
		if o > oo {
			if hh != null {
				goto notFound // $>360^\circ$
			}
			hh = q
		}
		o = oo
		if q == h && hh != null {
			break
		}
		q = r
		r = s
	}
}

@ 볼록한 펜 다각형은 왼쪽으로만 돈다. 이웃한 두 변 $(r-q)$와 $(s-r)$의 외적이 음수이면 오른쪽으로 도는 것이다.

@<|mc|와 변의 방향 |(dx,dy)|를 구한다; 점이 겹치거나 오른쪽으로 돌면 |goto notFound|@>=
s = link(r)
if mc < abs(xCoord(r)) {
	mc = abs(xCoord(r))
}
if mc < abs(yCoord(r)) {
	mc = abs(yCoord(r))
}
dx = xCoord(r) - xCoord(q)
dy = yCoord(r) - yCoord(q)
if dx == 0 && dy == 0 {
	goto notFound // 겹친 점
}
if abVsCd(dx, yCoord(s)-yCoord(r), dy, xCoord(s)-xCoord(r)) < 0 {
	goto notFound // 오른쪽으로 돈다
}

@ 방향 |(-dx,-dy)|의 팔분면이 |(dx,dy)|의 팔분면과 정확히 맞은편이 되기를 바란다.

@<방향 |(dx,dy)|의 팔분면...@>=
if dx > 0 {
	octant = firstOctant
} else if dx == 0 {
	if dy > 0 {
		octant = firstOctant
	} else {
		octant = firstOctant + negateX
	}
} else {
	dx = -dx
	octant = firstOctant + negateX
}
if dy < 0 {
	dy = -dy
	octant = octant + negateY
} else if dy == 0 {
	if octant > firstOctant {
		octant = firstOctant + negateX + negateY
	}
}
if dx < dy {
	octant = octant + switchXAndY
}

@ 이제 |q|는 현재 팔분면이 앞의 팔분면과 함께 갖는 노드를 가리키고, |rightType(q)|는 그동안 |q|가~나아가야 할
팔분면 코드다. 펜이 퇴화해서 |q|가 결코 나아가지 않아야 하는 특별한 경우에는 |rightType(q)=0|으로 놓았다.

오프셋의 수 |n|은 |maxQuarterword|보다 작아야 한다. 루틴 |fillEnvelope|가 매듭 노드의 |rightType| 필드에
|n+1|을 넣기 때문이다.

@<|k|번째 팔분면의 오프셋...@>=
octant = octantCode[k]
n = 0
h = p + octant
for {
	r = getNode(coordNodeSize)
	skew(xCoord(q), yCoord(q), octant)
	setXCoord(r, curX)
	setYCoord(r, curY)
	if n == 0 {
		setLink(h, r)
	} else {
		@<노드 |r|을 앞 노드에 잇는다@>
	}
	w = r
	if rightType(q) != octant {
		break
	}
	q = link(q)
	n++
}
@<오프셋 노드들의 연결을 마치고, 필요하면 경계의 오프셋 노드들을 겹친다@>
if n >= maxQuarterword {
	overflow("pen polygon size", maxQuarterword)
}
@:METAFONT capacity exceeded pen polygon size}{\quad pen polygon size@>
setInfo(h, n)

@ 이제 |w|는 가장 최근에 넣은 노드를 가리키고, |k|는 현재 팔분면 번호다.

@<노드 |r|을 앞 노드에...@>=
if odd(k) {
	setLink(w, r)
	setKnil(r, w)
} else {
	setKnil(w, r)
	setLink(r, w)
}

@ 우리는 노드 |n+1|개를 넣었다. 기울기 0과~$\infty$가 아직 나타나지 않았다면 양 끝의 노드를 겹쳐 넣는 일이
남았다. 이 절이 끝나면 오프셋 노드의 전체 수는 |n+2|여야 한다(우리는 그것들을 $w_0$, $w_1$,
\dots,~$w_{n+1}$이라고 부른다).

@<오프셋 노드들의 연결을...@>=
r = link(h)
if odd(k) {
	setLink(w, r)
	setKnil(r, w)
} else {
	setKnil(w, r)
	setLink(r, w)
	setLink(h, w)
	r = w
}
if yCoord(r) != yCoord(link(r)) || n == 0 {
	dupOffset(r)
	n++
}
r = knil(r)
if xCoord(r) != xCoord(knil(r)) {
	dupOffset(r)
} else {
	n--
}

@ 거꾸로, |makePath|는 펜에서 그것을 만들어 냈을 수도 있는 순환 경로로 되돌아간다. 이 서브루틴의 짜임새는
본질적으로 |printPen|과 같다.

@<함수들@>=
func makePath(penHead pointer) pointer {
	var p pointer // 가장 최근에 베낀 매듭
	var k int32 // 팔분면 번호; |1 .. 8|
	var h pointer // 오프셋 목록의 머리
	var m, n int32 // 오프셋 첨자들
	var w, ww pointer // 오프셋 목록을 훑는 포인터들
	p = tempHead
	for k = 1; k <= 8; k++ {
		octant = octantCode[k]
		h = penHead + octant
		n = info(h)
		w = link(h)
		if !odd(k) {
			w = knil(w) // 짝수 팔분면에서는 $w_{n+1}$에서 시작한다
		}
		for m = 1; m <= n+1; m++ {
			if odd(k) {
				ww = link(w)
			} else {
				ww = knil(w)
			}
			if xCoord(ww) != xCoord(w) || yCoord(ww) != yCoord(w) {
				@<노드 |ww|의 비스듬하지 않고 돌리지 않은 좌표를 베낀다@>
			}
			w = ww
		}
	}
	if p == tempHead {
		w = link(penHead + firstOctant)
		p = trivialKnot(xCoord(w)+yCoord(w), yCoord(w))
		setLink(tempHead, p)
	}
	setLink(p, link(tempHead))
	return link(tempHead)
}

@ @<노드 |ww|의 비스듬하지 않고 돌리지 않은 좌표를 베낀다@>=
unskew(xCoord(ww), yCoord(ww), octant)
setLink(p, trivialKnot(curX, curY))
p = link(p)

@ @<함수들@>=
func trivialKnot(x, y scaled) pointer {
	var p pointer // 명시적인 좌표 |x|와 |y|를 위한 새 매듭
	p = getNode(knotNodeSize)
	setLeftType(p, explicit)
	setRightType(p, explicit)
	setXCoord(p, x)
	setLeftX(p, x)
	setRightX(p, x)
	setYCoord(p, y)
	setLeftY(p, y)
	setRightY(p, y)
	return p
}

@ 만들어질 수 있는 것은 부서질 수 있다.

@<정의@>=
func addPenRef(p pointer) { setRefCount(p, refCount(p)+1) }
func deletePenRef(p pointer) {
	if refCount(p) == null {
		tossPen(p)
	} else {
		setRefCount(p, refCount(p)-1)
	}
}

@ @<함수들@>=
func tossPen(p pointer) {
	var k int32 // 상대 머리 위치들; |1 .. 8|
	var w, ww pointer // 오프셋 노드를 가리키는 포인터들
	if p != nullPen {
		for k = 1; k <= 8; k++ {
			w = link(p + k)
			for {
				ww = link(w)
				freeNode(w, coordNodeSize)
				w = ww
				if w == link(p+k) {
					break
				}
			}
		}
		freeNode(p, penNodeSize)
	}
}

@ 프로시저 |findOffset|은 주어진 방향~|(x,y)|와 주어진 펜~|p|에 딸린 오프셋을 |(curX,curY)|에 넣는다.
방향이 |x=y=0|이면 결과는 |(0,0)|이다. 서로 다른 두 오프셋이 해당되면 그 가운데 하나를 마음대로 고른다.

@<함수들@>=
func findOffset(x, y scaled, p pointer) {
	var octant int32 // |(x,y)|의 팔분면 코드
	var s int32 // 팔분면의 부호; |-1 .. +1|
	var n int32 // 남은 오프셋의 수
	var h, w, ww pointer // 목록을 훑는 레지스터들
	@<팔분면 코드를 계산하고, 좌표 |(x,y)|를 비스듬하게 하고 돌린다@>
	if odd(octantNumber[octant]) {
		s = -1
	} else {
		s = +1
	}
	h = p + octant
	w = link(link(h))
	ww = link(w)
	n = info(h)
	for n > 1 {
		if abVsCd(x, yCoord(ww)-yCoord(w), y, xCoord(ww)-xCoord(w)) != s {
			break
		}
		w = ww
		ww = link(w)
		n--
	}
	unskew(xCoord(w), yCoord(w), octant)
}

@ @<팔분면 코드를 계산하고...@>=
if x > 0 {
	octant = firstOctant
} else if x == 0 {
	if y <= 0 {
		if y == 0 {
			curX = 0
			curY = 0
			return
		}
		octant = firstOctant + negateX
	} else {
		octant = firstOctant
	}
} else {
	x = -x
	if y == 0 {
		octant = firstOctant + negateX + negateY
	} else {
		octant = firstOctant + negateX
	}
}
if y < 0 {
	octant = octant + negateY
	y = -y
}
if x >= y {
	x = x - y
} else {
	octant = octant + switchXAndY
	x = y - x
	y = y - x
}

@* 포락선 칠하기.
이제 \MF의 디지털 그리기 루틴들의 정점에 이르려 한다. 앞의 알고리즘들이 거의 모두 \MF의 가장 어려운 일,
곧 주어진 펜 다각형에 대해 주어진 순환 경로의 포락선을 칠하는 일에 동원될 것이다.

그러나 그렇게 크게 뛰어들기 전에 준비 작업을 조금 더 마쳐야 한다.

아래 그림이 우리가 하려는 일이다. 가는 선이 경로이고, 회색 마름모들은 경로의 몇몇 점에 놓은 펜이다. 굵은
선으로 둘러싼 영역이 펜이 경로를 따라 움직이며 쓸고 지나가는 자리, 곧 포락선이다. 포락선의 둘레는 펜의
꼭짓점만큼 옮긴 곡선 조각들과, 펜의 변과 평행한 직선 조각들이 번갈아 이어진 것이다. (이 그림을 그린
MetaPost의 \.{envelope} 연산자는 바로 이 부의 알고리즘에서 자라난 것이다.)
$$\mplibcode
beginfig(18);
save u, c, e, pn, q; numeric u; path c, e, q; pen pn; u := 30pt;
q := (0,-.4u)--(.55u,0)--(0,.4u)--(-.55u,0)--cycle;
pn := makepen q;
c := (0,0){dir 80}..(2u,1.4u)..{dir -60}(4u,0);
e := envelope pn of c;
fill e withcolor .92white;
for t = 0, .5, 1, 1.5, 2: draw q shifted (point t of c) withcolor .55white; endfor
draw e withpen pencircle scaled .9pt;
draw c withpen pencircle scaled .3pt;
endfig;
\endmplibcode$$

@ 비어 있지 않은 삼차식 목록을 가리키는 포인터 |c|와 펜 다각형 조각의 머리 정보를 가리키는 포인터~|h|가
주어지면, 루틴 |offsetPrep|은 그 목록을 특정한 펜 오프셋에 딸린 삼차식들로 바꾼다. 곧 |rightType(p)=k|이면
|p|와~|q| 사이의 삼차식은 |k|번째 오프셋에 딸린다.

목록 |c|는 실은 순환 명세의 일부이므로 |rightType|이 |endpoint|인 첫 노드에서 끝난다. 삼차식들은 모두 단조
비감소인 $x(t)$와 $y(t)$를 가진다.

@<함수들@>=
func offsetPrep(c, h pointer) {
	var n halfword // 펜 오프셋의 수
	var p, q, r, lh, ww pointer // 목록 조작을 위해
	var k halfword // 현재 오프셋 첨자
	var w pointer // 오프셋 $w_k$를 가리키는 포인터
	var x0, x1, x2, y0, y1, y2 int32 // 도함수의 대표값들
	var t0, t1, t2 int32 // 기울기를 시험하는 다항식의 계수들
	var du, dv, dx, dy int32 // 펜과 곡선의 기울기를 위해
	var maxCoef int32 // 눈금을 바꾸는 동안 쓴다
	var x0a, x1a, x2a, y0a, y1a, y2a int32 // 중간 값들
	var t fraction // 도함수가 0을 지나는 곳
	var s fraction // 기울기나 기울기의 역수
	p = c
	n = info(h)
	lh = link(h) // 이제 |lh|는 $w_0$을 가리킨다
	for rightType(p) != endpoint {
		q = link(p)
		@<필요하면 |p|와 |q| 사이의 삼차식을 오프셋마다 나누고, |q|를 마지막 조각의 끝으로 옮긴다@>
		@<|p|를 노드 |q|로 나아가게 하되, 나누는 과정에서 생겼을지 모르는 ``죽은'' 삼차식은 없앤다@>
	}
}

@ @<|p|를 노드 |q|로 나아가게...@>=
for {
	r = link(p)
	if xCoord(p) == rightX(p) && yCoord(p) == rightY(p) &&
		xCoord(p) == leftX(r) && yCoord(p) == leftY(r) &&
		xCoord(p) == xCoord(r) && yCoord(p) == yCoord(r) {
		removeCubic(p)
		if r == q {
			q = p
		}
		r = p
	}
	p = r
	if p == q {
		break
	}
}

@ 나누는 과정은 |splitCubic| 같은 서브루틴을 쓰지만, (``방탄'' 동작을 위해) 나눈 뒤의 (비스듬한) 좌표가
$\Delta x\ge0$과 $\Delta y\ge0$을 만족하는지 확인한다. 루틴 |makeSpec|은 나누기 전에 이 관계가 성립하도록 해
두었다. (루틴 |makeSpec|이 전보다 훨씬 조심스러워졌으니 이 조심은 이제 틀림없이 필요 없다. 그러나 누가 운에 맡기고
싶겠는가? 하드웨어가 고장 나든지 할지도 모른다.)

@<함수들@>=
func splitForOffset(p pointer, t fraction) {
	var q pointer // |p|의 후속자
	var r pointer // 새 노드
	q = link(p)
	splitCubic(p, t, xCoord(q), yCoord(q))
	r = link(p)
	if yCoord(r) < yCoord(p) {
		setYCoord(r, yCoord(p))
	} else if yCoord(r) > yCoord(q) {
		setYCoord(r, yCoord(q))
	}
	if xCoord(r) < xCoord(p) {
		setXCoord(r, xCoord(p))
	} else if xCoord(r) > xCoord(q) {
		setXCoord(r, xCoord(q))
	}
}

@ 펜 다각형에 오프셋이 |n|개 있고 그 가운데 $k$번째가 $w_k=(u_k,v_k)$이면, $k$번째 펜 기울기는 공식
$$s_k={v\k-v_k\over u\k-u_k},\qquad\hbox{($0<k<n$에 대해)}$$
으로 정의한다. 홀수 번째 팔분면에서는 이 분수의 분자와 분모가 음이 아니고, 짝수 번째 팔분면에서는 둘 다
양이 아니다. 게다가 언제나 $0=s_0\le s_1\le\cdots\le s_n=\infty$이다. 루틴 |offsetPrep|의 목표는 각 삼차식에 딸릴
오프셋 첨자~|k|를 찾는 것인데, 삼차식의 기울기 $s(t)$가
$$s_{k-1}\le s(t)\le s_k\qquad\hbox{($0\le t\le 1$에 대해)}\eqno(*)$$
를 만족해야 한다. 조각마다 오프셋이 하나로 정해지기 전에 삼차식을 $2n-1$조각까지 나누어야 할 수도 있다.

@<필요하면 |p|와 |q| 사이의 삼차식을...@>=
if n <= 1 {
	setRightType(p, 1) // 이 경우는 쉽다
} else {
	@<도함수 계산을 준비한다; 현재 삼차식이 죽었으면 |goto notFound|@>
	@<처음 기울기 |dy/dx|를 찾는다@>
	if dx == 0 {
		@<무한 기울기라는 특별한 경우를 처리한다@>
	} else {
		@<$s_{k-1}\le\\{dy}/\\{dx}<s_k$인 첨자 |k|를 찾는다@>
		@<오프셋 나누기 과정을 마친다@>
	}
notFound:
}

@ 삼차식 $B(z_0,z_1,z_2,z_3;t)=\bigl(x(t),y(t)\bigr)$의 기울기는 이차 다항식
${1\over3}x'(t)=B(x_1-x_0,x_2-x_1,x_3-x_2;t)$와 ${1\over3}y'(t)=B(y_1-y_0,y_2-y_1,y_3-y_2;t)$로 계산할 수 있다.
현재의 삼차식에서 나눈 여러 삼차식의 기울기를 계산할 수도 있으므로, 정밀도를 너무 많이 잃지 않고 이 계산을
하는 것이 바람직하다. 삼차식 자체에서 찾은 도함수보다 쌓인 오차에 덜 더럽혀진, ``키운'' 도함수 값들을 지역
변수 |x0|, |x1|, |x2|에 유지한다. 이것들은 $X_0=2^l(x_1-x_0)$, $X_1=2^l(x_2-x_1)$, $X_2=2^l(x_3-x_2)$를
나타낸다. 비슷하게 |y0|, |y1|,~|y2|는 $Y_0=2^l(y_1-y_0)$, $Y_1=2^l(y_2-y_1)$, $Y_2=2^l(y_3-y_2)$를 나타낸다.
삼차식의 기울기가 $\ge s$인지 $\le s$인지 시험하려면, $s\le1$이면 이차식
${1\over3}2^l\bigl(y'(t)-sx'(t)\bigr)$의 부호를, $s>1$이면 ${1\over3}2^l\bigl(y'(t)/s-x'(t)\bigr)$의 부호를 시험한다.
이 루틴의 지역 변수들은 앞에서 |offsetPrep|의 머리에 선언했다.

@<도함수 계산을 준비한다...@>=
x0 = rightX(p) - xCoord(p) // |>=0|이어야 한다
x2 = xCoord(q) - leftX(q) // 마찬가지
x1 = leftX(q) - rightX(p) // 그러나 이것은 음수일 수 있다
y0 = rightY(p) - yCoord(p)
y2 = yCoord(q) - leftY(q)
y1 = leftY(q) - rightY(p)
maxCoef = abs(x0) // 확실히 하려고 |abs|를 취한다
if abs(x1) > maxCoef {
	maxCoef = abs(x1)
}
if abs(x2) > maxCoef {
	maxCoef = abs(x2)
}
if abs(y0) > maxCoef {
	maxCoef = abs(y0)
}
if abs(y1) > maxCoef {
	maxCoef = abs(y1)
}
if abs(y2) > maxCoef {
	maxCoef = abs(y2)
}
if maxCoef == 0 {
	goto notFound
}
for maxCoef < fractionHalf {
	maxCoef += maxCoef
	x0 += x0
	x1 += x1
	x2 += x2
	y0 += y0
	y1 += y1
	y2 += y2
}

@ 먼저 문제의 특별한 경우 하나를 풀자. (i)~모든~$t$에 대해 $s(t)\ge s_{k-1}$이고 $s(0)<s_k$이거나,
(ii)~모든~$t$에 대해 $s(t)\le s_k$이고 $s(0)>s_{k-1}$인 첨자~$k$를 안다고 하자. 그러면 어떤 뜻에서 일은 절반
끝난 셈이다. 조건 $(*)$의 두 부등식 가운데 하나는 만족되고, 다른 하나는 다른 어떤 |k| 값으로도 만족될 수 없기
때문이다.

서브루틴 |finOffsetPrep|이 이 부분 문제를 푼다. 이것에는 |rising|이라는 불 매개변수가 있는데, 경우~(i)이면
|true|이고 경우~(ii)이면 |false|다. 또 |rising=false|이면 매개변수 |x0|부터 |y2|까지는 |p| 다음의 삼차식의 도함수의
음수를 나타내고, 그렇지 않으면 실제 도함수를 나타낸다. 매개변수 |w|는 오프셋~$w_k$를 가리켜야 한다.

@<함수들@>=
func finOffsetPrep(p pointer, k halfword, w pointer,
	x0, x1, x2, y0, y1, y2 int32, rising bool, n int32) {
	var ww pointer // 목록 조작을 위해
	var du, dv scaled // 기울기 계산을 위해
	var t0, t1, t2 int32 // 시험 계수들
	var t fraction // 도함수가 중요한 기울기를 지나는 곳
	var s fraction // 기울기나 기울기의 역수
	var v int32 // |x0 .. y2|를 갱신하는 중간 값
	for {
		setRightType(p, k)
		if rising {
			if k == n {
				return
			}
			ww = link(w) // $w\k$를 가리키는 포인터
		} else {
			if k == 1 {
				return
			}
			ww = knil(w) // $w_{k-1}$을 가리키는 포인터
		}
		@<$s(t)$를 $s_k$나 $s_{k-1}$과 견주는 시험 계수 |(t0,t1,t2)|를 계산한다@>
		t = crossingPoint(t0, t1, t2)
		if t >= fractionOne {
			return
		}
		@<삼차식을 $t$에서 나누고, 도함수가 되돌아 지나가면 삼차식 하나를 더 떼어 낸다@>
		if rising {
			k++
		} else {
			k--
		}
		w = ww
	}
}

@ @<$s(t)$를 $s_k$나 $s_{k-1}$과...@>=
du = xCoord(ww) - xCoord(w)
dv = yCoord(ww) - yCoord(w)
if abs(du) >= abs(dv) { // $s_{k-1}\le1$이거나 $s_k\le1$
	s = makeFraction(dv, du)
	t0 = takeFraction(x0, s) - y0
	t1 = takeFraction(x1, s) - y1
	t2 = takeFraction(x2, s) - y2
} else {
	s = makeFraction(du, dv)
	t0 = x0 - takeFraction(y0, s)
	t1 = x1 - takeFraction(y1, s)
	t2 = x2 - takeFraction(y2, s)
}

@ 곡선이 $s_k$나 $s_{k-1}$을 지났다. 그 처음 조각은 $(*)$을 만족하고, 그것이 다시 지나가서 각각 $s_{k-1}$이나
$s_k$ 쪽으로 되돌아와 $(*)$의 또 다른 해를 내놓을 수도 있다.

@<삼차식을 $t$에서 나누고...@>=
splitForOffset(p, t)
setRightType(p, k)
p = link(p)
v = tOfTheWay(x0, x1, t)
x1 = tOfTheWay(x1, x2, t)
x0 = tOfTheWay(v, x1, t)
v = tOfTheWay(y0, y1, t)
y1 = tOfTheWay(y1, y2, t)
y0 = tOfTheWay(v, y1, t)
t1 = tOfTheWay(t1, t2, t)
if t1 > 0 {
	t1 = 0 // 반올림 오차가 없다면 |t1|은 |<=0|일 것이다
}
t = crossingPoint(0, -t1, -t2)
if t < fractionOne {
	splitForOffset(p, t)
	setRightType(link(p), k)
	v = tOfTheWay(x1, x2, t)
	x1 = tOfTheWay(x0, x1, t)
	x2 = tOfTheWay(x1, v, t)
	v = tOfTheWay(y1, y2, t)
	y1 = tOfTheWay(y0, y1, t)
	y2 = tOfTheWay(y1, v, t)
}

@ 이제 주어진 삼차식에 대해 아무것도 모를 때 |offsetPrep|의 일반적인 문제를 생각해야 한다. 먼저 |t=0| 근처에서
그 기울기 $s(0)$을 찾는 데서 시작한다.

도함수가 $z'(t)=0$이면 주어진 삼차식은 수치적으로 불안정하다. 기울기의 방향이 아마 주로 반올림 오차의 영향을 받을
것이기 때문이다. 그런 뾰족한 곡선을 지정하는 사용자는 꽤 거친 결과를 예상해야 한다. 지금의 코드는 반올림
오차가 없는 것처럼 주어진 자료를 최대한 믿으려 애쓴다.

@ @<처음 기울기 |dy/dx|를...@>=
dx = x0
dy = y0
if dx == 0 && dy == 0 {
	dx = x1
	dy = y1
	if dx == 0 && dy == 0 {
		dx = x2
		dy = y2
	}
}

@ 다음 단계는 처음 기울기를 펜 다각형의 잇단 기울기 사이에 끼워 넣는 것이다. 다음 루프에서 가장 중요한 불변
관계는 |dy/dx>=@t$s_{k-1}$@>|이다.

@<$s_{k-1}\le\\{dy}/\\{dx}<s_k$인 첨자...@>=
k = 1
w = link(lh)
for {
	if k == n {
		break
	}
	ww = link(w)
	if abVsCd(dy, abs(xCoord(ww)-xCoord(w)), dx, abs(yCoord(ww)-yCoord(w))) >= 0 {
		k++
		w = ww
	} else {
		break
	}
}

@ 끝으로 일반적인 문제를 |finOffsetPrep|이 다룰 수 있는 상황으로 줄이고 싶다. 만일 |k=1|이면 이미 원하는 상황에
있다. 그렇지 않으면 삼차식을 $s_{k-1}$에 대해 많아야 세 부분으로 나누고, 각 부분에 |finOffsetPrep|을 적용할 수
있다.

@<오프셋 나누기 과정을...@>=
if k == 1 {
	t = fractionOne + 1
} else {
	ww = knil(w)
	@<$s(t)$를 $s_k$나 $s_{k-1}$과...@>
	t = crossingPoint(-t0, -t1, -t2)
}
if t >= fractionOne {
	finOffsetPrep(p, k, w, x0, x1, x2, y0, y1, y2, true, n)
} else {
	splitForOffset(p, t)
	r = link(p)
	x1a = tOfTheWay(x0, x1, t)
	x1 = tOfTheWay(x1, x2, t)
	x2a = tOfTheWay(x1a, x1, t)
	y1a = tOfTheWay(y0, y1, t)
	y1 = tOfTheWay(y1, y2, t)
	y2a = tOfTheWay(y1a, y1, t)
	finOffsetPrep(p, k, w, x0, x1a, x2a, y0, y1a, y2a, true, n)
	x0 = x2a
	y0 = y2a
	t1 = tOfTheWay(t1, t2, t)
	if t1 < 0 {
		t1 = 0
	}
	t = crossingPoint(0, t1, t2)
	if t < fractionOne {
		@<|finOffsetPrep|을 위해 |rising| 삼차식을 하나 더 떼어 낸다@>
	}
	finOffsetPrep(r, k-1, ww, -x0, -x1, -x2, -y0, -y1, -y2, false, n)
}

@ @<|finOffsetPrep|을 위해 |rising|...@>=
splitForOffset(r, t)
x1a = tOfTheWay(x1, x2, t)
x1 = tOfTheWay(x0, x1, t)
x0a = tOfTheWay(x1, x1a, t)
y1a = tOfTheWay(y1, y2, t)
y1 = tOfTheWay(y0, y1, t)
y0a = tOfTheWay(y1, y1a, t)
finOffsetPrep(link(r), k, w, x0a, x1a, x2, y0a, y1a, y2, true, n)
x2 = x0a
y2 = y0a

@ @<무한 기울기라는 특별한...@>=
finOffsetPrep(p, n, knil(knil(lh)), -x0, -x1, -x2, -y0, -y1, -y2, false, n)

@ 좋다, 이제 대물을 다룰 때다. 루틴 |fillEnvelope|는 |fillSpec|을 다각형 포락선으로 일반화한다. 그 바깥
짜임새는 본질적으로 전과 같다. 다만 삼차식이 없는 팔분면도 포락선에 이바지한다는 점이 다르다.

원본은 짝수 번째 팔분면의 경우를 |dual_moves|라는 프로시저로 따로 떼었다. 어떤 \PASCAL\ 컴파일러는
|fillEnvelope|만큼 큰 프로시저를 다루지 못하기 때문이었다. \GO/에는 그런 제약이 없으므로 여기서는 그 코드를
이름 있는 절로 두어 |fillEnvelope| 안에 끼워 넣는다.

@<함수들@>=
func fillEnvelope(specHead pointer) {
	var p, q, r, s pointer // 목록을 따라가는 데 쓴다
	var h pointer // 현재 팔분면의 펜 오프셋 목록의 머리
	var www pointer // 잠시 관심 있는 펜 오프셋
	var m, n int32 // 현재 격자 위치
	var mm0, mm1 int32 // |m0|과 |m1|에 해당하는 비스듬한 값
	var k int32 // 현재 오프셋 번호
	var w, ww pointer // 현재 오프셋과 그 이웃을 가리키는 포인터들
	var smoothBot, smoothTop int32 // 매끄럽게 하기의 경계; |0 .. moveSize|
	var xx, yy, xp, yp, delx, dely, tx, ty scaled // 좌표 계산을 위한 레지스터들
	if internal[tracingEdges] > 0 {
		beginEdgeTracing()
	}
	p = specHead // |leftType(specHead)=endpoint|라고 가정한다
	for {
		octant = leftOctant(p)
		h = curPen + octant
		@<변수 |q|를 현재 팔분면의...@>
		@<포락선의 처음과 마지막 격자점 |(m0,n0)|과 |(m1,n1)|을 정한다@>
		offsetPrep(p, h) // 노드~|q|가 ``죽으면'' 이것이 그것을 망가뜨릴 수도 있다
		@<변수 |q|를 현재 팔분면의...@>
		@<현재 팔분면의 포락선 움직임을 만들어 화소 자료에 넣는다@>
		p = link(q)
		if p == specHead {
			break
		}
	}
	if internal[tracingEdges] > 0 {
		endEdgeTracing()
	}
	tossKnotList(specHead)
}

@ 짝수 번째 팔분면에서는 좌표를 홀수 번 뒤집었으므로 시계 방향과 시계 반대 방향이 바뀌었다. 이것은 포락선이
``쌍대'' 방식으로 만들어진다는 뜻이다. 당분간은 홀수 번째 팔분면에 집중하자. 이해하기가 더 쉽기 때문이다.
홀수 번째 팔분면의 프로그램을 짜고 나면 그것을 쌍대로 바꾸는 데 필요한 변경은 그리 수수께끼 같지 않을 것이다.

홀수 번째 팔분면에는 |axis| 넘어감(비스듬한 기울기가 0인 곳)으로 들어와서 |diagonal| 넘어감(비스듬한 기울기가
무한대인 곳)으로 떠난다고 가정하면 편리하다. 그러면 오프셋 점 $z(t)+w(t)$는 모두, 왼쪽 아래 모서리와 오른쪽 위
모서리가 처음과 마지막 오프셋 점인 직사각형 안에 있게 된다. 이 가정이 성립하지 않으면 곡선을 암묵적으로
바꾸어 성립하게 할 수 있다. 이를테면 들어오는 넘어감이 대각선이면 $z_0+w_{n+1}$에서 $z_0+w_0$으로 직선을 긋고
곡선이 오른쪽으로 움직이는 것처럼 계속하면 된다. 이것이 포락선에 주는 효과는 그냥 $w_0$에서 $w_1$로, \dots,
$w_{n+1}$로, 다시~$w_0$으로 가는 펜의 한 부분이 둘러싸는 영역을 ``두 번 칠하는'' 것일 뿐이다. 처음의 추가
직선(과 끝의 비슷한 직선, 끝에서는 $z_1+w_{n+1}$에서 $z_1+w_0$으로 가야 할 수도 있다)은 |lineEdges| 루틴으로
그릴 수 있다. 그 덕분에 이 직선들이 현재 팔분면 방향에서 거꾸로 간다는 난처함을 피한다.

곡선이 $z_0+w_0$에서 $z_1+w_{n+1}$로 간다는 가정을 세우고 나면, 팔분면 안에서 일어날 수 있는 다른 뒷걸음
움직임들은 본질적으로 무시할 수 있다. 포락선을 계산하려면 각 행에서 가장 오른쪽의 가장자리만 기억하면 된다.

포락선 움직임은 옮긴 삼차식과 직선 조각이 섞인 것이다. 우리는 그것을 따로 |envMove| 배열에 기록한다. 이것은
|move|와 비슷하지만 각 행에서 포락선의 가장 오른쪽 위치를 기억한다.

@<전역 변수@>=
var @!envMove [moveSize + 1]int32

@ @<포락선의 처음과 마지막 격자점...@>=
w = link(h)
if leftTransition(p) == diagonal {
	w = knil(w)
}
if stat {
	if internal[tracingEdges] > unity {
		@<이 팔분면을 소개하는 진단 정보를 한 줄 찍는다@>
	}
}
ww = link(h)
www = ww // 처음과 마지막 오프셋
if odd(octantNumber[octant]) {
	www = knil(www)
} else {
	ww = knil(ww)
}
if w != ww {
	skewLineEdges(p, w, ww)
}
endRound(xCoord(p)+xCoord(ww), yCoord(p)+yCoord(ww))
m0 = m1
n0 = n1
d0 = d1
endRound(xCoord(q)+xCoord(www), yCoord(q)+yCoord(www))
if n1-n0 >= moveSize {
	overflow("move table size", moveSize)
}
@:METAFONT capacity exceeded move table size}{\quad move table size@>

@ @<이 팔분면을 소개하는...@>=
printNl("@@ Octant ")
printStr(octantDir[octant])
@:]]]\AT!_Octant}{\.{\AT! Octant...}@>
printStr(" (")
printInt(info(h))
printStr(" offset")
if info(h) != 1 {
	printChar('s')
}
printStr("), from ")
printTwoTrue(xCoord(p)+xCoord(w), yCoord(p)+yCoord(w), octant)
ww = link(h)
if rightTransition(q) == diagonal {
	ww = knil(ww)
}
printStr(" to ")
printTwoTrue(xCoord(q)+xCoord(ww), yCoord(q)+yCoord(ww), octant)

@ 표준이 아닌 들어감과 나감 조건에서 뒷걸음 직선을 그려야 할 때는 |lineEdges| 프로시저를 조금 바꾼 것이
쓸모 있다.

@<함수들@>=
func skewLineEdges(p, w, ww pointer) {
	var x0, y0, x1, y1 scaled // 출발점과 도착점
	if xCoord(w) != xCoord(ww) || yCoord(w) != yCoord(ww) {
		x0 = xCoord(p) + xCoord(w)
		y0 = yCoord(p) + yCoord(w)
		x1 = xCoord(p) + xCoord(ww)
		y1 = yCoord(p) + yCoord(ww)
		unskew(x0, y0, octant) // 좌표를 비스듬하지 않게 하고 돌리지 않는다
		x0 = curX
		y0 = curY
		unskew(x1, y1, octant)
		if stat {
			if internal[tracingEdges] > unity {
				printNl("@@ retrograde line from ")
@:]]]\AT!_retro_}{\.{\AT! retrograde line...}@>
@.retrograde line...@>
				printTwo(x0, y0)
				printStr(" to ")
				printTwo(curX, curY)
				printNl("")
			}
		}
		lineEdges(x0, y0, curX, curY) // 그다음 직선을 긋는다
	}
}

@ 포락선 계산에는 더 간단한 |fillSpec|의 경우보다 지역 변수가 더 많이 필요하다. 계산의 중요한 지점에서 |w|는
오프셋 $w_k$를 가리키고, |m|과 |n|은 현재 격자 위치를 기록한다. 처음의 오프셋 조정 뒤와 마지막 오프셋 조정
앞의 |movePtr| 값은 각각 |smoothBot|과 |smoothTop|에 저장한다. 이 변수들은 |fillEnvelope|의 머리에 선언했다.

@<현재 팔분면의 포락선 움직임을...@>=
if odd(octantNumber[octant]) {
	@<보통의 포락선 움직임을 위해 초기화한다@>
	r = p
	setRightType(q, info(h)+1)
	for {
		if r == q {
			smoothTop = movePtr
		}
		for rightType(r) != k {
			@<알맞은 오프셋에 다가가는 직선 조각을 끼워 넣는다@>
		}
		if r == p {
			smoothBot = movePtr
		}
		if r == q {
			break
		}
		move[movePtr] = 1
		n = movePtr
		s = link(r)
		makeMoves(xCoord(r)+xCoord(w), rightX(r)+xCoord(w),
			leftX(s)+xCoord(w), xCoord(s)+xCoord(w),
			yCoord(r)+yCoord(w)+halfUnit, rightY(r)+yCoord(w)+halfUnit,
			leftY(s)+yCoord(w)+halfUnit, yCoord(s)+yCoord(w)+halfUnit,
			xyCorr[octant], yCorr[octant])
		@<|move| 배열의 움직임을 |envMove|로 옮긴다@>
		r = s
	}
	@<새 포락선 움직임을 화소 자료에 넣는다@>
} else {
	@<쌍대 방식으로 포락선 움직임을 만들어 화소 자료에 넣는다@>
}
setRightType(q, endpoint)

@ @<보통의 포락선 움직임을...@>=
k = 0
w = link(h)
ww = knil(w)
mm0 = floorUnscaled(xCoord(p) + xCoord(w) - xyCorr[octant])
mm1 = floorUnscaled(xCoord(q) + xCoord(ww) - xyCorr[octant])
for n = 0; n <= n1-n0-1; n++ {
	envMove[n] = mm0
}
envMove[n1-n0] = mm1
movePtr = 0
m = mm0

@ 이 지점에서 |n|에는 |makeMoves|가 움직임을 기록하기 시작할 때의 |movePtr| 값이 들어 있다.

@<|move| 배열의 움직임을 |envMove|로...@>=
for {
	m = m + move[n] - 1
	if m > envMove[n] {
		envMove[n] = m
	}
	n++
	if n > movePtr {
		break
	}
}

@ 뒷걸음 직선(|k|가 줄어들 때)은 그 가장자리가 어느 행에서도 가장 오른쪽이 아니므로 |envMove|에 기록할 필요가
없다.

@<알맞은 오프셋에 다가가는...@>=
xx = xCoord(r) + xCoord(w)
yy = yCoord(r) + yCoord(w) + halfUnit
if stat {
	if internal[tracingEdges] > unity {
		printNl("@@ transition line ")
		printInt(k)
		printStr(", from ")
@:]]]\AT!_trans_}{\.{\AT! transition line...}@>
@.transition line...@>
		printTwoTrue(xx, yy-halfUnit, octant)
	}
}
if rightType(r) > k {
	k++
	w = link(w)
	xp = xCoord(r) + xCoord(w)
	yp = yCoord(r) + yCoord(w) + halfUnit
	if yp != yy {
		@<|(xx,yy)|에서 |(xp,yp)|로 가는 직선 조각을 |envMove|에 기록한다@>
	}
} else {
	k--
	w = knil(w)
	xp = xCoord(r) + xCoord(w)
	yp = yCoord(r) + yCoord(w) + halfUnit
}
if stat {
	if internal[tracingEdges] > unity {
		printStr(" to ")
		printTwoTrue(xp, yp-halfUnit, octant)
		printNl("")
	}
}
m = floorUnscaled(xp - xyCorr[octant])
movePtr = floorUnscaled(yp-yCorr[octant]) - n0
if m > envMove[movePtr] {
	envMove[movePtr] = m
}

@ 이 단계에서는 |xp>=xx|이고 |yp>=yy|다.

@<|(xx,yy)|에서 |(xp,yp)|로 가는 직선 조각을 |envMove|에...@>=
ty = floorScaled(yy - yCorr[octant])
dely = yp - yy
yy = yy - ty
ty = yp - yCorr[octant] - ty
if ty >= unity {
	delx = xp - xx
	yy = unity - yy
	for {
		tx = takeFraction(delx, makeFraction(yy, dely))
		if abVsCd(tx, dely, delx, yy)+xyCorr[octant] > 0 {
			tx--
		}
		m = floorUnscaled(xx + tx)
		if m > envMove[movePtr] {
			envMove[movePtr] = m
		}
		ty = ty - unity
		if ty < unity {
			break
		}
		yy = yy + unity
		movePtr++
	}
}

@ @<새 포락선 움직임을 화소...@>=
if debug {
	if m != mm1 || movePtr != n1-n0 {
		confusion("1")
	}
}
@:this can't happen /}{\quad 1@>
move[0] = d0 + envMove[0] - mm0
for n = 1; n <= movePtr; n++ {
	move[n] = envMove[n] - envMove[n-1] + 1
}
move[movePtr] = move[movePtr] - d1
if internal[smoothing] > 0 {
	smoothMoves(smoothBot, smoothTop)
}
moveToEdges(m0, n0, m1, n1)
if rightTransition(q) == axis {
	w = link(h)
	skewLineEdges(q, knil(w), w)
}

@ 홀수 팔분면의 경우는 다 했다. 남은 일은 같은 생각을 뒤집어서, 또는 거꾸로 되풀이하는 것뿐이다.

쌍대인 경우에는 |diagonal| 넘어감으로 들어와서 |axis|로 떠나는 것이 보통의 상황이다. 각 행에서 가장 오른쪽
가장자리 대신 가장 왼쪽 가장자리가 관계있다.

@<쌍대 방식으로 포락선 움직임을...@>=
@<쌍대 포락선 움직임을 위해 초기화한다@>
r = p // 이제 |rightType(q)=endpoint=0|임을 떠올리자
for {
	if r == q {
		smoothTop = movePtr
	}
	for rightType(r) != k {
		@<알맞은 오프셋에 쌍대 방식으로 다가가는 직선 조각을 끼워 넣는다@>
	}
	if r == p {
		smoothBot = movePtr
	}
	if r == q {
		break
	}
	move[movePtr] = 1
	n = movePtr
	s = link(r)
	makeMoves(xCoord(r)+xCoord(w), rightX(r)+xCoord(w),
		leftX(s)+xCoord(w), xCoord(s)+xCoord(w),
		yCoord(r)+yCoord(w)+halfUnit, rightY(r)+yCoord(w)+halfUnit,
		leftY(s)+yCoord(w)+halfUnit, yCoord(s)+yCoord(w)+halfUnit,
		xyCorr[octant], yCorr[octant])
	@<|move| 배열의 움직임을 쌍대 방식으로 |envMove|로 옮긴다@>
	r = s
}
@<새 포락선 움직임을 쌍대 방식으로 화소 자료에 넣는다@>

@ @<쌍대 포락선 움직임을...@>=
k = info(h) + 1
ww = link(h)
w = knil(ww)
mm0 = floorUnscaled(xCoord(p) + xCoord(w) - xyCorr[octant])
mm1 = floorUnscaled(xCoord(q) + xCoord(ww) - xyCorr[octant])
for n = 1; n <= n1-n0+1; n++ {
	envMove[n] = mm1
}
envMove[0] = mm0
movePtr = 0
m = mm0

@ @<|move| 배열의 움직임을 쌍대 방식으로...@>=
for {
	if m < envMove[n] {
		envMove[n] = m
	}
	m = m + move[n] - 1
	n++
	if n > movePtr {
		break
	}
}

@ 쌍대 뒷걸음 직선은 |k|가 늘어날 때 일어난다. 그런 직선의 가장자리는 어느 행에서도 가장 왼쪽이 아니다.

@<알맞은 오프셋에 쌍대 방식으로...@>=
xx = xCoord(r) + xCoord(w)
yy = yCoord(r) + yCoord(w) + halfUnit
if stat {
	if internal[tracingEdges] > unity {
		printNl("@@ transition line ")
		printInt(k)
		printStr(", from ")
@:]]]\AT!_trans_}{\.{\AT! transition line...}@>
@.transition line...@>
		printTwoTrue(xx, yy-halfUnit, octant)
	}
}
if rightType(r) < k {
	k--
	w = knil(w)
	xp = xCoord(r) + xCoord(w)
	yp = yCoord(r) + yCoord(w) + halfUnit
	if yp != yy {
		@<|(xx,yy)|에서 |(xp,yp)|로 가는 직선 조각을 쌍대 방식으로 |envMove|에 기록한다@>
	}
} else {
	k++
	w = link(w)
	xp = xCoord(r) + xCoord(w)
	yp = yCoord(r) + yCoord(w) + halfUnit
}
if stat {
	if internal[tracingEdges] > unity {
		printStr(" to ")
		printTwoTrue(xp, yp-halfUnit, octant)
		printNl("")
	}
}
m = floorUnscaled(xp - xyCorr[octant])
movePtr = floorUnscaled(yp-yCorr[octant]) - n0
if m < envMove[movePtr] {
	envMove[movePtr] = m
}

@ 다시 |xp>=xx|이고 |yp>=yy|다. 그러나 이번에는 주어진 |movePtr| 위치에 속하는 가장 큰~|m| 대신 {\sl 가장
작은\/} |m|에 관심이 있다.

@<|(xx,yy)|에서 |(xp,yp)|로 가는 직선 조각을 쌍대...@>=
ty = floorScaled(yy - yCorr[octant])
dely = yp - yy
yy = yy - ty
ty = yp - yCorr[octant] - ty
if ty >= unity {
	delx = xp - xx
	yy = unity - yy
	for {
		if m < envMove[movePtr] {
			envMove[movePtr] = m
		}
		tx = takeFraction(delx, makeFraction(yy, dely))
		if abVsCd(tx, dely, delx, yy)+xyCorr[octant] > 0 {
			tx--
		}
		m = floorUnscaled(xx + tx)
		ty = ty - unity
		movePtr++
		if ty < unity {
			break
		}
		yy = yy + unity
	}
	if m < envMove[movePtr] {
		envMove[movePtr] = m
	}
}

@ 배열 |envMove|에는 최댓값 대신 최솟값이 들어 있으므로, 쌍대인 경우에는 마무리 과정이 조금 다르다.

@<새 포락선 움직임을 쌍대 방식으로...@>=
if debug {
	if m != mm1 || movePtr != n1-n0 {
		confusion("2")
	}
}
@:this can't happen /}{\quad 2@>
move[0] = d0 + envMove[1] - mm0
for n = 1; n <= movePtr; n++ {
	move[n] = envMove[n+1] - envMove[n] + 1
}
move[movePtr] = move[movePtr] - d1
if internal[smoothing] > 0 {
	smoothMoves(smoothBot, smoothTop)
}
moveToEdges(m0, n0, m1, n1)
if rightTransition(q) == diagonal {
	w = link(h)
	skewLineEdges(q, w, knil(w))
}

@* 타원 펜.
순환 경로의 타원에 대한 포락선을 얻으려고, \MF는 타원을 근사하는 다각형에 대한 포락선을 계산한다. 이때 존
하비(스탠퍼드 대학교 박사 학위 논문, 1985)의 접근법을 쓴다. 이것은 ``정확한'' 포락선을 얻으려 애쓰는 것보다
@^Hobby, John Douglas@>
중요한 장점이 둘 있다.

\yskip\textindent{1)}결과가 더 좋다. 이 다각형은 화소화에서 생기는 문제를 상쇄하도록 설계되었기 때문이다.
다각형에는 정확한 타원에 대한 화소 아래 크기의 보정이 들어 있어서, 결과가 경로가 래스터의 어디에 떨어지든
본질적으로 같아진다. 이를테면 지름이~1인 펜에 대한 정확한 포락선은 경로가 그 화소에 내접하는 지름~1인 원과
만날 때, 그리고 오직 그때에만 화소를 검게 칠한다. 그 결과로 나오는 무늬에는 경로가 운 나쁜 래스터 위치에서
대각선으로 갈 때 ``얼룩''이 생긴다. 경로가 내접하는 지름~1인 {\sl 마름모\/}와 만날 때에만 화소를 검게 칠하면
훨씬 좋은 결과를 얻는다. 그런 마름모가 바로 지름이~1인 원이라는 특별한 경우에 \MF가 쓰는 다각형이다.
$$\mplibcode
beginfig(19);
save u; numeric u; u := 50pt;
for k = 0, 1.4:
  draw ((0,0)--(1,0)--(1,1)--(0,1)--cycle) scaled u shifted (k*u,0);
endfor
draw fullcircle scaled u shifted (.5u,.5u) withpen pencircle scaled .8pt;
draw ((.5,0)--(1,.5)--(.5,1)--(0,.5)--cycle) scaled u shifted (1.4u,0) withpen pencircle scaled .8pt;
draw ((-.25,.72)--(.62,1.35)) scaled u dashed evenly;
draw ((-.25,.72)--(.62,1.35)) scaled u shifted (1.4u,0) dashed evenly;
label.bot(btex 원 etex, (.5u,-2pt)); label.bot(btex 마름모 etex, (1.9u,-2pt));
endfig;
\endmplibcode$$
위 그림에서 점선 경로는 화소의 모서리를 아슬아슬하게 스쳐 지나간다. 원이면 이 화소가 칠해지지만 마름모면
칠해지지 않는다. 대각선 경로가 래스터의 어디를 지나느냐에 따라 이런 화소가 생겼다 말았다 하면 선에 얼룩이
진다. 마름모는 대각선 방향에서 원보다 조금 가늘어서 그런 얼룩을 없앤다.

\yskip\textindent{2)}삼차 스플라인의 다각형 포락선은 삼차 스플라인이므로 완전히 다른 루틴을 들여올 필요가 없다.
그와 달리 원에 대한 삼차 스플라인의 정확한 포락선은 복잡한 곡선으로서 삼차식보다 그리기가 더 어렵다.

@ 하비의 구성에는 재미있는 정수론이 들어 있다. 두 정수 $u$와~$v$가 서로소이면, 정수 점 $(m,n)$이 동치류
$um+vn$에 속한다고 말해서 정수 점들의 집합을 동치류로 나눈다. 그러면 기울기가 $-u/v$인 직선 위에 있는 두
정수 점은 같은 동치류에 속한다. 그런 점들은 $(m+tv,n-tu)$ 꼴이기 때문이다. 정수 점을 지나는 기울기 $-u/v$의
이웃한 직선들은 서로 거리 $1/\psqrt{u^2+v^2}$만큼 떨어져 있고, 이 직선들은 기울기~$v/u$인 직선과 수직이다.
원점에서 출발해서 방향 $(u,v)$로 거리 $k/\psqrt{u^2+v^2}$를 가면 그 점들이 동치류~$k$에 속하는 기울기~$-u/v$의
직선에 이른다.

이를테면 $u=2$이고 $v=3$이라고 하자. 그러면 점 $(0,0)$, $(3,-2)$, $\ldots$은 동치류~0에 속하고, 점 $(-1,1)$,
$(2,-1)$, $\ldots$은 동치류~1에 속하며, 두 직선 사이의 거리는 $1/\sqrt{13}$이다. 점 $(2,3)$ 자신은 동치류~13에
속하므로 원점에서 그 점까지의 거리는 $13/\sqrt{13}=\sqrt{13}$이다(이것은 이미 알고 있었다). 아래 그림의 각
격자점 옆의 수가 그 점의 동치류이고, 점선은 동치류 0, 1, 2의 직선이다.
$$\mplibcode
beginfig(20);
save u; numeric u; u := 20pt;
for m = -3 upto 4: for n = -2 upto 3:
  dot((m,n) scaled u);
  label.urt(textext("\sevenrm " & decimal(2m+3n)), (m,n) scaled u);
endfor endfor
for k = 0, 1, 2:
  draw ((-3.4, (k + 6.8)/3)--(4.4, (k - 8.8)/3)) scaled u dashed evenly withpen pencircle scaled .4pt;
endfor
drawarrow (0,0)--(2u,3u) withpen pencircle scaled .7pt;
endfig;
\endmplibcode$$

정수 꼭짓점을 가진 다각형에 대한 포락선을 그리고 싶다고 하자. 그러면 방향 $(v,-u)$로 가는 곡선에 가장 좋은
다각형은, $k/\psqrt{u^2+v^2}$가 $d$에 될 수 있는 대로 가까운 동치류~$k$의 점들을 담을 것이다. 여기서 $d$는
주어진 타원이 직선 $ux+vy=0$에서 떨어진 최대 거리다.

매개변수 |fillin|의 보정은 대각선이 정말로 정사각형인 화소에서 얻을 것보다
$$2f\cdot\min(\vert u\vert,\vert v\vert)/\psqrt{u^2+v^2}$$
만큼 더 두꺼워 보인다고 가정한다. (바깥 모서리의 흰 화소가 겉보기 진하기 $f_1$을 갖고 안쪽 모서리의 검은
화소가 겉보기 진하기 $1-f_2$를 갖는다고 가정하면, $f=f_1-f_2$가 |fillin| 매개변수다.) 이 가정 아래에서 우리는
$\bigl(k+2f\cdot\min(\vert u\vert,\vert v\vert)\bigr)\big/\psqrt{u^2+v^2}$가 $d$에 될 수 있는 대로 가깝도록 $k$를
고르고 싶다.

꼭짓점에 정수 좌표를 쓰면 일이 잘 풀린다. 주어진 기울기에서 포락선의 두께가 래스터에 대한 경로의 위치와
상관없기 때문이다. 실은 타원이 원점에 대해 대칭이므로, 꼭짓점의 좌표가 $1\over2$의 정수배인 다각형에서도 같은
성질이 성립한다는 것이 밝혀진다. 모든 치수를 두 배 하고 결과 다각형의 꼭짓점이 정수 좌표를 갖도록 요구하면
편리하다. 이를테면 {\sl 지름\/}이~$r$인 원을 얻으려면 {\sl 반지름\/}이~$r$인 원의 정수 좌표를 계산한다. 반지름이~$r$인
원은 경계 점 $(0,\pm r)$과~$(\pm r,0)$을 담은 다각형으로 나타내고 싶을 것이다. 나중에 모든 것을 2로 나누면
$(0,\pm{1\over2}r)$와 $(\pm{1\over2}r,0)$을 경계에 가진 다각형을 얻는다.

@ 실제로 중요한 기울기는 $u$와~$v$의 값이 작은 것들이다. 이것들은 규칙적인 무늬를 만들어서 우리 눈이
불규칙함을 금세 알아차린다. 이를테면 가로선과 세로선($u=0$이고 $\vert v\vert=1$이거나, $\vert u\vert=1$이고
$v=0$일 때)이 가장 중요하고, 대각선($\vert u\vert=\vert v\vert=1$일 때)이 그다음이며, 그다음은 기울기가 $\pm2$나
$\pm1/2$인 선들이다.

분자와 분모가 작은 유리 방향을 모두 만들어 내는 가장 멋진 방법은 스턴--브로코 나무[{\sl Concrete Mathematics},
4.5절 참조]를 다음과 같은 ``스턴--브로코 화환''으로 일반화하는 것이다. 각각 방향 $(u,v)=(1,0)$, $(0,1)$,
@^Brocot, Achille@>
@^Stern, Moritz Abraham@>
$(-1,0)$,~$(0,-1)$을 담은 노드 넷을 원으로 늘어놓고 시작한다. 그다음 화환의 잇단 항 $(u,v)$와 $(u',v')$의 쌍
사이마다 방향 $(u+u',v+v')$을 끼워 넣는다. 어떤 멈춤 기준이 만족될 때까지 이것을 계속한다.

멈춤 기준이 무엇이든, 이 화환의 잇단 방향 $(u,v)$와 $(u',v')$은 언제나 관계 $uv'-u'v=1$을 만족한다는 것을
확인하기는 어렵지 않다. 그런 방향의 쌍은 앞에서 말한 동치류에 대해 멋진 성질을 가진다. 이제 $l$을 $(u,v)$에 대한
동치인 정수 점 $(m+tv,n-tu)$의 직선이라고 하고, $l'$을 $(u',v')$에 대한 동치인 정수 점 $(m'+tv',n'-tu')$의
직선이라고 하자. 그러면 $l$과~$l'$은 정수 점 $(m'',n'')$에서 만난다. 교점에 대한 일차 방정식의 행렬식이
$uv'-u'v=1$이기 때문이다. 또 $(u+u',v+v')$에 대한 $(m'',n'')$의 동치류 번호는 $(u,v)$와~$(u',v')$에 대한 동치류
번호의 합이라는 데 주목하라. 게다가 $l$과~$l'$ 위의 잇단 점들은 $(u+u',v+v')$에 대해 동치류가 꼭~1만큼 다르다.

이로부터 될 수 있는 대로 많은 작은 정수 방향 $(u,v)$에 대해 ``올바른'' 동치류 번호를 가진 다각형을 만드는
멋진 알고리즘이 나온다. 직선 $l$과~$l'$이 각각 $(u,v)$와~$(u',v')$에 대해 올바른 동치류의 점들을 담는다고
가정하고, 교점 $(m'',n'')$을 정해서 $(u+u',v+v')$에 대한 그 동치류를 계산한다. 그 동치류가 가장 좋은 근사가
되기에는 너무 크면, $(m'',n'')$에서 $l$과~$l'$ 둘 다를 따라 더 작은 동치류 번호 쪽으로 알맞은 걸음 수만큼
물러선다. 다만 그렇게 하려면 더는 다각형에 있지 않은 점들로 옮겨 가야 한다면 물러서지 않는다. 이렇게 해서
알맞은 동치류를 가진 직선~$l''$을 정하는 두 점에 이른다. 이 과정은 $(u,v)$의 동치류나 $(u',v')$의 동치류에서
마지막 남은 점을 없애지 않고는 나아갈 수 없을 때까지 재귀적으로 계속된다.

@ 서브루틴 |makeEllipse|는 꼭짓점들이 포락선에 알맞은 다각형을 정의하는 순환 경로를 가리키는 포인터를 만든다.
이 경로의 조절점은 무시된다. 실은 매듭 노드에서 대개 조절점을 위해 남겨 두는 필드들에, |makeEllipse|가 원하는
다각형을 계산하는 데 도움이 되는 다른 자료가 들어 있다.

매개변수 |majorAxis|와 |minorAxis|는 타원의 축을 정의하고, 매개변수 |theta|는 타원을 시계 반대 방향으로 돌리는
각이다. 각이 |theta=0|이면 타원의 방정식은 $(x/a)^2+(y/b)^2=1$이다. 여기서 |a=majorAxis/2|이고 |b=minorAxis/2|다.
일반적으로 타원의 점들은 $t$가 모든 각을 지나는 동안 복소 평면에서 공식 $e^{i\theta}(a\cos t+ib\sin t)$로
만들어진다. 특히 |majorAxis=minorAxis=d|이면 |theta|의 값과 상관없이 지름이~|d|인 원을 얻는다는 데 주목하라.

앞에서 대강 말한 방법으로 타원 다각형을 만든다. 다만 주된 일은 세 출발 방향 $(0,-1)$, $(1,0)$,~$(0,1)$로부터
얻는 반평면에서만 한다. 타원은 원점 대칭이므로 다각형의 뒤쪽 절반은 그냥 앞쪽 절반의 부호를 바꾼 것이라는
사실을 쓴다. 게다가 타원이 축 대칭이면 다각형의 4분의 1만 계산하면 된다.

@<함수들@>=
func makeEllipse(majorAxis, minorAxis scaled, theta angle) pointer {
	var p, q, r, s pointer // 목록 조작을 위해
	var h pointer // 만든 매듭 목록의 머리
	var alpha, beta, gamma, delta int32 // 특별한 점들
	var c, d int32 // 동치류 번호들
	var u, v int32 // 방향들
	var symmetric bool // 결과가 축에 대해 대칭이어야 하나?
	@<방향 $(0,-1)$, $(1,0)$, $(0,1)$로 시작해서 타원 자료 구조를 초기화한다@>
	@<더 나아질 수 없을 때까지 타원 자료 구조에 새 꼭짓점을 보간해 넣는다@>
	if symmetric {
		@<이미 계산한 4분의 1을 뒤집어서 반 타원을 마친다@>
	}
	@<이미 계산한 반의 부호를 바꾼 것을 베껴서 타원을 마친다@>
	return h
}

@ 서브루틴 |makeEllipse|에서만 쓰는 특별한 자료 구조가 있다. 매듭 노드의 |rightX|, |leftX|, |rightY|, |leftY| 필드는
필요한 계산을 간단하게 하는 정보를 저장하려고 |rightU|, |leftV|, |rightClass|, |leftLength|로 이름을 바꾼다.

두 노드 |p|와 |q|가 이 자료 구조에서 잇단 매듭이면, |p|와~|q|의 |xCoord|와 |yCoord| 필드에는 다각형의 현재 꼭짓점이
들어 있다. 그 값은 |halfUnit|의 정수배다. 이 두 꼭짓점은 모두 방향 $\bigl($|rightU(p),leftV(q)|$\bigr)$에 대해
동치류 |rightClass(p)|에 속한다. 꼭짓점~|p|에서 꼭짓점~|q|로 가는 직선 위에 있는 이 동치류의 점의 수는
|1+leftLength(q)|다. 특히 |leftLength(q)=0|은 |xCoord(p)=xCoord(q)|이고 |yCoord(p)=yCoord(q)|라는 뜻이다. 그런
겹친 꼭짓점은 알고리즘이 진행하는 동안 버려진다.

필드 |rightU(p)|와 |leftV(q)|의 내용은 좌표 필드와 마찬가지로 |halfUnit|의 정수배다. 그러므로 이를테면 점
$\bigl($|xCoord(p)-leftV(q),yCoord(p)+rightU(p)|$\bigr)$도 동치류 번호 |rightClass(p)|에 속한다. 이 점은
노드~|q|의 꼭짓점에 한 걸음 더 가깝다. 그리고 |leftLength(q)=1|일 때, 그리고 오직 그때에만 그 꼭짓점과 같다.

필드 |leftType|과 |rightType|은 쓰지 않지만, |link|는 보통의 뜻을 가진다.

과정을 시작하려고 세 방향 $(0,-1)$, $(1,0)$, $(0,1)$을 위한 노드 넷을 만든다. 해당하는 꼭짓점은
$(-\alpha,-\beta)$, $(\gamma,-\beta)$, $(\gamma,\beta)$, $(\alpha,\beta)$다. 여기서 $(\alpha,\beta)$는 타원이
$x$축 위로 가장 높이 올라가는 곳의 반정수 근사이고, $\gamma$는 타원의 최대 $x$~좌표의 반정수 근사다. 타원이
축 대칭이면 이 노드 가운데 넷째는 실제로 계산하지 않는다.

@<정의@>=
func rightU(p pointer) int32           { return rightX(p) } // 펜 변의 |u| 값
func setRightU(p pointer, v int32)     { setRightX(p, v) }
func leftV(p pointer) int32            { return leftX(p) } // 펜 변의 |v| 값
func setLeftV(p pointer, v int32)      { setLeftX(p, v) }
func rightClass(p pointer) int32       { return rightY(p) } // 펜 변의 동치류 번호
func setRightClass(p pointer, v int32) { setRightY(p, v) }
func leftLength(p pointer) int32       { return leftY(p) } // 펜 변의 길이
func setLeftLength(p pointer, v int32) { setLeftY(p, v) }

@ @<방향 $(0,-1)$, $(1,0)$, $(0,1)$로 시작해서...@>=
@<꼭짓점 좌표를 위한 정수 $\alpha$, $\beta$, $\gamma$를 계산한다@>
p = getNode(knotNodeSize)
q = getNode(knotNodeSize)
r = getNode(knotNodeSize)
if symmetric {
	s = null
} else {
	s = getNode(knotNodeSize)
}
h = p
setLink(p, q)
setLink(q, r)
setLink(r, s) // |s=null|이거나 |link(s)=null|이다
@<길이가 0인 퇴화한 직선이 생기지 않도록 필요하면 $\alpha$, $\beta$, $\gamma$의 값을 고친다@>
setXCoord(p, -alpha*halfUnit)
setYCoord(p, -beta*halfUnit)
setXCoord(q, gamma*halfUnit)
setYCoord(q, yCoord(p))
setXCoord(r, xCoord(q))
setRightU(p, 0)
setLeftV(q, -halfUnit)
setRightU(q, halfUnit)
setLeftV(r, 0)
setRightU(r, 0)
setRightClass(p, beta)
setRightClass(q, gamma)
setRightClass(r, beta)
setLeftLength(q, gamma+alpha)
if symmetric {
	setYCoord(r, 0)
	setLeftLength(r, beta)
} else {
	setYCoord(r, -yCoord(p))
	setLeftLength(r, beta+beta)
	setXCoord(s, -xCoord(p))
	setYCoord(s, yCoord(r))
	setLeftV(s, halfUnit)
	setLeftLength(s, gamma-alpha)
}

@ 펜 자료 구조의 중요한 불변 관계 하나는 점들이 서로 다르다는 것이다. 이것을 지키려면 펜의 명세를 고쳐야 할
수도 있다. (\KW{pencircle}의 결과는 언제나 적어도 한 화소의 너비와 한 화소의 높이를 가진다. 다만 \KW{makepen}은
더 작은 펜을 만들 수 있다.)

@<길이가 0인 퇴화한 직선이...@>=
if beta == 0 {
	beta = 1
}
if gamma == 0 {
	gamma = 1
}
if gamma <= abs(alpha) {
	if alpha > 0 {
		alpha = gamma - 1
	} else {
		alpha = 1 - gamma
	}
}

@ 긴반지름과 짧은반지름이 $a$와 $b$이면, 주어진 타원은 점 $\bigl((a^2-b^2)\sin\theta\cos\theta/\rho\bigr)+i\rho$에서
$x$축 위로 가장 높이 올라간다. 여기서 $\rho=\sqrt{(a\sin\theta)^2+(b\cos\theta)^2}$이다. 그리고 점
$\sigma+i(a^2-b^2)\sin\theta\cos\theta/\sigma$에서 $y$축의 오른쪽으로 가장 멀리 나간다. 여기서
$\sigma=\sqrt{(a\cos\theta)^2+(b\sin\theta)^2}$이다.

@<꼭짓점 좌표를 위한 정수...@>=
if majorAxis == minorAxis || theta%ninetyDeg == 0 {
	symmetric = true
	alpha = 0
	if odd(theta / ninetyDeg) {
		beta = majorAxis
		gamma = minorAxis
		nSin = fractionOne
		nCos = 0 // |nSin|과 |nCos|는 나중에 쓰인다
	} else {
		beta = minorAxis
		gamma = majorAxis
		theta = 0
	} // 이 경우에는 |nSin|과 |nCos|가 필요 없다
} else {
	symmetric = false
	nSinCos(theta) // $|nSin|=\sin\theta$와 $|nCos|=\cos\theta$를 마련한다
	gamma = takeFraction(majorAxis, nSin)
	delta = takeFraction(minorAxis, nCos)
	beta = pythAdd(gamma, delta)
	alpha = takeFraction(takeFraction(majorAxis, makeFraction(gamma, beta)), nCos) -
		takeFraction(takeFraction(minorAxis, makeFraction(delta, beta)), nSin)
	alpha = (alpha + halfUnit) / unity
	gamma = pythAdd(takeFraction(majorAxis, nCos), takeFraction(minorAxis, nSin))
}
beta = (beta + halfUnit) / unity
gamma = (gamma + halfUnit) / unity

@ 이제 |p|, |q|, |r|이 목록을 따라 행진하는데, 언제나 잇단 꼭짓점 셋과 잇단 기울기 방향 둘을 나타낸다. 새 기울기를
보간하면 더 다듬는 것이 불가능해질 때까지 조금 물러서고, 그다음 다시 앞으로 행진한다. 알고리즘의 이 부분에서
하는 조금 마법 같은 연산들은 앞에서 대강 말한 이론으로 정당화된다. 복잡한 일은 길이가 0인 직선을 마지막
자료 구조에서 몰아내야 한다는 데서만 생긴다.

세 꼭짓점을 모두 처리하고 나면 안쪽 루프에서 바깥 루프까지 단번에 빠져나가야 하므로, 바깥 루프에 레이블
|interpolation|을 붙이고 |break interpolation|으로 빠져나간다.

@<더 나아질 수 없을 때까지...@>=
interpolation:
for {
	u = rightU(p) + rightU(q)
	v = leftV(q) + leftV(r)
	c = rightClass(p) + rightClass(q)
	@<방향 |(u,v)|로 타원 가장자리까지의 거리에 $\psqrt{u^2+v^2}$를 곱해 반올림한 |d|를 계산한다@>
	delta = c - d // 교점 꼭짓점~|q|에서 |delta|걸음 물러서고 싶다
	if delta > 0 {
		if delta > leftLength(r) {
			delta = leftLength(r)
		}
		if delta >= leftLength(q) {
			@<|p|에서 |q|로 가는 직선을 없애고, 새 직선을 들여오도록 꼭짓점~|q|를 고친다@>
		} else {
			@<|p|와~|q| 사이에 방향 |(u,v)|의 새 직선을 끼워 넣는다@>
		}
	} else {
		p = q
	}
	@<다음 세 꼭짓점 |(p,q,r)|로 옮기며 길이 0인 직선을 없앤다; 다 처리했으면 |break interpolation|@>
}

@ 길이가 0인 직선이 나타나면 |p|를 그 너머로 나아가게 해야 한다는 뜻이다. 빠진 방향을 가로질러서는 안 된다.
이 알고리즘은 잇단 방향의 쌍에서만 돌아가기 때문이다.

@<다음 세 꼭짓점 |(p,q,r)|로 옮기며 길이 0인 직선을 없앤다; 다 처리했으면 |break interpolation|@>=
for {
	q = link(p)
	if q == null {
		break interpolation
	}
	if leftLength(q) == 0 {
		setLink(p, link(q))
		setRightClass(p, rightClass(q))
		setRightU(p, rightU(q))
		freeNode(q, knotNodeSize)
	} else {
		r = link(q)
		if r == null {
			break interpolation
		}
		if leftLength(r) == 0 {
			setLink(p, r)
			freeNode(q, knotNodeSize)
			p = r
		} else {
			break
		}
	}
}

@ 이 단계의 끝 가까이에 있는 `|/8|'은 |delta|의 눈금이 $2^{15}$이고 $d$의~눈금이 $2^{16}$인데 |takeFraction|이
눈금 인수 $2^{28}$을 없애기 때문에 나온다. 또 $d\ge\max(\vert u\vert,\vert v\vert)$가 되도록 해서, 펜이 언제나
지름이~1인 원형 펜을 부분 집합으로 담게 한다. 그러면 연결이 끊어진 경로 포락선이 생길 수 없다.

@<방향 |(u,v)|로 타원 가장자리까지의 거리에 $\psqrt{u^2+v^2}$를 곱해 반올림한 |d|를 계산한다@>=
delta = pythAdd(u, v)
if majorAxis == minorAxis {
	d = majorAxis // 원은 쉽다
} else {
	if theta == 0 {
		alpha = u
		beta = v
	} else {
		alpha = takeFraction(u, nCos) + takeFraction(v, nSin)
		beta = takeFraction(v, nCos) - takeFraction(u, nSin)
	}
	alpha = makeFraction(alpha, delta)
	beta = makeFraction(beta, delta)
	d = pythAdd(takeFraction(majorAxis, alpha), takeFraction(minorAxis, beta))
}
alpha = abs(u)
beta = abs(v)
if alpha < beta {
	alpha = abs(v)
	beta = abs(u)
} // 이제 $\alpha=\max(\vert u\vert,\vert v\vert)$, $\beta=\min(\vert u\vert,\vert v\vert)$다
if internal[fillin] != 0 {
	d = d - takeFraction(internal[fillin], makeFraction(beta+beta, delta))
}
d = takeFraction((d+4)/8, delta)
alpha = alpha / halfUnit
if d < alpha {
	d = alpha
}

@ 이 지점에서 꼭짓점~|p|에서 꼭짓점~|q|로 가는, 길이가 |<=delta|이고 방향 $\bigl($|rightU(p),leftV(q)|$\bigr)$에
수직인 직선이 있다. 그리고 꼭짓점~|q|에서 꼭짓점~|r|로 가는, 길이가 |>=delta|이고 방향
$\bigl($|rightU(q),leftV(r)|$\bigr)$에 수직인 직선이 있다. 방향 $(u,v)$에 가장 좋은 직선이 |p|에서~|q|로 가는
직선을 대신해야 한다. 이 새 직선은 옛 직선과 길이가 같다.

@<|p|에서 |q|로 가는 직선을...@>=
delta = leftLength(q)
setRightClass(p, c-delta)
setRightU(p, u)
setLeftV(q, v)
setXCoord(q, xCoord(q)-delta*leftV(r))
setYCoord(q, yCoord(q)+delta*rightU(q))
setLeftLength(r, leftLength(r)-delta)

@ 예외를 다루었으니 이제 주된 경우다. 방향 |(u,v)|에 대해 길이 |delta|의 새 직선을 끼워 넣고, 이웃한 두 직선을
저마다 |delta|걸음씩 줄인다.

@<|p|와~|q| 사이에 방향...@>=
s = getNode(knotNodeSize)
setLink(p, s)
setLink(s, q)
setXCoord(s, xCoord(q)+delta*leftV(q))
setYCoord(s, yCoord(q)-delta*rightU(p))
setXCoord(q, xCoord(q)-delta*leftV(r))
setYCoord(q, yCoord(q)+delta*rightU(q))
setLeftV(s, leftV(q))
setRightU(s, u)
setLeftV(q, v)
setRightClass(s, c-delta)
setLeftLength(s, leftLength(q)-delta)
setLeftLength(q, delta)
setLeftLength(r, leftLength(r)-delta)

@ 좌표만 베끼면 되고 동치류 번호 같은 것은 베끼지 않아도 된다. 이 지점에서는 |link(p)|나 |link(link(p))|가
|null|이다.

@<이미 계산한 4분의 1을...@>=
s = null
q = h
for {
	r = getNode(knotNodeSize)
	setLink(r, s)
	s = r
	setXCoord(s, xCoord(q))
	setYCoord(s, -yCoord(q))
	if q == p {
		break
	}
	q = link(q)
	if yCoord(q) == 0 {
		break
	}
}
if link(p) != null {
	freeNode(link(p), knotNodeSize)
}
setLink(p, s)
beta = -yCoord(h)
for yCoord(p) != beta {
	p = link(p)
}
q = link(p)

@ 이제 조금 까다로운 사실을 쓴다. 마지막 방향 $(0,1)$의 직선이 없어졌을 때, 그리고 오직 그때에만 포인터 |q|가
널이다. 그 직선이 아직 살아 있으면 처음 방향 $(0,-1)$의 살아 있을지 모르는 직선과 합쳐야 한다.

@<이미 계산한 반의 부호를...@>=
if q != null {
	if rightU(h) == 0 {
		p = h
		h = link(h)
		freeNode(p, knotNodeSize)
		setXCoord(q, -xCoord(h))
	}
	p = q
} else {
	q = p
}
r = link(h) // 이제 |p=q|, |xCoord(p)=-xCoord(h)|, |yCoord(p)=-yCoord(h)|다
for {
	s = getNode(knotNodeSize)
	setLink(p, s)
	p = s
	setXCoord(p, -xCoord(r))
	setYCoord(p, -yCoord(r))
	r = link(r)
	if r == q {
		break
	}
}
setLink(p, h)

@* 방향 시각과 교차 시각.
길이가 $n$인 경로는 |0<=t<=n|에 대한 함수 $x(t)$와 $y(t)$로 매개변수로 정의된다. 우리는 $t$를 경로가 점
$\bigl(x(t),y(t)\bigr)$에 이르는 ``시각''으로 볼 수 있다. 프로그램의 이 부분에서는 주어진 경로에 딸린 특별한
시각을 정하는 연산들을 생각한다. 경로가 주어진 방향으로 처음 나아가는 시각, 그리고 두 경로가 서로 엇갈리는
시각의 쌍이다.

@ 더 쉬운 일부터 시작하자. 함수 |findDirectionTime|은 방향 |(x,y)|와 |h|에서~시작하는 경로를 받는다. 경로가
방향 |(x,y)|로 결코 나아가지 않으면 방향 시각은~|-1|이 되고, 그렇지 않으면 음이 아닌 값이 된다.

이상한 경우가 몇 가지 생길 수 있다. 방향이 |(x,y)=(0,0)|이어서 주어진 방향이 정의되지 않으면 방향 시각은 0이 된다.
도함수가 $\bigl(x'(t),y'(t)\bigr)=(0,0)$이어서 경로의 방향이 정의되지 않으면, 시각~|t|에서 경로가 주어진 어떤 방향과도
맞는다고 가정한다.

이 루틴은 퇴화하지 않은 경우에 경로와 주어진 방향을 |(x,y)=(1,0)|이 되도록 돌려서 이 문제를 푼다. 곧 주된
일은 주어진 경로가 언제 처음 ``정동쪽''으로 나아가는지 찾는 것이 된다.

@<함수들@>=
func findDirectionTime(x, y scaled, h pointer) scaled {
	var maxCoef scaled // $\max\bigl(\vert x\vert,\vert y\vert\bigr)$
	var p, q pointer // 목록을 따라가는 데 쓴다
	var n scaled // 매듭 |p|에서의 방향 시각
	var tt scaled // 삼차식 안에서의 방향 시각
	var x1, x2, x3, y1, y2, y3 scaled // 돌린 도함수의 배수들
	var theta, phi angle // 매듭에서 나가는 각과 들어오는 각
	var t fraction // 임시 저장소
	@<더 정확하도록 주어진 방향을 정규화한다; 그러나 0이면 결과 0으로 |return|한다@>
	n = 0
	p = h
	for {
		if rightType(p) == endpoint {
			goto notFound
		}
		q = link(p)
		@<|p|와 |q| 사이의 삼차식을 돌린다; 정동쪽으로 가면 |goto found|, 다 지났으면 |goto notFound|@>
		p = q
		n = n + unity
	}
notFound:
	return -unity
found:
	return n + tt
}

@ @<더 정확하도록 주어진...@>=
if abs(x) < abs(y) {
	x = makeFraction(x, abs(y))
	if y > 0 {
		y = fractionOne
	} else {
		y = -fractionOne
	}
} else if x == 0 {
	return 0
} else {
	y = makeFraction(y, abs(x))
	if x > 0 {
		x = fractionOne
	} else {
		x = -fractionOne
	}
}

@ 우리는 접선 방향에 관심이 있으므로 $B(x_0,x_1,x_2,x_3;t)$ 자체 대신 도함수
$${1\over3}B'(x_0,x_1,x_2,x_3;t)=B(x_1-x_0,x_2-x_1,x_3-x_2;t)$$
로 일한다. 더 정확하게 하려고 이끌어 낸 계수들도 키운다.

주어진 경로는 매듭에서 갑자기 꺾일 수 있고, 그때 중요한 접선 방향을 지나갈 수도 있다. 그래서 앞의 돌린
삼차식이 나아가던 방향 |phi|를 기억해 둔다. (각 |phi|의 값은 첫 삼차식에서, 곧 |n=0|일 때는 정해지지 않는다.)

@<|p|와 |q| 사이의 삼차식을 돌린다...@>=
tt = 0
@<지역 변수 |x1,x2,x3|과 |y1,y2,y3|을 돌린 도함수의 조절점들의 배수로 놓는다@>
if y1 == 0 {
	if x1 >= 0 {
		goto found
	}
}
if n > 0 {
	@<매듭 |p|에서 동쪽 방향이 일어나면 |found|로 간다@>
	if p == h {
		goto notFound
	}
}
if x3 != 0 || y3 != 0 {
	phi = nArg(x3, y3)
}
@<도함수가 주어진 곡선이 어떤 시각~|tt|에 동쪽으로 나아가면 |found|로 간다@>

@ 돌리는 것은 복소수 곱셈 $(x_k+iy_k)(x-iy)$다. 주어진 방향 $(x,y)$를 $x$축으로 돌리는 회전이기 때문이다.

@<지역 변수 |x1,x2,x3|과...@>=
x1 = rightX(p) - xCoord(p)
x2 = leftX(q) - rightX(p)
x3 = xCoord(q) - leftX(q)
y1 = rightY(p) - yCoord(p)
y2 = leftY(q) - rightY(p)
y3 = yCoord(q) - leftY(q)
@<계수들을 정밀도가 가장 좋도록 키운다; 모두 0이면 |goto found|@>
t = x1
x1 = takeFraction(x1, x) + takeFraction(y1, y)
y1 = takeFraction(y1, x) - takeFraction(t, y)
t = x2
x2 = takeFraction(x2, x) + takeFraction(y2, y)
y2 = takeFraction(y2, x) - takeFraction(t, y)
t = x3
x3 = takeFraction(x3, x) + takeFraction(y3, y)
y3 = takeFraction(y3, x) - takeFraction(t, y)

@ 돌리기 전에 여섯 계수를 함께 두 배씩 키워서 가장 큰 것이 |fractionHalf| 이상이 되게 한다. 그러면 |takeFraction|의 반올림 오차가 상대적으로 작아진다. 계수가 모두 0이면 곡선이 한 점이므로 어느 방향이든 지금 향하고 있다고 친다.

@<계수들을 정밀도가 가장 좋도록 키운다; 모두 0이면 |goto found|@>=
maxCoef = abs(x1)
if abs(x2) > maxCoef {
	maxCoef = abs(x2)
}
if abs(x3) > maxCoef {
	maxCoef = abs(x3)
}
if abs(y1) > maxCoef {
	maxCoef = abs(y1)
}
if abs(y2) > maxCoef {
	maxCoef = abs(y2)
}
if abs(y3) > maxCoef {
	maxCoef = abs(y3)
}
if maxCoef == 0 {
	goto found
}
for maxCoef < fractionHalf {
	maxCoef += maxCoef
	x1 += x1
	x2 += x2
	x3 += x3
	y1 += y1
	y2 += y2
	y3 += y3
}

@ 매듭에서 들어오는 방향 |phi|와 나가는 방향 |theta|가 정동쪽을 사이에 끼고 있으면(꺾임이 $180^\circ$보다
작은 쪽으로), 경로는 그 매듭에서 동쪽을 향한 적이 있는 것으로 친다.

@<매듭 |p|에서 동쪽 방향이...@>=
theta = nArg(x1, y1)
if theta >= 0 && phi <= 0 && phi >= theta-oneEightyDeg {
	goto found
}
if theta <= 0 && phi >= 0 && phi <= theta+oneEightyDeg {
	goto found
}

@ 이 단계에서는 |crossingPoint| 루틴으로 이차 방정식 $B(y_1,y_2,y_3;t)=0$의 근을 찾고 싶다. 몇 가지 복잡한 일이
생긴다. 이차 방정식이 중근을 가지면 곡선은 결코 0을 가로지르지 않으므로 |crossingPoint|는 아무것도 찾지 못한다.
이 경우는 $y_1y_3=y_2^2$이고 $y_1y_2<0$일 때, 그리고 오직 그때에만 일어난다. 이차 방정식이 단근을 가지거나 근이
하나뿐이면, $B(y_1,y_2,y_3;t)$가 첫 근에서 양수에서 음수로 가로지르도록 부호를 바꾸어야 할 수도 있다. 그리고
끝으로 $B(y_1,y_2,y_3;t)$가 항등적으로 0이면 특별한 일을 해야 한다.

@ @<도함수가 주어진 곡선이 어떤 시각~|tt|에 동쪽으로 나아가면 |found|로 간다@>=
if x1 < 0 && x2 < 0 && x3 < 0 {
	goto done
}
if abVsCd(y1, y3, y2, y2) == 0 {
	@<$y_1y_3=y_2^2$일 때 동쪽 방향의 검사를 처리한다; |goto found|이거나 |goto done|@>
}
if y1 <= 0 {
	if y1 < 0 {
		y1 = -y1
		y2 = -y2
		y3 = -y3
	} else if y2 > 0 {
		y2 = -y2
		y3 = -y3
	}
}
@<$B(y_1,y_2,y_3;t)=0$인 곳들에서 $B(x_1,x_2,x_3;t)\ge0$인지 검사한다@>
done:

@ 이차 다항식 $B(y_1,y_2,y_3;t)$는 |>=0|으로 시작하고, 항등적으로 0이 아님을 알므로 근이 많아야 둘이다.

루틴 |crossingPoint|가 완벽하게 정확하지는 않다는 것을 인정해야 한다. 반올림 오차 때문에 $y_1y_3>y_2^2$일 때
근을 찾거나, $y_1y_3<y_2^2$일 때 근을 놓칠 수도 있다. 돌리는 과정 자체도 반올림 오차를 겪는다. 그래도 이
코드는 낙관적으로 옳은 일을 하려고 애쓴다.

시각을 찾으면 |fraction|인 |t|를 |scaled|인 |tt|로 바꾸고 |found|로 간다. 이 일은 이 함수의 여러 곳에서 하므로
작은 함수 리터럴 |weFoundIt|로 두면 좋겠지만, |goto|는 함수 리터럴 밖으로 나갈 수 없으므로 바꾸는 계산만
함수 |fractionToScaledTime|으로 둔다.

@<정의@>=
func fractionToScaledTime(t fraction) scaled { return (t + 0o4000) / 0o10000 }

@ @<$B(y_1,y_2,y_3;t)=0$인 곳들에서...@>=
t = crossingPoint(y1, y2, y3)
if t > fractionOne {
	goto done
}
y2 = tOfTheWay(y2, y3, t)
x1 = tOfTheWay(x1, x2, t)
x2 = tOfTheWay(x2, x3, t)
x1 = tOfTheWay(x1, x2, t)
if x1 >= 0 {
	tt = fractionToScaledTime(t)
	goto found
}
if y2 > 0 {
	y2 = 0
}
tt = t
t = crossingPoint(0, -y2, -y3)
if t > fractionOne {
	goto done
}
x1 = tOfTheWay(x1, x2, t)
x2 = tOfTheWay(x2, x3, t)
if tOfTheWay(x1, x2, t) >= 0 {
	t = tOfTheWay(tt, fractionOne, t)
	tt = fractionToScaledTime(t)
	goto found
}

@ @<$y_1y_3=y_2^2$일 때 동쪽...@>=
if abVsCd(y1, y2, 0, 0) < 0 {
	t = makeFraction(y1, y1-y2)
	x1 = tOfTheWay(x1, x2, t)
	x2 = tOfTheWay(x2, x3, t)
	if tOfTheWay(x1, x2, t) >= 0 {
		tt = fractionToScaledTime(t)
		goto found
	}
} else if y3 == 0 {
	if y1 == 0 {
		@<도함수 $B(x_1,x_2,x_3;t)$가 |>=0|이 되면 |found|로 간다@>
	} else if x3 >= 0 {
		tt = unity
		goto found
	}
}
goto done

@ 이 지점에서 |y(t)|의 도함수는 항등적으로 0이고 |x1<0|임을 안다. 그러나 |x2>=0|이거나 |x3>=0|이므로 동쪽으로
나아갈 희망이 조금은 있다.

@<도함수 $B(x_1,x_2,x_3;t)$가...@>=
t = crossingPoint(-x1, -x2, -x3)
if t <= fractionOne {
	tt = fractionToScaledTime(t)
	goto found
}
if abVsCd(x1, x3, x2, x2) <= 0 {
	t = makeFraction(x1, x1-x2)
	tt = fractionToScaledTime(t)
	goto found
}

@ \seclabel{intersection}두 삼차식의 교점은 |makeMoves|의 머리말에서 설명한 일반적인 이분 방식의 재미있는 변형으로 찾을 수 있다.
두 삼차식 $w(t)=B(w_0,w_1,w_2,w_3;t)$와 $z(t)=B(z_0,z_1,z_2,z_3;t)$가 주어지면, 교점이 있을 경우 $w(t_1)=z(t_2)$인 시각의
쌍 $(t_1,t_2)$를 찾고 싶다. 먼저 점들 $\{w_0,w_1,w_2,w_3\}$를 둘러싸는 가장 작은 직사각형을 찾고, 그것이
$\{z_0,z_1,z_2,z_3\}$을 둘러싸는 가장 작은 직사각형과 겹치는지 검사한다. 겹치지 않으면 두 삼차식은 틀림없이
만나지 않는다. 그러나 직사각형들이 겹치면 구간을 둘로 나누어 새 삼차식 $w'$과~$w''$, $z'$과~$z''$을 얻는다.
교차 루틴은 먼저 $w'$과~$z'$ 사이의 교점을 찾아보고, (실패하면) $w'$과~$z''$ 사이를, (여전히 실패하면) $w''$과~$z'$
사이를, 끝으로 (세 번 실패하면) $w''$과~$z''$ 사이를 찾아본다. 이분을 $l$~단계 성공하고 나면 교차 시각 $t_1$과
$t_2$를 $l$비트의 정확도로 정한 것이 된다.

아래 그림의 왼쪽은 두 곡선과 그 조절점 상자(점선)다. 오른쪽은 각 곡선을 한 번 이분한 다음의 반쪽들의
상자인데, 겹치는 쌍만 계속 살펴보면 된다. 상자는 단계마다 대략 반으로 줄어드므로 교점 둘레로 빠르게 좁혀진다.
$$\mplibcode
beginfig(21);
save u, w, z, box, shift; numeric u; path w, z; pair shift; u := 26pt;
interim bboxmargin := 0;
vardef box(expr c) = bbox(point 0 of c -- postcontrol 0 of c -- precontrol 1 of c -- point 1 of c) enddef;
w := (0,0)..controls (1u,3u) and (3u,2.6u)..(4u,.6u);
z := (.2u,2.4u)..controls (1.6u,.2u) and (3u,-.4u)..(4.2u,2.8u);
draw w withpen pencircle scaled 1pt; draw z withpen pencircle scaled 1pt;
draw box(w) dashed evenly withcolor .5white; draw box(z) dashed evenly withcolor .5white;
shift := (5.2u, 0);
draw w shifted shift withpen pencircle scaled 1pt; draw z shifted shift withpen pencircle scaled 1pt;
for c = subpath (0,.5) of w, subpath (.5,1) of w, subpath (0,.5) of z, subpath (.5,1) of z:
  draw box(c) shifted shift dashed evenly withcolor .5white;
endfor
label.lft(btex $w$ etex, point 0 of w); label.lft(btex $z$ etex, point 0 of z);
endfig;
\endmplibcode$$

\def\submin{_{\rm min}} \def\submax{_{\rm max}}
앞에서처럼 계수 $w_k$와 $z_k$ 자체보다 $W_k=2^l(w_k-w_{k-1})$과 $Z_k=2^l(z_k-z_{k-1})$로 일하는 것이 낫다. 또
하나의 양 $\Delta=2^l(w_0-z_0)$도 필요한데, 둘러싸는 직사각형이 언제 겹치는지 정하는 데 쓴다. 까닭은 이렇다.
이제 $w_k=(u_k,v_k)$이고 $z_k=(x_k,y_k)$이고 $u\submin=\min(u_0,u_1,u_2,u_3)$ 따위로 쓰면, $w(t)$의 $x$~좌표는
$u\submin$과 $u\submax$ 사이에 있고 $z(t)$의 $x$~좌표는 $x\submin$과 $x\submax$ 사이에 있다. 이 $x$~좌표의
구간들은 $u\submin\le x\submax$이고 $x\submin\le u\submax$일 때, 그리고 오직 그때에만 겹친다.
$$U\submin=\min(0,U_1,U_1+U_2,U_1+U_2+U_3),\;
  U\submax=\max(0,U_1,U_1+U_2,U_1+U_2+U_3)$$
로 놓으면 $2^lu\submin=2^lu_0+U\submin$ 따위가 되므로, 겹침의 조건은
$$X\submin-U\submax\le 2^l(u_0-x_0)\le X\submax-U\submin$$
로 줄어든다. 그러므로 우리는 양 $2^l(u_0-x_0)$을 유지하고 싶다. 비슷하게 양 $2^l(v_0-y_0)$이 $y$~좌표를
맡는다. 겹침 조건 때문에 $\Delta=2^l(w_0-z_0)$의 좌표들은 $l$이 늘어나도 유계로 머물러야 한다. 곧 $X\submin$,
$X\submax$와 그 친척들이 유계임을 알므로 $X\submax-U\submin$과 $X\submin-U\submax$도 유계다.

@ 덧붙여, 주어진 삼차식들이 두 번 이상 만나면 방금 대강 말한 과정이 사전 순서로 가장 작은 쌍 $(t_1,t_2)$를
반드시 찾지는 않는다. 실제로 얻는 해는 ``섞은 순서''로 가장 작은 것이다. 곧 $t_1=(.a_1a_2\ldots a_{16})_2$이고
$t_2=(.b_1b_2\ldots b_{16})_2$이면, $a_1a_2\ldots a_{16}b_1b_2\ldots b_{16}$이 아니라 $a_1b_1a_2b_2\ldots a_{16}b_{16}$을
가장 작게 한다. 해의 모든 쌍 $(t_1,t_2)$와 $(t_1',t_2')$이 $t_1<t_1'$일 때 그리고 오직 그때에만 $t_2<t_2'$라는
성질을 가지면 섞은 순서가 사전 순서와 일치한다. 그러나 일반적으로 사전 순서는 꽤 다를 수 있고, 이분 알고리즘이
사전 순서에 묶이면 상당히 덜 효율적일 것이다.

이를테면 $l=3$에서 $(t_1,t_2)= (.101,.011)$(이진법)에 대해 겹침을 찾았지만, 단계~4에서 두 대안 $(.1010,.0110)$,
$(.1010,.0111)$ 어느 쪽도 겹침을 내지 않는다고 하자. 그러면 아마 부분 구간 $(.1011,.011x)$ 가운데 하나에
교점이 있을 것이다. 그러나 사전 순서를 따르면 먼저 $(.1010,.1xxx)$과 $(.1011,.00xx)$과 $(.1011,.010x)$를
살펴보아야 한다. 둘째 경로의 나누기 자료를 모두 저장하고 싶지는 않을 것이므로, 나누기를 여러 번 다시 만들어야
할 것이다. 그런 비효율은 $t_1$의 이진 표현의 모든 `1'마다 따라붙을 것이다.

@ 나누기 과정은 반올림 오차를 들여오므로 겹침을 더 너그럽게 검사해야 한다. 단계~$l$에서 계산한 $U_i$의 값이
참값과 많아야~$l$만큼 다르다는 것을 보이기는 어렵지 않다. 그러므로 $U\submin$과 $U\submax$의 오차는 많아야
$3l$이다. 이제 $\beta$가 단계~$l$에서 계산한 $\Delta=(|delx|,|dely|)$의 성분의 절대 오차의 상한이면, 검사
`$X\submin-U\submax\le|delx|$'를 더 너그러운 검사 `$X\submin-U\submax\le|delx|+|tol|$'로 바꾼다. 여기서
$|tol|=6l+\beta$다.

먼저 |tol=0|으로 알고리즘을 해 보면 더 정확해진다. 더 너그러운 허용치는 정확한 접근이 실패할 때에만 쓴다.
이렇게 두 번 해 보는 일은 앞 문단의 `3'을 매개변수로 해서, 처음에는 0으로, 그다음에는 3으로 하면 편리하다.

@<전역 변수@>=
var @!tolStep int32 // 대개 0이나 3; |0 .. 6|

@ 위에서 설명한 재귀적 이분 방법을 구현하려고 명시적인 스택을 쓴다. 실은 이 목적에 배열 |bisectStack|을 쓸
수 있다. 거기에는 $(U_1,U_2,U_3,U\submin,U\submax)$ 같은 다섯 낱말짜리 꾸러미가 많이 들어가고, $U$, $V$, $X$,~$Y$의
다섯 낱말짜리 꾸러미로 이루어진 스무 낱말짜리 꾸러미도 들어간다.

다음 정의들은 교차 이분에 필요한 양들에 스택 위치를 배정한다. 꾸러미 하나는 기준 위치 |k|에서 시작하는
다섯 낱말 |bisectStack[k+stack1]|, \dots, |bisectStack[k+stackMax]|이다. 기준 위치는 |ulPacket()| 같은 함수가
돌려준다. 이를테면 $U'_1$은 |bisectStack[ulPacket()+stack1]|이고, $Y''_3$은 |bisectStack[yrPacket()+stack3]|이다.

@<정의@>=
const (
	@!stack1 = 0 // $U_1$, $V_1$, $X_1$, $Y_1$
	@!stack2 = 1 // $U_2$, $V_2$, $X_2$, $Y_2$
	@!stack3 = 2 // $U_3$, $V_3$, $X_3$, $Y_3$
	@!stackMin = 3 // $U\submin$, $V\submin$, $X\submin$, $Y\submin$
	@!stackMax = 4 // $U\submax$, $V\submax$, $X\submax$, $Y\submax$
	@!intPackets = 20 // $U_k$, $V_k$, $X_k$, $Y_k$를 나타내는 낱말 수
)

func uPacket(k int32) int32 { return k - 5 }
func vPacket(k int32) int32 { return k - 10 }
func xPacket(k int32) int32 { return k - 15 }
func yPacket(k int32) int32 { return k - 20 }
func lPackets() int32       { return bisectPtr - intPackets }
func rPackets() int32       { return bisectPtr }
func ulPacket() int32       { return uPacket(lPackets()) } // $U'_k$ 변수들의 기준
func vlPacket() int32       { return vPacket(lPackets()) } // $V'_k$ 변수들의 기준
func xlPacket() int32       { return xPacket(lPackets()) } // $X'_k$ 변수들의 기준
func ylPacket() int32       { return yPacket(lPackets()) } // $Y'_k$ 변수들의 기준
func urPacket() int32       { return uPacket(rPackets()) } // $U''_k$ 변수들의 기준
func vrPacket() int32       { return vPacket(rPackets()) } // $V''_k$ 변수들의 기준
func xrPacket() int32       { return xPacket(rPackets()) } // $X''_k$ 변수들의 기준
func yrPacket() int32       { return yPacket(rPackets()) } // $Y''_k$ 변수들의 기준

const (
	@!stackDx = 0 // 쌓인 |delx|의 값의 오프셋
	@!stackDy = 1 // 쌓인 |dely|의 값의 오프셋
	@!stackTol = 2 // 쌓인 |tol|의 값의 오프셋
	@!stackUv = 3 // 쌓인 |uv|의 값의 오프셋
	@!stackXy = 4 // 쌓인 |xy|의 값의 오프셋
	@!intIncrement = intPackets + intPackets + 5 // 단계마다 쓰는 스택 낱말 수
)

@ @<``상수'' 값들이...@>=
if intPackets+17*intIncrement > bistackSize {
	bad = 32
}

@ 최솟값과 최댓값의 계산은 지루하지만 꽤 빠른 명령의 나열이다. 갈래마다 꼭 네 번 비교한다.

@<함수들@>=
func setMinMax(k int32) {
	s := bisectStack[k : k+5] // 꾸러미 하나
	if s[stack1] < 0 {
		@<첫 차분이 음수일 때 최솟값과 최댓값을 정한다@>
	} else if s[stack3] <= 0 {
		if s[stack2] > 0 {
			s[stackMax] = s[stack1] + s[stack2]
		} else {
			s[stackMax] = s[stack1]
		}
		s[stackMin] = s[stack1] + s[stack2] + s[stack3]
		if s[stackMin] > 0 {
			s[stackMin] = 0
		}
	} else {
		s[stackMax] = s[stack1] + s[stack2] + s[stack3]
		if s[stackMax] < s[stack1] {
			s[stackMax] = s[stack1]
		}
		s[stackMin] = s[stack1] + s[stack2]
		if s[stackMin] > 0 {
			s[stackMin] = 0
		}
	}
}

@ 첫 차분이 음수인 경우다. 부분합 $0$, $\Delta_1$, $\Delta_1+\Delta_2$, $\Delta_1+\Delta_2+\Delta_3$ 가운데 가장 작은 것과
가장 큰 것을, 셋째 차분의 부호로 경우를 나누어 적은 비교로 찾는다.

@<첫 차분이 음수일 때 최솟값과 최댓값을 정한다@>=
if s[stack3] >= 0 {
	if s[stack2] < 0 {
		s[stackMin] = s[stack1] + s[stack2]
	} else {
		s[stackMin] = s[stack1]
	}
	s[stackMax] = s[stack1] + s[stack2] + s[stack3]
	if s[stackMax] < 0 {
		s[stackMax] = 0
	}
} else {
	s[stackMin] = s[stack1] + s[stack2] + s[stack3]
	if s[stackMin] > s[stack1] {
		s[stackMin] = s[stack1]
	}
	s[stackMax] = s[stack1] + s[stack2]
	if s[stackMax] < 0 {
		s[stackMax] = 0
	}
}

@ 현재의 $l$, $t_1$, $t_2$ 값을 정수 꼴 $2^l+2^lt_1$과 $2^l+2^lt_2$로 두면 편리하다. 루틴 |cubicIntersection|은
이 목적에 전역 변수 |curT|와 |curTt|를 쓴다. 성공적으로 마치면 |curT|와 |curTt|에는 |unity|에 $t_1$과~$t_2$의
|scaled| 값을 더한 것이 들어 있다.

루틴 |cubicIntersection|이 교점을 찾지 못하면 |curT|와 |curTt|의 값은 0이 된다. 이 루틴은 5000번 넘게 되짚어
가면 포기하고 근삿값을 내준다(그러지 않으면 몇 분 동안 헛된 계산을 할 수 있는 경우가 있다).

@<정의@>=
const @!maxPatience = 5000

@ @<전역 변수@>=
var @!curT, @!curTt int32 // |cubicIntersection|의 제어와 결과
var @!timeToGo int32 // 포기하기 전에 이만큼 되짚어 간다
var @!maxT int32 // 지금까지 이른 $2^{l+1}$의 최댓값

@ 주어진 삼차식 $B(w_0,w_1,w_2,w_3;t)$와 $B(z_0,z_1,z_2,z_3;t)$는 각각 이웃한 매듭 노드 |(p,link(p))|와
|(pp,link(pp))|에 지정된다.

@<함수들@>=
func cubicIntersection(p, pp pointer) {
	var q, qq pointer // |link(p)|, |link(pp)|
	timeToGo = maxPatience
	maxT = 2
	@<단계 0에서 교차를 위해 초기화한다@>
	for {
		if delx-tol <= bisectStack[xPacket(xy)+stackMax]-bisectStack[uPacket(uv)+stackMin] &&
			delx+tol >= bisectStack[xPacket(xy)+stackMin]-bisectStack[uPacket(uv)+stackMax] &&
			dely-tol <= bisectStack[yPacket(xy)+stackMax]-bisectStack[vPacket(uv)+stackMin] &&
			dely+tol >= bisectStack[yPacket(xy)+stackMin]-bisectStack[vPacket(uv)+stackMax] {
			if curT >= maxT {
				if maxT == two { // 이분을 17번 했다
					curT = half(curT + 1)
					curTt = half(curTt + 1)
					return
				}
				maxT += maxT
				apprT = curT
				apprTt = curTt
			}
			@<교차의 새 단계를 위해 나눈다@>
			continue
		}
		if timeToGo > 0 {
			timeToGo--
		} else {
			for apprT < unity {
				apprT += apprT
				apprTt += apprTt
			}
			curT = apprT
			curTt = apprTt
			return
		}
		@<다음 쌍 |(curT,curTt)|로 나아간다@>
	}
}

@ 다음 변수들은 |cubicIntersection|에서만 쓰이는데도 전역이다. 원본은 어떤 기계에서는 |cubicIntersection|을 두
프로시저로 나누어야 했기 때문에 이렇게 했다.

@<전역 변수@>=
var @!delx, @!dely int32 // $\Delta=2^l(w_0-z_0)$의 성분들
var @!tol int32 // 겹침 검사의 불확실성의 한계
var @!uv, @!xy int32 // 지금 관심 있는 꾸러미를 가리키는 포인터들; |0 .. bistackSize|
var @!threeL int32 // |tolStep| 곱하기 이분 단계
var @!apprT, @!apprTt int32 // 알려진 가장 좋은 답의 근삿값

@ 좌표가 정수 넘침이 일어나지 않을 만큼 극단적이지 않다고 가정한다.
@^overflow in arithmetic@>

@<단계 0에서 교차를...@>=
q = link(p)
qq = link(pp)
bisectPtr = intPackets
bisectStack[urPacket()+stack1] = rightX(p) - xCoord(p)
bisectStack[urPacket()+stack2] = leftX(q) - rightX(p)
bisectStack[urPacket()+stack3] = xCoord(q) - leftX(q)
setMinMax(urPacket())
bisectStack[vrPacket()+stack1] = rightY(p) - yCoord(p)
bisectStack[vrPacket()+stack2] = leftY(q) - rightY(p)
bisectStack[vrPacket()+stack3] = yCoord(q) - leftY(q)
setMinMax(vrPacket())
bisectStack[xrPacket()+stack1] = rightX(pp) - xCoord(pp)
bisectStack[xrPacket()+stack2] = leftX(qq) - rightX(pp)
bisectStack[xrPacket()+stack3] = xCoord(qq) - leftX(qq)
setMinMax(xrPacket())
bisectStack[yrPacket()+stack1] = rightY(pp) - yCoord(pp)
bisectStack[yrPacket()+stack2] = leftY(qq) - rightY(pp)
bisectStack[yrPacket()+stack3] = yCoord(qq) - leftY(qq)
setMinMax(yrPacket())
delx = xCoord(p) - xCoord(pp)
dely = yCoord(p) - yCoord(pp)
tol = 0
uv = rPackets()
xy = rPackets()
threeL = 0
curT = 1
curTt = 1

@ 나누기는 꾸러미마다 똑같으므로, 기준 위치가 |src|인 꾸러미를 기준 위치가 |l|과 |r|인 두 꾸러미로 나누는
일을 함수 리터럴 |bisect|로 둔다. 이 절에서만 쓰이기 때문이다.

@<교차의 새 단계를 위해...@>=
bisectStack[bisectPtr+stackDx] = delx
bisectStack[bisectPtr+stackDy] = dely
bisectStack[bisectPtr+stackTol] = tol
bisectStack[bisectPtr+stackUv] = uv
bisectStack[bisectPtr+stackXy] = xy
bisectPtr = bisectPtr + intIncrement
curT += curT
curTt += curTt
bisect := func(src, l, r int32) {
	bisectStack[l+stack1] = bisectStack[src+stack1]
	bisectStack[r+stack3] = bisectStack[src+stack3]
	bisectStack[l+stack2] = half(bisectStack[l+stack1] + bisectStack[src+stack2])
	bisectStack[r+stack2] = half(bisectStack[r+stack3] + bisectStack[src+stack2])
	bisectStack[l+stack3] = half(bisectStack[l+stack2] + bisectStack[r+stack2])
	bisectStack[r+stack1] = bisectStack[l+stack3]
	setMinMax(l)
	setMinMax(r)
}
bisect(uPacket(uv), ulPacket(), urPacket())
bisect(vPacket(uv), vlPacket(), vrPacket())
bisect(xPacket(xy), xlPacket(), xrPacket())
bisect(yPacket(xy), ylPacket(), yrPacket())
uv = lPackets()
xy = lPackets()
delx += delx
dely += dely
tol = tol - threeL + tolStep
tol += tol
threeL = threeL + tolStep

@ @<다음 쌍 |(curT,curTt)|로...@>=
notFound:
if odd(curTt) {
	if odd(curT) {
		@<앞 단계로 내려가고 |goto notFound|@>
	} else {
		curT++
		delx = delx + bisectStack[uPacket(uv)+stack1] + bisectStack[uPacket(uv)+stack2] +
			bisectStack[uPacket(uv)+stack3]
		dely = dely + bisectStack[vPacket(uv)+stack1] + bisectStack[vPacket(uv)+stack2] +
			bisectStack[vPacket(uv)+stack3]
		uv = uv + intPackets // |lPackets|에서 |rPackets|로 바꾼다
		curTt--
		xy = xy - intPackets // |rPackets|에서 |lPackets|로 바꾼다
		delx = delx + bisectStack[xPacket(xy)+stack1] + bisectStack[xPacket(xy)+stack2] +
			bisectStack[xPacket(xy)+stack3]
		dely = dely + bisectStack[yPacket(xy)+stack1] + bisectStack[yPacket(xy)+stack2] +
			bisectStack[yPacket(xy)+stack3]
	}
} else {
	curTt++
	tol = tol + threeL
	delx = delx - bisectStack[xPacket(xy)+stack1] - bisectStack[xPacket(xy)+stack2] -
		bisectStack[xPacket(xy)+stack3]
	dely = dely - bisectStack[yPacket(xy)+stack1] - bisectStack[yPacket(xy)+stack2] -
		bisectStack[yPacket(xy)+stack3]
	xy = xy + intPackets // |lPackets|에서 |rPackets|로 바꾼다
}

@ @<앞 단계로 내려가고...@>=
curT = half(curT)
curTt = half(curTt)
if curT == 0 {
	return
}
bisectPtr = bisectPtr - intIncrement
threeL = threeL - tolStep
delx = bisectStack[bisectPtr+stackDx]
dely = bisectStack[bisectPtr+stackDy]
tol = bisectStack[bisectPtr+stackTol]
uv = bisectStack[bisectPtr+stackUv]
xy = bisectStack[bisectPtr+stackXy]
goto notFound

@ 프로시저 |pathIntersection|은 훨씬 간단하다. 이것은 만나는 삼차식의 쌍을 찾을 때까지 사전 순서로
|cubicIntersection|을 부른다. 마지막 교차 시각은 |curT|와~|curTt|에 넣는다.

@<함수들@>=
func pathIntersection(h, hh pointer) {
	var p, pp pointer // 주어진 경로를 훑는 연결 레지스터들
	var n, nn int32 // 교차 시각의 정수 부분에서 |unity|를 뺀 것
	@<점 하나짜리 경로를 죽은 순환으로 바꾼다@>
	tolStep = 0
	for {
		n = -unity
		p = h
		for {
			if rightType(p) != endpoint {
				nn = -unity
				pp = hh
				for {
					if rightType(pp) != endpoint {
						cubicIntersection(p, pp)
						if curT > 0 {
							curT = curT + n
							curTt = curTt + nn
							return
						}
					}
					nn = nn + unity
					pp = link(pp)
					if pp == hh {
						break
					}
				}
			}
			n = n + unity
			p = link(p)
			if p == h {
				break
			}
		}
		tolStep = tolStep + 3
		if tolStep > 3 {
			break
		}
	}
	curT = -unity
	curTt = -unity
}

@ @<점 하나짜리 경로를...@>=
if rightType(h) == endpoint {
	setRightX(h, xCoord(h))
	setLeftX(h, xCoord(h))
	setRightY(h, yCoord(h))
	setLeftY(h, yCoord(h))
	setRightType(h, explicit)
}
if rightType(hh) == endpoint {
	setRightX(hh, xCoord(hh))
	setLeftX(hh, xCoord(hh))
	setRightY(hh, yCoord(hh))
	setLeftY(hh, yCoord(hh))
	setRightType(hh, explicit)
}

@* 화면 그래픽 출력.
\MF는 아래에 정의하는 원시 연산 몇 개로 사용자의 화면에 그림을 보인다. 이 연산들은 다양한 기계에서 큰
어려움 없이 구현할 수 있도록 일부러 단순하게 했다. 그래픽 출력에는 전통적인 표준이 없으므로, \MF의 이
측면을 떠받치려면 시스템에 따른 코드를 좀 써야 한다. 그러나 필요한 루틴들은 대개 쓰기가 꽤 쉽다.
@^system dependencies@>

실은 그런 루틴은 꼭 넷이다.

\yskip\hang
함수 |initScreen|은 다른 연산들을 떠받치는 데 필요한 초기화를 무엇이든 한다. 이것은 그래픽 출력을 떠받칠 수 없으면
(이를테면 다른 세 루틴을 짜지 않았거나 사용자에게 알맞은 종류의 터미널이 없으면) |false|를 돌려주는 불 함수다.

\yskip\hang
프로시저 |blankRectangle|은 메모리의 버퍼 영역을 갱신해서 지정한 직사각형 안의 모든 화소를 바탕색으로 놓는다.

\yskip\hang
프로시저 |paintRow|는 방금 말한 버퍼의 한 행에서 지정한 화소들에, 아래에서 설명하는 ``넘어감'' 첨자에 따라 값을 준다.

\yskip\hang
프로시저 |updateScreen|은 현재 화면 버퍼를 보인다. 그리고 |blankRectangle|과 |paintRow| 명령의 효과는 다음 |updateScreen|
연산을 할 때까지 보이지 않을 수도 있다. (그러므로 |updateScreen|은 |updateTerminal|과 비슷하다.)

\yskip\noindent
여기의 코드는 화면 출력을 떠받치지 않는 \MF\ 시스템에서 쓸 수 있는 최소한의 |initScreen|과 |updateScreen|이다.
함수 |initScreen|이 |false| 대신 |true|를 돌려주도록 바꾸면, 다른 루틴들은 자기가 불렸다는 사실을 기록 파일에
적기만 하고 실제로는 아무것도 보이지 않는다. \MF의 표준 시험 루틴들은 \MF가 제대로 돌아가는지 확인하는 데 이
기록 정보를 쓴다. 그러나 실무용 \MF에서는 |wlog| 명령들을 빼야 한다. 여기서는 그 명령들을 \.{INIMF}로 돌
때에만 실행한다.

@<함수들@>=
func initScreen() bool {
	return false
}

func updateScreen() { // |initScreen|이 |true|를 돌려줄 때에만 불린다
	if iniVersion {
		wlogLn("Calling UPDATESCREEN") // 시험할 때만
	}
}

@ 사용자의 화면은 너비가 |screenWidth|화소이고 깊이가 |screenDepth|화소인 직사각형 영역이라고 가정한다. 왼쪽 위
모서리의 화소는 행~0의 열~0에 있다고 하고, 오른쪽 아래 모서리의 화소는 행 |screenDepth-1|의 열
|screenWidth-1|에 있다고 한다. 행 번호가 \MF의 다른 좌표와 반대로 위에서 아래로 늘어난다는 데 주목하라.

각 화소에는 두 상태가 있다고 가정하는데, 이 문서에서는 |black|과 |white|라고 부른다. 바탕색을 |white|라고 하고
다른 색을 |black|이라고 하지만, 실제로는 서로 다른 어떤 두 화소 값이든 쓸 수 있다. 이를테면 저자는 |white|가
검은색이고 |black|이 밝은 초록색인 시스템에서 \MF를 개발했다.

@<정의@>=
const (
	@!white = 0 // 바탕 화소
	@!black = 1 // 보이는 화소
)

@ @<전역 형@>=
type @!screenRow = int32 // 화면의 행 번호; |0 .. screenDepth|
type @!screenCol = int32 // 화면의 열 번호; |0 .. screenWidth|
type @!transSpec = [screenWidth + 1]screenCol // 넘어감 명세; 아래 참조
type @!pixelColor = int32 // 두 화소 값 가운데 하나; |white .. black|

@ 두 연산 |blankRectangle|과 |paintRow|는 |screenPixel|이라는 화면 버퍼를 선언한 것처럼 꾸며서 보인다. 이 코드는
실제로는 주석으로 막혀 있지만, 의도한 효과를 지정한다.
$$\hbox{|var screenPixel [screenDepth+1][screenWidth+1]pixelColor|}$$

@ 루틴 |blankRectangle|은 그냥 행 |topRow|부터 |botRow-1|까지의 열 |leftCol|부터 |rightCol-1|까지(양 끝 포함)에
있는 모든 화소를 하얗게 한다. 네 매개변수는 관계
$$\hbox{|0<=leftCol<=rightCol<=screenWidth|,\quad |0<=topRow<=botRow<=screenDepth|}$$
를 만족한다. 만일 |leftCol=rightCol|이거나 |topRow=botRow|이면 아무 일도 일어나지 않는다.

다음 프로시저의 주석으로 막은 코드는 설명을 위한 것일 뿐이다.
@^system dependencies@>

@<함수들@>=
func blankRectangle(leftCol, rightCol screenCol, topRow, botRow screenRow) {
	// |for r := topRow; r < botRow; r++ {|
	// \quad|for c := leftCol; c < rightCol; c++ { screenPixel[r][c] = white }|
	// |}|
	if iniVersion {
		wlogCr() // 이것은 |initScreen=true|가 된 뒤에만 일어난다
		wlogLn("Calling BLANKRECTANGLE(", leftCol, ",", rightCol, ",", topRow, ",", botRow, ")")
	}
}

@ 화면 표시의 진짜 일은 |paintRow|가 한다. 그러나 그것은 힘든 일이 아니다. 이 연산은 화면 행 하나에만, 그것도 그
행에서 잇닿은 열들의 집합에만 영향을 주기 때문이다. 매개변수는 넷이다. 곧 |r|~(행), |b|~(처음 색), |a|~(넘어감
명세의 배열), |n|~(넘어감의 수)이다. 배열 |a|의~원소들은
$$0\le a[0]<a[1]<\cdots<a[n]\le |screenWidth|$$
를 만족하고, |r|의 값은 |0<=r<screenDepth|를 만족하며, |n|은 양수다.

일반적인 생각은 화소의 덩어리들을 번갈아 다른 색으로 칠하는 것이다. 정확한 세부는 (아래의 주석으로 막은 코드처럼)
프로그램으로 전하는 것이 가장 좋다. 원본에서 배열 |a|는 변수 매개변수였다. 여기서는 배열의 슬라이스를 넘긴다.
@^system dependencies@>

@<함수들@>=
func paintRow(r screenRow, b pixelColor, a []screenCol, n screenCol) {
	// |k := 0; c := a[0]|
	// |for { k++; for { screenPixel[r][c] = b; c++; if c == a[k] {break} }|
	// \quad|b = black - b; if k == n {break} }| \quad (곧 |black|$\swap$|white|)
	if iniVersion {
		wlog("Calling PAINTROW(", r, ",", b, ";") // 이것은 |initScreen=true|가 된 뒤에만 일어난다
		for k := screenCol(0); k <= n; k++ {
			wlog(a[k])
			if k != n {
				wlog(",")
			}
		}
		wlogLn(")")
	}
}

@ \MF의 나머지 화면 루틴들은 방금 정의한 네 원시 연산을 시스템에 독립적인 방식으로 부른다.

먼저 |initScreen|을 불렀는지 알려 주는 전역 불 변수와, |initScreen|이 |true|로 대답했는지 알려 주는 또 하나의
변수가 있다.

@<전역 변수@>=
var @!screenStarted bool // 화면 원시 연산들을 초기화했나?
var @!screenOK bool // |blankRectangle|, |paintRow|, |updateScreen|을 불러도 되나?

@ @<정의@>=
func startScreen() {
	if !screenStarted {
		screenOK = initScreen()
		screenStarted = true
	}
}

@ @<핵심 변수들의...@>=
screenStarted = false
screenOK = false

@ \MF는 사용자에게 화면에 16개의 ``창'' 영역을 마련해 주는데, 각 영역에서 서로 독립적인 표시를 할 수 있다.

\MF의 창은 여러 창을 쓰는 그래픽 워크스테이션의 뜻에서 정말로 독립적인 ``클릭할 수 있는'' 실체가 아니라는 데
주의해야 한다. \MF는 그것들을 |initScreen|, |blankRectangle|, |paintRow|, |updateScreen|이 다스리는 하나의 화면
이미지의 부분 집합으로 대응시킬 뿐이다. 그러므로 여러 창을 쓰는 워크스테이션에서 \MF를 구현하면 아마 다른 뜻의
창을 둘만 쓸 것이다. 하나는 터미널 출력을 위한 것이고 다른 하나는 \MF의 영역 16개를 담은 화면을 위한 것이다.
이제부터 창이라는 낱말은 \MF의 뜻으로만 쓰기로 한다.

@<전역 형@>=
type @!windowNumber = int32 // |0 .. 15|

@ 사용자는 16개의 창 가운데 어느 것도 쓰지 않아도 된다. 그러나 창을 ``열면'' 그 창은 화면의 특정한 직사각형
부분과 \MF의 좌표에 대한 특정한 직사각형에 할당된다. 관련 자료는 전역 배열 |windowOpen|, |leftCol|, |rightCol|,
|topRow|, |botRow|, |mWindow|, |nWindow|에 저장된다.

배열 |windowOpen|은 불 배열이고 그 뜻은 뻔하다. 배열 |leftCol|, \dots, |botRow|에는 |blankRectangle|로 창 전체를
비울 때 쓸 수 있는 화면 좌표가 들어 있다. 그리고 방금 말한 나머지 두 배열은 실제 좌표와 화면 좌표 사이의
변환을 맡는다. 행~$n$의 열~$m$에 있는 \MF의 화소는, 창의 경계 안에 들어가기만 하면 화면의 열 |mWindow+m|과
화면의 행 |nWindow-n|에 나타난다.

또 하나의 배열 |windowTime|에는 이 창이 갱신된 횟수가 들어 있다.

@<전역 변수@>=
var @!windowOpen [16]bool // 이 창을 열었나?
var @!leftCol [16]screenCol // 화면에서 가장 왼쪽 열의 위치
var @!rightCol [16]screenCol // 가장 오른쪽 열의 위치에 1을 더한 것
var @!topRow [16]screenRow // 화면에서 맨 위 행의 위치
var @!botRow [16]screenRow // 맨 아래 행의 위치에 1을 더한 것
var @!mWindow [16]int32 // 사용자 열과 화면 열 사이의 옮김
var @!nWindow [16]int32 // 사용자 행과 화면 행 사이의 옮김
var @!windowTime [16]int32 // 이만큼 자주 갱신되었다

@ @<핵심 변수들의...@>=
for k = 0; k <= 15; k++ {
	windowOpen[k] = false
	windowTime[k] = 0
}

@ 창을 여는 것은 파일을 여는 것과 다르다. 원하는 만큼 자주 열 수 있고 다시 닫을 필요도 없다. 생각은 그냥 현재
화면 표시에 특별한 점들을 정의하는 것이다.

창의 지정이 겹치면 \MF의 표시 알고리즘을 꼼꼼히 들여다보아야만 이해할 수 있는 복잡한 효과가 날 수 있다. 그래서
\MF\ 사용자 설명서에서는 그것을 정의하지 않은 채로 남겨 두었다. 실제로는 그 행동을 예측할 수 있지만 말이다.
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>

다음은 명령 `\KW{openwindow}~|k| \KW{from}~$(\\{r0},\\{c0})$ \KW{to}~$(\\{r1},\\{c1})$ \KW{at}~$(x,y)$'을 구현하는
서브루틴이다.

@<함수들@>=
func openAWindow(k windowNumber, r0, c0, r1, c1 scaled, x, y scaled) {
	var m, n int32 // 화소 좌표
	@<좌표 |(r0,c0)|과 |(r1,c1)|이 알맞은 범위에 있도록 고친다@>
	windowOpen[k] = true
	windowTime[k]++
	leftCol[k] = c0
	rightCol[k] = c1
	topRow[k] = r0
	botRow[k] = r1
	@<화면 좌표와 실제 좌표 사이의 옮김을 계산한다@>
	startScreen()
	if screenOK {
		blankRectangle(c0, c1, r0, r1)
		updateScreen()
	}
}

@ 좌표가 지금의 화면 크기에 맞지 않는 창은 맞을 때까지 잘라 낸다.

@<좌표 |(r0,c0)|과 |(r1,c1)|이...@>=
if r0 < 0 {
	r0 = 0
} else {
	r0 = roundUnscaled(r0)
}
r1 = roundUnscaled(r1)
if r1 > screenDepth {
	r1 = screenDepth
}
if r1 < r0 {
	if r0 > screenDepth {
		r0 = r1
	} else {
		r1 = r0
	}
}
if c0 < 0 {
	c0 = 0
} else {
	c0 = roundUnscaled(c0)
}
c1 = roundUnscaled(c1)
if c1 > screenWidth {
	c1 = screenWidth
}
if c1 < c0 {
	if c0 > screenWidth {
		c0 = c1
	} else {
		c1 = c0
	}
}

@ 세 가지 좌표가 판을 치므로 그것들을 똑바로 구별해야 한다! (i)~\MF의 주 좌표는 화소 사이의 가장자리를
가리킨다. (ii)~(가장자리 구조 안의) \MF의 화소 좌표는 $(m,n)$, $(m,n+1)$, $(m+1,n)$,~$(m+1,n+1)$로 둘러싸인
화소가 화소 행 번호~$n$과 화소 열 번호~$m$에 있다고 말한다. (iii)~한편 화면 좌표는 앞에서 말했듯이 행 번호가
위에서 아래로 늘어난다.
@^coordinates, explained@>

여기의 프로그램은 먼저 화소 행~$n$의 화소 열~$m$이 창의 왼쪽 위 모서리에 오도록 하는 정수 $m$과 $n$을
계산한다. 그러므로 화소 행 |n+r0|의 화소 열 |m-c0|이 화면의 왼쪽 위 모서리에 오게 된다.

@<화면 좌표와 실제 좌표...@>=
m = roundUnscaled(x)
n = roundUnscaled(y) - 1
mWindow[k] = c0 - m
nWindow[k] = r0 + n

@ 이제 창 표시에 관련된 \MF의 가장 복잡한 연산이 나온다. 열린 창의 번호~|k|가 주어지면, |curEdges|에서 무게가
양수인 화소들을 창에 |black|으로 보이고, 다른 화소들은 모두 |white|로 보인다.

@<함수들@>=
func dispEdges(k windowNumber) {
	var p, q pointer // 목록 조작을 위해
	var alreadyThere bool // 앞의 화신이 창에 있나?
	var r int32 // 행 번호
	var n screenCol // |rowTransition|에서 쓰고 있는 가장 큰 첨자
	var w, ww int32 // 옛 쌓인 무게와 새 쌓인 무게
	var b pixelColor // 행 넘어감에서 첫 화소의 상태
	var m, mm int32 // 옛 화면 열 위치와 새 화면 열 위치
	var d int32 // |minHalfword| 보정을 하지 않은 가장자리와 무게
	var mAdjustment int32 // 가장자리 좌표와 화면 좌표 사이의 변환
	var rightEdge int32 // 창에 영향을 줄 수 있는 가장 큰 가장자리와 무게
	var minCol screenCol // 창에서 가장 작은 화면 열 번호
	if screenOK && leftCol[k] < rightCol[k] && topRow[k] < botRow[k] {
		alreadyThere = false
		if lastWindow(curEdges) == k {
			if lastWindowTime(curEdges) == windowTime[k] {
				alreadyThere = true
			}
		}
		if !alreadyThere {
			blankRectangle(leftCol[k], rightCol[k], topRow[k], botRow[k])
		}
		@<표시 계산을 위해 초기화한다@>
		p = link(curEdges)
		r = nWindow[k] - (nMin(curEdges) - zeroField)
		for p != curEdges && r >= topRow[k] {
			if r < botRow[k] {
				@<가장자리 행 |p|의 화소들을 화면 행 |r|에 보인다@>
			}
			p = link(p)
			r--
		}
		updateScreen()
		windowTime[k]++
		setLastWindow(curEdges, k)
		setLastWindowTime(curEdges, windowTime[k])
	}
}

@ 행 하나를 보이는 데는 일이 좀 들므로 될 수 있으면 다시 계산하지 않으려 한다.

@<가장자리 행 |p|의 화소들을 화면 행 |r|에 보인다@>=
if unsorted(p) > void {
	sortEdges(p)
} else if unsorted(p) == void && alreadyThere {
	goto done
}
setUnsorted(p, void) // 이번에는 칠하지만 다음번에는 안 칠할지도 모른다
@<|paintRow|에 필요한 매개변수들을 마련한다; 그러나 결국 칠할 필요가 없으면 |goto done|@>
paintRow(r, b, rowTransition[:], n)
done:

@ 프로시저 |paintRow|에 넘기는 넘어감 명세 매개변수는 언제나 같은 배열이다.

@<전역 변수@>=
var @!rowTransition transSpec // |black|/|white| 넘어감의 배열

@ 남은 일은 목록 |sorted(p)|를 훑으면서 |info| 필드를 |m|과 무게로 풀고, 쌓인 무게~|w|가 양수인 화소들을 |black|으로
만드는 것이다. 이 일에 쓰는 지역 변수들은 |dispEdges|의 머리에 선언했다.

@ 미리 계산한 상수 몇 개가 표시 계산을 빠르게 한다.

@<표시 계산을 위해...@>=
mAdjustment = mWindow[k] - mOffset(curEdges)
rightEdge = 8 * (rightCol[k] - mAdjustment)
minCol = leftCol[k]

@ @<|paintRow|에 필요한 매개변수들을...@>=
n = 0
ww = 0
m = -1
w = 0
q = sorted(p)
rowTransition[0] = minCol
for {
	if q == sentinel {
		d = rightEdge
	} else {
		d = ho(info(q))
	}
	mm = (d / 8) + mAdjustment
	if mm != m {
		@<열 |m|에서 일어날 수 있는 넘어감을 기록한다@>
		m = mm
		w = ww
	}
	if d >= rightEdge {
		break
	}
	ww = ww + (d % 8) - zeroW
	q = link(q)
}
@<마지막 넘어감을 넣어서 |paintRow| 매개변수 계산을 마무리한다; 칠할 필요가 없으면 |goto done|@>

@ 이제 |m|은 |<rightCol[k]|인 화면 열이다.

@<열 |m|에서 일어날 수 있는...@>=
if w <= 0 {
	if ww > 0 && m > minCol {
		if n == 0 {
			if alreadyThere {
				b = white
				n++
			} else {
				b = black
			}
		} else {
			n++
		}
		rowTransition[n] = m
	}
} else if ww <= 0 && m > minCol {
	if n == 0 {
		b = black
	}
	n++
	rowTransition[n] = m
}

@ 창 영역에서 행 전체가 |white|이면, |alreadyThere|가 거짓일 때는 칠하기를 건너뛸 수 있다. 그 경우에는 이미 비워
두었기 때문이다.

다음 코드를 부를 때 |rowTransition[n]|은 |rightCol[k]|보다 엄격히 작다.

@<마지막 넘어감을 넣어서...@>=
if alreadyThere || ww > 0 {
	if n == 0 {
		if ww > 0 {
			b = black
		} else {
			b = white
		}
	}
	n++
	rowTransition[n] = rightCol[k]
} else if n == 0 {
	goto done
}

@* 동적 일차 방정식.
\MF\ 사용자는 만족해야 할 방정식을 적어서 변수를 암묵적으로 정의한다. 컴퓨터는 그 방정식을 풀 만큼 영리해야
한다. 실제로 컴퓨터는 다섯 가지 수치 값의 형을 구별해서 그 일을 용감하게 해내려 애쓴다.

\smallskip\hang
형 |type(p)=known|은 좋은 경우로, |value(p)|가 주소가~|p|인 변수의 |scaled| 값이다.

\smallskip\hang
형 |type(p)=dependent|는 |value(p)|가 없고, 대신 |depList(p)|가 변수~|p|의 값을 |scaled| 수 하나에 |fraction|
계수를 가진 독립 변수들의 합을 더한 것으로 나타내는 {\sl 종속 목록\/}을 가리킨다는 뜻이다.

\smallskip\hang
형 |type(p)=independent|는 $|value|(p)=64s+m$이라는 뜻이다. 여기서 |s>0|은 이 변수가 방정식에서 처음 쓰인 때를
나타내는 ``일련번호''다. 또 |0<=m<64|이고, 이 변수를 가리키는 종속 변수들은 실은 이 변수의 앞날의 값에
$2^m$을 곱한 것을 가리키고 있다. (대개 |m=0|이지만, 종속 목록의 계수가 너무 커지지 않도록 더 큰 눈금이
이따금 필요하다. 또 |m|의~값은 언제나 짝수다.)

\smallskip\hang
형 |type(p)=numericType|은 변수 |p|가 전에 방정식에 나타난 적이 없지만 수치라고 명시적으로 선언되었다는 뜻이다.

\smallskip\hang
형 |type(p)=undefined|는 변수 |p|가 전에 나타난 적이 없다는 뜻이다.

\smallskip\noindent
우리는 실은 이 다섯 형을 계산하는 동안 거치는 내력의 거꾸로 순서로 논의했다. 한 번 |known|이 된 변수는 결코
다시 |dependent|가 되지 않는다. 한 번 |dependent|가 되면 다시 |independent|가 되는 일은 거의 없다. 한 번
|independent|가 되면 결코 다시 |numericType|이 되지 않는다. 그리고 한 번 |numericType|이 되면 결코 다시
|undefined|가 되지 않는다(물론 사용자가 옛 값을 버리고 다시 시작하기로 특별히 정할 때는 빼고). 그러나 뒷걸음이
일어날 수는 있다. 어떤 |dependent| 변수가 의존하던 독립 변수 가운데 하나가 |undefined|로 되돌아갈 때, 그 변수가 다시
|independent|가 되는 일이 이따금 있다.

간단한 보기를 보자. 사용자가 `\.{a+b=3; a-b=1;}'이라고 쓰면, 첫 방정식을 처리할 때 \MF는 독립 변수 |a|와 |b|
가운데 하나, 이를테면 |b|를 골라 `$b=-a+3$'이라는 종속 목록을 만든다. 둘째 방정식은 그 대입으로
`$2a-3-1=0$'이 되어 남은 독립 변수 |a|가 알려지고($a=2$), 그 결과 |b|의 종속 목록도 상수만 남아 |b|가
알려진다($b=1$). 이 부의 루틴들이 이런 가우스 소거를 방정식이 들어오는 대로 한 걸음씩 해낸다.

@<정의@>=
const @!sScale = 64 // 일련번호에 이 인수를 곱한다

func newIndep(p pointer) { // 새 독립 변수를 만든다
	if serialNo > elGordo-sScale {
		overflow("independent variables", serialNo/sScale)
@:METAFONT capacity exceeded independent variables}{\quad independent variables@>
	}
	setType(p, independent)
	serialNo = serialNo + sScale
	setValue(p, serialNo)
}

@ @<전역 변수@>=
var @!serialNo int32 // 가장 최근의 일련번호에 |sScale|을 곱한 것

@ @<변수 |q+s|를 새로 독립 변수로...@>=
newIndep(q + s)

@ 그러면 종속 목록은 어떻게 나타낼까? 간단하다. 일차 결합 $\alpha_1v_1+\cdots+\alpha_kv_k+\beta$는 값 노드
|k+1|개에 나타난다. 포인터 |q=depList(p)|가 이 목록을 가리키고 |k>0|이면, |value(q)=@t$\alpha_1$@>|(이것은
|fraction|이다)이고, |info(q)|는 $v_1$의 위치를 가리키고, |link(q)|는 종속 목록
$\alpha_2v_2+\cdots+\alpha_kv_k+\beta$를 가리킨다. 한편 |k=0|이면 |value(q)=@t$\beta$@>|(이것은 |scaled|다)이고
|info(q)=null|이다. (원문은 둘째 항부터의 목록을 가리키는 것이 |link(p)|라고 적었지만, 앞의 정의로 보아
|link(q)|가 맞다. 종속 변수~|p| 자신의 |link| 필드는 변수 구조의 연결이고, 목록을 훑는 |printDependency| 같은 루틴도
목록 노드의 |link|로 다음 항에 간다.)
@^bugs@>
독립 변수 $v_1$, \dots,~$v_k$는 |value| 필드(곧 일련번호)가 줄어드는 순서로 나타나도록 정렬되어
있다. \ (값 |value(null)|이 0이므로 줄어드는 순서를 쓰는 것이 편리하다. 독립 변수를 일련번호가 아니라 |mem|에서의 위치
같은 다른 기준으로 정렬하면 방정식 풀이 장치가 지나치게 시스템에 의존하게 될 것이다. 순서가 계산 결과에 영향을 줄
수 있기 때문이다.)

상수항 $\beta$를 담은 노드의 |link| 필드를 종속 목록의 {\sl 마지막 연결\/}이라고 부른다. \MF는 |depHead|라는,
|mem|에 영구히 할당된 노드를 머리로 해서 모든 종속 목록의 이중 연결 주 목록을 유지한다. 종속 관계가 하나도
없으면 |link(depHead)=depHead|이고 |prevDep(depHead)=depHead|다. 그렇지 않으면 |link(depHead)|는 첫 종속 변수,
이를테면~|p|를 가리키고 |prevDep(p)=depHead|다. 또 |type(p)=dependent|이고, |depList(p)|는 그 종속 목록을 가리킨다.
그 종속 목록의 마지막 연결이 위치~|q|에 있으면 |link(q)|는 다음 종속 변수(이를테면~|r|)를 가리키고,
|prevDep(r)=q|이다. 나머지도 마찬가지다.

@<정의@>=
func depList(p pointer) pointer       { return link(valueLoc(p)) } // |dependent| 변수의 |value| 필드의 절반
func setDepList(p pointer, v pointer) { setLink(valueLoc(p), v) }
func prevDep(p pointer) pointer       { return info(valueLoc(p)) } // 나머지 절반; 이중 연결 목록을 만든다
func setPrevDep(p pointer, v pointer) { setInfo(valueLoc(p), v) }

const @!depNodeSize = 2 // 종속 노드의 낱말 수

@ @<표의 항목들을...@>=
serialNo = 0
setLink(depHead, depHead)
setPrevDep(depHead, depHead)
setInfo(depHead, null)
setDepList(depHead, null)

@ 실은 위의 설명에는 작은 하얀 거짓말이 들어 있다. 사실은 |protoDependent|라는 다른 종류의 변수가 있는데, 이것은
종속 목록의 $\alpha$ 계수가 분수가 아니라 |scaled|라는 점을 빼고는 |dependent|와 똑같다. 원형 종속 목록은
|depHead|에서 이를 수 있는 노드들에서 종속 목록과 섞여 있다.

@ 다음은 종속 목록을 기호의 꼴로 찍는 프로시저다. 둘째 매개변수는 계수의 눈금을 알리려고 |dependent|나
|protoDependent|여야 한다. 독립 변수의 이름 뒤의 `\.{*4}'는 그 변수가 4배로 늘어난 횟수, 곧 $m/2$만큼 찍힌다.

@<함수들@>=
func printDependency(p pointer, t smallNumber) {
	var v int32 // 계수
	var pp, q pointer // 목록 조작을 위해
	pp = p
	for {
		v = abs(value(p))
		q = info(p)
		if q == null { // 상수항
			if v != 0 || p == pp {
				if value(p) > 0 {
					if p != pp {
						printChar('+')
					}
				}
				printScaled(value(p))
			}
			return
		}
		@<계수가 $\pm1.0$이 아니면 찍는다@>
		if typ(q) != independent {
			confusion("dep")
		}
@:this can't happen dep}{\quad dep@>
		printVariableName(q)
		v = value(q) % sScale
		for v > 0 {
			printStr("*4")
			v = v - 2
		}
		p = link(p)
	}
}

@ @<계수가 $\pm1.0$이 아니면...@>=
if value(p) < 0 {
	printChar('-')
} else if p != pp {
	printChar('+')
}
if t == dependent {
	v = roundFraction(v)
}
if v != unity {
	printScaled(v)
}

@ 주어진 종속 목록에서 계수의 최대 절댓값은 다음 간단한 함수가 돌려준다.

@<함수들@>=
func maxCoef(p pointer) fraction {
	var x fraction // 지금까지의 최댓값
	x = 0
	for info(p) != null {
		if abs(value(p)) > x {
			x = abs(value(p))
		}
		p = link(p)
	}
	return x
}

@ 종속 목록에 필요한 주요 연산 가운데 하나는 한 목록의 배수를 다른 목록에 더하는 것이다. 우리는 그것을
|pPlusFq|라고 부른다. 여기서 |p|와~|q|는 종속 목록을 가리키고 |f|는 분수다.

어떤 독립 변수의 계수가 절댓값으로 |coefBound| 이상이 되면, 이 프로시저는 그 변수의 형을 바꾸어
`|independentNeedingFix|'로 만들고 전역 변수 |fixNeeded|를~|true|로 놓는다. 문턱 $|coefBound|=\mu$의 값은
$\mu^2+\mu<8$이 되도록 고른다. 그러면 우리가 다루는 수가 너무 커지지 않는다. (``최적''인
$\mu=(\sqrt{33}-1)/2\approx2.3723$ 대신 더 안전한 값 7/3을 문턱으로 삼는다.)

앞 문단에서 말한 변경은 실은 전역 변수 |watchCoefs|가 |true|일 때에만 한다. 그러나 대개는 그렇다. 사실 그것이
|false|인 것은 \MF가 곧 0과 같다고 놓을 종속 목록을 만들고 있을 때뿐이다.

프로시저 |pPlusFq|를 비롯해서 종속 목록에 작용하는 여러 프로시저는 만들어 낸 종속 목록의 마지막 (상수항) 노드를 전역
변수 |depFinal|에 넣는다.

@<정의@>=
const (
	@!coefBound = 0o4525252525 // 7/3의 |fraction| 근사
	@!independentNeedingFix = 0
)

@ @<전역 변수@>=
var @!fixNeeded bool // 눈금을 바꾸어야 할 |independent| 변수가 적어도 하나 있나?
var @!watchCoefs bool // |coefBound|를 넘는 계수의 눈금을 바꾸어야 하나?
var @!depFinal pointer // 상수항과 마지막 연결의 위치

@ @<핵심 변수들의...@>=
fixNeeded = false
watchCoefs = true

@ 프로시저 |pPlusFq|에는 넷째 매개변수 |t|가 있는데, |p|가 원형 종속 목록이면 |protoDependent|로 놓아야 한다.
이 경우 |f|는 |fraction|이 아니라 |scaled|가 된다. 비슷하게, 다섯째 매개변수~|tt|는 |q|가 원형 종속 목록이면
|protoDependent|여야 한다.

목록 |q|는 이 연산으로 바뀌지 않는다. 그러나 목록 |p|는 완전히 망가진다.

프로시저 |pPlusFq|가 돌려주는 종속 목록이나 원형 종속 목록의 마지막 연결은 |p|의~원래 마지막 연결과 같다. 실제로 결과의
상수항은 |p|의 원래 상수항과 같은 |mem| 위치에 놓인다.

결과의 계수는 어떤 문턱보다 작으면 0이라고 가정한다. 이것은 피할 수 없는 반올림 오차를 보상하고, 더 많은
변수가 `|known|'이 되게 하는 경향이 있다. 문턱은 보통의 종속 목록이면 대략 $10^{-5}$이고 원형 종속이면 $10^{-4}$이다.

두 목록은 독립 변수의 일련번호가 줄어드는 순서로 정렬되어 있으므로, 덧셈은 정렬된 두 목록을 합치는 일이 된다.

@<정의@>=
const (
	@!fractionThreshold = 2685 // 이보다 작은 |fraction| 계수는 0으로 한다
	@!halfFractionThreshold = 1342 // |fractionThreshold|의 절반
	@!scaledThreshold = 8 // 이보다 작은 |scaled| 계수는 0으로 한다
	@!halfScaledThreshold = 4 // |scaledThreshold|의 절반
)

@ @<함수들@>=
func pPlusFq(p pointer, f int32, q pointer, t, tt smallNumber) pointer {
	var pp, qq pointer // 각각 |info(p)|와 |info(q)|
	var r, s pointer // 목록 조작을 위해
	var threshold int32 // 0의 근방을 정한다
	var v int32 // 임시 레지스터
	if t == dependent {
		threshold = fractionThreshold
	} else {
		threshold = scaledThreshold
	}
	r = tempHead
	pp = info(p)
	qq = info(q)
	for {
		if pp == qq {
			if pp == null {
				break
			}
			@<|p|의 항 하나에 |q|의 해당 항의 |f|배를 더한 것을 보탠다@>
		} else if value(pp) < value(qq) {
			@<|q|의 항 하나에 |f|를 곱한 것을 보탠다@>
		} else {
			setLink(r, p)
			r = p
			p = link(p)
			pp = info(p)
		}
	}
	if t == dependent {
		setValue(p, slowAdd(value(p), takeFraction(value(q), f)))
	} else {
		setValue(p, slowAdd(value(p), takeScaled(value(q), f)))
	}
	setLink(r, p)
	depFinal = p
	return link(tempHead)
}

@ @<|p|의 항 하나에 |q|의 해당 항의 |f|배를...@>=
if tt == dependent {
	v = value(p) + takeFraction(f, value(q))
} else {
	v = value(p) + takeScaled(f, value(q))
}
setValue(p, v)
s = p
p = link(p)
if abs(v) < threshold {
	freeNode(s, depNodeSize)
} else {
	if abs(v) >= coefBound && watchCoefs {
		setType(qq, independentNeedingFix)
		fixNeeded = true
	}
	setLink(r, s)
	r = s
}
pp = info(p)
q = link(q)
qq = info(q)

@ @<|q|의 항 하나에 |f|를 곱한...@>=
if tt == dependent {
	v = takeFraction(f, value(q))
} else {
	v = takeScaled(f, value(q))
}
if abs(v) > half(threshold) {
	s = getNode(depNodeSize)
	setInfo(s, qq)
	setValue(s, v)
	if abs(v) >= coefBound && watchCoefs {
		setType(qq, independentNeedingFix)
		fixNeeded = true
	}
	setLink(r, s)
	r = s
}
q = link(q)
qq = info(q)

@ 분수가 |f=1.0|인 |pPlusFq|의 특별한 경우에는 다른 서브루틴을 두면 편리하다. 이 루틴에서 목록 |p|와 |q|는 같은
형~|t|(|dependent|이거나 |protoDependent|)다.

@<함수들@>=
func pPlusQ(p pointer, q pointer, t smallNumber) pointer {
	var pp, qq pointer // 각각 |info(p)|와 |info(q)|
	var r, s pointer // 목록 조작을 위해
	var threshold int32 // 0의 근방을 정한다
	var v int32 // 임시 레지스터
	if t == dependent {
		threshold = fractionThreshold
	} else {
		threshold = scaledThreshold
	}
	r = tempHead
	pp = info(p)
	qq = info(q)
	for {
		if pp == qq {
			if pp == null {
				break
			}
			@<|p|의 항 하나에 |q|의 해당 항을 더한 것을 보탠다@>
		} else if value(pp) < value(qq) {
			s = getNode(depNodeSize)
			setInfo(s, qq)
			setValue(s, value(q))
			q = link(q)
			qq = info(q)
			setLink(r, s)
			r = s
		} else {
			setLink(r, p)
			r = p
			p = link(p)
			pp = info(p)
		}
	}
	setValue(p, slowAdd(value(p), value(q)))
	setLink(r, p)
	depFinal = p
	return link(tempHead)
}

@ @<|p|의 항 하나에 |q|의 해당 항을...@>=
v = value(p) + value(q)
setValue(p, v)
s = p
p = link(p)
pp = info(p)
if abs(v) < threshold {
	freeNode(s, depNodeSize)
} else {
	if abs(v) >= coefBound && watchCoefs {
		setType(qq, independentNeedingFix)
		fixNeeded = true
	}
	setLink(r, s)
	r = s
}
q = link(q)
qq = info(q)

@ 조금 더 간단한 루틴은 종속 목록에 주어진 상수~|v|를 곱한다. 상수는 |fractionOne|보다 작은 |fraction|이거나
|scaled|다. 뒤의 경우에는 종속 목록을 원형 종속 목록으로 바꾸어야 할 수도 있다. 매개변수 |t0|과 |t1|은 앞과
뒤의 목록 형이다. 이것들은 |t0=dependent|이고 |t1=protoDependent|이고 |vIsScaled=true|인 경우를 빼고는 같아야 한다.

@<함수들@>=
func pTimesV(p pointer, v int32, t0, t1 smallNumber, vIsScaled bool) pointer {
	var r, s pointer // 목록 조작을 위해
	var w int32 // 잠정적인 계수
	var threshold int32
	var scalingDown bool
	if t0 != t1 {
		scalingDown = true
	} else {
		scalingDown = !vIsScaled
	}
	@<새 목록의 형 |t1|에 맞는 문턱을 |threshold|에 놓는다@>
	r = tempHead
	for info(p) != null {
		if scalingDown {
			w = takeFraction(v, value(p))
		} else {
			w = takeScaled(v, value(p))
		}
		@<계수 |w|가 문턱 이하이면 항 |p|를 버리고, 그렇지 않으면 목록 |r| 뒤에 붙인다@>
	}
	setLink(r, p)
	if vIsScaled {
		setValue(p, takeScaled(value(p), v))
	} else {
		setValue(p, takeFraction(value(p), v))
	}
	return link(tempHead)
}

@ 비슷하게, 종속 목록을 주어진 |scaled| 상수로 나누어야 할 때가 있다.

@<함수들@>=
func pOverV(p pointer, v scaled, t0, t1 smallNumber) pointer {
	var r, s pointer // 목록 조작을 위해
	var w int32 // 잠정적인 계수
	var threshold int32
	var scalingDown bool
	if t0 != t1 {
		scalingDown = true
	} else {
		scalingDown = false
	}
	@<새 목록의 형 |t1|에 맞는 문턱을 |threshold|에 놓는다@>
	r = tempHead
	for info(p) != null {
		if scalingDown {
			if abs(v) < 0o2000000 {
				w = makeScaled(value(p), v*0o10000)
			} else {
				w = makeScaled(roundFraction(value(p)), v)
			}
		} else {
			w = makeScaled(value(p), v)
		}
		@<계수 |w|가 문턱 이하이면 항 |p|를 버리고, 그렇지 않으면 목록 |r| 뒤에 붙인다@>
	}
	setLink(r, p)
	setValue(p, makeScaled(value(p), v))
	return link(tempHead)
}

@ 두 프로시저는 계수가 문턱보다 작아진 항을 버린다. 문턱은 결과 목록이 |dependent|인지 |protoDependent|인지에 따라
다르다. 계수가 |coefBound|에 이르면 그 독립 변수의 눈금을 나중에 고쳐야 한다고 표시한다.

@<새 목록의 형 |t1|에...@>=
if t1 == dependent {
	threshold = halfFractionThreshold
} else {
	threshold = halfScaledThreshold
}

@ @<계수 |w|가 문턱 이하이면...@>=
if abs(w) <= threshold {
	s = link(p)
	freeNode(p, depNodeSize)
	p = s
} else {
	if abs(w) >= coefBound {
		fixNeeded = true
		setType(info(p), independentNeedingFix)
	}
	setLink(r, p)
	r = p
	setValue(p, w)
	p = link(p)
}

@ 다음은 종속 목록을 위한 또 하나의 유틸리티 루틴이다. 독립 변수가 종속 변수가 되면, 그것을 이미 있는 모든
종속 관계에서 없애고 싶다. 함수 |pWithXBecomingQ|는 변수~|x|가 |q|로~바뀐 다음의 |p|의~종속 목록을 계산한다.

이 프로시저의 부름 관례는 기본적으로 |pPlusFq|와 같다. 목록~|q|는 바뀌지 않고, 목록~|p|는 망가지고, 상수 노드와
마지막 연결은 |p|에서~물려받고, 넷째 매개변수는 |p|가 |protoDependent|인지 아닌지 알려 준다. 다만 |x|가 목록~|p|에
나타나지 않으면 전역 변수 |depFinal|은 바뀌지 않는다.

@<함수들@>=
func pWithXBecomingQ(p, x, q pointer, t smallNumber) pointer {
	var r, s pointer // 목록 조작을 위해
	var v int32 // |x|의 계수
	var sx int32 // |x|의 일련번호
	s = p
	r = tempHead
	sx = value(x)
	for value(info(s)) > sx {
		r = s
		s = link(s)
	}
	if info(s) != x {
		return p
	}
	setLink(tempHead, p)
	setLink(r, link(s))
	v = value(s)
	freeNode(s, depNodeSize)
	return pPlusFq(link(tempHead), v, q, t, dependent)
}

@ 다음은 변수가 방금 요구되는 범위를 벗어난 알려진 값을 받았을 때 오류를 알리는 간단한 프로시저다.

@<함수들@>=
func valTooBig(x scaled) {
	if internal[warningCheck] > 0 {
		printErr("Value is too large (")
		printScaled(x)
		printChar(')')
@.Value is too large@>
		help4("The equation I just processed has given some variable",
			"a value of 4096 or more. Continue and I'll try to cope",
			"with that big value; but it might be dangerous.",
			"(Set warningcheck:=0 to suppress this message.)")
		reportError()
	}
}

@ 종속 변수가 알려지면 다음 루틴이 그 종속 목록을 없앤다. 여기서 |p|는 변수를 가리키고, |q|는 (노드 하나 길이의)
종속 목록을 가리킨다.

@<함수들@>=
func makeKnown(p, q pointer) {
	var t int32 // 앞의 형; |dependent .. protoDependent|
	setPrevDep(link(q), prevDep(p))
	setLink(prevDep(p), link(q))
	t = typ(p)
	setType(p, known)
	setValue(p, value(q))
	freeNode(q, depNodeSize)
	if abs(value(p)) >= fractionOne {
		valTooBig(value(p))
	}
	if internal[tracingEquations] > 0 {
		if interesting(p) {
			beginDiagnostic()
			printNl("#### ")
@:]]]\#\#\#\#_}{\.{\#\#\#\#}@>
			printVariableName(p)
			printChar('=')
			printScaled(value(p))
			endDiagnostic(false)
		}
	}
	if curExp == p && curType == t {
		curType = known
		curExp = value(p)
		freeNode(p, valueNodeSize)
	}
}

@ 루틴 |fixDependencies|는 |fixNeeded|가 참이 되었을 때 일을 시작한다. 프로그램은 계수를 4로 나누어야 할 독립
변수들의 목록~|s|를 유지한다.

드문 경우에 이 고치기 과정이 계수 하나 이상을 0으로 줄여서, 어떤 변수가 말하자면 저절로 알려지게 될 수도 있다.

@<함수들@>=
func fixDependencies() {
	var p, q, r, s, t pointer // 목록 조작 레지스터들
	var x pointer // 독립 변수
	r = link(depHead)
	s = null
	for r != depHead {
		t = r
		@<변수 |t|의 종속 목록을 훑으며 모든 노드를 고치고, 마지막 연결~|q|로 끝낸다@>
		r = link(q)
		if q == depList(t) {
			makeKnown(t, q)
		}
	}
	for s != null {
		p = link(s)
		x = info(s)
		freeAvail(s)
		s = p
		setType(x, independent)
		setValue(x, value(x)+2)
	}
	fixNeeded = false
}

@ @<정의@>=
const @!independentBeingFixed = 1 // 이 변수는 이미 |s|에 나타난다

@ @<변수 |t|의 종속 목록을 훑으며...@>=
r = valueLoc(t) // |link(r)=depList(t)|
for {
	q = link(r)
	x = info(q)
	if x == null {
		break
	}
	if typ(x) <= independentBeingFixed {
		if typ(x) < independentBeingFixed {
			p = getAvail()
			setLink(p, s)
			s = p
			setInfo(s, x)
			setType(x, independentBeingFixed)
		}
		setValue(q, value(q)/4)
		if value(q) == 0 {
			setLink(r, link(q))
			freeNode(q, depNodeSize)
			q = r
		}
	}
	r = q
}

@ 루틴 |newDep|은 종속 목록~|p|를 값 노드~|q|에 넣고, 그것을 알려진 모든 종속 관계의 목록에 잇는다. 전역 변수 |depFinal|이
목록~|p|의 마지막 노드를 가리킨다고 가정한다.

@<함수들@>=
func newDep(q, p pointer) {
	var r pointer // 첫 종속 관계였던 것
	setDepList(q, p)
	setPrevDep(q, depHead)
	r = link(depHead)
	setLink(depFinal, r)
	setPrevDep(r, depFinal)
	setLink(depHead, q)
}

@ 다음은 종속 목록을 시작하는 방법 가운데 하나다. 루틴 |constDependency|는 상수항만 있는 목록을 만든다.

@<함수들@>=
func constDependency(v scaled) pointer {
	depFinal = getNode(depNodeSize)
	setValue(depFinal, v)
	setInfo(depFinal, null)
	return depFinal
}

@ 그리고 다음은 종속 목록을 맨바닥부터 시작하는 더 재미있는 방법이다. 루틴 |singleDependency|의 매개변수는 독립
변수~|x|의 위치이고, 결과는 간단한 종속 목록 `|x+0|'이다.

주어진 독립 변수가 너무 여러 번 두 배가 되어 0이 아닌 계수로 그것을 가리킬 수 없는 드문 경우에는,
|singleDependency|가 간단한 목록 `0'을 돌려준다. 이 경우는 돌려준 목록 포인터가 |depFinal|과 같은지 검사하면
알아볼 수 있다.

@<함수들@>=
func singleDependency(p pointer) pointer {
	var q pointer // 새 종속 목록
	var m int32 // 두 배가 된 횟수
	m = value(p) % sScale
	if m > 28 {
		return constDependency(0)
	}
	q = getNode(depNodeSize)
	setValue(q, twoToThe[28-m])
	setInfo(q, p)
	setLink(q, constDependency(0))
	return q
}

@ 이따금 종속 목록의 정확한 복사본을 만들어야 한다.

@<함수들@>=
func copyDepList(p pointer) pointer {
	var q pointer // 새 종속 목록
	q = getNode(depNodeSize)
	depFinal = q
	for {
		setInfo(depFinal, info(p))
		setValue(depFinal, value(p))
		if info(depFinal) == null {
			break
		}
		setLink(depFinal, getNode(depNodeSize))
		depFinal = link(depFinal)
		p = link(p)
	}
	return q
}

@ 그러나 변수는 보통 어떻게 알려지게 될까? 아, 이제 방정식 풀이 장치의 심장부에 이르렀다. 프로시저
|linearEq|는 독립 변수가 적어도 하나 나타나는 |dependent|나 |protoDependent| 목록~|p|를 받는다. 이것은 이 목록을
0과 같다고 놓는데, 계수가 가장 큰 독립 변수를 골라 그것을 다른 것들에 종속시킨다. 새로 종속이 된 변수는 현재의
모든 종속 관계에서 소거되고, 그 결과 다른 종속 변수들이 알려지게 될 수도 있다.

계수가 가장 큰 변수를 고르는 것은 가우스 소거에서 부분 피벗을 고르는 것과 같은 생각이다. 그 계수로 나누면
나머지 계수들이 모두 절댓값 1 이하가 되어 수치 오차가 커지지 않는다.

주어진 목록 |p|는 물론 이 처리로 완전히 망가진다.

@<함수들@>=
func linearEq(p pointer, t smallNumber) {
	var q, r, s pointer // 연결 조작을 위해
	var x pointer // 독립성을 잃는 변수
	var n int32 // |x|가 반으로 줄어든 횟수
	var v int32 // 목록 |p|에서 |x|의 계수
	var prevR pointer // |r|보다 한 걸음 뒤처진다
	var finalNode pointer // 새 종속 목록의 상수항
	var w int32 // 잠정적인 계수
	@<목록 |p|에서 계수 |v|가 가장 큰 노드 |q|를 찾는다@>
	x = info(q)
	n = value(x) % sScale
	@<목록 |p|를 |-v|로 나누고, 노드 |q|를 없앤다@>
	if internal[tracingEquations] > 0 {
		@<새 종속 관계를 보인다@>
	}
	@<|x|를 대입해서 이미 있는 모든 종속 관계를 간단하게 한다@>
	@<변수 |x|를 |independent|에서 |dependent|나 |known|으로 바꾼다@>
	if fixNeeded {
		fixDependencies()
	}
}

@ @<목록 |p|에서 계수 |v|가...@>=
q = p
r = link(p)
v = value(q)
for info(r) != null {
	if abs(value(r)) > abs(v) {
		q = r
		v = value(r)
	}
	r = link(r)
}

@ 여기서는 상수항을 빼고 계수들을 |scaled|에서 |fraction|으로 바꾸고 싶다. `\.{x=3.14}' 같은 흔한 하찮은 방정식의
경우에는 |v=-fractionOne|, |q=p|, |t=dependent|가 된다.

@<목록 |p|를 |-v|로 나누고...@>=
s = tempHead
setLink(s, p)
r = p
for {
	if r == q {
		setLink(s, link(r))
		freeNode(r, depNodeSize)
	} else {
		w = makeFraction(value(r), v)
		if abs(w) <= halfFractionThreshold {
			setLink(s, link(r))
			freeNode(r, depNodeSize)
		} else {
			setValue(r, -w)
			s = r
		}
	}
	r = link(s)
	if info(r) == null {
		break
	}
}
if t == protoDependent {
	setValue(r, -makeScaled(value(r), v))
} else if v != -fractionOne {
	setValue(r, -makeFraction(value(r), v))
}
finalNode = r
p = link(tempHead)

@ @<새 종속 관계를 보인다@>=
if interesting(x) {
	beginDiagnostic()
	printNl("## ")
	printVariableName(x)
@:]]]\#\#_}{\.{\#\#}@>
	w = n
	for w > 0 {
		printStr("*4")
		w = w - 2
	}
	printChar('=')
	printDependency(p, dependent)
	endDiagnostic(false)
}

@ @<|x|를 대입해서 이미 있는...@>=
prevR = depHead
r = link(depHead)
for r != depHead {
	s = depList(r)
	q = pWithXBecomingQ(s, x, p, typ(r))
	if info(q) == null {
		makeKnown(r, q)
	} else {
		setDepList(r, q)
		for {
			q = link(q)
			if info(q) == null {
				break
			}
		}
		prevR = q
	}
	r = link(prevR)
}

@ @<변수 |x|를 |independent|에서...@>=
if n > 0 {
	@<목록 |p|를 $2^n$으로 나눈다@>
}
if info(p) == null {
	setType(x, known)
	setValue(x, value(p))
	if abs(value(x)) >= fractionOne {
		valTooBig(value(x))
	}
	freeNode(p, depNodeSize)
	if curExp == x && curType == independent {
		curExp = value(x)
		curType = known
		freeNode(x, valueNodeSize)
	}
} else {
	setType(x, dependent)
	depFinal = finalNode
	newDep(x, p)
	if curExp == x && curType == independent {
		curType = dependent
	}
}

@ @<목록 |p|를 $2^n$으로...@>=
s = tempHead
setLink(tempHead, p)
r = p
for {
	if n > 30 {
		w = 0
	} else {
		w = value(r) / twoToThe[n]
	}
	if abs(w) <= halfFractionThreshold && info(r) != null {
		setLink(s, link(r))
		freeNode(r, depNodeSize)
	} else {
		setValue(r, w)
		s = r
	}
	r = link(s)
	if info(s) == null {
		break
	}
}
p = link(tempHead)

@ 프로시저 |checkMem|은 \MF를 디버깅할 때에만 쓰이는데, 현재의 종속 목록들이 제대로 된 꼴인지 확인한다.

@<일차 종속 관계의 목록을 검사한다@>=
q = depHead
p = link(q)
for p != depHead {
	if prevDep(p) != q {
		printNl("Bad PREVDEP at ")
		printInt(p)
@.Bad PREVDEP...@>
	}
	p = depList(p)
	r = infVal
	for {
		if value(info(p)) >= value(r) {
			printNl("Out of order at ")
			printInt(p)
@.Out of order...@>
		}
		r = info(p)
		q = p
		p = link(q)
		if r == null {
			break
		}
	}
}

@* 동적 비선형 방정식.
수치 형의 변수는 방금 공부한 독립, 종속, 알려진 값의 일반적인 체계로 유지된다. 쌍과 변환 변수의 성분들도
같은 방식으로 다룬다. 그러나 \MF에는 다른 다섯 가지 형의 값도 있다. \KW{boolean}, \KW{string}, \KW{pen},
\KW{path}, \KW{picture}다. 그것들은 어떻게 할까?

비선형인 양 사이의 방정식도 허용되지만 간단한 꼴에서만이다. 아직 값을 받지 않은 두 변수는 서로 같거나, 같지
않거나 둘 가운데 하나다.

불 변수가 값을 받기 전에는 그 형이 |unknownBoolean|이다. 비슷하게 형이 |unknownString|, |unknownPen|,
|unknownPath|, |unknownPicture|인 변수들도 있다. 그런 경우 값은 |null|(이 변수와 같은 다른 변수가 없다는 뜻)이거나,
같은 정의되지 않은 형의 다른 변수를 가리킨다. 뒤의 경우에 포인터들은 노드들의 순환을 이루는데, 그것을 ``고리''라고
부르기로 한다. 정의되지 않은 변수들의 고리에는 캡슐이 들어 있을 수도 있다. 캡슐은 식 안의 중간 결과나 매크로의
\KW{expr} 매개변수로 생긴다.

고리의 한 원소가 값을 받으면 고리의 다른 모든 원소도 같은 값을 받는다. 경로와 그림의 경우에는 이것이 잠재적으로
큰 자료 구조의 복사본을 따로따로 만든다는 뜻이다. 사용자는 메모리 공간이 아주아주 많지 않은 한 그런 일반성에
대한 열의를 억눌러야 한다.

@ 다음 프로시저는 캡슐 노드를 고리에 보탤 때(이를테면 알려지지 않은 변수가 식에서 언급될 때) 불린다.

@<함수들@>=
func newRingEntry(p pointer) pointer {
	var q pointer // 새 캡슐 노드
	q = getNode(valueNodeSize)
	setNameType(q, capsule)
	setType(q, typ(p))
	if value(p) == null {
		setValue(q, p)
	} else {
		setValue(q, value(p))
	}
	setValue(p, q)
	return q
}

@ 거꾸로, 캡슐이나 변수가 알려지기 전에 그것을 지울 수도 있다. 다음 프로시저는 양을 그 고리에서 떼어 내기만
하고 저장 공간은 재활용하지 않는다.

@<함수들@>=
func ringDelete(p pointer) {
	var q pointer
	q = value(p)
	if q != null && q != p {
		for value(q) != p {
			q = value(q)
		}
		setValue(q, value(p))
	}
}

@ 결국에는 고리의 모든 변수에 값을 주는 방정식이 나올 수 있다. 서브루틴 |nonlinearEq|가 값을 퍼뜨리는 데 필요한
일을 한다.

매개변수 |flushP|가 |true|이면 노드 |p| 자신은 값을 받지 않아도 된다. 곧 재활용될 것이기 때문이다.

@<함수들@>=
func nonlinearEq(v int32, p pointer, flushP bool) {
	var t smallNumber // 고리 |p|의 형
	var q, r pointer // 연결 조작 레지스터들
	t = typ(p) - unknownTag
	q = value(p)
	if flushP {
		setType(p, vacuous)
	} else {
		p = q
	}
	for {
		r = value(q)
		setType(q, t)
		switch t {
		case booleanType:
			setValue(q, v)
		case stringType:
			setValue(q, v)
			addStrRef(v)
		case penType:
			setValue(q, v)
			addPenRef(v)
		case pathType:
			setValue(q, copyPath(v))
		case pictureType:
			setValue(q, copyEdges(v))
		} // 더는 경우가 없다
		q = r
		if q == p {
			break
		}
	}
}

@ 고리의 원소 둘을 같다고 놓고 그것들의 형이 같으면 프로시저 |ringMerge|를 불러 둘을 같게 만든다. 두 고리를
합치는 것은 두 원소의 |value| 포인터를 맞바꾸기만 하면 된다. 순환 목록 둘이 하나로 이어지기 때문이다.

@<함수들@>=
func ringMerge(p, q pointer) {
	var r pointer // 한 목록을 훑는다
	r = value(p)
	for r != p {
		if r == q {
			@<중복된 방정식에 감탄한다@>
			return
		}
		r = value(r)
	}
	r = value(p)
	setValue(p, value(q))
	setValue(q, r)
}

@ @<중복된 방정식에...@>=
printErr("Redundant equation")
@.Redundant equation@>
help2("I already knew that this equation was true.",
	"But perhaps no harm has been done; let's continue.")
putGetError()

@* 구문 루틴 들어가기.
잠시 멈추고 큰 그림을 보도록 하자. \MF\ 프로그램은 크게 세 부분으로 이루어진다. 구문 루틴, 의미 루틴, 출력
루틴이다. 구문 루틴의 주된 목적은 사용자의 입력을 의미 루틴에 넘겨주면서 식을 구문 분석하고 연산자와 피연산자를
찾아내는 것이다. 의미 루틴은 이 연산자들에 응답하는 해석기 노릇을 하는데, 연산자들은 명령으로 볼 수 있다.
그리고 출력 루틴은 때때로 불려서 조판이나 중간 교정 그림에 쓸 수 있는 간결한 글꼴 서술을 만든다. 기본 자료
구조와 의미 연산의 세부 가운데 많은 것을 논의했으니, 이제 \MF의 활동을 실제로 다스리는 부분으로 뛰어들 준비가
충분히 되었다.

지금의 목표는 \MF\ 입력 장치의 쐐기돌인 |getNext| 프로시저와 씨름하는 것이다. 이 프로시저를 부를 때마다 다음
입력 토큰을 나타내는 세 변수 |curCmd|, |curMod|, |curSym|의 값이 정해진다.
$$\vbox{\halign{#\hfil\cr
  \hbox{|curCmd|는 앞에서 준 긴 코드 목록의 명령 코드를 나타낸다;}\cr
  \hbox{|curMod|는 명령 코드의 수식자를 나타낸다;}\cr
  \hbox{|curSym|은 방금 훑은 기호 토큰의 해시 주소이고,}\cr
  \hbox{\qquad 수치나 문자열이나 캡슐 토큰이면 0이다.}\cr}}$$
프로시저 |getNext|의 이런 바깥 행동 밑에는 문자 파일을 토큰으로 바꾸는 데 필요한 모든 장치가 깔려 있다. 어느 때든 우리는
(\KW{input}을 지정한) 여러 파일을 읽다가 만 상태일 수도 있고, 사용자가 정의한 어떤 매크로나 매크로 매개변수를
펼치다가 만 상태일 수도 있고, 사용자가 온라인으로 끼워 넣은 텍스트를 읽다가 만 상태일 수도 있다. 문자 파일을 읽을
때는 문자들을 토큰으로 바꾸어야 한다. 주석과 공백은 없애야 하고, 수치와 문자열 토큰은 값을 계산해야 한다.

이 모든 상황이 한꺼번에 있을 수도 있는데, 그것들을 다루려고 \MF는 마치지 않은 활동에 관한 정보를 담은 여러
스택을 쓰고, 입력 장치의 각 수준마다 유한 상태 제어가 있다. 이 스택들은 암묵적으로 재귀적인 과정의 현재 상태를
기록하지만, |getNext| 프로시저 자체는 재귀적이지 않다.

@<전역 변수@>=
var @!curCmd eightBits // |getNext|가 정한 현재 명령
var @!curMod int32 // 현재 명령의 피연산자
var @!curSym halfword // 현재 기호의 해시 주소

@ 루틴 |printCmdMod|는 명령 코드와 그 수식자를 기호로 풀어 찍는다. 이것은 꽤 지루한 찍기 명령의 나열인데,
대부분은 \MF\ 원시 명령을 |hash|와 |eqtb|에 넣는 |primitive| 루틴의 본질적인 역이다. 그래서 이 프로시저의
거의 모든 부분이 프로그램의 다른 곳에서 해당하는 |primitive| 호출과 함께 나타난다.

@<함수들@>=
func printCmdMod(c, m int32) {
	switch c {
	@<|printCmdMod|에서 원시 명령을...@>
	default:
		printStr("[unknown command code!]")
	}
}

@ 다음은 주어진 명령을 중괄호에 싸서 사용자의 기록 파일에 보이는 프로시저다.

@<함수들@>=
func showCmdMod(c, m int32) {
	beginDiagnostic()
	printNl("{")
	printCmdMod(c, m)
	printChar('}')
	endDiagnostic(false)
}

func showCurCmdMod() { showCmdMod(curCmd, curMod) }

@* 입력 스택과 상태.
\MF\ 입력 장치의 상태는 입력 스택에 나타난다. 그 항목들은 |index|, |start|, |loc|, |limit|, |name|이라는 다섯
필드를 가진 레코드다. 이 스택의 맨 위 원소는 첨자를 쓰지 않아도 되는 전역 변수에 유지되고, 스택의 다른 원소들은
배열에 나타난다. 그래서 스택은 다음과 같이 선언한다.

@<전역 형@>=
type @!inStateRecord struct {
	@!indexField quarterword
	@!startField, @!locField, @!limitField, @!nameField halfword
}

@ @<전역 변수@>=
var @!inputStack [stackSize + 1]inStateRecord
var @!inputPtr int32 // |inputStack|에서 쓰이지 않는 첫 위치; |0 .. stackSize|
var @!maxInStack int32 // 쌓을 때 |inputPtr|의 가장 큰 값; |0 .. stackSize|

@ \seclabel{cur-input}기본 입출력 루틴을 논의할 때 이미 특별한 변수 |loc|을 썼다. ``맨 위'' 입력 상태의 다른
구성 요소들도 |loc|처럼 저마다 전역 변수다. 그것들을 통째로 다룰 때는 함수 |curInput()|과 |setCurInput(r)|을 쓴다.

@<전역 변수@>=
var @!index quarterword // 버퍼 정보를 가리키는 참조
var @!start halfword // |buffer|에서 시작 위치
var @!loc halfword // |buffer|에서 읽지 않은 첫 문자의 위치
var @!limit halfword // |buffer|에서 현재 줄의 끝
var @!name halfword // 현재 파일의 이름

func curInput() inStateRecord { // ``맨 위'' 입력 상태
	return inStateRecord{index, start, loc, limit, name}
}

func setCurInput(r inStateRecord) {
	index, start, loc = r.indexField, r.startField, r.locField
	limit, name = r.limitField, r.nameField
}

@ 이제 \MF가 어떤 파일이나 사용자의 터미널에서 입력된 문자들의 줄을 읽고 있다고 가정하고 다섯 제어 변수
(|index|,~|start|,~|loc|,~|limit|,~|name|)를 더 자세히 살펴보자. 배열 |buffer|가 있는데, 이것은 지금 파일에서 읽고
있는 모든 문자 줄의 스택 노릇을 한다. 입력 스택의 아래 수준에서 아직 끝나지 않은 줄들도 모두 여기 들어 있다.
\MF는 지금의 입력 파일을 다 읽으면 다른 줄들로 돌아간다.

(덧붙여 말하면, 바이트 단위로 주소를 매기는 기계에서는 |buffer|를 배열 |strPool|과 합쳐서, 버퍼 항목들이 문자열
풀의 꼭대기에서 아래로 자라게 하고 이 두 표가 서로 부딪치지 않는지 검사하는 것이 알맞을 수도 있다.)

우리가 지금 다루는 줄은 버퍼의 위치 |start|에서 시작한다. 다음에 읽으려는 문자는 |buffer[loc]|이고, |limit|는
있는 마지막 문자의 위치다. 언제나 |loc<=limit|이다. 편의를 위해 |buffer[limit]|는 |'%'|로 놓아 두었으므로, 줄의
끝을 쉽게 알아챌 수 있다.

변수 |name|은 텍스트 파일을 읽고 있으면 현재 파일의 이름을 가리키는 문자열 번호다. 보통의 입력을 위해 터미널에서
읽고 있으면 0이고, \KW{readstring} 명령을 실행하고 있으면 1이고, \KW{scantokens}가 버퍼로 옮긴 문자열을 읽고
있으면 2다.

@ 현재 줄에 관한 추가 정보는 |index| 변수로 얻을 수 있다. 이것은 현재 수준 아래에서 버퍼에 들어 있는 문자 줄의
수를 센다. 터미널에서 읽으면서 줄마다 사용자에게 재촉할 때는 |index=0|이다. 그다음 사용자가 이를테면
`\.{input font}'를 치면 파일 \.{font.mf}를 읽는 동안 |index=1|이 된다. 그러나 |index|가 입력 스택 포인터와 같은
것은 아니다. 입력 스택의 수준 가운데 많은 것이 토큰 목록에서 올 수 있기 때문이다.

전역 변수 |inOpen|은 토큰 목록이 아닌 가장 높은 수준의 |index| 값과 같다. 그러므로 버퍼에 있는 읽다가 만 줄의
수는 |inOpen+1|이고, 토큰 목록을 읽고 있지 않으면 |inOpen=index|이다.

지금 터미널에서 읽고 있지 않으면 파일 변수 |inputFile[index]|에서 읽고 있다. 편리한 약어로 |name=0| 대신
|terminalInput()|이라고 쓰고, |inputFile[index]|를 가리키는 포인터는 |curFile()|이라고 쓴다.

전역 변수 |line|에는 맨 위에 열린 파일에서의 줄 번호가 들어 있는데, 오류 메시지에 쓴다. 터미널에서 읽고 있지
않으면 |lineStack[index]|에 둘러싼 수준의 줄 번호가 들어 있어서, 현재 파일을 다 읽으면 |line|을 되돌릴 수 있다.

입력 상태에 관한 정보가 더 필요하면 여기 보인 것 같은 작은 배열에 넣을 수 있다. 이를테면 입력 파일의 현재 쪽
번호나 조각 번호를 변수 |page|에 넣고, |lineStack|에 견주어 둘러싼 수준을 위해 |pageStack [maxInOpen+1]int32|에
유지할 수 있을 것이다.
@^system dependencies@>

@<정의@>=
func terminalInput() bool    { return name == 0 } // 터미널에서 읽고 있나?
func curFile() *alphaFile    { return &inputFile[index] } // 현재의 |alphaFile| 변수

@ @<전역 변수@>=
var @!inOpen int32 // 버퍼에 있는 줄의 수에서 1을 뺀 것; |0 .. maxInOpen|
var @!openParens int32 // 열린 텍스트 파일의 수; |0 .. maxInOpen|
var @!inputFile [maxInOpen + 1]alphaFile // 첨자는 |1 .. maxInOpen|
var @!line int32 // 현재 소스 파일에서의 현재 줄 번호
var @!lineStack [maxInOpen + 1]int32 // 첨자는 |1 .. maxInOpen|

@ 그러나 입력 상태에 관한 이 모든 논의는 실은 파일에서 입력을 받는 경우에만 들어맞는다. 또 하나의 중요한 경우,
곧 토큰 목록에서 입력을 받는 경우가 있다. 이 경우에는 |index>maxInOpen|이고, 다른 상태 변수에 관한 관례가 다르다.

\yskip\hang 변수 |loc|은 토큰 목록에서 현재 노드, 곧 다음에 읽을 노드를 가리키는 포인터다. 또 |loc=null|이면 토큰 목록을
다 읽은 것이다.

\yskip\hang 변수 |start|는 토큰 목록의 첫 노드를 가리킨다. 이 노드에는 관련된 토큰 목록의 종류에 따라 참조 횟수가 들어
있을 수도 있고 없을 수도 있다.

\yskip\hang 변수 |tokenType|은 앞의 논의에서 |index|의 자리를 차지하는데, 지금 훑고 있는 토큰 목록이 어떤 종류인지
설명하는 코드 번호다.

\yskip\hang 변수 |name|은 현재 토큰 목록이 \KW{vardef}로 정의하지 않은 매크로이면 펼치고 있는 매크로의 |eqtb| 주소를
가리킨다. \KW{vardef}로 정의한 매크로는 |name=null|이다. 그 이름은 처음 두 매개변수를 보면 알아낼 수 있다.

\yskip\hang 변수 |paramStart|는 |limit|의 자리를 차지하는데, 현재 매크로나 루프 텍스트의 매개변수가 |paramStack|의
어디서 시작하는지 알려 준다.

\yskip\noindent 변수 |tokenType|은 현재 토큰 목록이 어디서 왔는지에 따라 여러 값을 가질 수 있다.

\yskip
\indent|foreverText|, 훑고 있는 토큰 목록이 \KW{forever} 루프의 몸체이면;

\indent|loopText|, 훑고 있는 토큰 목록이 \KW{for}나 \KW{forsuffixes} 루프의 몸체이면;

\indent|parameter|, \KW{text}나 \KW{suffix} 매개변수를 훑고 있으면;

\indent|backedUp|, 훑고 있는 토큰 목록을 `다시 읽도록' 끼워 넣었으면;

\indent|inserted|, 훑고 있는 토큰 목록을 오류 회복의 일부로 끼워 넣었으면;

\indent|macro|, 사용자가 정의한 기호 토큰의 펼침을 훑고 있으면.

\yskip\noindent
토큰 목록은 |tokenType=macro|일 때, 그리고 오직 그때에만 참조 횟수로 시작한다.
@^reference counts@>

@<정의@>=
func tokenType() quarterword          { return index } // 현재 토큰 목록의 종류
func setTokenType(t quarterword)      { index = t }
func tokenState() bool                { return index > maxInOpen } // 토큰 목록을 훑고 있나?
func fileState() bool                 { return index <= maxInOpen } // 파일의 줄을 훑고 있나?
func paramStart() halfword            { return limit } // |paramStack|에서 매크로 매개변수의 기준
func setParamStart(v halfword)        { limit = v }

const (
	@!foreverText = maxInOpen + 1 // 루프 텍스트의 |tokenType| 코드
	@!loopText = maxInOpen + 2 // 루프 텍스트의 |tokenType| 코드
	@!parameter = maxInOpen + 3 // 매개변수 텍스트의 |tokenType| 코드
	@!backedUp = maxInOpen + 4 // 다시 읽을 텍스트의 |tokenType| 코드
	@!inserted = maxInOpen + 5 // 끼워 넣은 텍스트의 |tokenType| 코드
	@!macro = maxInOpen + 6 // 매크로 바꿈 텍스트의 |tokenType| 코드
)

@ 스택 |paramStack|은 현재 수준과 그 아래 수준의 입력에서 매개변수를 위한 토큰 목록을 가리키는 포인터들을 담는 보조
배열이다. 이 스택은 다른 스택들과 다른 속도로 자란다.

@<전역 변수@>=
var @!paramStack [paramSize + 1]pointer // 매개변수를 위한 토큰 목록 포인터들
var @!paramPtr int32 // |paramStack|에서 쓰이지 않는 첫 항목; |0 .. paramSize|
var @!maxParamStack int32 // |paramPtr|의 가장 큰 값

@ 그러므로 ``현재 입력 상태''는 정말로 아주 복잡할 수 있다. 수준이 여럿일 수 있고 각 수준은 여러 방식으로 생길 수
있다. \MF의 오류 알리기 루틴이 입력 파일의 가장 최근 문자 줄까지 모든 수준에서 현재 입력 상태를 찍는 데 쓰는
프로시저 |showContext|는 이 관례들 대부분을 잘 보여 준다. 전역 변수 |filePtr|에는 이 프로시저가 보인 가장 낮은
수준이 들어 있다.

@<전역 변수@>=
var @!filePtr int32 // |showContext|가 보인 가장 얕은 수준; |0 .. stackSize|

@ 각 수준의 상태는 두 줄을 찍어서 나타낸다. 첫 줄은 지금까지 읽은 것을 가리키고 둘째 줄은 아직 읽을 것을 보인다.
필요하면 문맥을 잘라서 첫 줄에는 많아야 |halfErrorLine|개의 문자가, 둘째 줄에는 많아야 |errorLine|개가 들어가게
한다. 현재가 아닌 입력 수준 가운데 |tokenType|이 `|backedUp|'인 것은 다 읽지 않았을 때에만 보인다.

@<함수들@>=
func showContext() { // 훑개가 어디 있는지 찍는다
	var oldSetting int32 // 저장한 |selector| 설정; |0 .. maxSelector|
	@<형식 계산을 위한 지역 변수@>
	filePtr = inputPtr
	inputStack[filePtr] = curInput() // 현재 상태를 저장한다
	for {
		setCurInput(inputStack[filePtr]) // 문맥에 들어간다
		@<현재 문맥을 보인다@>
		if fileState() {
			if name > 2 || filePtr == 0 {
				break
			}
		}
		filePtr--
	}
	setCurInput(inputStack[inputPtr]) // 원래 상태를 되돌린다
}

@ @<현재 문맥을 보인다@>=
if filePtr == inputPtr || fileState() || tokenType() != backedUp || loc != null {
	@t\qquad@>// 이미 읽은 되돌린 토큰 목록은 생략한다
	tally = 0 // 문자를 셀 준비를 한다
	oldSetting = selector
	if fileState() {
		@<현재 줄의 위치를 찍는다@>
		@<그 줄을 흉내 찍는다@>
	} else {
		@<토큰 목록의 종류를 찍는다@>
		@<그 토큰 목록을 흉내 찍는다@>
	}
	selector = oldSetting // 흉내 찍기를 멈춘다
	@<흉내 찍은 정보를 써서 교묘하게 두 줄을 찍는다@>
}

@ 이 루틴은 필요하면 바꾸어서, 현재 줄이 입력 파일의 어디에 있는지 될 수 있는 대로 잘 보이게 해야 한다. 이를테면
어떤 시스템에서는 쪽 번호와 줄 번호를 둘 다 찍는 것이 가장 좋다.
@^system dependencies@>

@<현재 줄의 위치를...@>=
if name <= 1 {
	if terminalInput() && filePtr == 0 {
		printNl("<*>")
	} else {
		printNl("<insert>")
	}
} else if name == 2 {
	printNl("<scantokens>")
} else {
	printNl("l.")
	printInt(line)
}
printChar(' ')

@ @<토큰 목록의 종류를...@>=
switch tokenType() {
case foreverText:
	printNl("<forever> ")
case loopText:
	@<현재 루프 값을 찍는다@>
case parameter:
	printNl("<argument> ")
case backedUp:
	if loc == null {
		printNl("<recently read> ")
	} else {
		printNl("<to be read again> ")
	}
case inserted:
	printNl("<inserted text> ")
case macro:
	printLn()
	if name != null {
		slowPrint(text(name))
	} else {
		@<\KW{vardef}로 정의한 매크로의 이름을 찍는다@>
	}
	printStr("->")
default:
	printNl("?") // 이런 일은 결코 일어나지 않아야 한다
@.?\relax@>
}

@ 루프 텍스트에 해당하는 매개변수는 (\KW{forsuffixes}의 경우) 토큰 목록이거나 (\KW{for}의 경우) ``캡슐''이다.
캡슐은 나중에 논의할 것이다. 지금은 캡슐 매개변수의 |link| 필드가 |void|이고, |printExp(p,0)|이 캡슐~|p|의 값을
줄인 꼴로 보인다는 것만 알면 된다.

@<현재 루프 값을...@>=
printNl("<for(")
p = paramStack[paramStart()]
if p != null {
	if link(p) == void {
		printExp(p, 0) // \KW{for} 루프 안에 있다
	} else {
		showTokenList(p, null, 20, tally)
	}
}
printStr(")> ")

@ \KW{vardef}로 정의한 매크로의 처음 두 매개변수는 매크로의 앞머리와 ``위치 표시''(at point)를 나타내는
토큰 목록이다. 그것들을 이어 붙이면 매크로의 온전한 이름을 얻는다.

@<\KW{vardef}로 정의한 매크로의...@>=
p = paramStack[paramStart()]
if p == null {
	showTokenList(paramStack[paramStart()+1], null, 20, tally)
} else {
	q = p
	for link(q) != null {
		q = link(q)
	}
	setLink(q, paramStack[paramStart()+1])
	showTokenList(p, null, 20, tally)
	setLink(q, null)
}

@ 이제 작은 꾀 하나를 설명해야 한다. 토큰 목록에 해당하는 긴 문자열은 저장하고 싶지 않다. 그 문자열은 메모리를
많이 차지할 수 있고, 우리는 오류 메시지를 내는 동안 찍고 있으므로 \MF의 표 가운데 어느 것이든 넘치게 할 만한
일은 감히 할 수 없다. 그래서 `흉내 찍기'가 답이다. 우리는 문자들을 길이 |errorLine|인 버퍼에 저장하는 찍기
방식에 들어간다. 만일 |k<trickCount|이면 문자 $k+1$을 \hbox{|trickBuf[k%errorLine]|}에 넣고, 그렇지 않으면 문자
|k|를 버린다. 처음에 |tally=0|과 |trickCount=1000000|으로 놓는다. 그다음 첫 줄에서 둘째 줄로 넘어가야 할 지점에
이르면 |firstCount=tally|와 |trickCount=@tmax@>(errorLine,tally+1+errorLine-halfErrorLine)|으로 놓는다. 흉내 찍기가
끝나면 |firstCount|, |tally|, |trickCount|의 값이 두 줄을 찍는 데 필요한 정보를 모두 주고, 필요한 텍스트는 모두
|trickBuf|에 있다.

첫 줄에 나타나는 설명 정보의 길이를 |l|이라고 하자. 그 줄을 위해 모은 문맥 정보의 길이는 |k=firstCount|이고,
둘째 줄을 위해 모은 문맥 정보의 길이는 $m=\min(|tally|, |trickCount|)-k$다. 그리고 |h=halfErrorLine|이라고 할 때
|l+k<=h|이면, 첫 줄의 설명 정보 뒤에 |trickBuf[0 .. k-1]|을 찍고 |n=l+k|로 놓는다. 여기서 |n|은 첫 줄의 길이다.
그러나 $l+k>h$이면 잘라 내야 하므로 |n=h|로 놓고 `\.{...}'와 그 뒤에
$$\hbox{|trickBuf[(l+k-h+3) .. k-1]|}$$
을 찍는다. 여기서 |trickBuf|의 첨자는 |errorLine|을 법으로 하는 순환이다. 둘째 줄은 |n|개의~공백과 그 뒤의
|trickBuf[k .. (k+m-1)]|로 이루어지는데, |n+m>errorLine|이면 더 잘라 낸다. 이것은 설명하기보다 짜기가 쉽다.

@<형식 계산을 위한...@>=
var i int32 // |buffer|의 첨자; |0 .. bufSize|
var l int32 // 첫 줄의 설명 정보의 길이
var m int32 // 둘째 줄을 위해 모은 문맥 정보
var n int32 // 첫 줄의 길이; |0 .. errorLine|
var p int32 // |trickBuf|에서 시작하거나 끝나는 곳
var q int32 // 임시 첨자

@ 다음 함수들은 찍기 루틴들에 원하는 정보를 모으라고 알린다. 흉내 찍기를 시작하는 함수
|beginPseudoprint|는 그때까지의 |tally|, 곧 첫 줄의 설명 정보의 길이를 돌려준다.

@<함수들@>=
func beginPseudoprint() (l int32) {
	l = tally
	tally = 0
	selector = pseudo
	trickCount = 1000000
	return
}

func setTrickCount() {
	firstCount = tally
	trickCount = tally + 1 + errorLine - halfErrorLine
	if trickCount < errorLine {
		trickCount = errorLine
	}
}

@ 그리고 다음 코드는 모은 정보를 쓴다.

@<흉내 찍은 정보를 써서...@>=
if trickCount == 1000000 {
	setTrickCount() // |setTrickCount|를 해야 한다
}
if tally < trickCount {
	m = tally - firstCount
} else {
	m = trickCount - firstCount // 둘째 줄의 문맥
}
if l+firstCount <= halfErrorLine {
	p = 0
	n = l + firstCount
} else {
	printStr("...")
	p = l + firstCount - halfErrorLine + 3
	n = halfErrorLine
}
for q = p; q <= firstCount-1; q++ {
	printChar(trickBuf[q%errorLine])
}
printLn()
for q = 1; q <= n; q++ {
	printChar(' ') // 둘째 줄을 시작하는 공백 |n|개를 찍는다
}
if m+n <= errorLine {
	p = firstCount + m
} else {
	p = firstCount + (errorLine - n - 3)
}
for q = firstCount; q <= p-1; q++ {
	printChar(trickBuf[q%errorLine])
}
if m+n > errorLine {
	printStr("...")
}

@ 그러나 그 꾀가 우리의 현재 목표, 곧 입력 상태를 이해하는 데서 눈을 돌리게 한다. 그러니 |showContext| 프로시저를
마무리하면서 흉내 찍는 자료 구조에 집중하자.

@<그 줄을 흉내 찍는다@>=
l = beginPseudoprint()
if limit > 0 {
	for i = start; i <= limit-1; i++ {
		if i == loc {
			setTrickCount()
		}
		printStr(buffer[i])
	}
}

@ @<그 토큰 목록을 흉내...@>=
l = beginPseudoprint()
if tokenType() != macro {
	showTokenList(start, loc, 100000, 0)
} else {
	showMacro(start, loc, 100000)
}

@ 다음은 줄~2를 시작하는 토큰을 보이려 할 때 작동하는 |showTokenList|의 빠진 조각이다.

@<마법 같은 계산을...@>=
setTrickCount()

@* 입력 스택 관리하기.
다음 서브루틴들은 흔히 필요한 방식으로 입력 상태를 바꾼다.

먼저 |pushInput|은 현재 상태를 저장하고 (처음에는 옛것과 같은 성질을 가진) 새 수준을 만든다.

@<정의@>=
func pushInput() { // 새 입력 수준에 들어가고 옛것을 저장한다
	if inputPtr > maxInStack {
		maxInStack = inputPtr
		if inputPtr == stackSize {
			overflow("input stack size", stackSize)
		}
@:METAFONT capacity exceeded input stack size}{\quad input stack size@>
	}
	inputStack[inputPtr] = curInput() // 레코드를 쌓는다
	inputPtr++
}

@ 그리고 물론 올라간 것은 내려와야 한다.

@<정의@>=
func popInput() { // 입력 수준을 떠나 옛것에 다시 들어간다
	inputPtr--
	setCurInput(inputStack[inputPtr])
}

@ 다음은 토큰 목록 |p|와 그 형 |t|가 주어지면 토큰 목록 입력의 새 수준을 시작하는 프로시저다. 형이 |t=macro|이면
부르는 루틴이 |name|을 정하고, |loc|을~다시 정하고, 매크로의 참조 횟수를 늘려야 한다.

@<함수들@>=
func beginTokenList(p pointer, t quarterword) {
	pushInput()
	start = p
	setTokenType(t)
	setParamStart(paramPtr)
	loc = p
}

func backList(p pointer) { beginTokenList(p, backedUp) } // 간단한 토큰 목록을 되돌린다

@ 토큰 목록을 다 훑었으면 그 입력 수준을 떠나면서 다음 계산을 해야 한다.
@^inner loop@>

@<함수들@>=
func endTokenList() { // 토큰 목록 입력 수준을 떠난다
	var p pointer // 임시 레지스터
	if tokenType() >= backedUp { // 지울 토큰 목록
		if tokenType() <= inserted {
			flushTokenList(start)
			goto done
		}
		deleteMacRef(start) // 참조 횟수를 고친다
	}
	for paramPtr > paramStart() { // 매개변수들을 치워야 한다
		paramPtr--
		p = paramStack[paramPtr]
		if p != null {
			if link(p) == void { // \KW{expr} 매개변수다
				recycleValue(p)
				freeNode(p, valueNodeSize)
			} else {
				flushTokenList(p) // \KW{suffix}나 \KW{text} 매개변수다
			}
		}
	}
done:
	popInput()
	checkInterrupt()
}

@ 세 변수 |curCmd,curMod,curSym|의 내용은 루틴 |curTok|이 그와 같은 토큰으로 바꾸어 놓는다.
@^inner loop@>

@<함수들@>=
func curTok() pointer {
	var p pointer // 새 토큰 노드
	var saveType smallNumber // 되돌릴 |curType|
	var saveExp int32 // 되돌릴 |curExp|
	if curSym == 0 {
		if curCmd == capsuleToken {
			saveType = curType
			saveExp = curExp
			makeExpCopy(curMod)
			p = stashCurExp()
			setLink(p, null)
			curType = saveType
			curExp = saveExp
		} else {
			p = getNode(tokenNodeSize)
			setValue(p, curMod)
			setNameType(p, token)
			if curCmd == numericToken {
				setType(p, known)
			} else {
				setType(p, stringType)
			}
		}
	} else {
		p = fastGetAvail()
		setInfo(p, curSym)
	}
	return p
}

@ 이따금 \MF는 너무 멀리 읽어서 본 것을 ``되훑고'' 싶어 한다. 프로시저 |backInput|이 이 일을 맡는데, 방금 훑은
토큰을 입력 흐름에 되돌려 놓아 다시 읽을 수 있게 한다. 만일 |curSym!=0|이면 |curCmd|와 |curMod|의 값은 상관없다.

@<함수들@>=
func backInput() { // 입력 토큰 하나를 무른다
	var p pointer // 길이가 1인 토큰 목록
	p = curTok()
	for tokenState() && loc == null {
		endTokenList() // 스택 공간을 아낀다
	}
	backList(p)
}

@ 루틴 |backError|는 오류 메시지를 내기 바로 전에 잘못된 토큰을 되돌리거나 바꾸고 싶을 때 쓴다. 도움말이
사라지지 않도록 |backInput|을 부르는 동안에는 끼어들기를 막는다.

@<함수들@>=
func backError() { // 토큰 하나를 되돌리고 |reportError|를 부른다
	okToInterrupt = false
	backInput()
	okToInterrupt = true
	reportError()
}

func insError() { // 끼워 넣은 토큰 하나를 되돌리고 |reportError|를 부른다
	okToInterrupt = false
	backInput()
	setTokenType(inserted)
	okToInterrupt = true
	reportError()
}

@ 프로시저 |beginFileReading|은 파일에서 읽거나 터미널에서 끼워 넣을 문자 줄을 위한 새 입력 수준을 시작한다.
파일을 여는 일은 하지 않고, |loc|이나 |limit|나 |line|도 정하지 않는다.
@^system dependencies@>

@<함수들@>=
func beginFileReading() {
	if inOpen == maxInOpen {
		overflow("text input levels", maxInOpen)
	}
@:METAFONT capacity exceeded text input levels}{\quad text input levels@>
	if first == bufSize {
		overflow("buffer size", bufSize)
	}
@:METAFONT capacity exceeded buffer size}{\quad buffer size@>
	inOpen++
	pushInput()
	index = inOpen
	lineStack[index] = line
	start = first
	name = 0 // 이제 |terminalInput()|이 |true|다
}

@ 거꾸로, 그런 입력 수준을 마치면 변수들을 되돌려야 한다.

@<함수들@>=
func endFileReading() {
	first = start
	line = lineStack[index]
	if index != inOpen {
		confusion("endinput")
	}
@:this can't happen endinput}{\quad endinput@>
	if name > 2 {
		aClose(curFile()) // 그것을 잊는다
	}
	popInput()
	inOpen--
}

@ 끼워 넣은 `\.{show}' 명령이 오래 이어지는 동안 스택이 넘치지 않도록, 다음 루틴은 오류 때 끼워 넣은 다 읽은
줄들을 메모리에서 치운다.

@<함수들@>=
func clearForErrorPrompt() {
	for fileState() && terminalInput() && inputPtr > 0 && loc == limit {
		endFileReading()
	}
	printLn()
	clearTerminal()
}

@ \MF의 입력 장치 전체를 움직이려면 다음 일들을 한다.

@<입력 루틴들을 초기화한다@>=
inputPtr = 0
maxInStack = 0
inOpen = 0
openParens = 0
maxBufStack = 0
paramPtr = 0
maxParamStack = 0
first = 1
start = 1
index = 0
line = 0
name = 0
forceEOF = false
if !initTerminal() {
	goto finalEnd
}
limit = last
first = last + 1 // |initTerminal|이 |loc|과 |last|를 정했다

@* 다음 토큰 얻기.
\MF\ 입력 장치의 심장은 |getNext| 프로시저인데, 프로그램의 다음 몇 절에서 이것을 전개한다. 그러나 이것을
``심장''이라고 부르는 것은 아마 옳지 않을 것이다. 그것은 실은 \MF의 눈과 입 노릇을 해서, 소스 파일을 읽고
게걸스럽게 먹어 치운다. 그리고 다시 처리할 저장된 토큰 목록을 \MF가 되새김질하는 것도 돕는다.

프로시저 |getNext|의 주된 임무는 토큰 하나를 입력하고 |curCmd|와 |curMod|를 그 토큰의 명령 코드와 수식자로 놓는 것이다.
게다가 입력 토큰이 기호 토큰이면 그 토큰의 |hash| 주소를 |curSym|에 저장하고, 그렇지 않으면 |curSym|을 0으로 놓는다.

이 간단한 설명 밑에는 다루어야 할 모든 경우 때문에 얼마쯤의 복잡함이 깔려 있다. 그러나 |getNext|의 안쪽 루프는
꽤 짧고 빠르다.

@ 프로시저 |getNext|에 들어가기 전에, 오류가 너무 멀리 퍼지지 않도록 \MF가 돕는 장치를 생각해야 한다. 프로그램이 어떤
조건이 만족될 때까지 |getNext|를 거듭 부르는 방식에 들어갈 때마다 |scannerStatus|를 |normal|이 아닌 어떤 값으로
놓는다. 그러면 입력 파일이 끝나거나 `\KW{outer}' 기호가 나타날 때 알맞게 오류를 회복할 수 있다.

전역 변수 |warningInfo|는 추가 정보를 주어 이 오류 회복을 돕는다. 이를테면 |warningInfo|는 바꿈 텍스트를 훑고
있는 매크로의 이름을 가리킬 수 있다.

@<정의@>=
const (
	@!normal = iota // ``조용한 때''의 |scannerStatus|
	@!skipping // 거짓인 조건문 텍스트를 건너뛸 때의 |scannerStatus|
	@!flushing // 문장 뒤의 쓰레기를 무시할 때의 |scannerStatus|
	@!absorbing // \KW{text} 매개변수를 훑을 때의 |scannerStatus|
	@!varDefining // \KW{vardef}를 훑을 때의 |scannerStatus|
	@!opDefining // 매크로 \KW{def}를 훑을 때의 |scannerStatus|
	@!loopDefining // \KW{for} 루프를 훑을 때의 |scannerStatus|
)

@ @<전역 변수@>=
var @!scannerStatus int32 // 빠르게 훑고 있나? |normal .. loopDefining|
var @!warningInfo int32 // 그렇다면 오류가 날 경우에 대비해 또 무엇을 알아야 하나?

@ @<입력 루틴들을...@>=
scannerStatus = normal

@ 다음 서브루틴은 `\KW{outer}' 기호 토큰을 훑었거나 파일의 끝에 이르렀을 때 불린다. 두 경우는 |curSym|으로
구별하는데, 파일의 끝에서는 0이다.

@<함수들@>=
func checkOuterValidity() bool {
	var p pointer // 끼워 넣은 토큰 목록을 가리킨다
	if scannerStatus == normal {
		return true
	}
	deletionsAllowed = false
	@<바깥 기호 토큰을 다시 읽을 수 있도록 되돌린다@>
	if scannerStatus > skipping {
		@<무엇이 폭주했는지 사용자에게 알리고 회복하려 애쓴다@>
	} else {
		printErr("Incomplete if; all text was ignored after line ")
@.Incomplete if...@>
		printInt(warningInfo)
		help3("A forbidden `outer' token occurred in skipped text.",
			"This kind of error happens when you say `if...' and forget",
			"the matching `fi'. I've inserted a `fi'; this might work.")
		if curSym == 0 {
			helpLine[2] = "The file ended while I was skipping conditional text."
		}
		curSym = frozenFi
		insError()
	}
	deletionsAllowed = true
	return false
}

@ @<바깥 기호 토큰을 다시...@>=
if curSym != 0 {
	p = getAvail()
	setInfo(p, curSym)
	backList(p) // 기호 토큰을 다시 읽을 준비를 한다
}

@ @<무엇이 폭주했는지...@>=
runaway() // 지금까지의 정의를 찍는다
if curSym == 0 {
	printErr("File ended")
@.File ended while scanning...@>
} else {
	printErr("Forbidden token found")
@.Forbidden token found...@>
}
printStr(" while scanning ")
help4("I suspect you have forgotten an `enddef',",
	"causing me to read past where you wanted me to stop.",
	"I'll try to recover; but if the error is serious,",
	"you'd better type `E' or `X' now and fix your file.")
switch scannerStatus {
@<오류 메시지를 마치고, |curSym|을 오류에서 회복하는 데 도움이 될 만한 토큰으로 놓는다@>
} // 다른 경우는 없다
insError()

@ 여러 종류의 오류를 생각하면서 방금 준 도움말의 첫 줄을 바꾸는 것도 알맞다. 도움말 줄 |helpLine[3]|이 바꿀 수도 있는
문자열을 가리킨다.

@<오류 메시지를 마치고...@>=
case flushing:
	printStr("to the end of the statement")
	helpLine[3] = "A previous error seems to have propagated,"
	curSym = frozenSemicolon
case absorbing:
	printStr("a text argument")
	helpLine[3] = "It seems that a right delimiter was left out,"
	if warningInfo == 0 {
		curSym = frozenEndGroup
	} else {
		curSym = frozenRightDelimiter
		setEquiv(frozenRightDelimiter, warningInfo)
	}
case varDefining, opDefining:
	printStr("the definition of ")
	if scannerStatus == opDefining {
		slowPrint(text(warningInfo))
	} else {
		printVariableName(warningInfo)
	}
	curSym = frozenEndDef
case loopDefining:
	printStr("the text of a ")
	slowPrint(text(warningInfo))
	printStr(" loop")
	helpLine[3] = "I suspect you have forgotten an `endfor',"
	curSym = frozenEndFor

@ 프로시저 |runaway|는 \MF가 특별한 |scannerStatus|를 시작했을 때 나온 텍스트의 첫 부분을, 그 텍스트를
저장해 두었다면 보인다.

@<함수들@>=
func runaway() {
	if scannerStatus > flushing {
		printNl("Runaway ")
		switch scannerStatus {
		case absorbing:
			printStr("text?")
		case varDefining, opDefining:
			printStr("definition?")
		case loopDefining:
			printStr("loop?")
		} // 다른 경우는 없다
		printLn()
		showTokenList(link(holdHead), null, errorLine-10, 0)
	}
}

@ 이제 |getNext| 자체로 뛰어들 준비가 되었다. 이 프로시저에는 레이블이 여럿 있다. 레이블 |restart|는 다음 입력 토큰을
얻으러 가는 곳이고, |found|는 기호 토큰의 끝을 찾았을 때 가는 곳이고, |switchClass|는 입력 문자의 부류에 따라
갈래를 칠 때 가는 곳이다(원본은 이 레이블을 `switch'라고 불렀지만, \GO/에서 그것은 예약어다). 수를 훑을 때는
중요한 단계마다 |startNumericToken|, |startDecimalToken|, |finNumericToken|으로 간다. ``|goto|는 해롭다''고들
하지만 말이다.

@<함수들@>=
func getNext() { // |curCmd|, |curMod|, |curSym|을 다음 토큰으로 놓는다
@^inner loop@>
	var k int32 // |buffer|의 첨자; |0 .. bufSize|
	var c asciiCode // 버퍼의 현재 문자
	var class asciiCode // 그 부류 번호
	var n, f int32 // 십진법을 이진법으로 바꾸는 레지스터들
restart:
	curSym = 0
	if fileState() {
		@<외부 파일에서 입력한다; 입력이 없으면 |goto restart|, 기호가 아니면 |return|@>
	} else {
		@<토큰 목록에서 입력한다; 목록이 끝났거나 매개변수면 |goto restart|, 기호가 아니면 |return|@>
	}
	@<기호 토큰을 |curSym|에 얻는 일을 마친다; 그것이 허용되지 않으면 |goto restart|@>
}

@ 기호 토큰을 `\KW{outer}'로 선언하면 그 명령 코드가 |outerTag|만큼 늘어난다.
@^inner loop@>

@<기호 토큰을 |curSym|에...@>=
curCmd = eqType(curSym)
curMod = equiv(curSym)
if curCmd >= outerTag {
	if checkOuterValidity() {
		curCmd = curCmd - outerTag
	} else {
		goto restart
	}
}

@ 버퍼의 끝 |buffer[limit]|에 퍼센트 기호가 있으므로 줄의 끝을 따로 검사하지 않아도 된다.
@^inner loop@>

@<외부 파일에서 입력한다...@>=
switchClass:
c = buffer[loc]
loc++
class = charClass[c]
@<문자의 부류에 따라 갈래를 고른다; 글자 따위의 기호이면 그냥 지나간다@>
k = loc - 1
for charClass[buffer[loc]] == class {
	loc++
}
goto found
startNumericToken:
@<수치 토큰의 정수 부분 |n|을 얻는다; 소수점이 없으면 |f=0|으로 놓고 |goto finNumericToken|@>
startDecimalToken:
@<수치 토큰의 소수 부분 |f|를 얻는다@>
finNumericToken:
@<수치 토큰의 정수 부분과 소수 부분을 묶고 |return|한다@>
found:
curSym = idLookup(k, loc-k)

@ 부류마다 할 일이 다르다. 숫자와 소수점은 수치 토큰으로, 빈칸은 건너뛰고, 퍼센트 기호는 줄의 나머지를 버리고, 따옴표는 문자열 토큰으로 간다. 홀로 서는 문자는 그 자체로 기호가 되고, 글자 따위는 같은 부류의 문자가 이어지는 데까지 한 기호를 이룬다.

@<문자의 부류에 따라 갈래를 고른다; 글자 따위의 기호이면 그냥 지나간다@>=
switch {
case class == digitClass:
	goto startNumericToken
case class == periodClass:
	class = charClass[buffer[loc]]
	if class > periodClass {
		goto switchClass
	} else if class < periodClass { // |class=digitClass|
		n = 0
		goto startDecimalToken
	}
@:. }{\..\ token@>
case class == spaceClass:
	goto switchClass
case class == percentClass:
	@<파일의 다음 줄로 옮겨 가거나, 다음 줄이 없으면 |goto restart|@>
	checkInterrupt()
	goto switchClass
case class == stringClass:
	@<문자열 토큰을 얻고 |return|한다@>
case isolatedClass(class):
	k = loc - 1
	goto found
case class == invalidClass:
	@<잘못된 문자를 나무라고 |goto restart|@>
default:
	// 글자 따위
}

@ 오류를 다룬 다음에 |tokenState|에 들어갈 수도 있으므로(|clearForErrorPrompt| 참조) |switchClass| 대신
|restart|로 간다.

@<잘못된 문자를 나무라고...@>=
printErr("Text line contains an invalid character")
@.Text line contains...@>
help2("A funny symbol that I can't read has just been input.",
	"Continue, and I'll forget that it ever happened.")
deletionsAllowed = false
reportError()
deletionsAllowed = true
goto restart

@ 빈 문자열은 문자열 상수의 목록에 있는 |str("")|이다. 길이가 1인 문자열의 문자가 보이는 문자이면, 새 문자열을
만들지 않고 그 문자 하나짜리 문자열(번호가 문자 코드와 같다)을 쓴다. 보이지 않는 문자는 그 문자열이 `\.{\^\^M}'
같은 꼴이어서 길이가 1이 아니므로 새 문자열을 만든다.

@<문자열 토큰을 얻고...@>=
if buffer[loc] == '"' {
	curMod = str("")
} else {
	k = loc
	buffer[limit+1] = '"'
	for {
		loc++
		if buffer[loc] == '"' {
			break
		}
	}
	if loc > limit {
		@<빠진 문자열 구분자를 나무라고 |goto restart|@>
	}
	if loc == k+1 && length(buffer[k]) == 1 {
		curMod = buffer[k]
	} else {
		strRoom(loc - k)
		for {
			appendChar(buffer[k])
			k++
			if k == loc {
				break
			}
		}
		curMod = makeString()
	}
}
loc++
curCmd = stringToken
return

@ 루틴 |reportError|가 끝난 다음 |clearForErrorPrompt| 루틴이 |tokenState|를 되살렸을 수도 있으므로, 이 오류 메시지
다음에는 |switchClass|가 아니라 |restart|로 간다.

@<빠진 문자열 구분자를...@>=
loc = limit // 이 줄에서 다음에 읽을 문자는 |'%'|가 된다
printErr("Incomplete string token has been flushed")
@.Incomplete string token...@>
help3("Strings should finish on the same line as they began.",
	"I've deleted the partial string; you might want to",
	"insert another by typing, e.g., `I\"new string\"'.")
deletionsAllowed = false
reportError()
deletionsAllowed = true
goto restart

@ @<수치 토큰의 정수 부분 |n|을 얻는다; 소수점이 없으면 |f=0|으로 놓고 |goto finNumericToken|@>=
n = c - '0'
for charClass[buffer[loc]] == digitClass {
	if n < 4096 {
		n = 10*n + buffer[loc] - '0'
	}
	loc++
}
if buffer[loc] == '.' {
	if charClass[buffer[loc+1]] == digitClass {
		goto done
	}
}
f = 0
goto finNumericToken
done:
loc++

@ @<수치 토큰의 소수 부분...@>=
k = 0
for {
	if k < 17 { // |k>=17|인 숫자는 결과에 영향을 줄 수 없다
		dig[k] = buffer[loc] - '0'
		k++
	}
	loc++
	if charClass[buffer[loc]] != digitClass {
		break
	}
}
f = roundDecimals(k)
if f == unity {
	n++
	f = 0
}

@ @<수치 토큰의 정수 부분과...@>=
if n < 4096 {
	curMod = n*unity + f
} else {
	printErr("Enormous number has been reduced")
@.Enormous number...@>
	help2("I can't handle numbers bigger than about 4095.99998;",
		"so I've changed your constant to that maximum amount.")
	deletionsAllowed = false
	reportError()
	deletionsAllowed = true
	curMod = 0o1777777777
}
curCmd = numericToken
return

@ 이제 |getNext|가 토큰 목록을 보고 있을 때 무슨 일이 일어나는지 생각해 보자.
@^inner loop@>

@<토큰 목록에서 입력한다...@>=
if loc >= hiMemMin { // 한 낱말짜리 토큰
	curSym = info(loc)
	loc = link(loc) // 다음으로 옮겨 간다
	if curSym >= exprBase {
		if curSym >= suffixBase {
			@<첨자나 텍스트 매개변수를 끼워 넣고 |goto restart|@>
		}
		curCmd = capsuleToken
		curMod = paramStack[paramStart()+curSym-(exprBase)]
		curSym = 0
		return
	}
} else if loc > null {
	@<저장된 수치나 문자열이나 캡슐 토큰을 얻고 |return|한다@>
} else { // 이 토큰 목록을 다 읽었다
	endTokenList()
	goto restart // 앞 수준으로 돌아간다
}

@ @<첨자나 텍스트 매개변수를...@>=
if curSym >= textBase {
	curSym = curSym - paramSize // |paramSize=textBase-suffixBase|
}
beginTokenList(paramStack[paramStart()+curSym-(suffixBase)], parameter)
goto restart

@ @<저장된 수치나 문자열이나...@>=
if nameType(loc) == token {
	curMod = value(loc)
	if typ(loc) == known {
		curCmd = numericToken
	} else {
		curCmd = stringToken
		addStrRef(curMod)
	}
} else {
	curMod = loc
	curCmd = capsuleToken
}
loc = link(loc)
return

@ 프로시저 |getNext|의 쉬운 갈래들은 이제 다 다루었다. 갈래가 하나 더 있다.

@<파일의 다음 줄로 옮겨 가거나...@>=
if name > 2 {
	@<파일의 다음 줄을 |buffer|에 읽거나, 파일이 끝났으면 |goto restart|@>
} else {
	if inputPtr > 0 { // 오류 회복 때 끼워 넣었거나 \KW{scantokens}가 넣은 텍스트
		endFileReading()
		goto restart // 앞 수준으로 돌아간다
	}
	if selector < logOnly {
		openLogFile()
	}
	if interaction > nonstopMode {
		if limit == start { // 앞 줄이 비어 있었다
			printNl("(Please type a command or say `end')")
		}
@.Please type...@>
		printLn()
		first = start
		promptInput("*") // |buffer|에 온라인으로 입력한다
@.*\relax@>
		limit = last
		buffer[limit] = '%'
		first = limit + 1
		loc = start
	} else {
		fatalError("*** (job aborted, no legal end found)")
@.job aborted@>
		@t\qquad@>// 밤새 일괄 처리를 하려는 비정지 모드는 온라인 입력을 결코 기다리지 않는다
	}
}

@ 전역 변수 |forceEOF|는 보통 |false|다. \KW{endinput} 명령이 이것을 |true|로 놓는다.

@<전역 변수@>=
var @!forceEOF bool // 다음 \KW{input}을 일찍 그만두어야 하나?

@ 파일이 끝나면 |checkOuterValidity|를 부르는데, 원본은 그 결과가 무엇이든 |restart|로 간다
(`|if checkOuterValidity then goto restart else goto restart|'). 부르는 것 자체가 중요하기 때문이다.
파일이 바깥 기호를 훑는 도중에 끝났으면 그 함수가 오류를 알린다.

@<파일의 다음 줄을 |buffer|에...@>=
line++
first = start
if !forceEOF {
	if inputLn(curFile(), true) { // 파일의 끝이 아니다
		firmUpTheLine() // 이것이 |limit|를 정한다
	} else {
		forceEOF = true
	}
}
if forceEOF {
	printChar(')')
	openParens--
	updateTerminal() // 파일을 다 읽었다는 것을 사용자에게 보인다
	forceEOF = false
	endFileReading() // 앞 수준으로 돌아간다
	checkOuterValidity()
	goto restart
}
buffer[limit] = '%'
first = limit + 1
loc = start // 읽을 준비가 되었다

@ 사용자가 |pausing| 매개변수를 어떤 양수로 놓았고 비정지 모드를 고르지 않았으면, 입력의 각 줄을 터미널과
기록 파일에 보이고 그 뒤에 `\.{=>}'를 찍는다. \MF는 대답을 기다린다. 대답이 비어 있으면(곧 공백 몇 개 말고는
아무것도 치지 않으면) 원래의 줄을 그대로 받아들인다. 그렇지 않으면 파일의 줄 대신 친 줄을 쓴다.

@<함수들@>=
func firmUpTheLine() {
	var k int32 // |buffer|의 첨자; |0 .. bufSize|
	limit = last
	if internal[pausing] > 0 && interaction > nonstopMode {
		wakeUpTerminal()
		printLn()
		if start < limit {
			for k = start; k <= limit-1; k++ {
				printStr(buffer[k])
			}
		}
		first = limit
		promptInput("=>") // 사용자의 대답을 기다린다
@.=>@>
		if last > first {
			for k = first; k <= last-1; k++ { // 줄을 버퍼에서 아래로 옮긴다
				buffer[k+start-first] = buffer[k]
			}
			limit = start + last - first
		}
	}
}

@* 매크로 정의 훑기.
\MF에는 나중에 쓰려고 토큰들을 토큰 목록에 챙겨 두는 여러 방법이 있다. 매크로는 \KW{def}, \KW{vardef},
\KW{primarydef} 따위로 정의할 수 있고, 되풀이할 코드는 \KW{for}, \KW{forever}, \KW{forsuffixes}로 정의할 수 있다.
그런 연산은 모두 프로그램의 이 부분에 있는 루틴들이 다룬다.

\KW{enddef}나 \KW{endfor} 같은 ``끝맺는 구분자''의 명령 코드의 수식자 부분은 0이다.

@<정의@>=
const (
	@!startDef = 1 // \KW{def}의 명령 수식자
	@!varDef = 2 // \KW{vardef}의 명령 수식자
	@!endDef = 0 // \KW{enddef}의 명령 수식자
	@!startForever = 1 // \KW{forever}의 명령 수식자
	@!endFor = 0 // \KW{endfor}의 명령 수식자
)

@ @<\MF의 원시 명령을...@>=
primitive("def", macroDef, startDef)
@!@:def_}{\KW{def} primitive@>
primitive("vardef", macroDef, varDef)
@!@:var_def_}{\KW{vardef} primitive@>
primitive("primarydef", macroDef, secondaryPrimaryMacro)
@!@:primary_def_}{\KW{primarydef} primitive@>
primitive("secondarydef", macroDef, tertiarySecondaryMacro)
@!@:secondary_def_}{\KW{secondarydef} primitive@>
primitive("tertiarydef", macroDef, expressionTertiaryMacro)
@!@:tertiary_def_}{\KW{tertiarydef} primitive@>
primitive("enddef", macroDef, endDef)
eqtb[frozenEndDef] = eqtb[curSym]
@!@:end_def_}{\KW{enddef} primitive@>
primitive("for", iteration, exprBase)
@!@:for_}{\KW{for} primitive@>
primitive("forsuffixes", iteration, suffixBase)
@!@:for_suffixes_}{\KW{forsuffixes} primitive@>
primitive("forever", iteration, startForever)
@!@:forever_}{\KW{forever} primitive@>
primitive("endfor", iteration, endFor)
eqtb[frozenEndFor] = eqtb[curSym]
@!@:end_for_}{\KW{endfor} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case macroDef:
	if m <= varDef {
		if m == startDef {
			printStr("def")
		} else if m < startDef {
			printStr("enddef")
		} else {
			printStr("vardef")
		}
	} else if m == secondaryPrimaryMacro {
		printStr("primarydef")
	} else if m == tertiarySecondaryMacro {
		printStr("secondarydef")
	} else {
		printStr("tertiarydef")
	}
case iteration:
	if m <= startForever {
		if m == startForever {
			printStr("forever")
		} else {
			printStr("endfor")
		}
	} else if m == exprBase {
		printStr("for")
	} else {
		printStr("forsuffixes")
	}

@ 매크로를 빨아들이는 연산들은 구문이 저마다 다르지만 공통점도 많다. 매개변수 토큰으로 바꿀 특별한 기호들의
목록이 있고, 정의를 끝내는 특별한 명령 코드가 있으며, 인용 관례가 똑같다. 그러므로 일의 대부분을 서브루틴 하나가
하는 것이 이치에 맞다. 그 서브루틴을 |scanToks|라고 부른다.

서브루틴 |scanToks|의 첫 매개변수는 훑기를 끝낼 명령 코드(|macroDef|나 |iteration|)다.

둘째 매개변수 |substList|는 두 낱말짜리 노드들의 (비어 있을 수도 있는) 목록을 가리키는데, 그 |info|와 |value|
필드는 바꾸기 전과 뒤의 기호 토큰을 지정한다. 이 목록은 |scanToks|가 빈 저장소로 돌려준다.

셋째 매개변수는 만든 토큰 목록에 그냥 덧붙인다. 그리고 마지막 매개변수는 특별한 연산 \.{\#\AT!}, \.{\AT!},
\.{\AT!\#} 가운데 몇 개를 첨자 매개변수로 바꿀지 알려 준다. 그런 매개변수가 있으면 그것들을 \.{(SUFFIX0)},
\.{(SUFFIX1)}, \.{(SUFFIX2)}라고 부른다.

명령 \KW{def}와 \KW{enddef}는 괄호처럼 짝을 이루므로, 매크로 정의 안의 매크로 정의는 그 짝을 세는 |balance|로
알아본다. 수식자가 0이 아닌 끝맺음 명령(곧 \KW{def}나 \KW{for})은 균형을 하나 늘리고, 0인 것(곧 \KW{enddef}나
\KW{endfor})은 하나 줄인다.

@<함수들@>=
func scanToks(terminator int32, substList, tailEnd pointer, suffixCount smallNumber) pointer {
	var p pointer // 만들고 있는 토큰 목록의 꼬리
	var q pointer // 연결 관리를 위한 임시 변수
	var balance int32 // 왼쪽 구분자 수에서 오른쪽 구분자 수를 뺀 것
	p = holdHead
	balance = 1
	setLink(holdHead, null)
	for {
		getNext()
		if curSym > 0 {
			@<|curSym|이 |substList|에 있으면 바꾼다@>
			if curCmd == terminator {
				@<균형을 고친다; 0이 되면 루프를 빠져나간다@>
			} else if curCmd == macroSpecial {
				@<인용한 기호, \.{\#\AT!}, \.{\AT!}, \.{\AT!\#}를 다룬다@>
			}
		}
		setLink(p, curTok())
		p = link(p)
	}
	setLink(p, tailEnd)
	flushNodeList(substList)
	return link(holdHead)
}

@ @<|curSym|이 |substList|에...@>=
q = substList
for q != null {
	if info(q) == curSym {
		curSym = value(q)
		curCmd = relax
		break
	}
	q = link(q)
}

@ @<균형을 고친다...@>=
if curMod > 0 {
	balance++
} else {
	balance--
	if balance == 0 {
		break
	}
}

@ 명령 넷은 매크로 텍스트 안에서만 쓰려는 것이다. \KW{quote}, \.{\#\AT!}, \.{\AT!}, \.{\AT!\#}다. 이것들은
|macroSpecial|이라는 한 명령 코드의 변형들이다.

@<정의@>=
const (
	@!quote = 0 // \KW{quote}의 |macroSpecial| 수식자
	@!macroPrefix = 1 // \.{\#\AT!}의 |macroSpecial| 수식자
	@!macroAt = 2 // \.{\AT!}의 |macroSpecial| 수식자
	@!macroSuffix = 3 // \.{\AT!\#}의 |macroSpecial| 수식자
)

@ @<\MF의 원시 명령을...@>=
primitive("quote", macroSpecial, quote)
@!@:quote_}{\KW{quote} primitive@>
primitive("#@@", macroSpecial, macroPrefix)
@!@:]]]\#\AT!_}{\.{\#\AT!} primitive@>
primitive("@@", macroSpecial, macroAt)
@!@:]]]\AT!_}{\.{\AT!} primitive@>
primitive("@@#", macroSpecial, macroSuffix)
@!@:]]]\AT!\#_}{\.{\AT!\#} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case macroSpecial:
	switch m {
	case macroPrefix:
		printStr("#@@")
	case macroAt:
		printChar('@@')
	case macroSuffix:
		printStr("@@#")
	default:
		printStr("quote")
	}

@ \KW{quote} 다음의 토큰은 바꾸지 않고 그대로 담는다. 첨자 매개변수로 바꿀 연산 \.{\#\AT!}, \.{\AT!}, \.{\AT!\#}는
수식자의 값이 1, 2, 3이므로, |suffixBase-1+curMod|가 \.{(SUFFIX0)}, \.{(SUFFIX1)}, \.{(SUFFIX2)}가 된다.

@<인용한 기호, \.{\#\AT!}...@>=
if curMod == quote {
	getNext()
} else if curMod <= suffixCount {
	curSym = suffixBase - 1 + curMod
}

@ 다음은 토큰을 다시 정의할 때마다 쓰는 루틴이다. 사용자의 토큰을 다시 정의할 수 없으면 `|frozenInaccessible|'
토큰으로 바꾼다. 뒤의 것은 다시 정의할 수 있지만 본질적으로 쓸 수 없으므로 \MF의 표가 엉망이 되지 않는다.

@<함수들@>=
func getSymbol() { // |curSym|을 안전한 기호로 놓는다
restart:
	getNext()
	if curSym == 0 || curSym > frozenInaccessible {
		printErr("Missing symbolic token inserted")
@.Missing symbolic token...@>
		help3("Sorry: You can't redefine a number, string, or expr.",
			"I've inserted an inaccessible symbol so that your",
			"definition will be completed without mixing me up too badly.")
		if curSym > 0 {
			helpLine[2] = "Sorry: You can't redefine my error-recovery tokens."
		} else if curCmd == stringToken {
			deleteStrRef(curMod)
		}
		curSym = frozenInaccessible
		insError()
		goto restart
	}
}

@ 기호 토큰을 실제로 다시 정의하기 전에, 그것이 변수였다면 그 이전 값을 치워야 한다. 프로시저 |getSymbol|을 더 세게 한
다음 판이 그 일을 한다.

@<함수들@>=
func getClearSymbol() {
	getSymbol()
	clearSymbol(curSym, false)
}

@ 다음은 또 하나의 작은 서브루틴이다. 매크로 정의의 알맞은 자리에 등호나 대입 기호가 오는지 검사한다.

@<함수들@>=
func checkEquals() {
	if curCmd != equals && curCmd != assignment {
		missingErr("=")
@.Missing `='@>
		help5("The next thing in this `def' should have been `=',",
			"because I've already looked at the definition heading.",
			"But don't worry; I'll pretend that an equals sign",
			"was present. Everything from here to `enddef'",
			"will be the replacement text of this macro.")
		backError()
	}
}

@ 서브루틴 |scanToks|가 있으니 이제 \KW{primarydef}, \KW{secondarydef}, \KW{tertiarydef}는 꽤 쉽게 다룰 수 있다. 이 경우에는
매개변수가 둘인데, \.{EXPR0}과 \.{EXPR1}(곧 |exprBase|와 |exprBase+1|)이 된다.

@<함수들@>=
func makeOpDef() {
	var m int32 // 정의의 종류
	var p, q, r pointer // 목록 조작을 위해
	m = curMod
	getSymbol()
	q = getNode(tokenNodeSize)
	setInfo(q, curSym)
	setValue(q, exprBase)
	getClearSymbol()
	warningInfo = curSym
	getSymbol()
	p = getNode(tokenNodeSize)
	setInfo(p, curSym)
	setValue(p, exprBase+1)
	setLink(p, q)
	getNext()
	checkEquals()
	scannerStatus = opDefining
	q = getAvail()
	setRefCount(q, null)
	r = getAvail()
	setLink(q, r)
	setInfo(r, generalMacro)
	setLink(r, scanToks(macroDef, p, null, 0))
	scannerStatus = normal
	setEqType(warningInfo, m)
	setEquiv(warningInfo, q)
	getXNext()
}

@ 매크로의 매개변수는 낱말 \KW{expr}, \KW{suffix}, \KW{text}, \KW{primary}, \KW{secondary}, \KW{tertiary}로
들여온다.

@<\MF의 원시 명령을...@>=
primitive("expr", paramType, exprBase)
@!@:expr_}{\KW{expr} primitive@>
primitive("suffix", paramType, suffixBase)
@!@:suffix_}{\KW{suffix} primitive@>
primitive("text", paramType, textBase)
@!@:text_}{\KW{text} primitive@>
primitive("primary", paramType, primaryMacro)
@!@:primary_}{\KW{primary} primitive@>
primitive("secondary", paramType, secondaryMacro)
@!@:secondary_}{\KW{secondary} primitive@>
primitive("tertiary", paramType, tertiaryMacro)
@!@:tertiary_}{\KW{tertiary} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case paramType:
	if m >= exprBase {
		if m == exprBase {
			printStr("expr")
		} else if m == suffixBase {
			printStr("suffix")
		} else {
			printStr("text")
		}
	} else if m < secondaryMacro {
		printStr("primary")
	} else if m == secondaryMacro {
		printStr("secondary")
	} else {
		printStr("tertiary")
	}

@ 다음으로 \KW{def}와 \KW{vardef}에 딸린 더 복잡한 처리로 눈을 돌리자. 다음 프로시저를 부를 때 |curMod|는
|startDef|이거나 |varDef|여야 한다.

매크로의 바꿈 텍스트 앞에는 매개변수를 나타내는 노드들이 온다. 이를테면 `\.{def f(expr a)(text t) =}'로 정의한
매크로의 토큰 목록은 참조 횟수 노드, \.{(EXPR0)}, \.{(TEXT1)}, 매크로의 종류 |generalMacro|를 담은 노드, 그리고
매개변수가 \.{(EXPR0)}과 \.{(TEXT1)}로 바뀐 바꿈 텍스트 순서로 이어진다.

@<함수들@>=
func scanDef() {
	var m int32 // 정의의 종류; |startDef .. varDef|
	var n int32 // 특별한 첨자 매개변수의 수; |0 .. 3|
	var k int32 // 매개변수의 전체 수; |0 .. paramSize|
	var c int32 // 정의하고 있는 매크로의 종류; |generalMacro .. textMacro|
	var r pointer // 매개변수 바꿈 목록
	var q pointer // 매크로 토큰 목록의 꼬리
	var p pointer // 임시 저장소
	var base halfword // |exprBase|, |suffixBase|, |textBase|
	var lDelim, rDelim pointer // 짝을 이루는 구분자
	m = curMod
	c = generalMacro
	setLink(holdHead, null)
	q = getAvail()
	setRefCount(q, null)
	r = null
	@<정의할 토큰이나 변수를 훑는다; |n|, |scannerStatus|, |warningInfo|를 정한다@>
	k = n
	if curCmd == leftDelimiter {
		@<구분된 매개변수들을 빨아들여 목록 |q|와 |r|에 넣는다@>
	}
	if curCmd == paramType {
		@<구분되지 않은 매개변수들을 빨아들여 목록 |r|에 넣는다@>
	}
	checkEquals()
	p = getAvail()
	setInfo(p, c)
	setLink(q, p)
	@<바꿈 텍스트를 노드 |p|의 꼬리에 붙인다@>
	scannerStatus = normal
	getXNext()
}

@ 사용자가 `\.{endgroup}'을 다시 정의하고 싶어 할 수도 있으므로 \KW{vardef}의 바꿈 텍스트에는
`|frozenEndGroup|'을 넣지 않는다.

@<바꿈 텍스트를 노드 |p|의...@>=
if m == startDef {
	setLink(p, scanToks(macroDef, r, null, n))
} else {
	q = getAvail()
	setInfo(q, bgLoc)
	setLink(p, q)
	p = getAvail()
	setInfo(p, egLoc)
	setLink(q, scanToks(macroDef, r, p, n))
}
if warningInfo == badVardef {
	flushTokenList(value(badVardef))
}

@ @<전역 변수@>=
var @!bgLoc, @!egLoc pointer // `\.{begingroup}'과 `\.{endgroup}'의 해시 주소; |1 .. hashEnd|

@ @<정의할 토큰이나 변수를...@>=
if m == startDef {
	getClearSymbol()
	warningInfo = curSym
	getNext()
	scannerStatus = opDefining
	n = 0
	setEqType(warningInfo, definedMacro)
	setEquiv(warningInfo, q)
} else {
	p = scanDeclaredVariable()
	flushVariable(equiv(info(p)), link(p), true)
	warningInfo = findVariable(p)
	flushList(p)
	if warningInfo == null {
		@<`\.{a bad variable}'로 바꾼다@>
	}
	scannerStatus = varDefining
	n = 2
	if curCmd == macroSpecial && curMod == macroSuffix { // \.{\AT!\#}
		n = 3
		getNext()
	}
	setType(warningInfo, unsuffixedMacro-2+n)
	setValue(warningInfo, q)
} // |suffixedMacro=unsuffixedMacro+1|

@ @<`\.{a bad variable}'로...@>=
printErr("This variable already starts with a macro")
@.This variable already...@>
help2("After `vardef a' you can't say `vardef a.b'.",
	"So I'll have to discard this definition.")
reportError()
warningInfo = badVardef

@ @<표의 항목들을...@>=
setNameType(badVardef, root)
setLink(badVardef, frozenBadVardef)
setEquiv(frozenBadVardef, badVardef)
setEqType(frozenBadVardef, tagToken)

@ @<구분된 매개변수들을...@>=
for {
	lDelim = curSym
	rDelim = curMod
	getNext()
	if curCmd == paramType && curMod >= exprBase {
		base = curMod
	} else {
		printErr("Missing parameter type; `expr' will be assumed")
@.Missing parameter type@>
		help1("You should've had `expr' or `suffix' or `text' here.")
		backError()
		base = exprBase
	}
	@<형 |base|의 매개변수 토큰들을 빨아들인다@>
	checkDelimiter(lDelim, rDelim)
	getNext()
	if curCmd != leftDelimiter {
		break
	}
}

@ @<형 |base|의 매개변수 토큰들을...@>=
for {
	setLink(q, getAvail())
	q = link(q)
	setInfo(q, base+k)
	getSymbol()
	p = getNode(tokenNodeSize)
	setValue(p, base+k)
	setInfo(p, curSym)
	if k == paramSize {
		overflow("parameter stack size", paramSize)
	}
@:METAFONT capacity exceeded parameter stack size}{\quad parameter stack size@>
	k++
	setLink(p, r)
	r = p
	getNext()
	if curCmd != comma {
		break
	}
}

@ @<구분되지 않은 매개변수들을...@>=
p = getNode(tokenNodeSize)
if curMod < exprBase {
	c = curMod
	setValue(p, exprBase+k)
} else {
	setValue(p, curMod+k)
	if curMod == exprBase {
		c = exprMacro
	} else if curMod == suffixBase {
		c = suffixMacro
	} else {
		c = textMacro
	}
}
if k == paramSize {
	overflow("parameter stack size", paramSize)
}
k++
getSymbol()
setInfo(p, curSym)
setLink(p, r)
r = p
getNext()
if c == exprMacro && curCmd == ofToken {
	c = ofMacro
	p = getNode(tokenNodeSize)
	if k == paramSize {
		overflow("parameter stack size", paramSize)
	}
	setValue(p, exprBase+k)
	getSymbol()
	setInfo(p, curSym)
	setLink(p, r)
	r = p
	getNext()
}

@* 다음 토큰 펼치기.
프로시저 |getNext|가 돌려줄 수 있는 명령 코드 가운데 |<minCommand|인 것은 몇 개뿐이다. 늘어나는 순서로 |ifTest|,
|fiOrElse|, |input|, |iteration|, |repeatLoop|, |exitTest|, |relax|, |scanTokens|, |expandAfter|, |definedMacro|다.

\MF는 대개 |getXNext|라고 해서 입력의 다음 토큰을 얻는다. 이것은 |getNext|와 같지만 |curCmd>=minCommand|인 것을
찾을 때까지 토큰을 더 얻는다. 다시 말해 |getXNext|는 매크로를 펼치고, 있을지 모르는 조건문이나 되풀이나 입력
명령을 없앤다.

그러므로 |getXNext|는 스스로를 재귀적으로 부를 수 있다. 사실 엄청난 재귀가 있다. 매크로 펼치기에는 임의로 복잡한
식을 훑는 일이 들어갈 수 있고, 그 일에는 다시 매크로 펼치기와 조건문 따위가 들어가기 때문이다. 원본은 그래서 이
지점에서 |forward| 프로시저를 한 무더기 선언해야 했지만, \GO/에서는 그럴 필요가 없다.
@^recursion@>

@ 프로시저 |getXNext|가 색다른 펼치기 명령을 처리해야 할 때는 |expand|라는 보조 서브루틴을 쓴다.

@<함수들@>=
func expand() {
	var p pointer // 목록 조작을 위해
	var k int32 // |<=bufSize|이기를 바라는 어떤 것
	var j poolPointer // |strPool|의 첨자
	if internal[tracingCommands] > unity && curCmd != definedMacro {
		showCurCmdMod()
	}
	switch curCmd {
	case ifTest:
		conditional() // 이 프로시저는 아래의 36부에서 논의한다
	case fiOrElse:
		@<현재 조건문을 끝내고 \KW{fi}까지 건너뛴다@>
	case input:
		@<파일의 입력을 시작하거나 끝낸다@>
	case iteration:
		if curMod == endFor {
			@<\KW{endfor}가 하나 더 있다고 사용자를 꾸짖는다@>
		} else {
			beginIteration() // 이 프로시저는 아래의 37부에서 논의한다
		}
	case repeatLoop:
		@<루프를 되풀이한다@>
	case exitTest:
		@<적절한 때가 오면 루프를 빠져나간다@>
	case relax:
		// 아무것도 하지 않는다
	case expandAfter:
		@<다음 토큰의 다음 토큰을 펼친다@>
	case scanTokens:
		@<문자열을 입력 버퍼에 넣는다@>
	case definedMacro:
		macroCall(curMod, null, curSym)
	} // 다른 경우는 없다
}

@ @<\KW{endfor}가 하나 더...@>=
printErr("Extra `endfor'")
@.Extra `endfor'@>
help2("I'm not currently working on a for loop,",
	"so I had better not try to end anything.")
reportError()

@ \KW{input}의 처리에는 나중에 선언할 서브루틴 |startInput|이 들어간다. \KW{endinput}의 처리는 하찮다.

@<\MF의 원시 명령을...@>=
primitive("input", input, 0)
@!@:input_}{\KW{input} primitive@>
primitive("endinput", input, 1)
@!@:end_input_}{\KW{endinput} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case input:
	if m == 0 {
		printStr("input")
	} else {
		printStr("endinput")
	}

@ @<파일의 입력을 시작하거나...@>=
if curMod > 0 {
	forceEOF = true
} else {
	startInput()
}

@ 루프 연산의 복잡한 부분은 나중에 논의하겠다. 지금은 루프가 진행 중이지 않으면 |null|이 되는 |loopPtr|라는
전역 변수가 있다는 것만 알면 된다.

@<루프를 되풀이한다@>=
for tokenState() && loc == null {
	endTokenList() // 스택 공간을 아낀다
}
if loopPtr == null {
	printErr("Lost loop")
@.Lost loop@>
	help2("I'm confused; after exiting from a loop, I still seem",
		"to want to repeat it. I'll try to forget the problem.")
	reportError()
} else {
	resumeIteration() // 이 프로시저는 아래의 37부에 있다
}

@ @<적절한 때가 오면...@>=
getBoolean()
if internal[tracingCommands] > unity {
	showCmdMod(nullary, curExp)
}
if curExp == trueCode {
	if loopPtr == null {
		printErr("No loop is in progress")
@.No loop is in progress@>
		help1("Why say `exitif' when there's nothing to exit from?")
		if curCmd == semicolon {
			reportError()
		} else {
			backError()
		}
	} else {
		@<되풀이에서 일찍 빠져나간다@>
	}
} else if curCmd != semicolon {
	missingErr(";")
@.Missing `;'@>
	help2("After `exitif <boolean expr>' I expect to see a semicolon.",
		"I shall pretend that one was there.")
	backError()
}

@ 여기서는 |foreverText|가 |loopText|보다 작은 유일한 |tokenType|이라는 사실을 쓴다.

@<되풀이에서 일찍...@>=
p = null
for {
	if fileState() {
		endFileReading()
	} else {
		if tokenType() <= loopText {
			p = start
		}
		endTokenList()
	}
	if p != null {
		break
	}
}
if p != info(loopPtr) {
	fatalError("*** (loop confusion)")
}
@.loop confusion@>
stopIteration() // 이 프로시저는 아래의 37부에 있다

@ @<다음 토큰의 다음 토큰을...@>=
getNext()
p = curTok()
getNext()
if curCmd < minCommand {
	expand()
} else {
	backInput()
}
backList(p)

@ @<문자열을 입력 버퍼에...@>=
getXNext()
scanPrimary()
if curType != stringType {
	dispErr(null, "Not a string")
@.Not a string@>
	help2("I'm going to flush this expression, since",
		"scantokens should be followed by a known string.")
	putGetFlushError(0)
} else {
	backInput()
	if length(curExp) > 0 {
		@<한 줄짜리 새 파일을 읽는 척한다@>
	}
}

@ @<한 줄짜리 새 파일을...@>=
beginFileReading()
name = 2
k = first + length(curExp)
if k >= maxBufStack {
	if k >= bufSize {
		maxBufStack = bufSize
		overflow("buffer size", bufSize)
	}
@:METAFONT capacity exceeded buffer size}{\quad buffer size@>
	maxBufStack = k + 1
}
j = strStart[curExp]
limit = k
for first < limit {
	buffer[first] = so(strPool[j])
	j++
	first++
}
buffer[limit] = '%'
first = limit + 1
loc = start
flushCurExp(0)

@ 마침내 |getXNext|다.

나중에 살펴볼 식 훑기 루틴들은 전역 양 |curType|과 |curExp|로 소통한다. 그러므로 매크로를 펼치는 동안 이 양들을
아주 조심스럽게 저장했다가 되돌려야 한다.
@^inner loop@>

@<함수들@>=
func getXNext() {
	var saveExp pointer // |curType|과 |curExp|를 저장하는 캡슐
	getNext()
	if curCmd < minCommand {
		saveExp = stashCurExp()
		for {
			if curCmd == definedMacro {
				macroCall(curMod, null, curSym)
			} else {
				expand()
			}
			getNext()
			if curCmd >= minCommand {
				break
			}
		}
		unstashCurExp(saveExp) // 그것이 |curType|과 |curExp|를 되돌린다
	}
}

@ 이제 사용자가 정의한 모든 매크로를 시작하는 데 쓰는 |macroCall| 프로시저를 생각해 보자. 매크로의 인자는 식일 수
있으므로 |macroCall|은 재귀적이다.
@^recursion@>

프로시저 |macroCall|의 첫 매개변수는 매크로를 정의하는 토큰 목록의 참조 횟수를 가리킨다. 둘째 매개변수에는 이미 구문 분석한
인자들이 들어 있다(아래 참조). 셋째 매개변수는 매크로의 이름을 짓는 기호 토큰을 가리킨다. 셋째 매개변수가
|null|이면 그 매크로는 \KW{vardef}로 정의한 것이므로, 그 이름은 둘째 매개변수 안의 앞머리 인자와 ``위치'' 인자로부터
다시 만들어 낼 수 있다.

이 둘째 매개변수는 무엇일까? 그것은 그냥 한 낱말짜리 항목들의 연결 목록인데, 그 |info| 필드가 인자들을 가리킨다.
다시 말해 |argList=null|이면 아직 인자를 하나도 훑지 않았다. 그렇지 않으면 |info(argList)|는 첫 번째로 훑은 인자를
가리키고, |link(argList)|는 (있으면) 나머지 인자들의 목록을 가리킨다.

\KW{expr} 형의 인자는 이른바 캡슐인데, 식에 집중할 때 나중에 논의하겠다. 그것들은 |link| 필드가 |void|이므로 쉽게
알아볼 수 있다. \KW{suffix}와 \KW{text} 형의 인자는 참조 횟수가 없는 토큰 목록이다.

@ 인자 훑기가 끝나면 인자들을 |paramStack|으로 옮긴다. (인자를 더 얻는 동안에는 스택이 예측할 수 없게 자라고
줄어들므로, 그것들을 더 일찍 스택에 넣을 수는 없다.) 그다음 매크로의 몸체를 훑개에 먹인다. 곧 매크로의 바꿈
텍스트를 \MF의 입력 스택 맨 위에 놓아서 |getNext|가 다음에 그것을 읽게 한다.

@<함수들@>=
func macroCall(defRef, argList, macroName pointer) { // 사용자가 정의한 명령의 나열을 부른다
	var r pointer // 매크로의 토큰 목록에서 현재 노드
	var p, q pointer // 목록 조작을 위해
	var n int32 // 인자의 수
	var lDelim, rDelim pointer // 구분자 한 쌍
	var tail pointer // 인자 목록의 꼬리
	r = link(defRef)
	addMacRef(defRef)
	if argList == null {
		n = 0
	} else {
		@<이미 주어진 인자의 수 |n|을 정하고, |tail|을 |argList|의 꼬리로 놓는다@>
	}
	if internal[tracingMacros] > 0 {
		@<펼치고 있는 매크로의 텍스트와 이미 있는 인자들을 보인다@>
	}
	@<남은 인자가 있으면 훑는다; |r|을 바꿈 텍스트의 첫 토큰으로 놓는다@>
	@<인자와 바꿈 텍스트를 훑개에 먹인다@>
}

@ @<펼치고 있는 매크로의...@>=
beginDiagnostic()
printLn()
printMacroName(argList, macroName)
if n == 3 {
	printStr("@@#") // 첨자가 붙은 매크로임을 나타낸다
}
showMacro(defRef, null, 100000)
if argList != null {
	n = 0
	p = argList
	for {
		q = info(p)
		printArg(q, n, 0)
		n++
		p = link(p)
		if p == null {
			break
		}
	}
}
endDiagnostic(false)

@ @<함수들@>=
func printMacroName(a, n pointer) {
	var p, q pointer // |a|의 첫 부분을 훑는다
	if n != null {
		slowPrint(text(n))
	} else {
		p = info(a)
		if p == null {
			slowPrint(text(info(info(link(a)))))
		} else {
			q = p
			for link(q) != null {
				q = link(q)
			}
			setLink(q, info(link(a)))
			showTokenList(p, null, 1000, 0)
			setLink(q, null)
		}
	}
}

@ @<함수들@>=
func printArg(q pointer, n int32, b pointer) {
	if link(q) == void {
		printNl("(EXPR")
	} else if b < textBase && b != textMacro {
		printNl("(SUFFIX")
	} else {
		printNl("(TEXT")
	}
	printInt(n)
	printStr(")<-")
	if link(q) == void {
		printExp(q, 1)
	} else {
		showTokenList(q, null, 1000, 0)
	}
}

@ @<이미 주어진 인자의 수...@>=
n = 1
tail = argList
for link(tail) != null {
	n++
	tail = link(tail)
}

@ @<남은 인자가 있으면...@>=
curCmd = comma + 1 // |!=comma|이면 무엇이든 된다
for info(r) >= exprBase {
	@<|info(r)|이 나타내는 구분된 인자를 훑는다@>
	r = link(r)
}
if curCmd == comma {
	printErr("Too many arguments to ")
@.Too many arguments...@>
	printMacroName(argList, macroName)
	printChar(';')
	printNl("  Missing `")
	slowPrint(text(rDelim))
@.Missing `)'...@>
	printStr("' has been inserted")
	help3("I'm going to assume that the comma I just read was a",
		"right delimiter, and then I'll begin expanding the macro.",
		"You might want to delete some tokens before continuing.")
	reportError()
}
if info(r) != generalMacro {
	@<구분되지 않은 인자들을 훑는다@>
}
r = link(r)

@ 이 지점에서 독자는 앞에서 보인 토큰 목록 꼴의 설명, 특히 매크로의 토큰 목록 맨 앞에만 해당하는 관례를 다시
보는 것이 좋겠다.

한편 독자는 다음 프로그램의 식 구문 분석 측면은 믿고 넘어가야 한다. 변수 |curType|과 |curExp|는 나중에 설명할
것이다. (이 프로그램의 여러 부분이 서로 의존하므로 어딘가에서 그 고리에 뛰어들어야 한다.)

@<|info(r)|이 나타내는 구분된...@>=
if curCmd != comma {
	getXNext()
	if curCmd != leftDelimiter {
		printErr("Missing argument to ")
@.Missing argument...@>
		printMacroName(argList, macroName)
		help3("That macro has more parameters than you thought.",
			"I'll continue by pretending that each missing argument",
			"is either zero or null.")
		if info(r) >= suffixBase {
			curExp = null
			curType = tokenList
		} else {
			curExp = 0
			curType = known
		}
		backError()
		curCmd = rightDelimiter
		goto found
	}
	lDelim = curSym
	rDelim = curMod
}
@<|info(r)|이 나타내는 인자를 훑는다@>
if curCmd != comma {
	@<알맞은 오른쪽 구분자가 있었는지 검사한다@>
}
found:
@<현재 식을 |argList|에 덧붙인다@>

@ @<알맞은 오른쪽 구분자가...@>=
if curCmd != rightDelimiter || curMod != lDelim {
	if info(link(r)) >= exprBase {
		missingErr(",")
@.Missing `,'@>
		help3("I've finished reading a macro argument and am about to",
			"read another; the arguments weren't delimited correctly.",
			"You might want to delete some tokens before continuing.")
		backError()
		curCmd = comma
	} else {
		missingErr(text(rDelim))
@.Missing `)'@>
		help2("I've gotten to the end of the macro parameter list.",
			"You might want to delete some tokens before continuing.")
		backError()
	}
}

@ \KW{suffix}나 \KW{text} 매개변수는 |curExp|가 가리키는 토큰 목록으로 훑었을 것이고, 그 경우 |curType=tokenList|다.

@<현재 식을 |argList|에...@>=
p = getAvail()
if curType == tokenList {
	setInfo(p, curExp)
} else {
	setInfo(p, stashCurExp())
}
if internal[tracingMacros] > 0 {
	beginDiagnostic()
	printArg(info(p), n, info(r))
	endDiagnostic(false)
}
if argList == null {
	argList = p
} else {
	setLink(tail, p)
}
tail = p
n++

@ @<|info(r)|이 나타내는 인자를...@>=
if info(r) >= textBase {
	scanTextArg(lDelim, rDelim)
} else {
	getXNext()
	if info(r) >= suffixBase {
		scanSuffix()
	} else {
		scanExpression()
	}
}

@ 서브루틴 |scanTextArg|의 매개변수는 구분자 한 쌍이거나 0이다. 뒤의 경우는 구분되지 않은 텍스트 인자를 위한 것인데, 그런
인자는 그룹 안에 들어 있지 않은 첫 쌍반점이나 \KW{endgroup}이나 \KW{end}에서 끝난다.

@<함수들@>=
func scanTextArg(lDelim, rDelim pointer) {
	var balance int32 // |lDelim|이 |rDelim|보다 많은 수
	var p pointer // 목록의 꼬리
	warningInfo = lDelim
	scannerStatus = absorbing
	p = holdHead
	balance = 1
	setLink(holdHead, null)
	for {
		getNext()
		if lDelim == 0 {
			@<구분되지 않은 인자의 균형을 고친다; 끝났으면 루프를 빠져나간다@>
		} else {
			@<구분된 인자의 균형을 고친다; 끝났으면 루프를 빠져나간다@>
		}
		setLink(p, curTok())
		p = link(p)
	}
	curExp = link(holdHead)
	curType = tokenList
	scannerStatus = normal
}

@ @<구분된 인자의 균형을...@>=
if curCmd == rightDelimiter {
	if curMod == lDelim {
		balance--
		if balance == 0 {
			break
		}
	}
} else if curCmd == leftDelimiter {
	if curMod == rDelim {
		balance++
	}
}

@ @<구분되지 않은 인자의 균형을...@>=
if endOfStatement() { // |curCmd=semicolon|, |endGroup|, 또는 |stop|
	if balance == 1 {
		break
	} else if curCmd == endGroup {
		balance--
	}
} else if curCmd == beginGroup {
	balance++
}

@ @<구분되지 않은 인자들을...@>=
if info(r) < textMacro {
	getXNext()
	if info(r) != suffixMacro {
		if curCmd == equals || curCmd == assignment {
			getXNext()
		}
	}
}
switch info(r) {
case primaryMacro:
	scanPrimary()
case secondaryMacro:
	scanSecondary()
case tertiaryMacro:
	scanTertiary()
case exprMacro:
	scanExpression()
case ofMacro:
	@<식과 그 뒤의 `\KW{of} $\langle$일차식$\rangle$'을 훑는다@>
case suffixMacro:
	@<구분자가 있을 수도 있는 첨자를 훑는다@>
case textMacro:
	scanTextArg(0, 0)
} // 다른 경우는 없다
backInput()
@<현재 식을 |argList|에...@>

@ @<식과 그 뒤의 `\KW{of}...@>=
scanExpression()
p = getAvail()
setInfo(p, stashCurExp())
if internal[tracingMacros] > 0 {
	beginDiagnostic()
	printArg(info(p), n, 0)
	endDiagnostic(false)
}
if argList == null {
	argList = p
} else {
	setLink(tail, p)
}
tail = p
n++
if curCmd != ofToken {
	missingErr("of")
	printStr(" for ")
@.Missing `of'@>
	printMacroName(argList, macroName)
	help1("I've got the first argument; will look now for the other.")
	backError()
}
getXNext()
scanPrimary()

@ @<구분자가 있을 수도 있는...@>=
if curCmd != leftDelimiter {
	lDelim = null
} else {
	lDelim = curSym
	rDelim = curMod
	getXNext()
}
scanSuffix()
if lDelim != null {
	if curCmd != rightDelimiter || curMod != lDelim {
		missingErr(text(rDelim))
@.Missing `)'@>
		help2("I've gotten to the end of the macro parameter list.",
			"You might want to delete some tokens before continuing.")
		backError()
	}
	getXNext()
}

@ 새 토큰 목록을 입력 스택에 넣기 전에, 최근에 다 쓴 토큰 목록들을 모두 치우는 것이 현명하다. 그러면 자기 자신을
부르는 것으로 끝나는 사용자 매크로가 끝없는 스택 공간을 요구하지 않는다. 곧 꼬리 재귀가 되풀이가 된다.

@<인자와 바꿈 텍스트를...@>=
for tokenState() && loc == null {
	endTokenList() // 스택 공간을 아낀다
}
if paramPtr+n > maxParamStack {
	maxParamStack = paramPtr + n
	if maxParamStack > paramSize {
		overflow("parameter stack size", paramSize)
	}
@:METAFONT capacity exceeded parameter stack size}{\quad parameter stack size@>
}
beginTokenList(defRef, macro)
name = macroName
loc = r
if n > 0 {
	p = argList
	for {
		paramStack[paramPtr] = info(p)
		paramPtr++
		p = link(p)
		if p == null {
			break
		}
	}
	flushList(argList)
}

@ 이따금 인자 하나를 |paramStack|에 넣어야 한다. 서브루틴 |stackArgument|가 이 일을 한다.

@<함수들@>=
func stackArgument(p pointer) {
	if paramPtr == maxParamStack {
		maxParamStack++
		if maxParamStack > paramSize {
			overflow("parameter stack size", paramSize)
		}
@:METAFONT capacity exceeded parameter stack size}{\quad parameter stack size@>
	}
	paramStack[paramPtr] = p
	paramPtr++
}

@* 조건문 처리.
이제 \KW{if} 명령을 다루는 방식을 생각해 보자.

조건 안에 조건이 있을 수 있는데, 이 둥지에는 다른 스택들과 독립인 스택이 있다. 전역 변수 넷이 조건 스택의 맨
위를 나타낸다. 그 가운데 |condPtr|는 밀려 내려간 항목이 있으면 그것을 가리키고, |curIf|는 \KW{if}를 처리하고 있는지
\KW{elseif}를 처리하고 있는지 알려 주고, |ifLimit|는 구문상 허용되는 |fiOrElse| 명령의 가장 큰 코드를 지정하고,
|ifLine|은 현재 조건문이 시작된 줄 번호다.

진행 중인 조건이 없으면 조건 스택은 |condPtr=null|, |ifLimit=normal|, |curIf=0|, |ifLine=0|이라는 특별한 상태에
있다. 그렇지 않으면 |condPtr|는 두 낱말짜리 노드를 가리킨다. 첫 낱말의 |type|, |nameType|, |link| 필드에는 다음
수준의 |ifLimit|, |curIf|, |condPtr|가 들어 있고, 둘째 낱말에는 그에 해당하는 |ifLine|이 들어 있다.

@<정의@>=
const @!ifNodeSize = 2 // 조건문을 위한 스택 항목의 낱말 수

func ifLineField(p pointer) int32       { return mem[p+1].sc }
func setIfLineField(p pointer, v int32) { mem[p+1].sc = v }

const (
	@!ifCode = 1 // 값을 구하고 있는 \KW{if}의 코드
	@!fiCode = 2 // \KW{fi}의 코드
	@!elseCode = 3 // \KW{else}의 코드
	@!elseIfCode = 4 // \KW{elseif}의 코드
)

@ @<전역 변수@>=
var @!condPtr pointer // 조건 스택의 맨 위
var @!ifLimit int32 // |fiOrElse| 코드의 상한; |normal .. elseIfCode|
var @!curIf smallNumber // 다루고 있는 조건문의 종류
var @!ifLine int32 // 그 조건문이 시작된 줄

@ @<핵심 변수들의...@>=
condPtr = null
ifLimit = normal
curIf = 0
ifLine = 0

@ @<\MF의 원시 명령을...@>=
primitive("if", ifTest, ifCode)
@!@:if_}{\KW{if} primitive@>
primitive("fi", fiOrElse, fiCode)
eqtb[frozenFi] = eqtb[curSym]
@!@:fi_}{\KW{fi} primitive@>
primitive("else", fiOrElse, elseCode)
@!@:else_}{\KW{else} primitive@>
primitive("elseif", fiOrElse, elseIfCode)
@!@:else_if_}{\KW{elseif} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case ifTest, fiOrElse:
	switch m {
	case ifCode:
		printStr("if")
	case fiCode:
		printStr("fi")
	case elseCode:
		printStr("else")
	default:
		printStr("elseif")
	}

@ 다음은 \KW{if}$\ldots$\KW{fi} 둥지의 현재 수준에서 \KW{elseif}나 \KW{else}나 \KW{fi}에 이를 때까지 텍스트를
무시하는 프로시저다. 일을 마치고 나면 |curMod|가 찾은 토큰을 가리킨다.

\MF의 가장 작은 두 명령 코드는 |ifTest|와 |fiOrElse|다. 그래서 건너뛰는 과정이 조금 더 간단해진다.

@<함수들@>=
func passText() {
	var l int32
	scannerStatus = skipping
	l = 0
	warningInfo = line
	for {
		getNext()
		if curCmd <= fiOrElse {
			if curCmd < fiOrElse {
				l++
			} else {
				if l == 0 {
					break
				}
				if curMod == fiCode {
					l--
				}
			}
		} else {
			@<현재 토큰이 문자열이면 그 참조 횟수를 줄인다@>
		}
	}
	scannerStatus = normal
}

@ @<현재 토큰이 문자열이면...@>=
if curCmd == stringToken {
	deleteStrRef(curMod)
}

@ 새 \KW{if}를 처리하기 시작할 때 |ifLimit=ifCode|로 놓는다. 그러면 현재 \KW{if}의 조건을 계산하기 전에 \KW{elseif}나
\KW{else}나 \KW{fi}가 나오면 쌍점을 끼워 넣는다. 그러지 않으면 `\.{if fi}' 같은 구성이 \MF를 헷갈리게 할 것이다.

@<조건 스택에 밀어 넣는다@>=
p = getNode(ifNodeSize)
setLink(p, condPtr)
setType(p, ifLimit)
setNameType(p, curIf)
setIfLineField(p, ifLine)
condPtr = p
ifLimit = ifCode
ifLine = line
curIf = ifCode

@ @<조건 스택에서 꺼낸다@>=
p = condPtr
ifLine = ifLineField(p)
curIf = nameType(p)
ifLimit = typ(p)
condPtr = link(p)
freeNode(p, ifNodeSize)

@ 다음은 주어진 |condPtr| 값에 해당하는 |ifLimit| 코드를 바꾸는 프로시저다.

@<함수들@>=
func changeIfLimit(l smallNumber, p pointer) {
	var q pointer
	if p == condPtr {
		ifLimit = l // 그것은 쉬운 경우다
		return
	}
	q = condPtr
	for {
		if q == null {
			confusion("if")
		}
@:this can't happen if}{\quad if@>
		if link(q) == p {
			setType(q, l)
			return
		}
		q = link(q)
	}
}

@ 사용자는 조건문의 알맞은 자리에 쌍점을 넣어야 한다. 그러므로 \MF는 쌍점이 있는지 검사해야 한다.

@<함수들@>=
func checkColon() {
	if curCmd != colon {
		missingErr(":")
@.Missing `:'@>
		help2("There should've been a colon after the condition.",
			"I shall pretend that one was there.")
		backError()
	}
}

@ 조건은 |getXNext| 프로시저가 |ifTest| 명령을 만나면 시작된다. 그 경우 |getXNext|는 |conditional|을 부르는데,
이것은 재귀적인 프로시저다.
@^recursion@>

조건이 거짓이면 다음 \KW{elseif}나 \KW{else}나 \KW{fi}까지 건너뛴다. \KW{elseif}면 처음으로 돌아가(|reswitch|)
새 조건을 계산하고, \KW{else}면 조건이 참인 것처럼 꾸며(|found|) 그 몸체를 읽기 시작한다.

@<함수들@>=
func conditional() {
	var saveCondPtr pointer // 이 조건문에 해당하는 |condPtr|
	var newIfLimit int32 // |ifLimit|의 앞날의 값; |fiCode .. elseIfCode|
	var p pointer // 임시 레지스터
	@<조건 스택에 밀어 넣는다@>
	saveCondPtr = condPtr
reswitch:
	getBoolean()
	newIfLimit = elseIfCode
	if internal[tracingCommands] > unity {
		@<|curExp|의 불 값을 보인다@>
	}
found:
	checkColon()
	if curExp == trueCode {
		changeIfLimit(newIfLimit, saveCondPtr)
		return // \KW{elseif}나 \KW{else}나 \KW{fi}를 기다린다
	}
	@<\KW{elseif}나 \KW{else}나 \KW{fi}까지 건너뛴다@>
	curIf = curMod
	ifLine = line
	if curMod == fiCode {
		@<조건 스택에서 꺼낸다@>
	} else if curMod == elseIfCode {
		goto reswitch
	} else {
		curExp = trueCode
		newIfLimit = fiCode
		getXNext()
		goto found
	}
}

@ `\KW{if} \KW{if} \KW{true}: $0=1$: \\{foo} \KW{else}: \\{bar} \KW{fi}' 같은 구성에서는, \KW{if}가 거짓이라는 것을
알게 된 다음 처음 만나는 \KW{else}가 우리가 찾는 \KW{else}가 아니다. 그래서 다음의 묘한 논리가 필요하다.

@<\KW{elseif}나 \KW{else}나 \KW{fi}까지...@>=
for {
	passText()
	if condPtr == saveCondPtr {
		break
	} else if curMod == fiCode {
		@<조건 스택에서 꺼낸다@>
	}
}

@ @<|curExp|의 불 값을...@>=
beginDiagnostic()
if curExp == trueCode {
	printStr("{true}")
} else {
	printStr("{false}")
}
endDiagnostic(false)

@ 조건문의 처리는 다음 코드를 빼면 끝났다. 이 코드는 실은 |getXNext|의 일부다. \KW{elseif}나 \KW{else}나
\KW{fi}를 훑었을 때 작동한다.

@<현재 조건문을 끝내고...@>=
if curMod > ifLimit {
	if ifLimit == ifCode { // 조건을 아직 계산하지 않았다
		missingErr(":")
@.Missing `:'@>
		backInput()
		curSym = frozenColon
		insError()
	} else {
		printErr("Extra ")
		printCmdMod(fiOrElse, curMod)
@.Extra else@>
@.Extra elseif@>
@.Extra fi@>
		help1("I'm ignoring this; it doesn't match any if.")
		reportError()
	}
} else {
	for curMod != fiCode {
		passText() // \KW{fi}까지 건너뛴다
	}
	@<조건 스택에서 꺼낸다@>
}

@* 되풀이.
프로시저 |getXNext|의 처리를 마무리하려면 \MF가 \KW{for}, \KW{forsuffixes}, \KW{forever}를 보았을 때 무엇을 하는지 생각해야
한다.

지금 활성인 \KW{for} 루프들을 기억하는 전역 변수 |loopPtr|가 있다. 만일 |loopPtr=null|이면 진행 중인 루프가 없다. 그렇지
않으면 |info(loopPtr)|는 현재의 (가장 안쪽) 루프의 되풀이 텍스트를 가리키고, |link(loopPtr)|는 현재 루프를 둘러싼
다른 루프들의 자료를 가리킨다.

루프 제어 노드에는 |loopType|과 |loopList|라는 다른 필드도 둘 있는데, 그 내용은 루프의 종류에 따라 다르다.

\yskip\indent 값 |loopType(loopPtr)=null|은 |loopList(loopPtr)|가 한 낱말짜리 노드들의 목록을 가리키는데, 그 |info|
필드가 첨자 목록이나 식 목록의 남은 인자 값들을 가리킨다는 뜻이다.

\yskip\indent 값 |loopType(loopPtr)=void|는 현재 루프가 `\KW{forever}'라는 뜻이다.

\yskip\indent 값 |loopType(loopPtr)=p>void|는 |value(p)|, |stepSize(p)|, |finalValue(p)|에 등차수열의 자료가 들어 있다는
뜻이다.

\yskip\noindent 마지막 경우에 |p|는 첫 낱말을 쓰지 않는 ``수열 노드''를 가리킨다. (동적 메모리 영역의 낱말의 연결
필드는 아무 값이나 될 수 없으므로 거기에는 값을 저장할 수 없었다.)

@<정의@>=
func loopListLoc(p pointer) pointer     { return p + 1 } // |loopList| 필드가 사는 곳
func loopType(p pointer) pointer        { return info(loopListLoc(p)) } // \KW{for} 루프의 종류
func setLoopType(p pointer, v pointer)  { setInfo(loopListLoc(p), v) }
func loopList(p pointer) pointer        { return link(loopListLoc(p)) } // 남은 목록 원소들
func setLoopList(p pointer, v pointer)  { setLink(loopListLoc(p), v) }

const (
	@!loopNodeSize = 2 // 루프 제어 노드의 낱말 수
	@!progressionNodeSize = 4 // 수열 노드의 낱말 수
)

func stepSize(p pointer) scaled          { return mem[p+2].sc } // 등차수열의 공차
func setStepSize(p pointer, v scaled)    { mem[p+2].sc = v }
func finalValue(p pointer) scaled        { return mem[p+3].sc } // 등차수열의 마지막 값
func setFinalValue(p pointer, v scaled)  { mem[p+3].sc = v }

@ @<전역 변수@>=
var @!loopPtr pointer // 루프 제어 노드 스택의 맨 위

@ @<핵심 변수들의...@>=
loopPtr = null

@ \KW{for} 루프의 등차수열을 정의하는 식들이 알려진 수치 값을 갖지 않으면 서브루틴 |badFor|가 사용자에게 소리친다.

@<함수들@>=
func badFor(s string) {
	dispErr(null, "Improper ") // 메시지 위에 나쁜 식을 보인다
@.Improper...replaced by 0@>
	printStr(s)
	printStr(" has been replaced by 0")
	help4("When you say `for x=a step b until c',",
		"the initial value `a' and the step size `b'",
		"and the final value `c' must have known numeric values.",
		"I'm zeroing this one. Proceed, with fingers crossed.")
	putGetFlushError(0)
}

@ 다음은 \KW{for}나 \KW{forsuffixes}나 \KW{forever}를 방금 훑었을 때 \MF가 하는 일이다. (이 코드를 이해하려면 아직
논의하지 않은 식 구문 분석 루틴에 조금 익숙해야 한다. 그러나 저자가 나중에야 썼는데도 프로그램의 이 부분에
속하는 것 같다. 독자는 나중에 여기로 돌아오고 싶을지도 모른다.)

@<함수들@>=
func beginIteration() {
	var m halfword // |exprBase|(\KW{for})나 |suffixBase|(\KW{forsuffixes})
	var n halfword // 현재 기호의 해시 주소
	var p, q, s, pp pointer // 연결 조작 레지스터들
	m = curMod
	n = curSym
	s = getNode(loopNodeSize)
	if m == startForever {
		setLoopType(s, void)
		p = null
		getXNext()
		goto found
	}
	getSymbol()
	p = getNode(tokenNodeSize)
	setInfo(p, curSym)
	setValue(p, m)
	getXNext()
	if curCmd != equals && curCmd != assignment {
		missingErr("=")
@.Missing `='@>
		help3("The next thing in this loop should have been `=' or `:='.",
			"But don't worry; I'll pretend that an equals sign",
			"was present, and I'll look for the values next.")
		backError()
	}
	@<루프에 쓸 값들을 훑는다@>
found:
	@<쌍점이 있는지 검사한다@>
	@<루프 텍스트를 훑어서 루프 제어 스택에 넣는다@>
	resumeIteration()
}

@ @<쌍점이 있는지...@>=
if curCmd != colon {
	missingErr(":")
@.Missing `:'@>
	help3("The next thing in this loop should have been a `:'.",
		"So I'll pretend that a colon was present;",
		"everything from here to `endfor' will be iterated.")
	backError()
}

@ 루프의 끝에서 `\KW{endfor}' 대신 특별한 |frozenRepeatLoop| 토큰을 덧붙인다. 이것이 알맞은 때에 \MF의 훑개를
지나오면서 루프를 되풀이하게 한다.

(`\KW{for} $\ldots$ \KW{let} \KW{endfor}' 같은 장난을 치려는 사용자는 얼어붙은 토큰을 바꾸지 않고 두는 |getSymbol|
루틴에 막힐 것이다. 게다가 |frozenRepeatLoop|은 \KW{outer} 토큰이므로 실수로 잃어버리는 일도 없다.)

@ @<루프 텍스트를 훑어서...@>=
q = getAvail()
setInfo(q, frozenRepeatLoop)
scannerStatus = loopDefining
warningInfo = n
setInfo(s, scanToks(iteration, p, q, 0))
scannerStatus = normal
setLink(s, loopPtr)
loopPtr = s

@ @<표의 항목들을...@>=
setEqType(frozenRepeatLoop, repeatLoop+outerTag)
setText(frozenRepeatLoop, str(" ENDFOR"))

@ @<번호로 쓰이는 문자열 상수들@>=
" ENDFOR",

@ 루프 텍스트는 루틴 |resumeIteration|이 \MF의 훑기 장치에 끼워 넣는다.

@<함수들@>=
func resumeIteration() {
	var p, q pointer // 연결 레지스터들
	p = loopType(loopPtr)
	if p > void { // |p|는 수열 노드를 가리킨다
		curExp = value(p)
		ended := @<등차수열이 끝났다@>
		if ended {
			goto notFound
		}
		curType = known
		q = stashCurExp() // |q|를 \KW{expr} 인자로 만든다
		setValue(p, curExp+stepSize(p)) // 다음 되풀이를 위해 |value(p)|를 놓는다
	} else if p < void {
		p = loopList(loopPtr)
		if p == null {
			goto notFound
		}
		setLoopList(loopPtr, link(p))
		q = info(p)
		freeAvail(p)
	} else {
		beginTokenList(info(loopPtr), foreverText)
		return
	}
	beginTokenList(info(loopPtr), loopText)
	stackArgument(q)
	if internal[tracingCommands] > unity {
		@<루프의 시작을 추적한다@>
	}
	return
notFound:
	stopIteration()
}

@ @<등차수열이 끝났다@>=
(stepSize(p) > 0 && curExp > finalValue(p)) || (stepSize(p) < 0 && curExp < finalValue(p))

@ @<루프의 시작을 추적한다@>=
beginDiagnostic()
printNl("{loop value=")
@.loop value=n@>
if q != null && link(q) == void {
	printExp(q, 1)
} else {
	showTokenList(q, null, 50, 0)
}
printChar('}')
endDiagnostic(false)

@ 루틴 |resumeIteration|이 되풀이하지 않기로 했을 때나, \KW{exitif} 구성이 입력 스택에서 루프 텍스트를 없앴을 때 루프
제어의 한 수준이 사라진다.

@<함수들@>=
func stopIteration() {
	var p, q pointer // 늘 쓰는 것들
	p = loopType(loopPtr)
	if p > void {
		freeNode(p, progressionNodeSize)
	} else if p < void {
		q = loopList(loopPtr)
		for q != null {
			p = info(q)
			if p != null {
				if link(p) == void { // \KW{expr} 매개변수다
					recycleValue(p)
					freeNode(p, valueNodeSize)
				} else {
					flushTokenList(p) // \KW{suffix}나 \KW{text} 매개변수다
				}
			}
			p = q
			q = link(q)
			freeAvail(p)
		}
	}
	p = loopPtr
	loopPtr = link(p)
	flushTokenList(info(p))
	freeNode(p, loopNodeSize)
}

@ 이제 루프 제어에 관해 다 알았으니 |beginIteration|의 빠진 부분을 마무리하면 끝이다.

다음 코드는 \KW{for} 구성(|m=exprBase|이면)이나 \KW{forsuffixes} 구성(|m=suffixBase|이면)에서 `\.='를 훑은 다음에
실행된다. 값이 빠진 자리(이를테면 `\.{for x=1,,3}'의 가운데)에 이르면 그 값은 목록에 넣지 않는다. 원본은
그때 루프의 끝 검사로 바로 뛰어간다(|goto continue|).

@<루프에 쓸 값들을...@>=
setLoopType(s, null)
q = loopListLoc(s)
setLink(q, null) // |link(q)=loopList(s)|
for {
	getXNext()
	if m != exprBase {
		scanSuffix()
	} else {
		if curCmd >= colon && curCmd <= comma { // 값이 빠졌다
			if curCmd != comma {
				break
			}
			continue
		}
		scanExpression()
		if curCmd == stepToken && q == loopListLoc(s) {
			@<\KW{step}--\KW{until} 구성을 준비하고 루프를 빠져나간다@>
		}
		curExp = stashCurExp()
	}
	setLink(q, getAvail())
	q = link(q)
	setInfo(q, curExp)
	curType = vacuous
	if curCmd != comma {
		break
	}
}

@ @<\KW{step}--\KW{until} 구성을...@>=
if curType != known {
	badFor("initial value")
}
pp = getNode(progressionNodeSize)
setValue(pp, curExp)
getXNext()
scanExpression()
if curType != known {
	badFor("step size")
}
setStepSize(pp, curExp)
if curCmd != untilToken {
	missingErr("until")
@.Missing `until'@>
	help2("I assume you meant to say `until' after `step'.",
		"So I'll look for the final value and colon next.")
	backError()
}
getXNext()
scanExpression()
if curType != known {
	badFor("final value")
}
setFinalValue(pp, curExp)
setLoopType(s, pp)
break

@* 파일 이름.
이제 파일 이름에 대해 애를 태울 때가 되었다. 운영체제마다 파일을 다르게 다룬다는 사실 말고도, 사람들의 무리마다
완전히 다른 이름 짓기 관례를 쓴다는 사실을 감당해야 한다. 다음 프로그램들은 어느 한 운영체제에서 필요한 것을
보여 준다. 다른 시스템을 위한 비슷한 루틴을 고안하기는 어렵지 않다.
@^system dependencies@>

\MF는 파일 이름이 세 부분, 곧 본디 이름과 ``확장자''와 바깥 파일 시스템에서 그것을 찾을 ``파일 영역''으로
이루어진다고 가정한다. 입력 파일의 확장자는 따로 지정하지 않으면 `\.{.mf}'라고 가정한다. \MF의 각 실행을 기록하는
기록 파일은 `\.{.log}', \MF가 만드는 글꼴의 문자들을 묘사하는 글꼴 계량 파일은 `\.{.tfm}', 일반 글꼴 정보를 지정하는
출력 파일은 `\.{.gf}', \.{INIMF}가 \MF를 초기화하려고 쓰는 기반 파일은 `\.{.base}'다. 입력 파일의 영역은 무엇이든
될 수 있지만, 파일은 대개 사용자의 현재 영역에 출력된다. 입력 파일을 지정한 영역에서 찾을 수 없으면 \MF는 특별한
시스템 영역에서 찾는다. 이 특별한 영역은 흔히 쓰는 입력 파일을 위한 것이다.

\MF를 간단히 쓸 때는 명시적인 확장자나 영역이 없는 파일 이름만 쓴다. 이를테면 사람들은 대개 `\.{input}
\.{cmr10.new}' 대신 `\.{input} \.{cmr10}'이라고 한다. 간단한 파일 이름이 가장 좋다. 그래야 \MF\ 원본 파일을 옮겨 갈
수 있기 때문이다. 파일 이름이 글자와 숫자로만 이루어져 있으면 \MF의 모든 구현이 그것을 똑같이 다루어야 한다.
그러나 사용자는 자기 환경의 다른 파일들을, 특히 열 수 없는 파일에 관한 오류 메시지에 대답할 때 가리킬 수 있어야
한다. 그래서 그들이 좋아하는 운영체제의 문법을 쓰게 해 주고 싶다.

@ \MF는 \TeX에서 만족스러웠던 관례를 그대로 쓴다. 파일 이름의 시스템 의존적인 면을 따로 떼어 내려고, \MF의
@^system dependencies@>
시스템 독립 부분은 |beginName|, |moreName|, |endName|이라는 세 시스템 의존 프로시저로 표현된다. 본질적으로, 사용자가
지정한 파일 이름의 문자들이 $c_1\ldots c_n$이면 시스템 독립 구동 프로그램은 다음 연산들을 한다.
$$|beginName|;\,|moreName|(c_1);\,\ldots\,;\,|moreName|(c_n);\,|endName|.$$
이 세 프로시저는 전역 변수로 서로 소통한다. 그 뒤에 파일 이름은 문자열 풀에 |curName|\penalty10000\hskip-.05em,
|curArea|, |curExt|라는 세 문자열로 나타난다. 뒤의 둘은 사용자가 명시적으로 지정하지 않는 한 널(곧 |""|)이다.

실제 상황은 조금 더 복잡하다. \MF는 파일 이름이 어디서 끝나는지 알아야 하기 때문이다. 루틴 |moreName|은 (부수
효과가 있는) 함수로서, 호출 |moreName|$(c_1)$, \dots, |moreName|$(c_{n-1})$에서 |true|를 돌려준다. 마지막 호출
|moreName|$(c_n)$은 |false|를 돌려주거나, |true|를 돌려주고 $c_n$이 현재 입력 줄의 마지막 문자다. 다시 말하면
|moreName|은 파일 이름을 다 훑었다고 확신하지 않는 한 |true|를 돌려주기로 되어 있고, |endName|은 $|moreName|(c_n)$이
|true|를 돌려주었든 |false|를 돌려주었든 |curName|, |curArea|, |curExt|의 조립을 마칠 수 있어야 한다.

@<전역 변수@>=
var @!curName strNumber // 방금 훑은 파일의 이름
var @!curArea strNumber // 방금 훑은 파일 영역, 또는 \.{""}
var @!curExt strNumber // 방금 훑은 파일 확장자, 또는 \.{""}

@ 설명을 위해 다룰 파일 이름은 다음 구조를 지닌다. 이름에 `\.>'나 `\.:'가 들어 있으면 파일 영역은 그런 문자 가운데
마지막 것까지(그것을 포함해서)의 모든 문자로 이루어진다. 그렇지 않으면 파일 영역은 널이다. 나머지 파일 이름에
`\..'가 들어 있으면 파일 확장자는 남은 첫 `\..'부터 끝까지의 문자들로 이루어지고, 그렇지 않으면 파일 확장자는 널이다.
@^system dependencies@>

영역 구분자와 확장자 구분자가 나타나는 곳을 추적하는 전역 변수 둘을 쓰면 그런 파일 이름을 쉽게 훑을 수 있다.

유닉스 계열의 시스템에서는 `\./'가 디렉터리를 가르므로, |moreName|은 `\.>'와 `\.:'에 더해 `\./'도 영역 구분자로
알아본다. 이를테면 `\.{input ../fonts/cmr10}'에서 영역은 `\.{../fonts/}', 이름은 `\.{cmr10}', 확장자는 널이 되므로
`\.{.mf}'가 붙고, 작업 이름은 `\.{cmr10}'이 된다.

@<전역 변수@>=
var @!areaDelimiter poolPointer // 가장 최근의 `\.>'나 `\.:'나 `\./', 있다면
var @!extDelimiter poolPointer // 관련된 `\..', 있다면

@ \seclabel{mf-area}사용자의 영역에서 찾을 수 없는 입력 파일은 |mfArea|라는 표준 시스템 영역에 있을 수 있다. 물론 이
시스템 영역 이름은 곳마다 다를 것이다. 이 영역 이름이 실제로 어디를 가리키는지는 함수 |externalName|이
정한다(\secref{external-name}).
@^system dependencies@>

이것은 풀 문자열의 번호를 담은 꾸러미 변수다. \GO/는 꾸러미 변수를 초기화할 때 |poolLiterals|를 먼저 초기화하므로
|str|을 불러도 된다.

@<전역 변수@>=
var mfArea = str("MFinputs:")
@.MFinputs@>

@ @<번호로 쓰이는 문자열 상수들@>=
"MFinputs:", ".mf", ".log", ".gf", ".tfm", ".base", "mfput",

@ 다음은 파일 이름 훑기를 위한 시스템 의존 루틴 가운데 첫째다.
@^system dependencies@>

@<함수들@>=
func beginName() {
	areaDelimiter = 0
	extDelimiter = 0
}

@ 그리고 다음은 둘째다.
@^system dependencies@>

@<함수들@>=
func moreName(c asciiCode) bool {
	if c == ' ' {
		return false
	}
	if c == '>' || c == ':' || c == '/' {
		areaDelimiter = poolPtr
		extDelimiter = 0
	} else if c == '.' && extDelimiter == 0 {
		extDelimiter = poolPtr
	}
	strRoom(1)
	appendChar(c) // |c|를 현재 문자열에 보탠다
	return true
}

@ 셋째다. 영역과 이름과 확장자는 풀의 잇닿은 문자들이므로, 구분자의 위치에서 |strStart|를 나누기만 하면 문자열
셋이 된다.
@^system dependencies@>

@<함수들@>=
func endName() {
	if strPtr+3 > maxStrPtr {
		if strPtr+3 > maxStrings {
			overflow("number of strings", maxStrings-initStrPtr)
		}
@:METAFONT capacity exceeded number of strings}{\quad number of strings@>
		maxStrPtr = strPtr + 3
	}
	if areaDelimiter == 0 {
		curArea = str("")
	} else {
		curArea = strPtr
		strPtr++
		strStart[strPtr] = areaDelimiter + 1
	}
	if extDelimiter == 0 {
		curExt = str("")
		curName = makeString()
	} else {
		curName = strPtr
		strPtr++
		strStart[strPtr] = extDelimiter
		curExt = makeString()
	}
}

@ 거꾸로, 다음은 세 문자열을 받아서 그것들을 만들어 냈을 법한 파일 이름을 찍는 루틴이다. (어떤 운영체제는 파일
영역을 처음이 아니라 마지막에 두므로 이 루틴은 시스템에 따라 다르다.)
@^system dependencies@>

@<기본 인쇄...@>=
func printFileName(n, a, e int32) {
	slowPrint(a)
	slowPrint(n)
	slowPrint(e)
}

@ \MF의 내부 문자열 셋을 파일을 열 때 쓰는 |nameOfFile| 값으로 바꾸는 시스템 의존 루틴이 또 하나 필요하다. 지금의
코드는 파일 이름에 소문자와 대문자를 다 허용한다.
@^system dependencies@>

작은 함수 |appendToName|은 부르는 쪽의 계수기 |k|를 하나 늘리고 문자 |c|를 |nameOfFile[k]|에 넣는다. 다음 절의
|packBufferedName|에서도 쓰이므로 계수기는 포인터로 받는다.

@<함수들@>=
func appendToName(k *int32, c asciiCode) {
	*k++
	if *k <= fileNameSize {
		nameOfFile[*k] = xchr[c]
	}
}

func packFileName(n, a, e strNumber) {
	var k int32 // |nameOfFile|에서 채운 위치의 수
	var j poolPointer // |strPool|의 첨자
	k = 0
	for j = strStart[a]; j <= strStart[a+1]-1; j++ {
		appendToName(&k, so(strPool[j]))
	}
	for j = strStart[n]; j <= strStart[n+1]-1; j++ {
		appendToName(&k, so(strPool[j]))
	}
	for j = strStart[e]; j <= strStart[e+1]-1; j++ {
		appendToName(&k, so(strPool[j]))
	}
	nameLength = min(k, fileNameSize)
	for k = nameLength + 1; k <= fileNameSize; k++ {
		nameOfFile[k] = ' '
	}
}

@ 더 지저분한 루틴도 필요하다. 기반 파일의 이름은 \MF의 문자열 장치가 초기화되기 전에 훑어야 하기 때문이다. 전역
변수 |mfBaseDefault|를 써서 기반 파일에 관련된 기본 시스템 영역과 확장자의 텍스트를 준다.
@^system dependencies@>

@<전역 변수@>=
const (
	@!baseDefaultLength = 18 // 문자열 |mfBaseDefault|의 길이
	@!baseAreaLength = 8 // 그 영역 부분의 길이
	@!baseExtLength = 5 // 그 `\.{.base}' 부분의 길이
)

var baseExtension = str(".base") // 확장자, 풀 문자열로서

var @!mfBaseDefault [baseDefaultLength + 1]textChar

@ @<핵심 변수들의...@>=
copy(mfBaseDefault[1:], "MFbases:plain.base")
@.MFbases@>
@.plain@>
@^system dependencies@>

@ @<``상수'' 값들이...@>=
if baseDefaultLength > fileNameSize {
	bad = 41
}

@ 다음은 방금 말한 지저분한 루틴이다. 이것은 |nameOfFile|을 |mfBaseDefault|의 처음 |n|문자, |buffer[a .. b]|,
|mfBaseDefault|의 마지막 |baseExtLength|문자를 차례로 이은 것으로 놓는다.

\MF는 |reportError| 루틴이 움직일 준비가 되기 전에 이 루틴을 부르므로, 여기서는 감히 오류 메시지를 낼 수 없다. 그
대신 남는 문자들을 그냥 버린다. 이상한 파일 이름을 찾지 못하면 오류가 다른 방법으로 드러날 것이기 때문이다.
@^system dependencies@>

@<함수들@>=
func packBufferedName(n smallNumber, a, b int32) {
	var k int32 // |nameOfFile|에서 채운 위치의 수
	var j int32 // |buffer|나 |mfBaseDefault|의 첨자
	if n+b-a+1+baseExtLength > fileNameSize {
		b = a + fileNameSize - n - 1 - baseExtLength
	}
	k = 0
	for j = 1; j <= n; j++ {
		appendToName(&k, xord[mfBaseDefault[j]])
	}
	for j = a; j <= b; j++ {
		appendToName(&k, buffer[j])
	}
	for j = baseDefaultLength - baseExtLength + 1; j <= baseDefaultLength; j++ {
		appendToName(&k, xord[mfBaseDefault[j]])
	}
	nameLength = min(k, fileNameSize)
	for k = nameLength + 1; k <= fileNameSize; k++ {
		nameOfFile[k] = ' '
	}
}

@ \seclabel{base-default}다음은 |packBufferedName|을 쓰는 유일한 곳이다. 프로그램의 이 부분은 ``처녀'' \MF가 예비 초기화를 막
마치고 움직이기 시작하려 할 때나, 사용자가 처음의 `\.{**}' 재촉 기호 뒤에 `\.\&'를 쳐서 다른 기반 파일로 바꿀 때
작동한다. 버퍼에는 입력의 첫 줄이 |buffer[loc .. (last-1)]|에 들어 있는데, |loc<last|이고 |buffer[loc]!=" "|다.

@<함수들@>=
func openBaseFile() bool {
	var j int32 // 파일 이름 뒤의 첫 공백; |0 .. bufSize|
	j = loc
	if buffer[loc] == '&' {
		loc++
		j = loc
		buffer[last] = ' '
		for buffer[j] != ' ' {
			j++
		}
		packBufferedName(0, loc, j-1) // 먼저 시스템 파일 영역 없이 해 본다
		if wOpenIn(&baseFile) {
			goto found
		}
		packBufferedName(baseAreaLength, loc, j-1) // 이제 시스템 기반 파일 영역을 해 본다
		if wOpenIn(&baseFile) {
			goto found
		}
		wakeUpTerminal()
		wtermLn("Sorry, I can't find that base;", " will try PLAIN.")
@.Sorry, I can't find...@>
		updateTerminal()
	}
	// 이제 모든 수단을 써 본다: 시스템의 \.{plain} 파일을 찾는다
	packBufferedName(baseDefaultLength-baseExtLength, 1, 0)
	if !wOpenIn(&baseFile) {
		wakeUpTerminal()
		wtermLn("I can't find the PLAIN base file!")
@.I can't find PLAIN...@>
@.plain@>
		return false
	}
found:
	loc = j
	return true
}

@ 운영체제는 흔히 열린 파일의 정확한 이름(과 판 번호)을 알아낼 수 있게 해 준다. 다음 루틴은 그저 |nameOfFile|의
값으로 \MF\ 문자열을 만드는데, 될 수 있으면 가장 최근에 연 파일~|f|의 온전한 이름을 알아내도록 하는 것이 좋다.
@^system dependencies@>

이 루틴은 문자열 메모리가 넘친 뒤에 불릴 수도 있으므로 감히 `|strRoom|'을 쓸 수 없다.

\GO/에서는 열린 파일의 실제 경로를 |f.f.Name()|으로 알 수 있다. 그래서 |aMakeNameString| 따위는 그 경로를
|nameOfFile|에 넣은 뒤 |makeNameString|을 부른다. 이를테면 \MF가 `\.{MFinputs:}' 영역에서 찾은 파일의 이름은 그
파일의 실제 경로로 찍힌다.

@<함수들@>=
func makeNameString() strNumber {
	var k int32 // |nameOfFile|의 첨자; |1 .. fileNameSize|
	if poolPtr+nameLength > poolSize || strPtr == maxStrings {
		return '?'
	}
	for k = 1; k <= nameLength; k++ {
		appendChar(xord[nameOfFile[k]])
	}
	return makeString()
}

func setNameOfFile(nm string) { // 열린 파일의 실제 경로를 |nameOfFile|에 넣는다
	if len(nm) > fileNameSize {
		return
	}
	nameLength = int32(copy(nameOfFile[1:], nm))
}

func aMakeNameString(f *alphaFile) strNumber {
	if f.f != nil {
		setNameOfFile(f.f.Name())
	}
	return makeNameString()
}

func bMakeNameString(f *byteFile) strNumber {
	if f.f != nil {
		setNameOfFile(f.f.Name())
	}
	return makeNameString()
}

func wMakeNameString(f *wordFile) strNumber {
	if f.f != nil {
		setNameOfFile(f.f.Name())
	}
	return makeNameString()
}

@ 이제 \MF가 시스템과 상관없는 방식으로 파일 이름을 다루는 ``구동'' 루틴들을 살펴보자. 먼저 입력 버퍼에서 정보를
가져와 입력에서 파일 이름을 찾는 프로시저가 온다. (프로시저 |getNext|는 쓸 수 없다. 토큰으로 바꾸면 필요한 정보가 망가지기
때문이다.)

이 프로시저는 쌍반점이나 퍼센트 기호가 파일 이름의 일부가 되는 것을 허용하지 않는다. \MF의 다른 관례 때문이다.
설명서는 파일 이름 바로 뒤에 쌍반점이나 퍼센트를 쓰지 않지만, 틀림없이 어떤 사용자는 그렇게 하는 것을 자연스럽게
여길 것이다. 그러므로 파일 이름에 그런 문자를 허용하는 시스템 의존 변경은 마지못해서만, 그리고 특별한 문자를
포함한 파일 이름 전체를 어떤 식으로든 ``따옴표로 묶을'' 때에만 해야 할 것이다.
@^system dependencies@>

@<함수들@>=
func scanFileName() {
	beginName()
	for buffer[loc] == ' ' {
		loc++
	}
	for {
		if buffer[loc] == ';' || buffer[loc] == '%' {
			break
		}
		if !moreName(buffer[loc]) {
			break
		}
		loc++
	}
	endName()
}

@ 전역 변수 |jobName|에는 사용자가 처음 \KW{input}한 파일 이름이 들어 있다. 이 이름에 `\.{.log}'와 `\.{.gf}'와
`\.{.base}'와 `\.{.tfm}'을 붙여 \MF의 출력 파일 이름을 만든다.

@<전역 변수@>=
var @!jobName strNumber // 주된 파일 이름
var @!logOpened bool // 기록 파일을 열었나?
var @!logName strNumber // 기록 파일의 온전한 이름

@ 처음에는 |jobName=0|이다. 참 이름을 알게 되자마자 0이 아니게 된다. `\.{log}' 파일을 열지 않았을 때, 그리고 오직
그때에만 |jobName=0|이다. 물론 |jobName|이 0이 아니게 된 바로 뒤의 잠깐은 빼고 말이다.

@<출력 루틴들을...@>=
jobName = 0
logOpened = false

@ 다음은 |jobName!=0|이라고 가정하고 출력 파일 이름을 만드는 루틴이다. 이것은 |curArea|와 |curExt|의 현재 설정을
무시하고 바꾼다.

@<함수들@>=
func packCurName() { packFileName(curName, curArea, curExt) }

func packJobName(s strNumber) { // |s = ".log"|, |".gf"|, |".tfm"|, 또는 |baseExtension|
	curArea = str("")
	curExt = s
	curName = jobName
	packCurName()
}

@ 실은 주 출력 파일의 확장자는 대개 그냥 |".gf"|가 아니라 |".300gf"| 같은 것이다. 덧붙은 수는 파일을 열 때의
|hppp| 설정에 따른 인치당 화소 수의 해상도를 나타낸다.

@<전역 변수@>=
var @!gfExt strNumber // 출력 파일의 기본 확장자

@ \MF가 파일을 열려다가 문제가 생기면, 다음 루틴이 사용자에게 다른 파일 이름을 대라고 부탁한다. 매개변수~|s|는
오류 메시지에서 파일의 종류를 밝히는 데 쓰고, 매개변수~|e|는 확장자를 주지 않았을 때의 기본 확장자다. 이 루틴을
빠져나가면 변수 |curName|, |curArea|, |curExt|, |nameOfFile|이 파일 열기를 다시 해 볼 준비가 되어 있다.

원본에서 |s|는 문자열 번호여서 |s="input file name"|처럼 비교했지만, 여기서는 찍기만 하므로 \GO/ 문자열로 받는다.

@<함수들@>=
func promptFileName(s string, e strNumber) {
	var k int32 // |buffer|의 첨자; |0 .. bufSize|
	if interaction == scrollMode {
		wakeUpTerminal()
	}
	if s == "input file name" {
		printErr("I can't find file `")
@.I can't find file x@>
	} else {
		printErr("I can't write on file `")
@.I can't write on file x@>
	}
	printFileName(curName, curArea, curExt)
	printStr("'.")
	if e == str(".mf") {
		showContext()
	}
	printNl("Please type another ")
	printStr(s)
@.Please type...@>
	if interaction < scrollMode {
		fatalError("*** (job aborted, file error in nonstop mode)")
	}
@.job aborted, file error...@>
	clearTerminal()
	promptInput(": ")
	@<버퍼의 파일 이름을 훑는다@>
	if curExt == str("") {
		curExt = e
	}
	packCurName()
}

@ @<버퍼의 파일 이름을...@>=
beginName()
k = first
for buffer[k] == ' ' && k < last {
	k++
}
for {
	if k == last {
		break
	}
	if !moreName(buffer[k]) {
		break
	}
	k++
}
endName()

@ 루틴 |openLogFile|은 기록 파일을 열고, 그것이 앞서 터미널에 찍은 것을 따라잡도록 돕는다.

@<함수들@>=
func openLogFile() {
	var oldSetting int32 // 앞의 |selector| 설정; |0 .. maxSelector|
	var k int32 // |months|와 |buffer|의 첨자; |0 .. bufSize|
	var l int32 // 첫 입력 줄의 끝; |0 .. bufSize|
	const months = "JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC" // 달 이름의 약어들
	oldSetting = selector
	if jobName == 0 {
		jobName = str("mfput")
	}
@.mfput@>
	packJobName(str(".log"))
	for !aOpenOut(&logFile) {
		@<다른 기록 파일 이름을 얻어 본다@>
	}
	logName = aMakeNameString(&logFile)
	selector = logOnly
	logOpened = true
	@<날짜와 시각을 포함한 머리줄을 찍는다@>
	inputStack[inputPtr] = curInput() // 맨 아래 수준이 메모리에 있게 한다
	printNl("**")
@.**@>
	l = inputStack[0].limitField - 1 // 첫 줄의 마지막 위치
	for k = 1; k <= l; k++ {
		printStr(buffer[k])
	}
	printLn() // 이제 기록 파일에 입력의 첫 줄이 들어 있다
	selector = oldSetting + 2 // |logOnly|나 |termAndLog|
}

@ 루틴 |openLogFile|은 \MF가 오류 메시지를 찍을 수도 없고 |showContext|조차 할 수 없는 어색한 때에 불리기도 한다.
루틴 |promptFileName|은 |fatalError|로 이어질 수 있지만, |logOpened|가 거짓일 것이므로 |reportError| 루틴은 불리지
않는다.

모드 |batchMode|의 보통의 생각은 터미널에 아무것도 쓰지 않는 것이다. 그러나 기록 파일을 열 수 없는 드문 경우에는 예외로
설명 메시지를 보이도록 허용한다.

덧붙여, 이 프로그램은 기록 파일을 언제나 `\.{transcript file}'이라고 부른다. 어떤 시스템에서는 이 파일에 확장자
`\.{.log}'를 쓸 수 없기 때문이다.

@<다른 기록 파일 이름을...@>=
selector = termOnly
promptFileName("transcript file name", str(".log"))

@ @<날짜와 시각을 포함한...@>=
wlog(banner)
slowPrint(baseIdent)
printStr("  ")
printInt(sysDay)
printChar(' ')
for k = 3*sysMonth - 2; k <= 3*sysMonth; k++ {
	wlog(months[k-1])
}
printChar(' ')
printInt(sysYear)
printChar(' ')
printDd(sysTime / 60)
printChar(':')
printDd(sysTime % 60)

@ 다음은 이 파일 이름 구문 분석 루틴들이 실제로 어떻게 돌아가는지 보이는 보기다. 출력 파일을 띄울 때가 되면
|setOutputFileName|을 부른다.

@<함수들@>=
func setOutputFileName() {
	if jobName == 0 {
		openLogFile()
	}
	packJobName(gfExt)
	for !bOpenOut(&gfFile) {
		promptFileName("file name for output", gfExt)
	}
	outputFileName = bMakeNameString(&gfFile)
}

@ @<전역 변수@>=
var @!gfFile byteFile // 일반 글꼴 출력이 여기로 간다
var @!outputFileName strNumber // 출력 파일의 온전한 이름

@ @<출력 루틴들을...@>=
outputFileName = 0

@ 이제 `\.{input}' 명령을 처리할 때 파일 읽기를 시작하는 프로시저를 보자. 조심할 것: 역사적인 까닭으로 이 코드는
문자열 풀 공간을 아주 조금 어리석게 아낀다. 그러나 그것이 대화형 `\.E' 선택지를 헷갈리게 할 수 있다.
@^system dependencies@>

@<함수들@>=
func startInput() { // \MF가 무언가를 \.{input}한다
	@<원하는 파일 이름을 |(curName,curExt,curArea)|에 넣는다@>
	if curExt == str("") {
		curExt = str(".mf")
	}
	packCurName()
	for {
		beginFileReading() // |curFile|과 새 입력 수준을 마련한다
		if aOpenIn(curFile()) {
			break
		}
		if curArea == str("") {
			packFileName(curName, mfArea, curExt)
			if aOpenIn(curFile()) {
				break
			}
		}
		endFileReading() // 통하지 않은 수준을 없앤다
		promptFileName("input file name", str(".mf"))
	}
	name = aMakeNameString(curFile())
	strRef[curName] = maxStrRef
	if jobName == 0 {
		jobName = curName
		openLogFile()
	} // |openLogFile|은 |showContext|를 하지 않으므로 |limit|와 |loc|은 아직 뜻있는 값이 아니어도 된다
	if termOffset+length(name) > maxPrintLine-2 {
		printLn()
	} else if termOffset > 0 || fileOffset > 0 {
		printChar(' ')
	}
	printChar('(')
	openParens++
	slowPrint(name)
	updateTerminal()
	if name == strPtr-1 { // 문자열 풀 공간을 아낀다(그러나 위의 주의를 보라)
		flushString(name)
		name = curName
	}
	@<새 파일의 첫 줄을 읽는다@>
}

@ 여기서는 루틴 |inputLn|에 |get|으로 시작하지 말라고 일러 주어야 한다는 것을 기억해야 한다. 파일이 비어 있으면
빈 줄 하나를 담은 것으로 본다.
@^system dependencies@>

@<새 파일의 첫 줄을...@>=
line = 1
inputLn(curFile(), false)
firmUpTheLine()
buffer[limit] = '%'
first = limit + 1
loc = start

@ @<원하는 파일 이름을...@>=
for tokenState() && loc == null {
	endTokenList()
}
if tokenState() {
	printErr("File names can't appear within macros")
@.File names can't...@>
	help3("Sorry...I've converted what follows to tokens,",
		"possibly garbaging the name you gave.",
		"Please delete the tokens and insert the name again.")
	reportError()
}
if fileState() {
	scanFileName()
} else {
	curName = str("")
	curExt = str("")
	curArea = str("")
}

@* 구문 분석 루틴 들어가기.
이제 \MF의 많은 활동에 불을 붙이는 중추 신경계에 이르렀다. \MF는 식을 그 일차 구성 요소에서부터 점점 더 큰 부분식까지
계산하면서, 결국 활자의 글꼴을 정의하는 구조를 만든다.

이 과정에는 서로 재귀적인 서브루틴 넷이 관여한다. 그것들을
$$\hbox{|scanPrimary|, |scanSecondary|, |scanTertiary|, |scanExpression|}$$
이라고 부른다. 저마다 매개변수가 없고, 훑을 첫 토큰이 이미 |curCmd|, |curMod|, |curSym|에 나타나 있는 상태에서
@^recursion@>
시작한다. 실행한 다음에는 찾은 일차식이나 이차식이나 삼차식이나 식의 값이 전역 변수 |curType|과 |curExp|에 나타난다.
식 다음의 토큰은 |curCmd|, |curMod|, |curSym|으로 나타난다.

기술적으로 말하면 구문 분석 알고리즘은 대략 ``LL(1)''이다. 그럴듯한 오류 회복을 하려고 되돌림 장치를 보탰다.

네 수준은 연산자의 우선순위에 해당한다. 이를테면 `\.{a+b*c}'에서 |scanTertiary|가 `\.+'를 보고 오른쪽 피연산자를 얻으려고
|scanSecondary|를 부르면, |scanSecondary|가 `\.{b*c}'를 통째로 처리한다. 일차식은 변수, 상수, 괄호 식처럼 쪼갤 수 없는
것이고, 이차식은 `\.*'나 `\.{scaled}' 같은 곱셈 꼴의 연산자로 이어진 것이고, 삼차식은 `\.+'나 `\.{++}' 같은 덧셈 꼴의
연산자로 이어진 것이고, 식은 `\.{..}'나 `\.<'나 `\.\&' 같은 연산자로 이어진 것이다.

@<전역 변수@>=
var @!curType smallNumber // 방금 찾은 식의 형
var @!curExp int32 // 방금 찾은 식의 값

@ @<핵심 변수들의...@>=
curExp = 0

@ 여러 종류의 식이 있을 수 있으므로, 모든 경우에 |curType|과 |curExp|가 무엇을 뜻하는지 정확히 기술해 두는 것이 현명하다.

\smallskip\hang
값 |curType=vacuous|는 이 식이 결국 값을 갖지 않았다는 뜻이다. \KW{begingroup}$\,\ldots\,$\KW{endgroup} 구성에서
\KW{endgroup} 앞에 식이 없었기 때문이다. 이 경우 |curExp|에는 상관없는 값이 들어 있다.

\smallskip\hang
값 |curType=booleanType|은 |curExp|가 |trueCode|이거나 |falseCode|라는 뜻이다.

\smallskip\hang
값 |curType=unknownBoolean|은 |curExp|가 값이 아직 정의되지 않은 같은 불 값들의 고리에 있는 캡슐 노드를 가리킨다는 뜻이다.

\smallskip\hang
값 |curType=stringType|은 |curExp|가 문자열 번호(곧 범위 |0<=curExp<strPtr|의 정수)라는 뜻이다. 그 문자열의 참조 횟수에는
이 참조가 들어 있다.

\smallskip\hang
값 |curType=unknownString|은 |curExp|가 값이 아직 정의되지 않은 같은 문자열들의 고리에 있는 캡슐 노드를 가리킨다는 뜻이다.

\smallskip\hang
값 |curType=penType|은 |curExp|가 펜 머리 노드를 가리킨다는 뜻이다. 이 노드에는 참조 횟수가 들어 있는데, 이 참조도 셈에 들어
있다.

\smallskip\hang
값 |curType=unknownPen|은 |curExp|가 값이 아직 정의되지 않은 같은 펜들의 고리에 있는 캡슐 노드를 가리킨다는 뜻이다.

\smallskip\hang
값 |curType=futurePen|은 |curExp|가 결국 펜으로 만들어질 매듭 목록을 가리킨다는 뜻이다. 다른 누구도 이 매듭 목록을
가리키지 않는다. 이 |futurePen| 선택지는 |scanPrimary|와 |scanSecondary|의 출력으로만 나타나고, |scanTertiary|나
|scanExpression|의 출력으로는 나타나지 않는다.

\smallskip\hang
값 |curType=pathType|은 |curExp|가 경로의 첫 노드를 가리킨다는 뜻이다. 다른 누구도 이 경로를 가리키지 않는다. 경로의
조절점들은 이미 골라져 있다.

\smallskip\hang
값 |curType=unknownPath|는 |curExp|가 값이 아직 정의되지 않은 같은 경로들의 고리에 있는 캡슐 노드를 가리킨다는 뜻이다.

\smallskip\hang
값 |curType=pictureType|은 |curExp|가 가장자리 머리 노드를 가리킨다는 뜻이다. 다른 누구도 이 가장자리 집합을 가리키지 않는다.

\smallskip\hang
값 |curType=unknownPicture|는 |curExp|가 값이 아직 정의되지 않은 같은 그림들의 고리에 있는 캡슐 노드를 가리킨다는 뜻이다.

\smallskip\hang
값 |curType=transformType|은 |curExp|가 |transformType| 캡슐 노드를 가리킨다는 뜻이다. 이 캡슐의 |value| 부분은 수치 값 여섯을
담은 변환 노드를 가리키는데, 그 값은 저마다 |independent|, |dependent|, |protoDependent|, |known| 가운데 하나다.

\smallskip\hang
값 |curType=pairType|은 |curExp|가 형이 |pairType|인 캡슐 노드를 가리킨다는 뜻이다. 이 캡슐의 |value| 부분은 수치 값 둘을
담은 쌍 노드를 가리키는데, 그 값은 저마다 |independent|, |dependent|, |protoDependent|, |known| 가운데 하나다.

\smallskip\hang
값 |curType=known|은 |curExp|가 |scaled| 값이라는 뜻이다.

\smallskip\hang
값 |curType=dependent|는 |curExp|가 형이 |dependent|인 캡슐 노드를 가리킨다는 뜻이다. 이 캡슐의 |depList| 필드는 딸린 종속
목록을 가리킨다.

\smallskip\hang
값 |curType=protoDependent|는 |curExp|가 |protoDependent| 캡슐 노드를 가리킨다는 뜻이다. 이 캡슐의 |depList| 필드는 딸린
종속 목록을 가리킨다.

\smallskip\hang
값 |curType=independent|는 |curExp|가 형이 |independent|인 캡슐 노드를 가리킨다는 뜻이다. 이 조금 별난 경우는 이를테면
식 `$x+\KW{begingroup}\penalty0\,\KW{string}\,x; 0\,\KW{endgroup}$'에서 생길 수 있다.

\smallskip\hang
값 |curType=tokenList|는 |curExp|가 토큰들의 연결 목록을 가리킨다는 뜻이다.

\smallskip\noindent
변수 |curType|의 가능한 설정은 여기서 수치가 늘어나는 순서로 늘어놓았다. 그리고 |curType|은 결코 |numericType|이나
|suffixedMacro|나 |unsuffixedMacro|가 되지 않는다는 데 주목하라. 그런 형의 변수는 허용되는데도 말이다. 거꾸로 \MF에는
|vacuous|나 |tokenList| 형의 변수가 없다.

@ 캡슐은 |curType|과 |curExp|와 비슷한 뜻을 가진 두 낱말짜리 노드다. 그런 노드는 |nameType=capsule|이고, 그 |type|
필드는 위에서 늘어놓은 |curType|의 가능성 가운데 하나다. 또 토큰 목록의 일부가 아닌 캡슐에서는 |link<=void|다.

캡슐의 |value| 필드는 대개 |curExp|가 |curType|에 해당하듯이 그 |type|에 해당하는 값이다. 그러나 |curExp|가 캡슐을
가리킬 경우에는 추가의 간접 단계가 없다. 그 |value| 필드는 캡슐에 넣지 않았다면 |value(curExp)|라고 불렀을 것이다.
게다가 형이 |dependent|나 |protoDependent|이면 캡슐의 |value| 필드는 |depList|와 |prevDep| 필드로 바뀐다. 캡슐의 종속
목록은 언제나 일반적인 |depList| 구조의 일부이기 때문이다.

루틴 |getXNext|는 펼친 토큰을 얻을 때 |curType|과 |curExp|의 값을 바꾸지 않도록 조심한다. 그러나 |getXNext|는 매크로를
부를 수 있고, 매크로는 식을 구문 분석할 수 있고, 식은 그룹 안의 명령을 많이 실행할 수 있다. 그러므로 |getXNext|를
부르는 동안 |curType|이 이를테면 |unknownBoolean|에서 |booleanType|으로, 또는 |dependent|에서 |known|이나
|independent|로 바뀔 수 있다. 아래 프로그램들은 민감한 중간 결과를 캡슐에 넣어 두도록 조심해서, \MF의 일반성이 말썽을
일으키지 않게 한다.

다음은 이 관례들을 보여 주는 프로시저다. 이것은 $(|curType|\kern-.3pt,|curExp|\kern-.3pt)$의 내용을 받아서 캡슐에 넣어
둔다. 단 |curType=tokenList|일 때는 쓰지 않는다. 연산이 끝나면 |curType=vacuous|가 되므로 경로 목록을 베끼거나 참조 횟수를
고치는 따위를 할 필요가 없다.

프로시저 |stashCurExp|가 돌려주는 캡슐에는 특별한 연결 |void|를 붙인다. 이 프로시저는 토큰 목록과 쉽게 구별되어야 하는 매크로
매개변수를 저장하는 데 쓰이기 때문이다.

@<함수들@>=
func stashCurExp() pointer {
	var p pointer // 돌려줄 캡슐
	switch curType {
	case unknownBoolean, unknownString, unknownPen, unknownPicture, unknownPath,
		transformType, pairType, dependent, protoDependent, independent:
		p = curExp
	default:
		p = getNode(valueNodeSize)
		setNameType(p, capsule)
		setType(p, curType)
		setValue(p, curExp)
	}
	curType = vacuous
	setLink(p, void)
	return p
}

@ 프로시저 |stashCurExp|의 역은 다음 프로시저다. 이것은 쓸데없는 캡슐을 지우고 그 내용을 |curType|과 |curExp|에 넣는다.

\MF의 프로그램 단계는 두 부류로 나눌 수 있다. 변수 |curType|과 |curExp|가 ``살아 있는'' 단계와 ``죽어 있는'' 단계, 곧
|curType|과 |curExp|가 뜻있는 정보를 담고 있느냐 아니냐다. 그것들이 살아 있을 때 무시하지 않는 것이 중요하고, 죽어
있을 때 신경 쓰지 않는 것이 중요하다.

중간 부류도 있다. 만일 |curType=vacuous|이면 |curExp|는 상관없으므로, |curType|과 |curExp|가 살아 있든 죽어 있든 상관없이
나아갈 수 있다. 그런 경우 |curType|과 |curExp|가 {\sl 잠들어\/} 있다고 말한다. 프로시저 |getXNext|는 그것들이 살아 있거나 잠들어
있을 때에만 불러도 된다.

위의 \\{stash} 프로시저는 |curType|과 |curExp|가 살아 있거나 잠들어 있다고 가정한다. 그리고 \\{unstash} 프로시저는 그것들이
죽어 있거나 잠들어 있다고 가정하고, 그것들을 되살린다.

@<함수들@>=
func unstashCurExp(p pointer) {
	curType = typ(p)
	switch curType {
	case unknownBoolean, unknownString, unknownPen, unknownPicture, unknownPath,
		transformType, pairType, dependent, protoDependent, independent:
		curExp = p
	default:
		curExp = value(p)
		freeNode(p, valueNodeSize)
	}
}

@ 다음 프로시저는 식의 값을 줄인 꼴로 찍는다. 첫 매개변수 |p|가 널이면 |(curType,curExp)|의 값을 보이고, 그렇지
않으면 |p|는 원하는 값을 담은 캡슐이어야 한다. 둘째 매개변수는 출력의 양을 다스린다. 그것이~0이면 종속 목록은 항이
하나뿐이 아니면 `\.{linearform}'으로 줄인다. 1보다 크면 복잡한 구조(펜, 그림, 경로)를 온전히 보인다.
@.linearform@>

@<함수들@>=
func printExp(p pointer, verbosity smallNumber) {
	var restoreCurExp bool // |curExp|를 되돌려야 하나?
	var t smallNumber // 식의 형
	var v int32 // 식의 값
	var q pointer // 보이고 있는 큰 노드
	if p != null {
		restoreCurExp = false
	} else {
		p = stashCurExp()
		restoreCurExp = true
	}
	t = typ(p)
	if t < dependent {
		v = value(p)
	} else if t < independent {
		v = depList(p)
	}
	@<|t|에 따라 꼴을 정해서 |v|의 값을 줄여 찍는다@>
	if restoreCurExp {
		unstashCurExp(p)
	}
}

@ @<|t|에 따라 꼴을...@>=
switch t {
case vacuous:
	printStr("vacuous")
case booleanType:
	if v == trueCode {
		printStr("true")
	} else {
		printStr("false")
	}
case unknownBoolean, unknownString, unknownPen, unknownPicture, unknownPath, numericType:
	@<선언되었으나 정의되지 않은 변수를 보인다@>
case stringType:
	printChar('"')
	slowPrint(v)
	printChar('"')
case penType, futurePen, pathType, pictureType:
	@<복잡한 형을 보인다@>
case transformType, pairType:
	if v == null {
		printType(t)
	} else {
		@<큰 노드를 보인다@>
	}
case known:
	printScaled(v)
case dependent, protoDependent:
	printDp(t, v, verbosity)
case independent:
	printVariableName(p)
default:
	confusion("exp")
@:this can't happen exp}{\quad exp@>
}

@ @<큰 노드를 보인다@>=
printChar('(')
q = v + bigNodeSize[t]
for {
	if typ(v) == known {
		printScaled(value(v))
	} else if typ(v) == independent {
		printVariableName(v)
	} else {
		printDp(typ(v), depList(v), verbosity)
	}
	v = v + 2
	if v != q {
		printChar(',')
	}
	if v == q {
		break
	}
}
printChar(')')

@ \KW{picture}, \KW{path}, \KW{pen} 형의 값은 사용자가 \\{tracingonline}에 양수를 주지 않는 한 기록 파일에만 자세히 보인다.

@<복잡한 형을...@>=
if verbosity <= 1 {
	printType(t)
} else {
	if selector == termAndLog && internal[tracingOnline] <= 0 {
		selector = termOnly
		printType(t)
		printStr(" (see the transcript file)")
		selector = termAndLog
	}
	switch t {
	case penType:
		printPen(v, "", false)
	case futurePen:
		printPath(v, " (future pen)", false)
	case pathType:
		printPath(v, "", false)
	case pictureType:
		curEdges = v
		printEdges("", false, 0, 0)
	} // 다른 경우는 없다
}

@ @<함수들@>=
func printDp(t smallNumber, p pointer, verbosity smallNumber) {
	var q pointer // |p| 다음의 노드
	q = link(p)
	if info(q) == null || verbosity > 0 {
		printDependency(p, t)
	} else {
		printStr("linearform")
	}
@.linearform@>
}

@ 고리에 있는 변수의 보이는 이름은 고리가 온통 캡슐로만 이루어진 경우가 아니면 캡슐이 아니다.

@<선언되었으나 정의되지...@>=
printType(t)
if v != null {
	printChar(' ')
	for nameType(v) == capsule && v != p {
		v = value(v)
	}
	printVariableName(v)
}

@ 구문 분석하다가 오류를 발견하면 오류 메시지 바로 위에 식을 보이는 것이 도움이 될 때가 잦다. 그럴 때는 |printErr|
대신 |expErr|나 |dispErr|를 쓴다.

@<함수들@>=
func expErr(s any) { dispErr(null, s) } // 현재 식을 보인다

func dispErr(p pointer, s any) {
	if interaction == errorStopMode {
		wakeUpTerminal()
	}
	printNl(">> ")
@.>>@>
	printExp(p, 1) // 식을 ``중간쯤 자세히'' 찍는다
	if s != "" {
		printNl("! ")
		printStr(s)
@.!\relax@>
	}
}

@ 변수 |curType|과 |curExp|에 재활용해야 할 정보가 들어 있으면 다음 프로시저를 쓴다. 이것은 |curType|을 |known|으로 바꾸고
주어진 값을 |curExp|에 넣는다. 이제 |curExp|에 포인터 값이 들어 있지 않으므로, 이것을 한 다음에는 |curType|과 |curExp|를 살아
있거나 잠들어 있다고 생각할 수 있다.

@<함수들@>=
func flushCurExp(v scaled) {
	switch curType {
	case unknownBoolean, unknownString, unknownPen, unknownPicture, unknownPath,
		transformType, pairType, dependent, protoDependent, independent:
		recycleValue(curExp)
		freeNode(curExp, valueNodeSize)
	case penType:
		deletePenRef(curExp)
	case stringType:
		deleteStrRef(curExp)
	case futurePen, pathType:
		tossKnotList(curExp)
	case pictureType:
		tossEdges(curExp)
	default:
		// 아무것도 하지 않는다
	}
	curType = known
	curExp = v
}

@ 어떤 두 낱말짜리 값 꾸러미에 딸린 저장소든 풀어 줄 수 있는 훨씬 일반적인 프로시저가 있다.

@<함수들@>=
func recycleValue(p pointer) {
	var t smallNumber // 형 코드
	var v int32 // 값
	var vv int32 // 또 하나의 값
	var q, r, s, pp pointer // 연결 조작 레지스터들
	t = typ(p)
	if t < dependent {
		v = value(p)
	}
	switch t {
	case undefined, vacuous, booleanType, known, numericType:
		// 아무것도 하지 않는다
	case unknownBoolean, unknownString, unknownPen, unknownPicture, unknownPath:
		ringDelete(p)
	case stringType:
		deleteStrRef(v)
	case penType:
		deletePenRef(v)
	case pathType, futurePen:
		tossKnotList(v)
	case pictureType:
		tossEdges(v)
	case pairType, transformType:
		@<큰 노드를 재활용한다@>
	case dependent, protoDependent:
		@<종속 목록을 재활용한다@>
	case independent:
		@<독립 변수를 재활용한다@>
	case tokenList, structured:
		confusion("recycle")
@:this can't happen recycle}{\quad recycle@>
	case unsuffixedMacro, suffixedMacro:
		deleteMacRef(value(p))
	} // 다른 경우는 없다
	setType(p, undefined)
}

@ @<큰 노드를 재활용한다@>=
if v != null {
	q = v + bigNodeSize[t]
	for {
		q = q - 2
		recycleValue(q)
		if q == v {
			break
		}
	}
	freeNode(v, bigNodeSize[t])
}

@ @<종속 목록을 재활용한다@>=
q = depList(p)
for info(q) != null {
	q = link(q)
}
setLink(prevDep(p), link(q))
setPrevDep(link(q), prevDep(p))
setLink(q, null)
flushNodeList(depList(p))

@ 독립 변수가 사라질 때, 그것에 의존하는 것이 없으면 그냥 흐려져 사라진다. 의존하는 것이 있으면 의존 계수가 가장 큰
종속 변수가 그 자리를 차지한다. 이 알고리즘은 이그나시오~A. 사발라가 박사 논문(스탠퍼드 대학교, 1982년 12월)의
일부로 구현한 것이다.
@^Zabala Salelles, Ignacio Andr\'es@>

이를테면 변수 $x$를 재활용하고 있는데 $x$에 의존하는 변수가 $y=2x+a$와 $z=x+b$뿐이라고 하자. 이 경우 우리는 $y$를
독립으로 만들고 $z=.5y-.5a+b$로 만들고 싶다. 다른 변수는 $y$에~의존하지 않게 된다. 이 상황에서
$\\{tracingequations}>0$이면 `\.{\#\#\# -2x=-y+a}'를 찍을 것이다.

그러나 조금 복잡한 일이 있다. 독립 변수 $x$는 종속 목록과 원형 종속 목록 모두에 나타날 수 있다. 그래서 어느 계수가
가장 큰지 정할 때 조심해야 한다.

게다가 원형 종속 변수가 독립 변수가 되도록 골라질 때는 이 복잡한 일이 그리 조금이 아니다. 이를테면 $y=2x+100a$가 원형
종속이고 $z=x+b$가 종속이라고 하자. 그러면 큰 계수 `50' 때문에 $z=.5y-50a+b$를 원형 종속으로 바꾸어야 한다.

시간을 너무 낭비하지 않고 이 복잡한 일들을 다루려고, 모든 일차 종속 관계에 걸쳐 $x$가 나타나는 곳들을 한데 잇는다.
종속인 경우와 원형 종속인 경우의 목록은 따로 유지한다.

@<독립 변수를 재활용한다@>=
maxC[dependent] = 0
maxC[protoDependent] = 0
maxLink[dependent] = null
maxLink[protoDependent] = null
@<|p|가 나타나는 항들을 종속 목록에서 떼어 형별 목록에 모은다@>
if maxC[dependent] > 0 || maxC[protoDependent] > 0 {
	@<사라지는 독립 변수의 자리를 차지할 종속 변수를 고르고, 남은 모든 종속 관계를 그에 맞게 바꾼다@>
}

@ 모든 종속 목록을 훑으며 |p|의 항을 떼어 낸다. 떼어 낸 항 노드의 |info|에는 그 항이 들어 있던 종속 변수를 적어 두고,
형마다 계수가 가장 큰 항은 |maxPtr|에, 나머지는 |maxLink|에서 시작하는 목록에 둔다.

@<|p|가 나타나는 항들을 종속 목록에서 떼어 형별 목록에 모은다@>=
q = link(depHead)
for q != depHead {
	s = valueLoc(q) // 이제 |link(s)=depList(q)|다
	for {
		r = link(s)
		if info(r) == null {
			break
		}
		if info(r) != p {
			s = r
		} else {
			t = typ(q)
			setLink(s, link(r))
			setInfo(r, q)
			if abs(value(r)) > maxC[t] {
				@<형 |t|의 새 최대 계수를 기록한다@>
			} else {
				setLink(r, maxLink[t])
				maxLink[t] = r
			}
		}
	}
	q = link(r)
}

@ 독립 변수를 없애는 코드는 두 낱말짜리 배열 셋을 쓴다.

@<전역 변수@>=
var @!maxC [protoDependent + 1]int32 // 최대 계수의 크기; 첨자는 |dependent .. protoDependent|
var @!maxPtr [protoDependent + 1]pointer // |p|가 |maxC|로 나타나는 곳
var @!maxLink [protoDependent + 1]pointer // |p|가 나타나는 다른 곳들

@ @<형 |t|의 새 최대 계수를...@>=
if maxC[t] > 0 {
	setLink(maxPtr[t], maxLink[t])
	maxLink[t] = maxPtr[t]
}
maxC[t] = abs(value(r))
maxPtr[t] = r

@ 원형 종속의 계수는 |scaled|이고 종속의 계수는 |fraction|이므로, 둘을 견줄 때는 |fraction|을 $2^{12}$으로 나누어
눈금을 맞춘다.

@<사라지는 독립 변수의 자리를...@>=
if maxC[dependent]/0o10000 >= maxC[protoDependent] {
	t = dependent
} else {
	t = protoDependent
}
@<독립 변수~|p| 대신 넣을 종속 목록 |s|를 정한다@>
t = dependent + protoDependent - t // |t|의 보수를 취한다
if maxC[t] > 0 { // 고르지 않은 종속 관계를 집어 들어야 한다
	setLink(maxPtr[t], maxLink[t])
	maxLink[t] = maxPtr[t]
}
if t != dependent {
	@<|p| 대신 새 종속 관계를 넣는다@>
} else {
	@<|p| 대신 새 원형 종속 관계를 넣는다@>
}
flushNodeList(s)
if fixNeeded {
	fixDependencies()
}
checkArith()

@ 이제 |s=maxPtr[t]|라고 하자. 이 지점에서 $|value|(s)=\pm|maxC|[t]$이고, |info(s)|는 노드~|s|를 그 종속 목록에서 없앤 형~|t|의
종속 변수~|pp|를 가리킨다. 노드~|s|를 계수 $-1.0$과 새 독립 변수 |pp|로 종속 목록에 다시 넣어야 한다. 변수 |pp|는 다른 어떤
변수보다 일련번호가 크므로 노드 |s|를 목록의 맨 앞에 넣을 수 있다.

@<독립 변수~|p| 대신...@>=
s = maxPtr[t]
pp = info(s)
v = value(s)
if t == dependent {
	setValue(s, -fractionOne)
} else {
	setValue(s, -unity)
}
r = depList(pp)
setLink(s, r)
for info(r) != null {
	r = link(r)
}
q = link(r)
setLink(r, null)
setPrevDep(q, prevDep(pp))
setLink(prevDep(pp), q)
newIndep(pp)
if curExp == pp && curType == t {
	curType = independent
}
if internal[tracingEquations] > 0 {
	@<변환한 종속 관계를 보인다@>
}

@ 이제 예전의 독립 변수~|p|의 $(-v)$배를 종속 목록~|s|로 바꾸고 있다.

@<변환한 종속 관계를...@>=
if interesting(p) {
	beginDiagnostic()
	printNl("### ")
@:]]]\#\#\#_}{\.{\#\#\#}@>
	if v > 0 {
		printChar('-')
	}
	if t == dependent {
		vv = roundFraction(maxC[dependent])
	} else {
		vv = maxC[protoDependent]
	}
	if vv != unity {
		printScaled(vv)
	}
	printVariableName(p)
	for value(p)%sScale > 0 {
		printStr("*4")
		setValue(p, value(p)-2)
	}
	if t == dependent {
		printChar('=')
	} else {
		printStr(" = ")
	}
	printDependency(s, t)
	endDiagnostic(false)
}

@ 끝으로, 종속 목록을 최신으로 고쳐야 할 종속 변수와 원형 종속 변수들이 있다.

@<|p| 대신 새 종속 관계를...@>=
for t = dependent; t <= protoDependent; t++ {
	r = maxLink[t]
	for r != null {
		q = info(r)
		setDepList(q, pPlusFq(depList(q), makeFraction(value(r), -v), s, t, dependent))
		if depList(q) == depFinal {
			makeKnown(q, depFinal)
		}
		q = r
		r = link(r)
		freeNode(q, depNodeSize)
	}
}

@ @<|p| 대신 새 원형 종속 관계를...@>=
for t = dependent; t <= protoDependent; t++ {
	r = maxLink[t]
	for r != null {
		q = info(r)
		if t == dependent { // 안전을 위해 |q|를 |protoDependent|로 바꾼다
			if curExp == q && curType == dependent {
				curType = protoDependent
			}
			setDepList(q, pOverV(depList(q), unity, dependent, protoDependent))
			setType(q, protoDependent)
			setValue(r, roundFraction(value(r)))
		}
		setDepList(q, pPlusFq(depList(q), makeScaled(value(r), -v), s, protoDependent, protoDependent))
		if depList(q) == depFinal {
			makeKnown(q, depFinal)
		}
		q = r
		r = link(r)
		freeNode(q, depNodeSize)
	}
}

@ 다음은 오류 회복 때 자주 필요한 동작들을 편리하게 묶은 루틴들이다. 이를테면 `|flushError|'는 현재 식을 치우고,
그것을 주어진 값으로 바꾸고, |reportError|를 부른다.

오류는 이미 토큰 하나를 더 훑은 다음에 발견될 때가 많다. `\\{put\_get}' 루틴들은 |reportError|를 부르기 전에 그 토큰을
되돌려 놓고, 그다음 다시 가져온다. (사용자가 무언가를 바꾸었다면 다른 토큰을 가져올지도 모른다.)

@<함수들@>=
func flushError(v scaled) {
	reportError()
	flushCurExp(v)
}

func putGetError() {
	backError()
	getXNext()
}

func putGetFlushError(v scaled) {
	putGetError()
	flushCurExp(v)
}

@ 전역 변수 |varFlag|는 \MF가 |scanExpression|을 부르기 바로 전에, 이 명령 코드가 바로 뒤따르면 식을 변수로 다루어야
할 때 그 특별한 명령 코드로 놓는다. 이를테면 문장의 처음에서는 |varFlag|를 |assignment|로 놓는다. `\.{:=}'의 왼쪽에 있는
변수의 값이 아니라 그 {\sl 위치\/}를 알고 싶기 때문이다.

서브루틴 |scanExpression|은 |scanTertiary|를 부르고, 그것은 |scanSecondary|를 부르고, 그것은 |scanPrimary|를 부르는데,
|scanPrimary|가 |varFlag=0|으로 놓는다. 이런 식으로 각 훑기 루틴은 자기가 특별한 |varFlag|로 불렸는지 ``알지만'',
|varFlag|는 대개 0이다.

코드가 |varFlag|와 같은 명령 앞에 오는 변수는 값이 아니라 토큰 목록으로 바뀐다. 게다가 |varFlag=assignment|인 식 뒤의 `\.{=}'
기호는 불 식을 만드는 관계로 여기지 않는다.

@<전역 변수@>=
var @!varFlag int32 // 변수를 원하는 명령; |0 .. maxCommandCode|

@ @<핵심 변수들의...@>=
varFlag = 0

@* 일차식 구문 분석.
첫 구문 분석 루틴 |scanPrimary|가 가장 복잡하기도 하다. 다루어야 할 경우가 아주 많기 때문이다. 그러나 경우 하나하나는
---한 가지만 빼고---그 자체로는 꽤 간단하다.

루틴 |scanPrimary|가 시작할 때 훑을 일차식의 첫 토큰은 이미 |curCmd|, |curMod|, |curSym|에 나타나 있어야 한다. 앞에서
설명했듯이 |curType|과 |curExp|의 값은 죽어 있거나 잠들어 있어야 한다. 그리고 |curCmd|가 |minPrimaryCommand|와
|maxPrimaryCommand| 사이(양 끝 포함)에 있지 않으면 구문 오류를 알린다.

이 함수는 레이블을 셋 쓴다. 레이블 |restart|는 일차식을 처음부터 다시 훑는 곳이고(이를테면 매크로를 펼친 다음),
|done|은 다음 토큰을 이미 가져온 경우들이 마지막 |getXNext|를 건너뛰어 모이는 곳이다. 원본 \.{WEB}에는 레이블이 둘 더
있었다. 변수를 훑는 반복문을 빠져나가는 |done1|과 근사 형을 찾는 반복문을 빠져나가는 |done2|인데, 둘 다 \GO/의
|break|로 바뀌었다.

@<함수들@>=
func scanPrimary() {
	var p, q, r pointer // 목록 조작용
	var c quarterword // 원시 연산 코드
	var myVarFlag int32 // |varFlag|의 처음 값; |0 .. maxCommandCode|
	var lDelim, rDelim pointer // 구분자 쌍의 해시 주소
	@<|scanPrimary|의 다른 지역 변수들@>
	myVarFlag = varFlag
	varFlag = 0
restart:
	checkArith()
	@<요청이 있으면 진단 정보를 내놓는다@>
	@<명령 코드에 따라 일차식을 훑는다; 다음 토큰을 이미 얻었으면 |goto done|@>
	getXNext() // 이것을 원하지 않는 경우들은 |goto done|한다
done:
	if curCmd == leftBracket {
		if curType >= known {
			@<중개 구문을 훑는다@>
		}
	}
}

@ 일차식은 첫 토큰의 명령 코드로 갈래를 고른다. 각 갈래는 일차식을 훑은 다음 대개 토큰 하나를 더 얻는데, 이미 다음 토큰을
얻은 갈래는 |goto done|으로 마지막 |getXNext|를 건너뛴다.

@<명령 코드에 따라 일차식을...@>=
switch curCmd {
case leftDelimiter:
	@<구분자로 둘러싼 일차식을 훑는다@>
case beginGroup:
	@<그룹으로 묶은 일차식을 훑는다@>
case stringToken:
	@<문자열 상수를 훑는다@>
case numericToken:
	@<수치 토큰으로 시작하는 일차식을 훑는다@>
case nullary:
	@<영항 연산을 훑는다@>
case unary, typeName, cycle, plusOrMinus:
	@<단항 연산을 훑는다@>
case primaryBinary:
	@<피연산자 사이에 `\KW{of}'가 오는 이항 연산을 훑는다@>
case strOp:
	@<접미사를 문자열로 바꾼다@>
case internalQuantity:
	@<내부 수치량을 훑는다@>
case capsuleToken:
	makeExpCopy(curMod)
case tagToken:
	@<변수 일차식을 훑는다; 매크로로 드러나면 |goto restart|@>
default:
	badExp("A primary")
	goto restart
@.A primary expression...@>
}

@ 식의 첫머리에서 일어나는 오류는 |badExp|가 알린다.

@<함수들@>=
func badExp(s string) {
	var saveFlag int32 // |0 .. maxCommandCode|
	printErr(s)
	printStr(" expression can't begin with `")
	printCmdMod(curCmd, curMod)
	printChar('\'')
	help4("I'm afraid I need some sort of value in order to continue,",
		"so I've tentatively inserted `0'. You may want to",
		"delete this zero and insert something else;",
		"see Chapter 27 of The METAFONTbook for an example.")
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
	backInput()
	curSym = 0
	curCmd = numericToken
	curMod = 0
	insError()
	saveFlag = varFlag
	varFlag = 0
	getXNext()
	varFlag = saveFlag
}

@ @<요청이 있으면 진단 정보를...@>=
if debug {
	if panicking {
		checkMem(false)
	}
}
if interrupt != 0 {
	if okToInterrupt {
		backInput()
		checkInterrupt()
		getXNext()
	}
}

@ @<구분자로 둘러싼 일차식을 훑는다@>=
lDelim = curSym
rDelim = curMod
getXNext()
scanExpression()
if curCmd == comma && curType >= known {
	@<수치 쌍의 둘째 것을 훑는다@>
} else {
	checkDelimiter(lDelim, rDelim)
}

@ 서브루틴 |stashIn|은 현재의 (수치) 식을 ``큰 노드'' 안의 한 필드에 넣는다.

@<함수들@>=
func stashIn(p pointer) {
	var q pointer // 임시 레지스터
	setType(p, curType)
	if curType == known {
		setValue(p, curExp)
	} else {
		if curType == independent {
			@<독립인 |curExp|를 큰 노드에 넣는다@>
		} else {
			mem[valueLoc(p)] = mem[valueLoc(curExp)]
			// |depList(p)=depList(curExp)|이고 |prevDep(p)=prevDep(curExp)|다
			setLink(prevDep(p), p)
		}
		freeNode(curExp, valueNodeSize)
	}
	curType = vacuous
}

@ 드물게 현재 식이 |independent|가 될 수 있다. 그런 독립 캡슐을 가리키는 종속 목록이 많을 수 있으므로 그냥 큰 노드 안의
자리로 옮길 수는 없다. 대신 베끼고 나서 재활용한다.

@<독립인 |curExp|를...@>=
q = singleDependency(curExp)
if q == depFinal {
	setType(p, known)
	setValue(p, 0)
	freeNode(q, depNodeSize)
} else {
	setType(p, dependent)
	newDep(p, q)
}
recycleValue(curExp)

@ @<수치 쌍의 둘째 것을...@>=
p = getNode(valueNodeSize)
setType(p, pairType)
setNameType(p, capsule)
initBigNode(p)
q = value(p)
stashIn(xPartLoc(q))
getXNext()
scanExpression()
if curType < known {
	expErr("Nonnumeric ypart has been replaced by 0")
@.Nonnumeric...replaced by 0@>
	help4("I thought you were giving me a pair `(x,y)'; but",
		"after finding a nice xpart `x' I found a ypart `y'",
		"that isn't of numeric type. So I've changed y to zero.",
		"(The y that I didn't like appears above the error message.)")
	putGetFlushError(0)
}
stashIn(yPartLoc(q))
checkDelimiter(lDelim, rDelim)
curType = pairType
curExp = p

@ 지역 변수 |groupLine|은 \KW{begingroup} 명령이 나온 줄을 기억한다. 그룹이 실제로 끝나지 않을 때 오류 메시지에 쓸모가
있을 것이다.

@<|scanPrimary|의 다른 지역 변수들@>=
var groupLine int32 // 그룹이 시작한 곳

@ @<그룹으로 묶은 일차식을...@>=
groupLine = line
if internal[tracingCommands] > 0 {
	showCurCmdMod()
}
p = saveBoundaryItem()
for {
	doStatement() // |curCmd>=semicolon|으로 끝난다
	if curCmd != semicolon {
		break
	}
}
if curCmd != endGroup {
	printErr("A group begun on line ")
@.A group...never ended@>
	printInt(groupLine)
	printStr(" never ended")
	help2("I saw a `begingroup' back there that hasn't been matched",
		"by `endgroup'. So I've inserted `endgroup' now.")
	backError()
	curCmd = endGroup
}
unsave() // 독립 변수가 재활용되면 이것이 |curType|을 바꿀 수도 있다
if internal[tracingCommands] > 0 {
	showCurCmdMod()
}

@ @<문자열 상수를...@>=
curType = stringType
curExp = curMod

@ 나중에 덧셈, 제곱근 따위의 실제 연산을 하는 프로시저들에 이를 것이다. 지금 목적은 구문 분석이다. 그러나 너무 애태우지
않도록 그 미래의 프로시저들을 지금 소개해 두자.

\smallskip
함수 |doNullary(c)|는 피연산자가 없는 원시 연산(이를테면 `\KW{true}'나 `\KW{pencircle}')을 한다.

\smallskip
함수 |doUnary(c)|는 원시 연산을 현재 식에 적용한다.

\smallskip
함수 |doBinary(p,c)|는 원시 연산을 캡슐~|p|와 현재 식에 적용한다.

@<영항 연산을...@>=
doNullary(curMod)

@ @<단항 연산을...@>=
c = curMod
getXNext()
scanPrimary()
doUnary(c)
goto done

@ 수치 토큰은 그 자체로 일차식일 수도 있고, 수치 토큰만으로 이루어진 분수의 분자일 수도 있고, 뒤따르는 일차식에 곱하는
수일 수도 있다(그 일차식이 더하기나 빼기 부호로 시작하지 않는다면). 여기 코드는 |maxPrimaryCommand=plusOrMinus|이고
|maxPrimaryCommand-1=numericToken|이라는 사실을 쓴다. 1보다 작은 분수를 찾으면 그것을 스칼라 곱셈에 쓸 때 정밀도를 더
지키려고 애쓴다.

이를테면 `\.{1/3x}'에서 \MF는 |x|에 $1/3$을 반올림한 |scaled| 값 |21845|를 곱하는 대신, |fracMult(1,3)|으로 |x|에
$1\over3$을 거의 정확히 곱한다. `\.{3/2x}'처럼 분수가 1 이상이면 그냥 |doBinary|로 곱한다.

@<|scanPrimary|의 다른 지역 변수들@>=
var num, denom scaled // `1/2' 같은 분수인 일차식을 위해

@ @<수치 토큰으로 시작하는...@>=
curExp = curMod
curType = known
getXNext()
if curCmd != slash {
	num = 0
	denom = 0
} else {
	getXNext()
	if curCmd != numericToken {
		backInput()
		curCmd = slash
		curMod = over
		curSym = frozenSlash
		goto done
	}
	num = curExp
	denom = curMod
	if denom == 0 {
		@<0으로 나누기에 항의한다@>
	} else {
		curExp = makeScaled(num, denom)
	}
	checkArith()
	getXNext()
}
if curCmd >= minPrimaryCommand {
	if curCmd < numericToken { // 특히 |curCmd!=plusOrMinus|다
		p = stashCurExp()
		scanPrimary()
		if abs(num) >= abs(denom) || curType < pairType {
			doBinary(p, times)
		} else {
			fracMult(num, denom)
			freeNode(p, valueNodeSize)
		}
	}
}
goto done

@ @<0으로 나누기에...@>=
printErr("Division by zero")
@.Division by zero@>
help1("I'll pretend that you meant to divide by 1.")
reportError()

@ @<피연산자 사이에 `\KW{of}'가...@>=
c = curMod
getXNext()
scanExpression()
if curCmd != ofToken {
	missingErr("of")
	printStr(" for ")
	printCmdMod(primaryBinary, c)
@.Missing `of'@>
	help1("I've got the first argument; will look now for the other.")
	backError()
}
p = stashCurExp()
getXNext()
scanPrimary()
doBinary(p, c)
goto done

@ @<접미사를 문자열로...@>=
getXNext()
scanSuffix()
oldSetting = selector
selector = newString
showTokenList(curExp, null, 100000, 0)
flushTokenList(curExp)
curExp = makeString()
selector = oldSetting
curType = stringType
goto done

@ 내부 수치량이 대입문의 왼쪽에 홀로 나타나면 길이가 1인 토큰 목록을 돌려준다. 그 토큰에는 내부 수치량의 주소에
|hashEnd|를 더한 값이 들어 있다. (이것은 앞에서 설명한 저장 스택의 관례와 맞는다.)

@<내부 수치량을...@>=
q = curMod
if myVarFlag == assignment {
	getXNext()
	if curCmd == assignment {
		curExp = getAvail()
		setInfo(curExp, q+hashEnd)
		curType = tokenList
		goto done
	}
	backInput()
}
curType = known
curExp = internal[q]

@ 루틴 |scanPrimary|의 가장 어려운 부분은 마지막까지 아껴 두었다. 먼저 자신감을 쌓아야 했기 때문이다. 이제 변수를 훑는 일에
맞설 수 있다.

변수를 훑으면서 관련된 이름과 첨자 값을 담은 토큰 목록을 만들고, 동시에 ``집합적'' 구조를 따라가며 우리가 실제로는
값이 아니라 매크로를 다루고 있는 것은 아닌지 살핀다.

지역 변수 |preHead|와 |postHead|는 앞붙이 목록과 뒷붙이 목록의 처음을 가리킨다. 또 |tail|은 지금 자라고 있는 목록의 끝을
가리킨다.

또 하나의 지역 변수 |tt|에는 지금까지의 변수가 선언된 형에 대한 부분적인 정보가 들어 있다. 만일 |tt>=unsuffixedMacro|이면
언제나 |tt=typ(q)|가 성립한다. 또 |tt=undefined|이면 이 루틴은 형 정보를 더는 고치지 않는다. 그리고
|undefined<tt<unsuffixedMacro|이면 |tt|의 정확한 값은 중요하지 않다.

@<|scanPrimary|의 다른 지역 변수들@>=
var preHead, postHead, tail pointer // 앞붙이와 뒷붙이 목록 변수
var tt smallNumber // 지금까지의 변수의 형의 근삿값
var t pointer // 토큰
var macroRef pointer // 접미사 있는 매크로의 참조 횟수

@ @<변수 일차식을 훑는다...@>=
preHead = fastGetAvail()
tail = preHead
postHead = null
tt = vacuous
for {
	t = curTok()
	setLink(tail, t)
	if tt != undefined {
		@<근사 형 |tt|와 그에 맞는~|q|를 찾는다@>
		if tt >= unsuffixedMacro {
			@<접미사 없는 매크로 호출을 시작하거나 접미사 있는 호출을 준비한다@>
		}
	}
	getXNext()
	tail = t
	if curCmd == leftBracket {
		@<첨자를 훑는다; 찾으면 |curCmd|를 |numericToken|으로 바꾼다@>
	}
	if curCmd > maxSuffixToken || curCmd < minSuffixToken {
		break
	}
	// 이제 |curCmd|는 |internalQuantity|, |tagToken|, |numericToken| 가운데 하나다
}
@<변수로 가장한 별난 경우를 처리하고 |goto restart|나 |goto done|; 아니면 변수를 베끼고 |goto done|@>

@ @<접미사 없는 매크로 호출을 시작하거나...@>=
setLink(tail, null)
if tt > unsuffixedMacro { // |tt=suffixedMacro|
	postHead = getAvail()
	tail = postHead
	setLink(tail, t)
	tt = undefined
	macroRef = value(q)
	addMacRef(macroRef)
} else {
	@<접미사 없는 매크로 호출을 마련하고 |goto restart|@>
}

@ @<첨자를 훑는다...@>=
getXNext()
scanExpression()
if curCmd != rightBracket {
	@<왼쪽 대괄호와 식을 되돌려 다시 훑게 한다@>
} else {
	if curType != known {
		badSubscript()
	}
	curCmd = numericToken
	curMod = curExp
	curSym = 0
}

@ 첨자를 여는 줄 알았던 왼쪽 대괄호가 사실은 `\.{x[a,b]}' 같은 중개 구문의 왼쪽 대괄호였을 수도 있다. 그래서 이 지점에서
오류 메시지를 내지 않는다. 그러나 잘못된 가정 때문에 낭패를 보지 않도록 되돌아가 둔다.

@<왼쪽 대괄호와 식을...@>=
backInput() // 이것은 현재 식 다음의 토큰이었다
backExpr()
curCmd = leftBracket
curMod = 0
curSym = frozenLeftBracket

@ 현재 식을 되돌려 다시 읽게 하는 루틴이다.

@<함수들@>=
func backExpr() {
	var p pointer // 캡슐 토큰
	p = stashCurExp()
	setLink(p, null)
	backList(p)
}

@ 알 수 없는 첨자는 다음 오류 메시지를 낳는다.

@<함수들@>=
func badSubscript() {
	expErr("Improper subscript has been replaced by zero")
@.Improper subscript...@>
	help3("A bracketed subscript must have a known numeric value;",
		"unfortunately, what I found was the value that appears just",
		"above this error message. So I'll try a zero subscript.")
	flushError(0)
}

@ 프로시저 |getXNext|를 부를 때마다 우리가 보고 있던 변수가 사라질 가능성이 있다. 그러므로 |q|가 변수 구조 안을 가리키도록 안전하게
둘 수 없다. 매번 뿌리부터 다시 찾아야 한다.

원본의 |done2| 레이블은 바깥 반복문의 |break|가 되었다. 안쪽 |repeat| 반복문은 그 자체의 |break|로 끝나므로 헷갈릴 일이
없다.

@<근사 형 |tt|와...@>=
@^inner loop@>
p = link(preHead)
q = info(p)
tt = undefined
if eqType(q)%outerTag == tagToken {
	q = equiv(q)
	if q != null {
		for {
			p = link(p)
			if p == null {
				tt = typ(q)
				break
			}
			if typ(q) != structured {
				break
			}
			q = link(attrHead(q)) // |collectiveSubscript| 속성
			if p >= hiMemMin { // 첨자가 아니다
				for {
					q = link(q)
					if attrLoc(q) >= info(p) {
						break
					}
				}
				if attrLoc(q) > info(p) {
					break
				}
			}
		}
	}
}

@ 지금 형편은 어떤가? 첨자와 속성까지 포함한 변수 이름 전체를 훑었고, |curCmd|, |curMod|, |curSym|은 그다음 토큰을
나타낸다. 만일 |postHead=null|이면 이 변수 이름의 토큰 목록이 |link(preHead)|에서 시작하고 첨자는 모두 값이 매겨져 있다.
그러나 |postHead!=null|이면 이 변수는 접미사 있는 매크로로 드러난 것이다. 이때 |preHead|는 앞붙이 목록의 머리이고
|postHead|는 `\.{\AT!}'과 접미사를 함께 담은 토큰 목록의 머리다.

당장의 문제는 이 변수가 아직 있는지 보는 것이다. (변수 구조는 |getXNext|를 부를 때마다 크게 바뀔 수 있다. 사용자가 그러면
안 되지만 그럴 수 있다는 사실 때문에 우리는 조심해야 한다.)

다음 프로시저는 변수가 뜻밖에 사라졌을 때 오류 메시지를 찍는다. 도움말이 지금 목적에 꼭 맞지는 않지만 손볼 수 있다.

@<함수들@>=
func obliterated(q pointer) {
	printErr("Variable ")
	showTokenList(q, null, 1000, 0)
	printStr(" has been obliterated")
@.Variable...obliterated@>
	help5("It seems you did a nasty thing---probably by accident,",
		"but nevertheless you nearly hornswoggled me...",
		"While I was evaluating the right-hand side of this",
		"command, something happened, and the left-hand side",
		"is no longer a variable! So I won't change anything.")
}

@ 변수가 있다면, 평범한 보통 변수를 정말로 훑었다고 결론짓기 전에 몇 가지 특별한 경우를 더 살펴야 한다.

@<변수로 가장한 별난...@>=
if postHead != null {
	@<접미사 있는 매크로 호출을 마련하고 |goto restart|@>
}
q = link(preHead)
freeAvail(preHead)
if curCmd == myVarFlag {
	curType = tokenList
	curExp = q
	goto done
}
p = findVariable(q)
if p != null {
	makeExpCopy(p)
} else {
	obliterated(q)
	helpLine[2] = "While I was evaluating the suffix of this variable,"
	helpLine[1] = "something was redefined, and it's no longer a variable!"
	helpLine[0] = "In order to get back on my feet, I've inserted `0' instead."
	putGetFlushError(0)
}
flushNodeList(q)
goto done

@ 매크로 호출에 얽힌 유일한 복잡한 점은 앞붙이 매개변수와 ``at'' 매개변수를 알맞은 목록들의 목록으로 꾸려야 한다는
것이다.

@<접미사 없는 매크로 호출을 마련하고...@>=
p = getAvail()
setInfo(preHead, link(preHead))
setLink(preHead, p)
setInfo(p, t)
macroCall(value(q), preHead, null)
getXNext()
goto restart

@ 접미사 있는 매크로로 드러난 ``변수''가 더는 없다 해도 상관없다. 그 토큰 목록을 가리키는 포인터(|macroRef|)를 확보해
두었기 때문이다.

@<접미사 있는 매크로 호출을...@>=
backInput()
p = getAvail()
q = link(postHead)
setInfo(preHead, link(preHead))
setLink(preHead, postHead)
setInfo(postHead, q)
setLink(postHead, p)
setInfo(p, link(q))
setLink(q, null)
macroCall(macroRef, preHead, null)
setRefCount(macroRef, refCount(macroRef)-1)
getXNext()
goto restart

@ 남은 일은 찾은 값을 베끼는 것뿐이다. 어떤 경우는 다른 경우보다 어렵지만, 복잡함은 오로지 가능한 경우가 많다는 데서
온다.

@<함수들@>=
func makeExpCopy(p pointer) {
	var q, r, t pointer // 목록 조작용 레지스터
restart:
	curType = typ(p)
	switch curType {
	case vacuous, booleanType, known:
		curExp = value(p)
	case unknownBoolean, unknownString, unknownPen, unknownPicture, unknownPath:
		curExp = newRingEntry(p)
	case stringType:
		curExp = value(p)
		addStrRef(curExp)
	case penType:
		curExp = value(p)
		addPenRef(curExp)
	case pictureType:
		curExp = copyEdges(value(p))
	case pathType, futurePen:
		curExp = copyPath(value(p))
	case transformType, pairType:
		@<큰 노드 |p|를 베낀다@>
	case dependent, protoDependent:
		encapsulate(copyDepList(depList(p)))
	case numericType:
		newIndep(p)
		goto restart
	case independent:
		q = singleDependency(p)
		if q == depFinal {
			curType = known
			curExp = 0
			freeNode(q, depNodeSize)
		} else {
			curType = dependent
			encapsulate(q)
		}
	default:
		confusion("copy")
@:this can't happen copy}{\quad copy@>
	}
}

@ 서브루틴 |encapsulate|는 |depFinal|이 종속 목록~|p|의 꼬리라고 가정한다.

@<함수들@>=
func encapsulate(p pointer) {
	curExp = getNode(valueNodeSize)
	setType(curExp, curType)
	setNameType(curExp, capsule)
	newDep(curExp, p)
}

@ 사용자가 \KW{pair}나 \KW{transform} 변수를 가리킬 때가 가장 지루하다. 필드 여럿을 베껴야 하는데, 그 하나하나가
|independent|, |dependent|, |protoDependent|, |known| 가운데 어느 것이든 될 수 있다.

@<큰 노드 |p|를...@>=
if value(p) == null {
	initBigNode(p)
}
t = getNode(valueNodeSize)
setNameType(t, capsule)
setType(t, curType)
initBigNode(t)
q = value(p) + bigNodeSize[curType]
r = value(t) + bigNodeSize[curType]
for {
	q = q - 2
	r = r - 2
	install(r, q)
	if q == value(p) {
		break
	}
}
curExp = t

@ 프로시저 |install|은 수치 필드~|q|를 캡슐의 일부가 될 큰 노드의 필드~|r|에 베낀다.

@<함수들@>=
func install(r, q pointer) {
	var p pointer // 임시 레지스터
	if typ(q) == known {
		setValue(r, value(q))
		setType(r, known)
	} else if typ(q) == independent {
		p = singleDependency(q)
		if p == depFinal {
			setType(r, known)
			setValue(r, 0)
			freeNode(p, depNodeSize)
		} else {
			setType(r, dependent)
			newDep(r, p)
		}
	} else {
		setType(r, typ(q))
		newDep(r, copyDepList(depList(q)))
	}
}

@ `\.{a[b,c]}' 꼴의 식은 \.a가 수치라면 \.b와~\.c의 형을 검사하지 않고 `\.{b+a*(c-b)}'로 바꾼다.

계산 순서를 따라가 보자. 먼저 |p|에 \.a를, |q|에 \.b를, |r|에 \.c를 넣어 둔 다음 |makeExpCopy(q)|로 현재 식을 \.b로 만든다.
이어서 |doBinary(r,minus)|는 $c-b$를, |doBinary(p,times)|는 $a(c-b)$를, |doBinary(q,plus)|는 $b+a(c-b)$를 남긴다.

@<중개 구문을...@>=
p = stashCurExp()
getXNext()
scanExpression()
if curCmd != comma {
	@<왼쪽 대괄호와 식을...@>
	unstashCurExp(p)
} else {
	q = stashCurExp()
	getXNext()
	scanExpression()
	if curCmd != rightBracket {
		missingErr("]")
@.Missing `]'@>
		help3("I've scanned an expression of the form `a[b,c',",
			"so a right bracket should have come next.",
			"I shall pretend that one was there.")
		backError()
	}
	r = stashCurExp()
	makeExpCopy(q)
	doBinary(r, minus)
	doBinary(p, times)
	doBinary(q, plus)
	getXNext()
}

@ 다음은 매크로의 \KW{suffix} 매개변수를 훑는 데 쓰는 비교적 간단한 루틴이다.

@<함수들@>=
func scanSuffix() {
	var h, t pointer // 만들고 있는 목록의 머리와 꼬리
	var p pointer // 임시 레지스터
	h = getAvail()
	t = h
	for {
		if curCmd == leftBracket {
			@<대괄호 첨자를 훑고 |curCmd=numericToken|으로 놓는다@>
		}
		if curCmd == numericToken {
			p = newNumTok(curMod)
		} else if curCmd == tagToken || curCmd == internalQuantity {
			p = getAvail()
			setInfo(p, curSym)
		} else {
			break
		}
		setLink(t, p)
		t = p
		getXNext()
	}
	curExp = link(h)
	freeAvail(h)
	curType = tokenList
}

@ @<대괄호 첨자를 훑고...@>=
getXNext()
scanExpression()
if curType != known {
	badSubscript()
}
if curCmd != rightBracket {
	missingErr("]")
@.Missing `]'@>
	help3("I've seen a `[' and a subscript value, in a suffix,",
		"so a right bracket should have come next.",
		"I shall pretend that one was there.")
	backError()
}
curCmd = numericToken
curMod = curExp

@* 이차식과 그 위의 식 구문 분석.
루틴 |scanPrimary|의 복잡함을 겪고 나면 |scanSecondary| 루틴은 상쾌할 만큼 간단하다. 사소하지는 않지만 연산들이 비교적
곧이곧대로다. 주된 어려움은 이번에도 |getXNext|를 부를 때마다 식과 자료 구조가 크게 바뀔 수 있다는 점이므로 조심스럽게
다가가야 한다. 이를테면 \KW{primarydef}로 정의한 매크로는 그 둘째 인자를 다 훑었을 때 이미 사라졌을 수도 있다. 우리는
그 토큰 목록의 참조 횟수를 늘려서, 매크로가 짓밟힌 다음에도 부를 수 있게 하여 이 문제를 푼다.

원본의 |continue| 레이블은 연산자가 이어지는 동안 도는 \GO/의 |for| 반복문이 되었다. 레이블 |restart|는 매크로를 부른 다음
처음부터 다시 훑으려고 남겨 두었다.

@<함수들@>=
func scanSecondary() {
	var p pointer // 목록 조작용
	var c, d halfword // 연산 코드나 수식어
	var macName pointer // \KW{primarydef}로 정의한 토큰
restart:
	if curCmd < minPrimaryCommand || curCmd > maxPrimaryCommand {
		badExp("A secondary")
	}
@.A secondary expression...@>
	scanPrimary()
	for curCmd <= maxSecondaryCommand && curCmd >= minSecondaryCommand {
		p = stashCurExp()
		c = curMod
		d = curCmd
		if d == secondaryPrimaryMacro {
			macName = curSym
			addMacRef(c)
		}
		getXNext()
		scanPrimary()
		if d != secondaryPrimaryMacro {
			doBinary(p, c)
		} else {
			backInput()
			binaryMac(p, c, macName)
			setRefCount(c, refCount(c)-1)
			getXNext()
			goto restart
		}
	}
}

@ 다음 프로시저는 매개변수가 둘, 곧 |p|와 |curExp|인 매크로를 부른다.

@<함수들@>=
func binaryMac(p, c, n pointer) {
	var q, r pointer // 매개변수 목록의 노드
	q = getAvail()
	r = getAvail()
	setLink(q, r)
	setInfo(q, p)
	setInfo(r, stashCurExp())
	macroCall(c, q, n)
}

@ 다음 프로시저 |scanTertiary|도 거의 같은 이야기다.

@<함수들@>=
func scanTertiary() {
	var p pointer // 목록 조작용
	var c, d halfword // 연산 코드나 수식어
	var macName pointer // \KW{secondarydef}로 정의한 토큰
restart:
	if curCmd < minPrimaryCommand || curCmd > maxPrimaryCommand {
		badExp("A tertiary")
	}
@.A tertiary expression...@>
	scanSecondary()
	if curType == futurePen {
		materializePen()
	}
	for curCmd <= maxTertiaryCommand && curCmd >= minTertiaryCommand {
		p = stashCurExp()
		c = curMod
		d = curCmd
		if d == tertiarySecondaryMacro {
			macName = curSym
			addMacRef(c)
		}
		getXNext()
		scanSecondary()
		if d != tertiarySecondaryMacro {
			doBinary(p, c)
		} else {
			backInput()
			binaryMac(p, c, macName)
			setRefCount(c, refCount(c)-1)
			getXNext()
			goto restart
		}
	}
}

@ 미래의 펜 |futurePen|은 여기서 어엿한 펜이 된다. 원본의 |commonEnding| 레이블은 |if|--|else|로 바뀌었다.

@<함수들@>=
func materializePen() {
	var aMinusB, aPlusB, majorAxis, minorAxis scaled // 타원 변수들
	var theta angle // 타원을 돌린 양
	var p pointer // 경로를 훑는 포인터
	var q pointer // 펜으로 만들 매듭 목록
	q = curExp
	if leftType(q) == endpoint {
		printErr("Pen path must be a cycle")
@.Pen path must be a cycle@>
		help2("I can't make a pen from the given path.",
			"So I've replaced it by the trivial path `(0,0)..cycle'.")
		putGetError()
		curExp = nullPen
	} else {
		if leftType(q) == open {
			@<노드 |q|를 타원 펜의 경로로 바꾼다@>
		}
		curExp = makePen(q)
	}
	tossKnotList(q)
	curType = penType
}

@ 우리는 세 점 $(0,0)$, $(1,0)$, $(0,1)$을 \KW{pencircle}에 넣어 두었고, 이제 그것들은 $(u,v)$, $(A+u,B+v)$,
$(C+u,D+v)$로 변환되었다. 이것으로 변환 $(x,y)\mapsto(Ax+Cy+u,Bx+Dy+v)$을 알아내기에 충분한 정보를 얻는다.

네 값 $(A,B,C,D)$가 주어지면 언제나
$$\eqalign{A&=a\cos\phi\cos\theta-b\sin\phi\sin\theta;\cr
B&=a\cos\phi\sin\theta+b\sin\phi\cos\theta;\cr
C&=-a\sin\phi\cos\theta-b\cos\phi\sin\theta;\cr
D&=-a\sin\phi\sin\theta+b\cos\phi\cos\theta\cr}$$
인 $(a,b,\theta,\phi)$를 찾을 수 있다. 이 표기에서 단위원 $(\cos t,\sin t)$는
$$\bigl(a\cos(\phi+t)\cos\theta-b\sin(\phi+t)\sin\theta,\;
a\cos(\phi+t)\sin\theta+b\sin(\phi+t)\cos\theta\bigr)\;+\;(u,v)$$
로 변환되는데, 이것은 반축이~$(a,b)$이고 $\theta$만큼 돌고 $(u,v)$만큼 옮겨진 타원이다. 곧 단위원을 먼저 $\phi$만큼
돌리고, $x$~방향으로 $a$배 $y$~방향으로 $b$배 늘이고, $\theta$만큼 돌리고, $(u,v)$만큼 옮긴 것이다. 주어진 방정식을
풀려면
$$\eqalign{A-D&=(a-b)\cos(\theta-\phi),\cr
B+C&=(a-b)\sin(\theta-\phi),\cr}
\qquad
\eqalign{A+D&=(a+b)\cos(\theta+\phi),\cr
B-C&=(a+b)\sin(\theta+\phi)\cr}$$
를 푸는 것이 필요충분하다. 이 식들에서 $a-b$, $a+b$, $\theta-\phi$, $\theta+\phi$를 쉽게 찾을 수 있다. 그러면
$a=\bigl((a+b)+(a-b)\bigr)/2$이고 $\theta=\bigl((\theta+\phi)+(\theta-\phi)\bigr)/2$다. 회전 $\phi$는 원 위에서 매개변수를
옮길 뿐이라 타원의 모양에는 아무 영향이 없으므로 구할 필요조차 없다. 다만 $a-b$는 음수일 수도 있어서 코드는
|majorAxis|와 |minorAxis|를 구할 때 절댓값을 쓴다.

아래 코드는 $(A,B,C,D,u,v)$를 나타내는 데 |(txx,tyx,txy,tyy,tx,ty)|를 쓴다.

$$\mplibcode
beginfig(22);
save u, T, a, b, phi, theta, c, p, q; numeric u, a, b, phi, theta; transform T; pair c, p, q;
u := 28pt; a := 1.7; b := .8; phi := -30; theta := 30;
c := (6.6u, 0);
T := identity rotated phi xscaled a yscaled b rotated theta shifted c;
draw fullcircle scaled 2u;
drawarrow (0,0) -- (u,0) withpen pencircle scaled .4pt;
drawarrow (0,0) -- (0,u) withpen pencircle scaled .4pt;
dot((0,0)); dot((u,0)); dot((0,u));
label.llft(btex $(0,0)$ etex, (0,0));
label.rt(btex $(1,0)$ etex, (u,0));
label.urt(btex $(0,1)$ etex, (0,u));
drawarrow (2.3u,0) -- (4.4u,0) withpen pencircle scaled .6pt;
label.top(btex 변환 etex, (3.35u,0));
draw fullcircle scaled 2u transformed T;
draw c -- (c - (1.9u,0)) dashed evenly withcolor .5white;
draw c -- (c + a*u*dir(theta+180)) dashed withdots withcolor .3white;
draw c -- (c + b*u*dir(theta+270)) dashed withdots withcolor .3white;
draw anglearc(c, 180, 180+theta, .6u) withpen pencircle scaled .4pt;
label(btex $\theta$ etex, c + 1.0u*dir(180+.5theta) + (0,-1pt));
label.lrt(btex $a$ etex, c + .5a*u*dir(theta+180));
label.rt(btex $b$ etex, c + .5b*u*dir(theta+270));
p := (u,0) transformed T; q := (0,u) transformed T;
drawarrow c -- p withpen pencircle scaled .4pt;
drawarrow c -- q withpen pencircle scaled .4pt;
dot(c); dot(p); dot(q);
label.ulft(btex $(u,v)$ etex, c);
label.rt(btex $(A{+}u,B{+}v)$ etex, p);
label.top(btex $(C{+}u,D{+}v)$ etex, q);
endfig;
\endmplibcode$$

@<노드 |q|를 타원 펜의...@>=
tx = xCoord(q)
ty = yCoord(q)
txx = leftX(q) - tx
tyx = leftY(q) - ty
txy = rightX(q) - tx
tyy = rightY(q) - ty
aMinusB = pythAdd(txx-tyy, tyx+txy)
aPlusB = pythAdd(txx+tyy, tyx-txy)
majorAxis = half(aMinusB + aPlusB)
minorAxis = half(abs(aPlusB - aMinusB))
if majorAxis == minorAxis {
	theta = 0 // 원
} else {
	theta = half(nArg(txx-tyy, tyx+txy) + nArg(txx+tyy, tyx-txy))
}
freeNode(q, knotNodeSize)
q = makeEllipse(majorAxis, minorAxis, theta)
if tx != 0 || ty != 0 {
	@<경로 |q|의 좌표를 옮긴다@>
}

@ @<경로 |q|의 좌표를...@>=
p = q
for {
	setXCoord(p, xCoord(p)+tx)
	setYCoord(p, yCoord(p)+ty)
	p = link(p)
	if p == q {
		break
	}
}

@ 마침내 구문 분석 루틴 사중주의 가장 깊은 수준에 이르렀다. 이것도 다른 것들과 비슷하지만, 경로 때문에 복잡한 일이
하나 더 있다. 경로가 여기서 구체화되기 때문이다.

원본에는 레이블이 여섯이었다. 그 가운데 |restart|는 그대로 두었고, |continue|는 바깥 |for| 반복문이 되었고, |exit|는 |return|이
되었고, |done|은 |if|--|else|로 사라졌다. 경로 조각을 잇는 동안 도는 |continuePath|와 그 반복문을 빠져나가는
|finishPath|는 레이블 붙은 |for| 반복문 |nextJoin|과 그것의 |break|가 되었다.

@<함수들@>=
func scanExpression() {
	var p, q, r, pp, qq pointer // 목록 조작용
	var c, d halfword // 연산 코드나 수식어
	var myVarFlag int32 // |varFlag|의 처음 값; |0 .. maxCommandCode|
	var macName pointer // \KW{tertiarydef}로 정의한 토큰
	var cycleHit bool // 경로 식이 방금 `\KW{cycle}'로 끝났나?
	var x, y scaled // 경로 이음에서 명시한 좌표나 장력
	var t smallNumber // 경로 이음 다음의 매듭 형; |endpoint .. open|
	myVarFlag = varFlag
restart:
	if curCmd < minPrimaryCommand || curCmd > maxPrimaryCommand {
		badExp("An")
	}
@.An expression...@>
	scanTertiary()
	for curCmd <= maxExpressionCommand && curCmd >= minExpressionCommand &&
		(curCmd != equals || myVarFlag != assignment) {
		p = stashCurExp()
		c = curMod
		d = curCmd
		if d == expressionTertiaryMacro {
			macName = curSym
			addMacRef(c)
		}
		if d < ampersand || (d == ampersand && (typ(p) == pairType || typ(p) == pathType)) {
			@<경로 구성 연산을 훑는다; 그러나 |p|의 형이 틀리면 |return|@>
		} else {
			@<식 연산자의 오른쪽 삼차식을 훑어 연산한다; 매크로였으면 |goto restart|@>
		}
	}
}

@ 경로를 만드는 연산자가 아니면 |scanSecondary|와 |scanTertiary|에서 본 것과 같은 일을 한다.

@<식 연산자의 오른쪽 삼차식을...@>=
getXNext()
scanTertiary()
if d != expressionTertiaryMacro {
	doBinary(p, c)
} else {
	backInput()
	binaryMac(p, c, macName)
	setRefCount(c, refCount(c)-1)
	getXNext()
	goto restart
}

@ 이 코드의 다음 부분을 이해하려면 먼저 경로의 자료 구조 관례를 다시 보아야 한다.

경로 식 `$z_0\ldots z_1\ldots z_2$'를 훑는 동안 |p|와 |q|는 지금까지 만든 부분 경로의 머리와 꼬리이고, |pp|와 |qq|는
새로 훑은 오른쪽 피연산자의 머리와 꼬리다. 이음 하나를 처리할 때마다 두 부분 경로를 이어서 |q|를 |qq|로 옮긴다.
부분 경로는 아직 고리가 아니어서 |link(q)|는 |p|를 가리키지만, 그 사이의 |leftType(p)|와 |rightType(q)|는 |open|이다.

@<경로 구성 연산을 훑는다...@>=
cycleHit = false
@<왼쪽 피연산자 |p|를 |q|에서 끝나는 부분 경로로 바꾼다; 그러나 |p|의 형이 알맞지 않으면 |return|@>
nextJoin:
for {
	@<경로 이음 매개변수를 정한다; 그러나 방향 지정만 있으면 |break nextJoin|@>
	if curCmd == cycle {
		@<고리를 닫을 준비를 한다@>
	} else {
		scanTertiary()
		@<오른쪽 피연산자 |curExp|를 |pp|에서 |qq|까지의 부분 경로로 바꾼다@>
	}
	@<부분 경로들을 잇고 |p|와 |q|를 그 결과의 머리와 꼬리로 다시 놓는다@>
	if curCmd < minExpressionCommand || curCmd > ampersand || cycleHit {
		break
	}
}
@<경로의 조절점을 고르고 그 결과를 |curExp|에 넣는다@>

@ @<왼쪽 피연산자 |p|를...@>=
unstashCurExp(p)
if curType == pairType {
	p = newKnot()
} else if curType == pathType {
	p = curExp
} else {
	return
}
q = p
for link(q) != p {
	q = link(q)
}
if leftType(p) != endpoint { // 고리를 연다
	r = copyKnot(p)
	setLink(q, r)
	q = r
}
setLeftType(p, open)
setRightType(q, open)

@ 쌍 수치 값은 \MF가 그 쌍이 경로의 일부임을 알아챌 때 점 하나짜리 경로를 위한 매듭 노드로 바뀐다.

@<함수들@>=
func newKnot() pointer { // 쌍을 끝점이 둘인 매듭으로 바꾼다
	var q pointer // 새 노드
	q = getNode(knotNodeSize)
	setLeftType(q, endpoint)
	setRightType(q, endpoint)
	setLink(q, q)
	knownPair()
	setXCoord(q, curX)
	setYCoord(q, curY)
	return q
}

@ 서브루틴 |knownPair|는 현재 식이 알려진 수치의 쌍이라고 가정하고 |curX|와 |curY|를 그 성분으로 놓는다. 알려지지 않은
성분은 0이 되고, 현재 식은 치워진다.

@<함수들@>=
func knownPair() {
	var p pointer // 쌍 노드
	if curType != pairType {
		expErr("Undefined coordinates have been replaced by (0,0)")
@.Undefined coordinates...@>
		help5("I need x and y numbers for this part of the path.",
			"The value I found (see above) was no good;",
			"so I'll try to keep going by using zero instead.",
			"(Chapter 27 of The METAFONTbook explains that",
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
			"you might want to type `I ???' now.)")
		putGetFlushError(0)
		curX = 0
		curY = 0
	} else {
		p = value(curExp)
		@<|p|의 |x|와 |y| 부분이 모두 알려져 있는지 확인하고, 그것들을 |curX|와 |curY|에 베낀다@>
		flushCurExp(0)
	}
}

@ @<|p|의 |x|와 |y| 부분이...@>=
if typ(xPartLoc(p)) == known {
	curX = value(xPartLoc(p))
} else {
	dispErr(xPartLoc(p), "Undefined x coordinate has been replaced by 0")
@.Undefined coordinates...@>
	help5("I need a `known' x value for this part of the path.",
		"The value I found (see above) was no good;",
		"so I'll try to keep going by using zero instead.",
		"(Chapter 27 of The METAFONTbook explains that",
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
		"you might want to type `I ???' now.)")
	putGetError()
	recycleValue(xPartLoc(p))
	curX = 0
}
if typ(yPartLoc(p)) == known {
	curY = value(yPartLoc(p))
} else {
	dispErr(yPartLoc(p), "Undefined y coordinate has been replaced by 0")
	help5("I need a `known' y value for this part of the path.",
		"The value I found (see above) was no good;",
		"so I'll try to keep going by using zero instead.",
		"(Chapter 27 of The METAFONTbook explains that",
		"you might want to type `I ???' now.)")
	putGetError()
	recycleValue(yPartLoc(p))
	curY = 0
}

@ 이 지점에서 |curCmd|는 |ampersand|, |leftBrace|, |pathJoin| 가운데 하나다.

@<경로 이음 매개변수를...@>=
if curCmd == leftBrace {
	@<이음 앞의 방향 정보를 노드 |q|에 넣는다@>
}
d = curCmd
if d == pathJoin {
	@<장력이나 조절점을 정한다@>
} else if d != ampersand {
	break nextJoin
}
getXNext()
if curCmd == leftBrace {
	@<이음 뒤의 방향 정보를 |x|와 |t|에 넣는다@>
} else if rightType(q) != explicit {
	t = open
	x = 0
}

@ 서브루틴 |scanDirection|은 중괄호로 둘러싼 방향 정보를 살피고, 그다음 문자까지 미리 훑는다. 돌려주는 형 코드는
|open|(방향이 $(0,0)$이었을 때)이거나, |curl|(방향이 값이 알려진 |curExp|인 휨이었을 때)이거나, |given|(방향이 지금
|curExp|에 나타난 |angle| 값으로 주어졌을 때)이다.

이 서브루틴에 어려운 것은 없지만, 여러 가지 오류의 싹을 미리 잘라야 해서 프로그램이 꽤 길다.

@<함수들@>=
func scanDirection() smallNumber {
	var t smallNumber // 찾은 정보의 형; |given .. open|
	var x scaled // |x| 좌표
	getXNext()
	if curCmd == curlCommand {
		@<휨 지정을 훑는다@>
	} else {
		@<주어진 방향을 훑는다@>
	}
	if curCmd != rightBrace {
		missingErr("}")
@.Missing `\char`\}'@>
		help3("I've scanned a direction spec for part of a path,",
			"so a right brace should have come next.",
			"I shall pretend that one was there.")
		backError()
	}
	getXNext()
	return t
}

@ @<휨 지정을...@>=
getXNext()
scanExpression()
if curType != known || curExp < 0 {
	expErr("Improper curl has been replaced by 1")
@.Improper curl@>
	help1("A curl must be a known, nonnegative number.")
	putGetFlushError(unity)
}
t = curl

@ @<주어진 방향을...@>=
scanExpression()
if curType > pairType {
	@<쉼표로 나뉜 주어진 방향을 얻는다@>
} else {
	knownPair()
}
if curX == 0 && curY == 0 {
	t = open
} else {
	t = given
	curExp = nArg(curX, curY)
}

@ @<쉼표로 나뉜...@>=
if curType != known {
	expErr("Undefined x coordinate has been replaced by 0")
@.Undefined coordinates...@>
	help5("I need a `known' x value for this part of the path.",
		"The value I found (see above) was no good;",
		"so I'll try to keep going by using zero instead.",
		"(Chapter 27 of The METAFONTbook explains that",
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
		"you might want to type `I ???' now.)")
	putGetFlushError(0)
}
x = curExp
if curCmd != comma {
	missingErr(",")
@.Missing `,'@>
	help2("I've got the x coordinate of a path direction;",
		"will look for the y coordinate next.")
	backError()
}
getXNext()
scanExpression()
if curType != known {
	expErr("Undefined y coordinate has been replaced by 0")
	help5("I need a `known' y value for this part of the path.",
		"The value I found (see above) was no good;",
		"so I'll try to keep going by using zero instead.",
		"(Chapter 27 of The METAFONTbook explains that",
		"you might want to type `I ???' now.)")
	putGetFlushError(0)
}
curY = curExp
curX = x

@ 이 지점에서 |rightType(q)|는 대개 |open|이지만, 앞의 연산이 다른 값으로 놓았을 수도 있다. 이를테면
경로 조각 `\.{..\{curl2\}z\{0,0\}..}'에서는 방향 \.{\{0,0\}}이 |open|을 뜻하므로, 앞서 \KW{curl}로 놓은
|rightType(q)|의 값을 지켜야 한다.

@<이음 앞의 방향 정보를...@>=
t = scanDirection()
if t != open {
	setRightType(q, t)
	setRightGiven(q, curExp)
	if leftType(q) == open {
		setLeftType(q, t)
		setLeftGiven(q, curExp)
	} // |leftGiven(q)=leftCurl(q)|임에 주의하라
}

@ 매듭 노드에서 |leftTension|과 |leftY|가 같은 자리를 나눠 쓰고 |leftGiven|도 비슷하게 |leftX|와 같으므로, 명시한
조절점이 없을 때는 주어진 방향과 장력 정보를 |x|와 |y|에 담아 둔다.

@<이음 뒤의 방향 정보를...@>=
t = scanDirection()
if rightType(q) != explicit {
	x = curExp
} else {
	t = explicit // 방향 정보가 쓸데없다
}

@ 원본의 |done| 레이블은 기본 장력의 경우를 |if|의 한 갈래로 떼어 내어 없앴다.

@<장력이나 조절점을...@>=
getXNext()
if curCmd != tension && curCmd != controls {
	setRightTension(q, unity)
	y = unity
	backInput() // 기본 장력
} else {
	if curCmd == tension {
		@<명시한 장력을 놓는다@>
	} else {
		@<명시한 조절점을 놓는다@>
	}
	if curCmd != pathJoin {
		missingErr("..")
@.Missing `..'@>
		help1("A path join command should end with two dots.")
		backError()
	}
}

@ 장력 값 앞에 \KW{atleast}가 왔는지를 기억하는 데 잠깐 |y|를 빌려 명령 코드를 담는다. \KW{atleast}가 붙은 장력은 음수로
저장하는데, 조절점 고르기 루틴이 이 부호를 보고 ``적어도 이만큼''이라는 뜻으로 읽는다.

@<명시한 장력을...@>=
getXNext()
y = curCmd
if curCmd == atLeast {
	getXNext()
}
scanPrimary()
@<현재 식이 올바른 장력 설정인지 확인한다@>
if y == atLeast {
	curExp = -curExp
}
setRightTension(q, curExp)
if curCmd == andCommand {
	getXNext()
	y = curCmd
	if curCmd == atLeast {
		getXNext()
	}
	scanPrimary()
	@<현재 식이 올바른 장력 설정인지...@>
	if y == atLeast {
		curExp = -curExp
	}
}
y = curExp

@ @<현재 식이 올바른 장력 설정인지...@>=
if curType != known || curExp < minTension {
	expErr("Improper tension has been set to 1")
@.Improper tension@>
	help1("The expression above should have been a number >=3/4.")
	putGetFlushError(unity)
}

@ @<정의@>=
const @!minTension = threeQuarterUnit // 허용되는 가장 작은 장력

@ @<명시한 조절점을...@>=
setRightType(q, explicit)
t = explicit
getXNext()
scanPrimary()
knownPair()
setRightX(q, curX)
setRightY(q, curY)
if curCmd != andCommand {
	x = rightX(q)
	y = rightY(q)
} else {
	getXNext()
	scanPrimary()
	knownPair()
	x = curX
	y = curY
}

@ @<오른쪽 피연산자 |curExp|를...@>=
if curType != pathType {
	pp = newKnot()
} else {
	pp = curExp
}
qq = pp
for link(qq) != pp {
	qq = link(qq)
}
if leftType(pp) != endpoint { // 고리를 연다
	r = copyKnot(pp)
	setLink(qq, r)
	qq = r
}
setLeftType(pp, open)
setRightType(qq, open)

@ 누군가 `\.{(x,y)\&cycle}'이라고 써서 경로 전체를 정의하려 하면, 우리는 그 지정을 소리 없이 `\.{(x,y)..cycle}'로
바꾼다. 고리의 길이가 0이어서는 안 되기 때문이다.

@<고리를 닫을 준비를...@>=
cycleHit = true
getXNext()
pp = p
qq = p
if d == ampersand {
	if p == q {
		d = pathJoin
		setRightTension(q, unity)
		y = unity
	}
}

@ @<부분 경로들을 잇고...@>=
if d == ampersand {
	if xCoord(q) != xCoord(pp) || yCoord(q) != yCoord(pp) {
		printErr("Paths don't touch; `&' will be changed to `..'")
@.Paths don't touch@>
		help3("When you join paths `p&q', the ending point of p",
			"must be exactly equal to the starting point of q.",
			"So I'm going to pretend that you said `p..q' instead.")
		putGetError()
		d = pathJoin
		setRightTension(q, unity)
		y = unity
	}
}
@<할 수 있으면 |rightType(pp)|의 틈을 메운다@>
if d == ampersand {
	@<독립된 경로들을 이어 붙인다@>
} else {
	@<할 수 있으면 |rightType(q)|의 틈을 메운다@>
	setLink(q, pp)
	setLeftY(pp, y)
	if t != open {
		setLeftX(pp, x)
		setLeftType(pp, t)
	}
}
q = qq

@ @<할 수 있으면 |rightType(q)|의...@>=
if rightType(q) == open {
	if leftType(q) == curl || leftType(q) == given {
		setRightType(q, leftType(q))
		setRightGiven(q, leftGiven(q))
	}
}

@ @<할 수 있으면 |rightType(pp)|의...@>=
if rightType(pp) == open {
	if t == curl || t == given {
		setRightType(pp, t)
		setRightGiven(pp, x)
	}
}

@ @<독립된 경로들을...@>=
if leftType(q) == open {
	if rightType(q) == open {
		setLeftType(q, curl)
		setLeftCurl(q, unity)
	}
}
if rightType(pp) == open {
	if t == open {
		setRightType(pp, curl)
		setRightCurl(pp, unity)
	}
}
setRightType(q, rightType(pp))
setLink(q, link(pp))
setRightX(q, rightX(pp))
setRightY(q, rightY(pp))
freeNode(pp, knotNodeSize)
if qq == pp {
	qq = q
}

@ @<경로의 조절점을 고르고...@>=
if cycleHit {
	if d == ampersand {
		p = q
	}
} else {
	setLeftType(p, endpoint)
	if rightType(p) == open {
		setRightType(p, curl)
		setRightCurl(p, unity)
	}
	setRightType(q, endpoint)
	if leftType(q) == open {
		setLeftType(q, curl)
		setLeftCurl(q, unity)
	}
	setLink(q, p)
}
makeChoices(p)
curType = pathType
curExp = p

@ 끝으로, 값이 |trueCode|이거나 |falseCode|여야 하는 식을 훑어야 할 때가 가끔 있다.

@<함수들@>=
func getBoolean() {
	getXNext()
	scanExpression()
	if curType != booleanType {
		expErr("Undefined condition will be treated as `false'")
@.Undefined condition...@>
		help2("The expression shown above should have had a definite",
			"true-or-false value. I'm changing it to `false'.")
		putGetFlushError(falseCode)
		curType = booleanType
	}
}

@* 연산하기.
구문 분석의 목적은 주로 사람들이 괄호 더미를 피할 수 있게 하는 것이다. 그러나 진짜 일은 식의 구조를 알아본
다음에 이루어진다. 새 식이 만들어지는 것이 그때다. 이제 \MF의 내장, 곧 구문 분석 기구를 거쳐 온 개별 연산자를
처리하는 부분으로 넘어간다.

피연산자가 없는 쉬운 것들부터 시작해서, 인자가 하나인 연산자, 마지막으로 둘인 연산자로 올라가겠다. 달리 말해 식
훑개들이 이따금 부르는 세 프로시저 |doNullary|, |doUnary|, |doBinary|를 쓰겠다.

먼저 모든 원시 연산자가 해시 표에 있는지 확인하자. 루틴 |scanPrimary|와 그 친척들은 이 연산자들의 \\{cmd} 코드를 썼지만,
\\{do} 루틴들은 모든 것을 \\{mod} 코드에 기댄다. 이를테면 |doBinary|는 자기가 하는 연산이 |primaryBinary|인지
|secondaryBinary|인지 따위에 신경 쓰지 않는다.

@<\MF의 원시 명령을...@>=
primitive("true", nullary, trueCode)
@!@:true_}{\KW{true} primitive@>
primitive("false", nullary, falseCode)
@!@:false_}{\KW{false} primitive@>
primitive("nullpicture", nullary, nullPictureCode)
@!@:null_picture_}{\KW{nullpicture} primitive@>
primitive("nullpen", nullary, nullPenCode)
@!@:null_pen_}{\KW{nullpen} primitive@>
primitive("jobname", nullary, jobNameOp)
@!@:job_name_}{\KW{jobname} primitive@>
primitive("readstring", nullary, readStringOp)
@!@:read_string_}{\KW{readstring} primitive@>
primitive("pencircle", nullary, penCircle)
@!@:pen_circle_}{\KW{pencircle} primitive@>
primitive("normaldeviate", nullary, normalDeviate)
@!@:normal_deviate_}{\KW{normaldeviate} primitive@>
primitive("odd", unary, oddOp)
@!@:odd_}{\KW{odd} primitive@>
primitive("known", unary, knownOp)
@!@:known_}{\KW{known} primitive@>
primitive("unknown", unary, unknownOp)
@!@:unknown_}{\KW{unknown} primitive@>
primitive("not", unary, notOp)
@!@:not_}{\KW{not} primitive@>
primitive("decimal", unary, decimal)
@!@:decimal_}{\KW{decimal} primitive@>
primitive("reverse", unary, reverse)
@!@:reverse_}{\KW{reverse} primitive@>
primitive("makepath", unary, makePathOp)
@!@:make_path_}{\KW{makepath} primitive@>
primitive("makepen", unary, makePenOp)
@!@:make_pen_}{\KW{makepen} primitive@>
primitive("totalweight", unary, totalWeightOp)
@!@:total_weight_}{\KW{totalweight} primitive@>
primitive("oct", unary, octOp)
@!@:oct_}{\KW{oct} primitive@>

@ @<\MF의 원시 명령을...@>=
primitive("hex", unary, hexOp)
@!@:hex_}{\KW{hex} primitive@>
primitive("ASCII", unary, asciiOp)
@!@:ASCII_}{\KW{ASCII} primitive@>
primitive("char", unary, charOp)
@!@:char_}{\KW{char} primitive@>
primitive("length", unary, lengthOp)
@!@:length_}{\KW{length} primitive@>
primitive("turningnumber", unary, turningOp)
@!@:turning_number_}{\KW{turningnumber} primitive@>
primitive("xpart", unary, xPart)
@!@:x_part_}{\KW{xpart} primitive@>
primitive("ypart", unary, yPart)
@!@:y_part_}{\KW{ypart} primitive@>
primitive("xxpart", unary, xxPart)
@!@:xx_part_}{\KW{xxpart} primitive@>
primitive("xypart", unary, xyPart)
@!@:xy_part_}{\KW{xypart} primitive@>
primitive("yxpart", unary, yxPart)
@!@:yx_part_}{\KW{yxpart} primitive@>
primitive("yypart", unary, yyPart)
@!@:yy_part_}{\KW{yypart} primitive@>
primitive("sqrt", unary, sqrtOp)
@!@:sqrt_}{\KW{sqrt} primitive@>
primitive("mexp", unary, mExpOp)
@!@:m_exp_}{\KW{mexp} primitive@>
primitive("mlog", unary, mLogOp)
@!@:m_log_}{\KW{mlog} primitive@>
primitive("sind", unary, sinDOp)
@!@:sin_d_}{\KW{sind} primitive@>
primitive("cosd", unary, cosDOp)
@!@:cos_d_}{\KW{cosd} primitive@>
primitive("floor", unary, floorOp)
@!@:floor_}{\KW{floor} primitive@>
primitive("uniformdeviate", unary, uniformDeviate)
@!@:uniform_deviate_}{\KW{uniformdeviate} primitive@>

@ @<\MF의 원시 명령을...@>=
primitive("charexists", unary, charExistsOp)
@!@:char_exists_}{\KW{charexists} primitive@>
primitive("angle", unary, angleOp)
@!@:angle_}{\KW{angle} primitive@>
primitive("cycle", cycle, cycleOp)
@!@:cycle_}{\KW{cycle} primitive@>
primitive("+", plusOrMinus, plus)
@!@:+ }{\.{+} primitive@>
primitive("-", plusOrMinus, minus)
@!@:- }{\.{-} primitive@>
primitive("*", secondaryBinary, times)
@!@:* }{\.{*} primitive@>
primitive("/", slash, over)
eqtb[frozenSlash] = eqtb[curSym]
@!@:/ }{\.{/} primitive@>
primitive("++", tertiaryBinary, pythagAdd)
@!@:++_}{\.{++} primitive@>
primitive("+-+", tertiaryBinary, pythagSub)
@!@:+-+_}{\.{+-+} primitive@>
primitive("and", andCommand, andOp)
@!@:and_}{\KW{and} primitive@>
primitive("or", tertiaryBinary, orOp)
@!@:or_}{\KW{or} primitive@>
primitive("<", expressionBinary, lessThan)
@!@:< }{\.{<} primitive@>
primitive("<=", expressionBinary, lessOrEqual)
@!@:<=_}{\.{<=} primitive@>
primitive(">", expressionBinary, greaterThan)
@!@:> }{\.{>} primitive@>
primitive(">=", expressionBinary, greaterOrEqual)
@!@:>=_}{\.{>=} primitive@>
primitive("=", equals, equalTo)
@!@:= }{\.{=} primitive@>
primitive("<>", expressionBinary, unequalTo)
@!@:<>_}{\.{<>} primitive@>

@ @<\MF의 원시 명령을...@>=
primitive("substring", primaryBinary, substringOf)
@!@:substring_}{\KW{substring} primitive@>
primitive("subpath", primaryBinary, subpathOf)
@!@:subpath_}{\KW{subpath} primitive@>
primitive("directiontime", primaryBinary, directionTimeOf)
@!@:direction_time_}{\KW{directiontime} primitive@>
primitive("point", primaryBinary, pointOf)
@!@:point_}{\KW{point} primitive@>
primitive("precontrol", primaryBinary, precontrolOf)
@!@:precontrol_}{\KW{precontrol} primitive@>
primitive("postcontrol", primaryBinary, postcontrolOf)
@!@:postcontrol_}{\KW{postcontrol} primitive@>
primitive("penoffset", primaryBinary, penOffsetOf)
@!@:pen_offset_}{\KW{penoffset} primitive@>
primitive("&", ampersand, concatenate)
@!@:!!!}{\.{\&} primitive@>
primitive("rotated", secondaryBinary, rotatedBy)
@!@:rotated_}{\KW{rotated} primitive@>
primitive("slanted", secondaryBinary, slantedBy)
@!@:slanted_}{\KW{slanted} primitive@>
primitive("scaled", secondaryBinary, scaledBy)
@!@:scaled_}{\KW{scaled} primitive@>
primitive("shifted", secondaryBinary, shiftedBy)
@!@:shifted_}{\KW{shifted} primitive@>
primitive("transformed", secondaryBinary, transformedBy)
@!@:transformed_}{\KW{transformed} primitive@>
primitive("xscaled", secondaryBinary, xScaled)
@!@:x_scaled_}{\KW{xscaled} primitive@>
primitive("yscaled", secondaryBinary, yScaled)
@!@:y_scaled_}{\KW{yscaled} primitive@>
primitive("zscaled", secondaryBinary, zScaled)
@!@:z_scaled_}{\KW{zscaled} primitive@>
primitive("intersectiontimes", tertiaryBinary, intersect)
@!@:intersection_times_}{\KW{intersectiontimes} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case nullary, unary, primaryBinary, secondaryBinary, tertiaryBinary,
	expressionBinary, cycle, plusOrMinus, slash, ampersand, equals, andCommand:
	printOp(m)

@ 좋다, 가장 간단한 \\{do} 프로시저부터 보자.

@<함수들@>=
func doNullary(c quarterword) {
	var k int32 // 만능 반복 첨자
	checkArith()
	if internal[tracingCommands] > two {
		showCmdMod(nullary, c)
	}
	switch c {
	case trueCode, falseCode:
		curType = booleanType
		curExp = c
	case nullPictureCode:
		curType = pictureType
		curExp = getNode(edgeHeaderSize)
		initEdges(curExp)
	case nullPenCode:
		curType = penType
		curExp = nullPen
	case normalDeviate:
		curType = known
		curExp = normRand()
	case penCircle:
		@<\KW{pencircle}을 위한 특별한 매듭 노드를 만든다@>
	case jobNameOp:
		if jobName == 0 {
			openLogFile()
		}
		curType = stringType
		curExp = jobName
	case readStringOp:
		@<단말기에서 문자열을 읽는다@>
	} // 다른 경우는 없다
	checkArith()
}

@ 연산 \KW{pencircle}은 단위원의 지름이 1인 원 펜을 나타내는 ``미래의 펜''이다. 매듭 하나에 세 점 $(0,0)$, $(1,0)$,
$(0,1)$을 담아 두는데, 이 점들은 \KW{pencircle}에 변환이 적용될 때마다 함께 변환된다. 마침내 펜이 필요해지면
|materializePen|이 이 세 점에서 타원을 되살려 낸다.

@<\KW{pencircle}을 위한...@>=
curType = futurePen
curExp = getNode(knotNodeSize)
setLeftType(curExp, open)
setRightType(curExp, open)
setLink(curExp, curExp)
setXCoord(curExp, 0)
setYCoord(curExp, 0)
setLeftX(curExp, unity)
setLeftY(curExp, 0)
setRightX(curExp, 0)
setRightY(curExp, unity)

@ @<단말기에서 문자열을...@>=
if interaction <= nonstopMode {
	fatalError("*** (cannot readstring in nonstop modes)")
}
beginFileReading()
name = 1
promptInput("")
strRoom(last - start)
for k = start; k <= last-1; k++ {
	appendChar(buffer[k])
}
endFileReading()
curType = stringType
curExp = makeString()

@ 피연산자가 있으면 일이 조금 더 재미있어진다. 함수 |doUnary|의 피연산자는 |curType|과 |curExp|에 나타난다.

@<함수들@>=
func doUnary(c quarterword) {
	var p, q pointer // 목록 조작용
	var x int32 // 임시 레지스터
	checkArith()
	if internal[tracingCommands] > two {
		@<현재 단항 연산을 추적한다@>
	}
	switch c {
	case plus:
		if curType < pairType {
			if curType != pictureType {
				badUnary(plus)
			}
		}
	case minus:
		@<현재 식의 부호를 바꾼다@>
	@<단항 연산자의 다른 경우들@>
	} // 다른 경우는 없다
	checkArith()
}

@ 함수 |nicePair|는 쌍의 두 성분이 모두 알려져 있으면 |true|를 돌려준다.

@<함수들@>=
func nicePair(p int32, t quarterword) bool {
	if t == pairType {
		p = value(p)
		if typ(xPartLoc(p)) == known && typ(yPartLoc(p)) == known {
			return true
		}
	}
	return false
}

@ @<함수들@>=
func printKnownOrUnknownType(t smallNumber, v int32) {
	printChar('(')
	if t < dependent {
		if t != pairType {
			printType(t)
		} else if nicePair(v, pairType) {
			printStr("pair")
		} else {
			printStr("unknown pair")
		}
	} else {
		printStr("unknown numeric")
	}
	printChar(')')
}

@ @<함수들@>=
func badUnary(c quarterword) {
	expErr("Not implemented: ")
	printOp(c)
@.Not implemented...@>
	printKnownOrUnknownType(curType, curExp)
	help3("I'm afraid I don't know how to apply that operation to that",
		"particular type. Continue, and I'll simply return the",
		"argument (shown above) as the result of the operation.")
	putGetError()
}

@ @<현재 단항 연산을...@>=
beginDiagnostic()
printNl("{")
printOp(c)
printChar('(')
printExp(null, 0) // 피연산자를 보이되 자세하지 않게
printStr(")}")
endDiagnostic(false)

@ 부호 바꾸기는 쉽다. 다만 현재 식의 형이 |independent|이거나, 성분 가운데 하나 이상이 |independent|인 쌍일 때는
그렇지 않다.

독립 변수의 음수는 독립 변수이므로 그것의 부호를 바꿀 때는 아무것도 할 필요가 없다고 우기고 싶어진다. 그 논리의
허점은, 현재 식을 바꾸지 않으면 현재 식을 가리키는 다른 종속 변수들이 그 계수의 부호를 바꾸어야 한다는 것이다.

그래서 우리는 현재 식을 베끼고 나서 재활용하여 이 문제를 비켜 간다(|stashIn| 루틴과 견주어 보라).

@<현재 식의 부호를...@>=
switch curType {
case pairType, independent:
	q = curExp
	makeExpCopy(q)
	if curType == dependent {
		negateDepList(depList(curExp))
	} else if curType == pairType {
		p = value(curExp)
		if typ(xPartLoc(p)) == known {
			setValue(xPartLoc(p), -value(xPartLoc(p)))
		} else {
			negateDepList(depList(xPartLoc(p)))
		}
		if typ(yPartLoc(p)) == known {
			setValue(yPartLoc(p), -value(yPartLoc(p)))
		} else {
			negateDepList(depList(yPartLoc(p)))
		}
	} // |curType=known|이면 |curExp=0|이다
	recycleValue(q)
	freeNode(q, valueNodeSize)
case dependent, protoDependent:
	negateDepList(depList(curExp))
case known:
	curExp = -curExp
case pictureType:
	negateEdges(curExp)
default:
	badUnary(minus)
}

@ @<함수들@>=
func negateDepList(p pointer) {
	for {
		setValue(p, -value(p))
		if info(p) == null {
			return
		}
		p = link(p)
	}
}

@ 연산 \KW{not}은 현재 값을 |trueCode+falseCode|에서 빼서 참과 거짓을 맞바꾼다.

@<단항 연산자의 다른 경우들@>=
case notOp:
	if curType != booleanType {
		badUnary(notOp)
	} else {
		curExp = trueCode + falseCode - curExp
	}

@ 불 값을 돌려주는 연산이 많으므로 \.{WEB} 매크로 \\{boolean\_reset}을 함수 |booleanReset|으로 옮겼다.

@<정의@>=
const @!threeSixtyUnits = 23592960 // 곧 |360*unity|

@ @<함수들@>=
func booleanReset(b bool) {
	if b {
		curExp = trueCode
	} else {
		curExp = falseCode
	}
}

@ 각도 |curExp|를 |threeSixtyUnits|로 나눈 나머지에 16을 곱하는 것은 \MF의 |scaled| 도(度)를 |nSinCos|가 바라는
|angle| 단위($2^{-20}$도)로 바꾸는 것이다. 나머지가 음수일 수 있지만 |nSinCos|는 음의 각도도 받는다.

@<단항 연산자의 다른 경우들@>=
case sqrtOp, mExpOp, mLogOp, sinDOp, cosDOp, floorOp, uniformDeviate, oddOp, charExistsOp:
	if curType != known {
		badUnary(c)
	} else {
		switch c {
		case sqrtOp:
			curExp = squareRt(curExp)
		case mExpOp:
			curExp = mExp(curExp)
		case mLogOp:
			curExp = mLog(curExp)
		case sinDOp, cosDOp:
			nSinCos((curExp % threeSixtyUnits) * 16)
			if c == sinDOp {
				curExp = roundFraction(nSin)
			} else {
				curExp = roundFraction(nCos)
			}
		case floorOp:
			curExp = floorScaled(curExp)
		case uniformDeviate:
			curExp = unifRand(curExp)
		case oddOp:
			booleanReset(odd(roundUnscaled(curExp)))
			curType = booleanType
		case charExistsOp:
			@<문자가 내보내졌는지 정한다@>
		} // 다른 경우는 없다
	}

@ 함수 |nArg|가 내는 |angle| 값을 16으로 나누어 반올림하면 |scaled| 도가 된다.

@<단항 연산자의 다른 경우들@>=
case angleOp:
	if nicePair(curExp, curType) {
		p = value(curExp)
		x = nArg(value(xPartLoc(p)), value(yPartLoc(p)))
		if x >= 0 {
			flushCurExp((x + 8) / 16)
		} else {
			flushCurExp(-((-x + 8) / 16))
		}
	} else {
		badUnary(angleOp)
	}

@ 현재 식이 쌍인데 문맥이 경로를 바라면 |pairToPath|를 부른다.

@<함수들@>=
func pairToPath() {
	curExp = newKnot()
	curType = pathType
}

@ @<단항 연산자의 다른 경우들@>=
case xPart, yPart:
	if curType <= pairType && curType >= transformType {
		takePart(c)
	} else {
		badUnary(c)
	}
case xxPart, xyPart, yxPart, yyPart:
	if curType == transformType {
		takePart(c)
	} else {
		badUnary(c)
	}

@ 다음 프로시저에서 |curExp|는 큰 노드를 가리키는 캡슐을 가리킨다. 우리는 큰 노드의 한 부분만 남기고 모두 지우고 싶다.
큰 노드를 잠깐 |tempVal|이라는 고정된 캡슐에 매달아 두고, 원하는 부분을 베낀 다음 |tempVal|을 재활용하는 것이 요령이다.
주소 |p+2*(c-xPart)|가 원하는 부분의 위치인 것은 연산 코드 |xPart .. yyPart|가 큰 노드 안의 필드 순서와 같은 차례로 놓였기
때문이다.

@<함수들@>=
func takePart(c quarterword) {
	var p pointer // 큰 노드
	p = value(curExp)
	setValue(tempVal, p)
	setType(tempVal, curType)
	setLink(p, tempVal)
	freeNode(curExp, valueNodeSize)
	makeExpCopy(p + 2*(c-xPart))
	recycleValue(tempVal)
}

@ @<표의 항목들을...@>=
setNameType(tempVal, capsule)

@ @<단항 연산자의 다른 경우들@>=
case charOp:
	if curType != known {
		badUnary(charOp)
	} else {
		curExp = roundUnscaled(curExp) % 256
		curType = stringType
		if curExp < 0 {
			curExp = curExp + 256
		}
		if length(curExp) != 1 {
			strRoom(1)
			appendChar(curExp)
			curExp = makeString()
		}
	}
case decimal:
	if curType != known {
		badUnary(decimal)
	} else {
		oldSetting = selector
		selector = newString
		printScaled(curExp)
		curExp = makeString()
		selector = oldSetting
		curType = stringType
	}
case octOp, hexOp, asciiOp:
	if curType != stringType {
		badUnary(c)
	} else {
		strToNum(c)
	}

@ @<함수들@>=
func strToNum(c quarterword) { // 문자열을 수로 바꾼다
	var n int32 // 누산기
	var m asciiCode // 현재 문자
	var k poolPointer // |strPool|의 첨자
	var b int32 // 변환의 기수; |8 .. 16|
	var badChar bool // 문자열에 틀린 숫자가 있었나?
	if c == asciiOp {
		if length(curExp) == 0 {
			n = -1
		} else {
			n = int32(strPool[strStart[curExp]])
		}
	} else {
		if c == octOp {
			b = 8
		} else {
			b = 16
		}
		n = 0
		badChar = false
		for k = strStart[curExp]; k <= strStart[curExp+1]-1; k++ {
			@<문자 |k|를 기수~|b|의 숫자 |m|으로 바꾼다; 숫자가 아니면 |badChar|를 켠다@>
			if n < 32768/b {
				n = n*b + m
			} else {
				n = 32767
			}
		}
		@<|badChar|이거나 |n>=4096|이면 오류 메시지를 낸다@>
	}
	flushCurExp(n * unity)
}

@ 숫자로 읽을 수 없는 문자는 0으로 친다. 팔진수에서는 \.8과 \.9도 틀린 숫자다.

@<문자 |k|를 기수~|b|의 숫자 |m|으로 바꾼다; 숫자가 아니면 |badChar|를 켠다@>=
m = asciiCode(strPool[k])
if m >= '0' && m <= '9' {
	m = m - '0'
} else if m >= 'A' && m <= 'F' {
	m = m - 'A' + 10
} else if m >= 'a' && m <= 'f' {
	m = m - 'a' + 10
} else {
	badChar = true
	m = 0
}
if m >= b {
	badChar = true
	m = 0
}

@ @<|badChar|이거나...@>=
if badChar {
	expErr("String contains illegal digits")
@.String contains illegal digits@>
	if c == octOp {
		help1("I zeroed out characters that weren't in the range 0..7.")
	} else {
		help1("I zeroed out characters that weren't hex digits.")
	}
	putGetError()
}
if n > 4095 {
	printErr("Number too large (")
	printInt(n)
	printChar(')')
@.Number too large@>
	help1("I have trouble with numbers greater than 4095; watch out.")
	putGetError()
}

@ 길이 연산은 여러 형의 피연산자에 적용된다는 점에서 조금 별나다.

@<단항 연산자의 다른 경우들@>=
case lengthOp:
	if curType == stringType {
		flushCurExp(length(curExp) * unity)
	} else if curType == pathType {
		flushCurExp(pathLength())
	} else if curType == known {
		curExp = abs(curExp)
	} else if nicePair(curExp, curType) {
		flushCurExp(pythAdd(value(xPartLoc(value(curExp))), value(yPartLoc(value(curExp)))))
	} else {
		badUnary(c)
	}

@ @<함수들@>=
func pathLength() scaled { // 현재 경로의 길이를 계산한다
	var n scaled // 지금까지의 경로 길이
	var p pointer // 훑는 포인터
	p = curExp
	if leftType(p) == endpoint {
		n = -unity
	} else {
		n = 0
	}
	for {
		p = link(p)
		n = n + unity
		if p == curExp {
			break
		}
	}
	return n
}

@ 회전수는 널 펜에 대해서만 계산한다. 다른 펜은 퇴화한 경우에 회전수에 영향을 줄 수 있다. 자동 반올림이 조금 다른
경로를 만들거나, 지나치게 큰 좌표가 잘릴 수 있기 때문이다.

루틴 |makeSpec|의 둘째 인자 |fractionOne-halfUnit-1-elGordo|는 음수여서 ``좌표가 크다는 경고를 하지 말라''는 뜻이다.
또 |makeSpec|은 부수 효과로 전역 변수 |turningNumber|를 계산하는데, 우리가 원하는 것은 바로 그것이다.

@<단항 연산자의 다른 경우들@>=
case turningOp:
	if curType == pairType {
		flushCurExp(0)
	} else if curType != pathType {
		badUnary(turningOp)
	} else if leftType(curExp) == endpoint {
		flushCurExp(0) // 순환 경로가 아니다
	} else {
		curPen = nullPen
		curPathType = contourCode
		curExp = makeSpec(curExp, fractionOne-halfUnit-1-elGordo, 0)
		flushCurExp(turningNumber * unity) // |scaled|로 바꾼다
	}

@ 형을 묻는 연산(이를테면 `\KW{pair} |x|')은 현재 식을 치우고 불 값으로 바꾼다. 원본은 이것을 \.{WEB} 매크로
\\{type\_range}와 \\{type\_test}로 썼는데, 여기서는 조건을 인자로 받는 함수 |typeTest| 하나로 줄였다.

@<함수들@>=
func typeTest(b bool) {
	if b {
		flushCurExp(trueCode)
	} else {
		flushCurExp(falseCode)
	}
	curType = booleanType
}

@ @<단항 연산자의 다른 경우들@>=
case booleanType:
	typeTest(curType >= booleanType && curType <= unknownBoolean)
case stringType:
	typeTest(curType >= stringType && curType <= unknownString)
case penType:
	typeTest(curType >= penType && curType <= futurePen)
case pathType:
	typeTest(curType >= pathType && curType <= unknownPath)
case pictureType:
	typeTest(curType >= pictureType && curType <= unknownPicture)
case transformType, pairType:
	typeTest(curType == c)
case numericType:
	typeTest(curType >= known && curType <= independent)
case knownOp, unknownOp:
	testKnown(c)

@ 원본의 |done| 레이블은 반복문의 |break|가 되었다. 큰 노드의 성분을 거꾸로 훑다가 알려지지 않은 것을 만나면 곧바로
|b|를 |falseCode|로 놓고 빠져나온다.

@<함수들@>=
func testKnown(c quarterword) {
	var b int32 // 현재 식이 알려져 있나?; |trueCode .. falseCode|
	var p, q pointer // 큰 노드 안의 위치
	b = falseCode
	switch curType {
	case vacuous, booleanType, stringType, penType, futurePen, pathType, pictureType, known:
		b = trueCode
	case transformType, pairType:
		p = value(curExp)
		q = p + bigNodeSize[curType]
		b = trueCode
		for {
			q = q - 2
			if typ(q) != known {
				b = falseCode
				break
			}
			if q == p {
				break
			}
		}
	default:
		// 아무것도 하지 않는다
	}
	if c == knownOp {
		flushCurExp(b)
	} else {
		flushCurExp(trueCode + falseCode - b)
	}
	curType = booleanType
}

@ @<단항 연산자의 다른 경우들@>=
case cycleOp:
	if curType != pathType {
		flushCurExp(falseCode)
	} else if leftType(curExp) != endpoint {
		flushCurExp(trueCode)
	} else {
		flushCurExp(falseCode)
	}
	curType = booleanType

@ @<단항 연산자의 다른 경우들@>=
case makePenOp:
	if curType == pairType {
		pairToPath()
	}
	if curType == pathType {
		curType = futurePen
	} else {
		badUnary(makePenOp)
	}
case makePathOp:
	if curType == futurePen {
		materializePen()
	}
	if curType != penType {
		badUnary(makePathOp)
	} else {
		flushCurExp(makePath(curExp))
		curType = pathType
	}
case totalWeightOp:
	if curType != pictureType {
		badUnary(totalWeightOp)
	} else {
		flushCurExp(totalWeight(curExp))
	}
case reverse:
	if curType == pathType {
		p = htapYpoc(curExp)
		if rightType(p) == endpoint {
			p = link(p)
		}
		tossKnotList(curExp)
		curExp = p
	} else if curType == pairType {
		pairToPath()
	} else {
		badUnary(reverse)
	}

@ 마지막으로 캡슐~|p|와 현재 식을 결합하는 연산들이 있다.

원본의 레이블 셋 가운데 비교 연산의 |done|은 |switch|를 빠져나가는 |break|가 되었고, 큰 노드 비교의 |done1|은 반복문의
|break|가 되었다. 연산이 |p|를 이미 처리했을 때 |recycleValue(p)|를 건너뛰는 |exit|만 레이블로 남았다. 끝의 산술
검사와 비켜 간 캡슐 재활용은 어느 경우에나 해야 하므로 그냥 |return|할 수는 없다.

@<함수들@>=
func doBinary(p pointer, c quarterword) {
	var q, r, rr pointer // 목록 조작용
	var oldP, oldExp pointer // 재활용할 캡슐
	var v int32 // 수치 조작용
	checkArith()
	if internal[tracingCommands] > two {
		@<현재 이항 연산을 추적한다@>
	}
	@<캡슐 |p|의 |independent| 경우를 비켜 간다@>
	@<현재 식의 |independent| 경우를 비켜 간다@>
	switch c {
	case plus, minus:
		@<|p|에 현재 식을 더하거나 |p|에서 현재 식을 뺀다@>
	@<이항 연산자의 다른 경우들@>
	} // 다른 경우는 없다
	recycleValue(p)
	freeNode(p, valueNodeSize) // 이것을 피하려면 |goto exit|한다
exit:
	checkArith()
	@<비켜 간 |independent| 캡슐을 재활용한다@>
}

@ @<함수들@>=
func badBinary(p pointer, c quarterword) {
	dispErr(p, "")
	expErr("Not implemented: ")
@.Not implemented...@>
	if c >= minOf {
		printOp(c)
	}
	printKnownOrUnknownType(typ(p), p)
	if c >= minOf {
		printStr("of")
	} else {
		printOp(c)
	}
	printKnownOrUnknownType(curType, curExp)
	help3("I'm afraid I don't know how to apply that operation to that",
		"combination of types. Continue, and I'll return the second",
		"argument (see above) as the result of the operation.")
	putGetError()
}

@ @<현재 이항 연산을...@>=
beginDiagnostic()
printNl("{(")
printExp(p, 0) // 피연산자를 보이되 자세하지 않게
printChar(')')
printOp(c)
printChar('(')
printExp(null, 0)
printStr(")}")
endDiagnostic(false)

@ 이항 연산 가운데 몇은 |independent| 값이 캡슐에 몰래 들어올 수 있다는 사실 때문에 복잡해질 수 있다. 단항 연산인 부호
바꾸기에서 이미 이 어려움의 한 예를 보았다. 처리할 경우의 수를 줄이려고, 먼저 (필요하면) 두 피연산자를 바꾸어
|independent| 성분을 없앤다. 원래 피연산자는 |oldP|와 |oldExp|라는 캡슐에 넣어 두었다가, 이항 연산을 무사히 마친 다음
재활용한다.

@<비켜 간 |independent| 캡슐을...@>=
if oldP != null {
	recycleValue(oldP)
	freeNode(oldP, valueNodeSize)
}
if oldExp != null {
	recycleValue(oldExp)
	freeNode(oldExp, valueNodeSize)
}

@ 큰 노드에 독립 성분이 적어도 하나 있으면 그것을 ``얼룩졌다''고 한다. 인자가 얼룩지지 않았을 때, 그리고 오직
그때에만 |null|을 돌려주는 간단한 함수 |tarnished|를 정의하겠다.

@<캡슐 |p|의 |independent| 경우를...@>=
switch typ(p) {
case transformType, pairType:
	oldP = tarnished(p)
case independent:
	oldP = void
default:
	oldP = null
}
if oldP != null {
	q = stashCurExp()
	oldP = p
	makeExpCopy(oldP)
	p = stashCurExp()
	unstashCurExp(q)
}

@ @<현재 식의 |independent| 경우를...@>=
switch curType {
case transformType, pairType:
	oldExp = tarnished(curExp)
case independent:
	oldExp = void
default:
	oldExp = null
}
if oldExp != null {
	oldExp = curExp
	makeExpCopy(oldExp)
}

@ @<함수들@>=
func tarnished(p pointer) pointer {
	var q pointer // 큰 노드의 처음
	var r pointer // 큰 노드 안의 현재 위치
	q = value(p)
	r = q + bigNodeSize[typ(p)]
	for {
		r = r - 2
		if typ(r) == independent {
			return void
		}
		if r == q {
			break
		}
	}
	return null
}

@ @<|p|에 현재 식을 더하거나...@>=
if curType < pairType || typ(p) < pairType {
	if curType == pictureType && typ(p) == pictureType {
		if c == minus {
			negateEdges(curExp)
		}
		curEdges = curExp
		mergeEdges(value(p))
	} else {
		badBinary(p, c)
	}
} else if curType == pairType {
	if typ(p) != pairType {
		badBinary(p, c)
	} else {
		q = value(p)
		r = value(curExp)
		addOrSubtract(xPartLoc(q), xPartLoc(r), c)
		addOrSubtract(yPartLoc(q), yPartLoc(r), c)
	}
} else if typ(p) == pairType {
	badBinary(p, c)
} else {
	addOrSubtract(p, null, c)
}

@ 프로시저 |addOrSubtract|의 첫 인자는 곧 재활용될 캡슐이나 쌍 노드 안에 있는 값 노드의 위치다. 둘째 인자는 |curExp|의 쌍
노드나 변환 노드 안의 위치이거나, |null|(곧 |curExp| 자체가 둘째 인자여야 한다는 뜻)이다. 셋째 인자는 |plus|이거나
|minus|다.

두 수치량의 합이나 차가 둘째 피연산자를 대신한다. 산술 넘침을 알아채지 못할 수도 있다. 사용자는 정말 큰 값을 가지고
장난치면 안 된다.
@^overflow in arithmetic@>

원본의 |done| 레이블은 두 종속 목록을 그냥 더할 수 있는 경우를 |if|의 한 갈래로 떼어 내어 없앴다.

@<함수들@>=
func addOrSubtract(p, q pointer, c quarterword) {
	var s, t smallNumber // 피연산자의 형
	var r pointer // 목록을 훑는 포인터
	var v int32 // 둘째 피연산자의 값
	@<둘째 피연산자의 형 |t|와 값 |v|를 얻는다@>
	if t == known {
		if c == minus {
			v = -v
		}
		if typ(p) == known {
			v = slowAdd(value(p), v)
			if q == null {
				curExp = v
			} else {
				setValue(q, v)
			}
			return
		}
		@<알려진 값을 |depList(p)|의 상수항에 더한다@>
	} else {
		if c == minus {
			negateDepList(v)
		}
		@<피연산자 |p|를 종속 목록 |v|에 더한다@>
	}
}

@ 둘째 피연산자가 종속 변수이면 그 값으로 종속 목록을 쓴다.

@<둘째 피연산자의 형 |t|와 값 |v|를 얻는다@>=
if q == null {
	t = curType
	if t < dependent {
		v = curExp
	} else {
		v = depList(curExp)
	}
} else {
	t = typ(q)
	if t < dependent {
		v = value(q)
	} else {
		v = depList(q)
	}
}

@ @<알려진 값을 |depList(p)|의...@>=
r = depList(p)
for info(r) != null {
	r = link(r)
}
setValue(r, slowAdd(value(r), v))
if q == null {
	q = getNode(valueNodeSize)
	curExp = q
	curType = typ(p)
	setNameType(q, capsule)
}
setDepList(q, depList(p))
setType(q, typ(p))
setPrevDep(q, prevDep(p))
setLink(prevDep(p), q)
setType(p, known) // 이렇게 해야 재활용기가 쓰레기 아닌 것을 거두지 않는다

@ 우리는 |protoDependent| 목록보다 |dependent| 목록을 더 좋아한다. 형이 |fraction|인 계수의 높은 정확도를 지킬 수 있으면
좋기 때문이다. 그러나 두 종류와 그 섞임까지 모두 다루어야 한다.

@<피연산자 |p|를 종속 목록...@>=
if typ(p) == known {
	@<알려진 |value(p)|를 |v|의 상수항에 더한다@>
} else {
	s = typ(p)
	r = depList(p)
	if t == dependent && s == dependent && maxCoef(r)+maxCoef(v) < coefBound {
		v = pPlusQ(v, r, dependent) // |fixNeeded|는 반드시 거짓이 된다
	} else {
		if t == dependent {
			t = protoDependent
			v = pOverV(v, unity, dependent, protoDependent)
		}
		if s == protoDependent {
			v = pPlusQ(v, r, protoDependent)
		} else {
			v = pPlusFq(v, unity, r, protoDependent, dependent)
		}
	}
	@<답 |v|를 내놓는다(이것은 |known|이 되었을 수도 있다)@>
}

@ @<알려진 |value(p)|를...@>=
for info(v) != null {
	v = link(v)
}
setValue(v, slowAdd(value(p), value(v)))

@ @<답 |v|를 내놓는다...@>=
if q != null {
	depFinish(v, q, t)
} else {
	curType = t
	depFinish(v, null, t)
}

@ 지금 형편은 이렇다. 형이~|t|인 종속 목록 |v|를 현재 식에 넣거나(|q=null|이면) 쌍 노드 안의 위치 |q|에 넣어야
한다(그렇지 않으면). 목적지(|curExp|나 |q|)에는 전에 목록 |v|와 마지막 포인터가 같은 종속 목록이 들어 있었다.

@<함수들@>=
func depFinish(v, q pointer, t smallNumber) {
	var p pointer // 목적지
	var vv scaled // |known|일 때의 값
	if q == null {
		p = curExp
	} else {
		p = q
	}
	setDepList(p, v)
	setType(p, t)
	if info(v) == null {
		vv = value(v)
		if q == null {
			flushCurExp(vv)
		} else {
			recycleValue(p)
			setType(q, known)
			setValue(q, vv)
		}
	} else if q == null {
		curType = t
	}
	if fixNeeded {
		fixDependencies()
	}
}

@ 이제 여섯 가지 기본 비교 관계로 넘어가자. 두 수치(또는 쌍, 변환)를 비교할 때는 그 차 $p-|curExp|$를 계산해서
0과 견준다. 이렇게 하면 일차 방정식 기구가 아는 모든 것을 비교에 쓸 수 있다. 이를테면 $x=y+1$이 알려져 있으면 $x$와
$y$의 값을 모르더라도 `\.{x>y}'는 참이다.

@<이항 연산자의 다른 경우들@>=
case lessThan, lessOrEqual, greaterThan, greaterOrEqual, equalTo, unequalTo:
	if curType > pairType && typ(p) > pairType {
		addOrSubtract(p, null, minus) // |curExp:=(p)-curExp|
	} else if curType != typ(p) {
		badBinary(p, c)
		break
	} else if curType == stringType {
		flushCurExp(strVsStr(value(p), curExp))
	} else if curType == unknownString || curType == unknownBoolean {
		@<알려지지 않은 것들이 같다고 놓였는지 검사한다@>
	} else if curType == pairType || curType == transformType {
		@<큰 노드의 비교를 스칼라의 비교로 줄인다@>
	} else if curType == booleanType {
		flushCurExp(curExp - value(p))
	} else {
		badBinary(p, c)
		break
	}
	@<현재 식을 0과 비교한다@>

@ @<현재 식을 0과...@>=
if curType != known {
	if curType < known {
		dispErr(p, "")
		help1("The quantities shown above have not been equated.")
	} else {
		help2("Oh dear. I can't decide if the expression above is positive,",
			"negative, or zero. So this comparison test won't be `true'.")
	}
	expErr("Unknown relation will be considered false")
@.Unknown relation...@>
	putGetFlushError(falseCode)
} else {
	switch c {
	case lessThan:
		booleanReset(curExp < 0)
	case lessOrEqual:
		booleanReset(curExp <= 0)
	case greaterThan:
		booleanReset(curExp > 0)
	case greaterOrEqual:
		booleanReset(curExp >= 0)
	case equalTo:
		booleanReset(curExp == 0)
	case unequalTo:
		booleanReset(curExp != 0)
	} // 다른 경우는 없다
}
curType = booleanType

@ 알려지지 않은 두 문자열이 같은 고리에 있으면 그것들이 같다는 것을 안다. 그렇지 않으면 같은지 다른지 모르므로 아무것도
바꾸지 않는다.

@<알려지지 않은 것들이...@>=
q = value(curExp)
for q != curExp && q != p {
	q = value(q)
}
if q == p {
	flushCurExp(0)
}

@ 큰 노드의 비교는 성분들을 차례로 빼면서, 0이 아니거나 알려지지 않은 첫 차이에서 멈추어 그 성분을 결과로 삼는다.
그래서 쌍의 비교는 사전 순서가 된다. 원본의 |done1| 레이블은 반복문의 |break|가 되었다.

@<큰 노드의 비교를...@>=
q = value(p)
r = value(curExp)
rr = r + bigNodeSize[curType] - 2
for {
	addOrSubtract(q, r, minus)
	if typ(r) != known || value(r) != 0 || r == rr {
		break
	}
	q = q + 2
	r = r + 2
}
takePart(xPart + half(r-value(curExp)))

@ 여기서 |andOp-falseCode=orOp-trueCode|라는 교묘한 사실을 쓴다. \KW{and}에서는 |p|가 거짓이면 결과가 |p|이고,
\KW{or}에서는 |p|가 참이면 결과가 |p|다. 그렇지 않으면 결과는 현재 식 그대로다.

@<이항 연산자의 다른 경우들@>=
case andOp, orOp:
	if typ(p) != booleanType || curType != booleanType {
		badBinary(p, c)
	} else if value(p) == c+falseCode-andOp {
		curExp = value(p)
	}

@ @<이항 연산자의 다른 경우들@>=
case times:
	if curType < pairType || typ(p) < pairType {
		badBinary(p, times)
	} else if curType == known || typ(p) == known {
		@<적어도 한 피연산자가 알려져 있을 때 곱한다@>
	} else if (nicePair(p, typ(p)) && curType > pairType) ||
		(nicePair(curExp, curType) && typ(p) > pairType) {
		hardTimes(p)
		goto exit
	} else {
		badBinary(p, times)
	}

@ @<적어도 한 피연산자가...@>=
if typ(p) == known {
	v = value(p)
	freeNode(p, valueNodeSize)
} else {
	v = curExp
	unstashCurExp(p)
}
if curType == known {
	curExp = takeScaled(curExp, v)
} else if curType == pairType {
	p = value(curExp)
	depMult(xPartLoc(p), v, true)
	depMult(yPartLoc(p), v, true)
} else {
	depMult(null, v, true)
}
goto exit

@ @<함수들@>=
func depMult(p pointer, v int32, vIsScaled bool) {
	var q pointer // |v|를 곱할 종속 목록
	var s, t smallNumber // 그 형, 곱하기 전과 후
	if p == null {
		q = curExp
	} else if typ(p) != known {
		q = p
	} else {
		if vIsScaled {
			setValue(p, takeScaled(value(p), v))
		} else {
			setValue(p, takeFraction(value(p), v))
		}
		return
	}
	t = typ(q)
	q = depList(q)
	s = t
	if t == dependent && vIsScaled {
		if abVsCd(maxCoef(q), abs(v), coefBound-1, unity) >= 0 {
			t = protoDependent
		}
	}
	q = pTimesV(q, v, s, t, vIsScaled)
	depFinish(q, p, t)
}

@ 다음 루틴은 |times|와 비슷하지만, |v|가 크기 1 이하인 |fraction|이고 |curType>=pairType|일 때 내부에서만 불린다.
`\.{1/3x}' 같은 일차식에서 |scanPrimary|가 부르는 것이 바로 이것이다.

@<함수들@>=
func fracMult(n, d scaled) { // |curExp|에 |n/d|를 곱한다
	var p pointer // 쌍 노드
	var oldExp pointer // 재활용할 캡슐
	var v fraction // |n/d|
	if internal[tracingCommands] > two {
		@<분수 곱셈을 추적한다@>
	}
	switch curType {
	case transformType, pairType:
		oldExp = tarnished(curExp)
	case independent:
		oldExp = void
	default:
		oldExp = null
	}
	if oldExp != null {
		oldExp = curExp
		makeExpCopy(oldExp)
	}
	v = makeFraction(n, d)
	if curType == known {
		curExp = takeFraction(curExp, v)
	} else if curType == pairType {
		p = value(curExp)
		depMult(xPartLoc(p), v, false)
		depMult(yPartLoc(p), v, false)
	} else {
		depMult(null, v, false)
	}
	if oldExp != null {
		recycleValue(oldExp)
		freeNode(oldExp, valueNodeSize)
	}
}

@ @<분수 곱셈을...@>=
beginDiagnostic()
printNl("{(")
printScaled(n)
printChar('/')
printScaled(d)
printStr(")*(")
printExp(null, 0)
printStr(")}")
endDiagnostic(false)

@ 루틴 |hardTimes|는 성분이 모두 알려진 쌍에 종속 목록을 곱한다.

@<함수들@>=
func hardTimes(p pointer) {
	var q pointer // 종속 변수 |p|의 사본
	var r pointer // 성분을 아는 쌍의 큰 노드
	var u, v scaled // 그 쌍의 알려진 값
	if typ(p) == pairType {
		q = stashCurExp()
		unstashCurExp(p)
		p = q
	} // 이제 |curType=pairType|이다
	r = value(curExp)
	u = value(xPartLoc(r))
	v = value(yPartLoc(r))
	@<종속 변수 |p|를 쌍 노드 |r|의 두 부분에 옮긴다@>
	depMult(xPartLoc(r), u, true)
	depMult(yPartLoc(r), v, true)
}

@ @<종속 변수 |p|를 쌍 노드...@>=
setType(yPartLoc(r), typ(p))
newDep(yPartLoc(r), copyDepList(depList(p)))
setType(xPartLoc(r), typ(p))
mem[valueLoc(xPartLoc(r))] = mem[valueLoc(p)]
setLink(prevDep(p), xPartLoc(r))
freeNode(p, valueNodeSize)

@ @<이항 연산자의 다른 경우들@>=
case over:
	if curType != known || typ(p) < pairType {
		badBinary(p, over)
	} else {
		v = curExp
		unstashCurExp(p)
		if v == 0 {
			@<0으로 나누려 한다고 꽥 소리친다@>
		} else {
			if curType == known {
				curExp = makeScaled(curExp, v)
			} else if curType == pairType {
				p = value(curExp)
				depDiv(xPartLoc(p), v)
				depDiv(yPartLoc(p), v)
			} else {
				depDiv(null, v)
			}
		}
		goto exit
	}

@ @<함수들@>=
func depDiv(p pointer, v scaled) {
	var q pointer // |v|로 나눌 종속 목록
	var s, t smallNumber // 그 형, 나누기 전과 후
	if p == null {
		q = curExp
	} else if typ(p) != known {
		q = p
	} else {
		setValue(p, makeScaled(value(p), v))
		return
	}
	t = typ(q)
	q = depList(q)
	s = t
	if t == dependent {
		if abVsCd(maxCoef(q), unity, coefBound-1, abs(v)) >= 0 {
			t = protoDependent
		}
	}
	q = pOverV(q, v, s, t)
	depFinish(q, p, t)
}

@ @<0으로 나누려 한다고...@>=
expErr("Division by zero")
@.Division by zero@>
help2("You're trying to divide the quantity shown above the error",
	"message by zero. I'm going to divide it by one instead.")
putGetError()

@ @<이항 연산자의 다른 경우들@>=
case pythagAdd, pythagSub:
	if curType == known && typ(p) == known {
		if c == pythagAdd {
			curExp = pythAdd(value(p), curExp)
		} else {
			curExp = pythSub(value(p), curExp)
		}
	} else {
		badBinary(p, c)
	}

@ 다음 몇 절은 좌표 자료의 아핀 변환을 다룬다.

@<이항 연산자의 다른 경우들@>=
case rotatedBy, slantedBy, scaledBy, shiftedBy, transformedBy, xScaled, yScaled, zScaled:
	if typ(p) == pathType || typ(p) == futurePen || typ(p) == penType {
		pathTrans(p, c)
		goto exit
	} else if typ(p) == pairType || typ(p) == transformType {
		bigTrans(p, c)
	} else if typ(p) == pictureType {
		edgesTrans(p, c)
		goto exit
	} else {
		badBinary(p, c)
	}

@ 연산 코드 |c|가 여덟 변환 연산자 가운데 하나라고 하자. 프로시저 호출 |setUpTrans(c)|는 먼저 |curExp|를 |c|와 |curExp|의 원래
값에 해당하는 변환으로 바꾼다. (특히 |c=transformedBy|이면 |curExp|는 전혀 바뀌지 않는다.)

그다음 결과 변환의 모든 성분이 |known|이면 그것들을 전역 변수 |txx|, |txy|, |tyx|, |tyy|, |tx|, |ty|로 옮기고
|curExp|를 알려진 값 0으로 바꾼다.

변환 $(x,y)\mapsto(t_{xx}x+t_{xy}y+t_x,\;t_{yx}x+t_{yy}y+t_y)$의 여섯 계수가 각 연산에서 어떻게 정해지는지는 다음과
같다. 여기서 $s$는 스칼라 인자이고 $(a,b)$는 쌍 인자다.
$$\vbox{\halign{#\hfil\quad&$#$\hfil\cr
\KW{rotated} $s$&t_{xx}=t_{yy}=\cos s,\ t_{yx}=-t_{xy}=\sin s\cr
\KW{slanted} $s$&t_{xy}=s\cr
\KW{scaled} $s$&t_{xx}=t_{yy}=s\cr
\KW{shifted} $(a,b)$&t_x=a,\ t_y=b\cr
\KW{xscaled} $s$&t_{xx}=s\cr
\KW{yscaled} $s$&t_{yy}=s\cr
\KW{zscaled} $(a,b)$&t_{xx}=t_{yy}=a,\ t_{yx}=-t_{xy}=b\cr}}$$
나머지 계수는 항등 변환의 값, 곧 $t_{xx}=t_{yy}=1$, 나머지는 0이다.

@<함수들@>=
func setUpTrans(c quarterword) {
	var p, q, r pointer // 목록 조작 레지스터
	if c != transformedBy || curType != transformType {
		@<현재 변환을 |curExp|에 넣는다@>
	}
	@<현재 변환이 온통 알려져 있으면 전역 변수에 넣어 두고, 그렇지 않으면 |return|@>
}

@ @<전역 변수@>=
var @!txx, @!txy, @!tyx, @!tyy, @!tx, @!ty scaled // 현재 변환 계수

@ @<현재 변환을...@>=
p = stashCurExp()
curExp = idTransform()
curType = transformType
q = value(curExp)
switch c {
@<여덟 경우마다 |curExp|의 필드를 바꾸고 |goto done|; |p|의 형이 맞지 않으면 그냥 둔다@>
} // 다른 경우는 없다
dispErr(p, "Improper transformation argument")
@.Improper transformation argument@>
help3("The expression shown above has the wrong type,",
	"so I can't transform anything using it.",
	"Proceed, and I'll omit the transformation.")
putGetError()
done:
recycleValue(p)
freeNode(p, valueNodeSize)

@ @<현재 변환이 온통...@>=
q = value(curExp)
r = q + transformNodeSize
for {
	r = r - 2
	if typ(r) != known {
		return
	}
	if r == q {
		break
	}
}
txx = value(xxPartLoc(q))
txy = value(xyPartLoc(q))
tyx = value(yxPartLoc(q))
tyy = value(yyPartLoc(q))
tx = value(xPartLoc(q))
ty = value(yPartLoc(q))
flushCurExp(0)

@ @<여덟 경우마다...@>=
case rotatedBy:
	if typ(p) == known {
		@<사인과 코사인을 넣고 |goto done|@>
	}
case slantedBy:
	if typ(p) > pairType {
		install(xyPartLoc(q), p)
		goto done
	}
case scaledBy:
	if typ(p) > pairType {
		install(xxPartLoc(q), p)
		install(yyPartLoc(q), p)
		goto done
	}
case shiftedBy:
	if typ(p) == pairType {
		r = value(p)
		install(xPartLoc(q), xPartLoc(r))
		install(yPartLoc(q), yPartLoc(r))
		goto done
	}
case xScaled:
	if typ(p) > pairType {
		install(xxPartLoc(q), p)
		goto done
	}
case yScaled:
	if typ(p) > pairType {
		install(yyPartLoc(q), p)
		goto done
	}
case zScaled:
	if typ(p) == pairType {
		@<복소수 곱수를 넣고 |goto done|@>
	}
case transformedBy:
	// 아무것도 하지 않는다

@ @<사인과 코사인을...@>=
nSinCos((value(p) % threeSixtyUnits) * 16)
setValue(xxPartLoc(q), roundFraction(nCos))
setValue(yxPartLoc(q), roundFraction(nSin))
setValue(xyPartLoc(q), -value(yxPartLoc(q)))
setValue(yyPartLoc(q), value(xxPartLoc(q)))
goto done

@ 연산 \KW{zscaled}는 평면을 복소수 평면으로 보고 $(a+bi)$를 곱하는 것이다. 실제로 $(x+yi)(a+bi)=(ax-by)+(bx+ay)i$이므로
$t_{xx}=t_{yy}=a$, $t_{yx}=b$, $t_{xy}=-b$다.

@<복소수 곱수를...@>=
r = value(p)
install(xxPartLoc(q), xPartLoc(r))
install(yyPartLoc(q), xPartLoc(r))
install(yxPartLoc(q), yPartLoc(r))
if typ(yPartLoc(r)) == known {
	setValue(yPartLoc(r), -value(yPartLoc(r)))
} else {
	negateDepList(depList(yPartLoc(r)))
}
install(xyPartLoc(q), yPartLoc(r))
goto done

@ 프로시저 |setUpKnownTrans|는 |setUpTrans|와 비슷하지만 변환이 온통 알려져 있을 것을 고집한다.

@<함수들@>=
func setUpKnownTrans(c quarterword) {
	setUpTrans(c)
	if curType != known {
		expErr("Transform components aren't all known")
@.Transform components...@>
		help3("I'm unable to apply a partially specified transformation",
			"except to a fully known pair or transform.",
			"Proceed, and I'll omit the transformation.")
		putGetFlushError(0)
		txx = unity
		txy = 0
		tyx = 0
		tyy = unity
		tx = 0
		ty = 0
	}
}

@ 다음은 위치 |p|와~|q|에 있는 좌표 쌍에 변환 |txx .. ty|를 적용하는 프로시저다.

@<함수들@>=
func trans(p, q pointer) {
	var v scaled // 새 |x| 값
	v = takeScaled(mem[p].sc, txx) + takeScaled(mem[q].sc, txy) + tx
	mem[q].sc = takeScaled(mem[p].sc, tyx) + takeScaled(mem[q].sc, tyy) + ty
	mem[p].sc = v
}

@ 가장 간단한 변환 프로시저는 경로의 모든 좌표에 변환을 적용한다. 널 펜 |nullPen|은 옮겨지지 않는 한 바뀌지 않은 채로
남는다.

@<함수들@>=
func pathTrans(p pointer, c quarterword) {
	var q pointer // 목록을 훑는 포인터
	setUpKnownTrans(c)
	unstashCurExp(p)
	if curType == penType {
		if maxOffset(curExp) == 0 && tx == 0 && ty == 0 {
			return
		}
		flushCurExp(makePath(curExp))
		curType = futurePen
	}
	q = curExp
	for {
		if leftType(q) != endpoint {
			trans(q+3, q+4) // |leftX|와 |leftY|다
		}
		trans(q+1, q+2) // |xCoord|와 |yCoord|다
		if rightType(q) != endpoint {
			trans(q+5, q+6) // |rightX|와 |rightY|다
		}
		q = link(q)
		if q == curExp {
			break
		}
	}
}

@ 그다음으로 간단한 변환 프로시저는 가장자리에 적용한다. 간단한 까닭은 주로 \MF가 아주 일반적인 변환은 허락하지 않기
때문이고, 가장자리 변환을 위한 까다로운 서브루틴들을 이미 써 두었기 때문이다. 허락되는 것은 정수 배율과 정수 이동,
그리고 $x$와 $y$를 맞바꾸는 것(|txx=tyy=0|)뿐이다.

@<함수들@>=
func edgesTrans(p pointer, c quarterword) {
	setUpKnownTrans(c)
	unstashCurExp(p)
	curEdges = curExp
	if emptyEdges(curEdges) {
		return // 빈 집합은 변환하기 쉽다
	}
	if txx == 0 && tyy == 0 && txy%unity == 0 && tyx%unity == 0 {
		xySwapEdges()
		txx = txy
		tyy = tyx
		txy = 0
		tyx = 0
		if emptyEdges(curEdges) {
			return
		}
	}
	if txy == 0 && tyx == 0 && txx%unity == 0 && tyy%unity == 0 {
		@<가장자리의 눈금을 바꾸고 옮긴 다음 |return|@>
	}
	printErr("That transformation is too hard")
@.That transformation...@>
	help3("I can apply complicated transformations to paths,",
		"but I can only do integer operations on pictures.",
		"Proceed, and I'll omit the transformation.")
	putGetError()
}

@ @<가장자리의 눈금을...@>=
if txx == 0 || tyy == 0 {
	tossEdges(curEdges)
	curExp = getNode(edgeHeaderSize)
	initEdges(curExp)
} else {
	if txx < 0 {
		xReflectEdges()
		txx = -txx
	}
	if tyy < 0 {
		yReflectEdges()
		tyy = -tyy
	}
	if txx != unity {
		xScaleEdges(txx / unity)
	}
	if tyy != unity {
		yScaleEdges(tyy / unity)
	}
	@<가장자리를 |(tx,ty)|만큼 반올림해 옮긴다@>
}
return

@ 행 번호 범위가 열 번호 범위보다 하나 좁은 것(|nMax|는 8191보다 작아야 한다)은 가장자리 구조의 관례 때문이다.

@<가장자리를 |(tx,ty)|만큼...@>=
tx = roundUnscaled(tx)
ty = roundUnscaled(ty)
if mMin(curEdges)+tx <= 0 || mMax(curEdges)+tx >= 8192 ||
	nMin(curEdges)+ty <= 0 || nMax(curEdges)+ty >= 8191 ||
	abs(tx) >= 4096 || abs(ty) >= 4096 {
	printErr("Too far to shift")
@.Too far to shift@>
	help3("I can't shift the picture as requested---it would",
		"make some coordinates too large or too small.",
		"Proceed, and I'll omit the transformation.")
	putGetError()
} else {
	if tx != 0 {
		if !validRange(mOffset(curEdges) - tx) {
			fixOffset()
		}
		setMMin(curEdges, mMin(curEdges)+tx)
		setMMax(curEdges, mMax(curEdges)+tx)
		setMOffset(curEdges, mOffset(curEdges)-tx)
		setLastWindowTime(curEdges, 0)
	}
	if ty != 0 {
		setNMin(curEdges, nMin(curEdges)+ty)
		setNMax(curEdges, nMax(curEdges)+ty)
		setNPos(curEdges, nPos(curEdges)+ty)
		setLastWindowTime(curEdges, 0)
	}
}

@ 큰 노드가 얽히고 그 성분 가운데 몇이 알려지지 않았을 때 변환의 어려운 경우가 생긴다.

@<함수들@>=
func bigTrans(p pointer, c quarterword) {
	var q, r, pp, qq pointer // 목록 조작 레지스터
	var s smallNumber // 큰 노드의 크기
	s = bigNodeSize[typ(p)]
	q = value(p)
	r = q + s
	for {
		r = r - 2
		if typ(r) != known {
			@<알려지지 않은 큰 노드를 변환하고 |return|@>
		}
		if r == q {
			break
		}
	}
	@<알려진 큰 노드를 변환한다@>
} // 이제 |doBinary|가 노드 |p|를 재활용할 것이다

@ @<알려지지 않은 큰 노드를...@>=
setUpKnownTrans(c)
makeExpCopy(p)
r = value(curExp)
if curType == transformType {
	bilin1(yyPartLoc(r), tyy, xyPartLoc(q), tyx, 0)
	bilin1(yxPartLoc(r), tyy, xxPartLoc(q), tyx, 0)
	bilin1(xyPartLoc(r), txx, yyPartLoc(q), txy, 0)
	bilin1(xxPartLoc(r), txx, yxPartLoc(q), txy, 0)
}
bilin1(yPartLoc(r), tyy, xPartLoc(q), tyx, ty)
bilin1(xPartLoc(r), txx, yPartLoc(q), txy, tx)
return

@ 포인터 |p|가 |curExp|의 큰 노드 안에 있는 두 낱말짜리 값 필드를 가리키고 |q|가 또 하나의 값 필드를 가리킨다고 하자.
프로시저 |bilin1|은 |p|를 $p\cdot t+q\cdot u+\delta$로 바꾼다.

@<함수들@>=
func bilin1(p pointer, t scaled, q pointer, u, delta scaled) {
	var r pointer // 목록을 훑는 포인터
	if t != unity {
		depMult(p, t, true)
	}
	if u != 0 {
		if typ(q) == known {
			delta = delta + takeScaled(value(q), u)
		} else {
			@<|typ(p)=protoDependent|임을 보장한다@>
			setDepList(p, pPlusFq(depList(p), u, depList(q), protoDependent, typ(q)))
		}
	}
	if typ(p) == known {
		setValue(p, value(p)+delta)
	} else {
		r = depList(p)
		for info(r) != null {
			r = link(r)
		}
		delta = value(r) + delta
		if r != depList(p) {
			setValue(r, delta)
		} else {
			recycleValue(p)
			setType(p, known)
			setValue(p, delta)
		}
	}
	if fixNeeded {
		fixDependencies()
	}
}

@ @<|typ(p)=protoDependent|임을...@>=
if typ(p) != protoDependent {
	if typ(p) == known {
		newDep(p, constDependency(value(p)))
	} else {
		setDepList(p, pTimesV(depList(p), unity, dependent, protoDependent, true))
	}
	setType(p, protoDependent)
}

@ @<알려진 큰 노드를...@>=
setUpTrans(c)
if curType == known {
	@<알려진 것을 알려진 것으로 변환한다@>
} else {
	pp = stashCurExp()
	qq = value(pp)
	makeExpCopy(p)
	r = value(curExp)
	if curType == transformType {
		bilin2(yyPartLoc(r), yyPartLoc(qq), value(xyPartLoc(q)), yxPartLoc(qq), null)
		bilin2(yxPartLoc(r), yyPartLoc(qq), value(xxPartLoc(q)), yxPartLoc(qq), null)
		bilin2(xyPartLoc(r), xxPartLoc(qq), value(yyPartLoc(q)), xyPartLoc(qq), null)
		bilin2(xxPartLoc(r), xxPartLoc(qq), value(yxPartLoc(q)), xyPartLoc(qq), null)
	}
	bilin2(yPartLoc(r), yyPartLoc(qq), value(xPartLoc(q)), yxPartLoc(qq), yPartLoc(qq))
	bilin2(xPartLoc(r), xxPartLoc(qq), value(yPartLoc(q)), xyPartLoc(qq), xPartLoc(qq))
	recycleValue(pp)
	freeNode(pp, valueNodeSize)
}

@ 값 |p|가 종속 목록이 |depFinal|에서 끝나는 |protoDependent| 값이라고 하자. 다음 프로시저는 또 다른 수치량의 |v|배를
|p|에 더한다.

@<함수들@>=
func addMultDep(p pointer, v scaled, r pointer) {
	if typ(r) == known {
		setValue(depFinal, value(depFinal)+takeScaled(value(r), v))
	} else {
		setDepList(p, pPlusFq(depList(p), v, depList(r), protoDependent, typ(r)))
		if fixNeeded {
			fixDependencies()
		}
	}
}

@ 프로시저 |bilin2|는 |bilin1|과 비슷하지만 알려진 양과 알려지지 않은 양의 역할이 뒤바뀌었다. 매개변수 |p|는 |curExp|의
큰 노드 안의 값 필드를 가리키고, |typ(p)=known|이다. 매개변수 |t|와~|u|는 다른 곳의 값 필드를 가리킨다. 매개변수~|q|도
그렇지만 |null|(0을 뜻한다)일 수도 있다. 위치~|p|는 $p\cdot t+v\cdot u+q$로 바뀐다.

@<함수들@>=
func bilin2(p, t pointer, v scaled, u, q pointer) {
	var vv scaled // |value(p)|를 잠시 담아 둔다
	vv = value(p)
	setType(p, protoDependent)
	newDep(p, constDependency(0)) // 이것이 |depFinal|을 놓는다
	if vv != 0 {
		addMultDep(p, vv, t) // |depFinal|은 바뀌지 않는다
	}
	if v != 0 {
		addMultDep(p, v, u)
	}
	if q != null {
		addMultDep(p, unity, q)
	}
	if depList(p) == depFinal {
		vv = value(depFinal)
		recycleValue(p)
		setType(p, known)
		setValue(p, vv)
	}
}

@ @<알려진 것을 알려진 것으로...@>=
makeExpCopy(p)
r = value(curExp)
if curType == transformType {
	bilin3(yyPartLoc(r), tyy, value(xyPartLoc(q)), tyx, 0)
	bilin3(yxPartLoc(r), tyy, value(xxPartLoc(q)), tyx, 0)
	bilin3(xyPartLoc(r), txx, value(yyPartLoc(q)), txy, 0)
	bilin3(xxPartLoc(r), txx, value(yxPartLoc(q)), txy, 0)
}
bilin3(yPartLoc(r), tyy, value(xPartLoc(q)), tyx, ty)
bilin3(xPartLoc(r), txx, value(yPartLoc(q)), txy, tx)

@ 끝으로 |bilin3|에서는 모든 것이 |known|이다.

@<함수들@>=
func bilin3(p pointer, t, v, u, delta scaled) {
	if t != unity {
		delta = delta + takeScaled(value(p), t)
	} else {
		delta = delta + value(p)
	}
	if u != 0 {
		setValue(p, delta+takeScaled(v, u))
	} else {
		setValue(p, delta)
	}
}

@ @<이항 연산자의 다른 경우들@>=
case concatenate:
	if curType == stringType && typ(p) == stringType {
		cat(p)
	} else {
		badBinary(p, concatenate)
	}
case substringOf:
	if nicePair(p, typ(p)) && curType == stringType {
		chopString(value(p))
	} else {
		badBinary(p, substringOf)
	}
case subpathOf:
	if curType == pairType {
		pairToPath()
	}
	if nicePair(p, typ(p)) && curType == pathType {
		chopPath(value(p))
	} else {
		badBinary(p, subpathOf)
	}

@ @<함수들@>=
func cat(p pointer) {
	var a, b strNumber // 이어 붙일 문자열
	var k poolPointer // |strPool|의 첨자
	a = value(p)
	b = curExp
	strRoom(length(a) + length(b))
	for k = strStart[a]; k <= strStart[a+1]-1; k++ {
		appendChar(asciiCode(strPool[k]))
	}
	for k = strStart[b]; k <= strStart[b+1]-1; k++ {
		appendChar(asciiCode(strPool[k]))
	}
	curExp = makeString()
	deleteStrRef(b)
}

@ 연산 \KW{substring} $(a,b)$ \KW{of} $s$는 $s$의 문자 사이 위치 $a$에서 $b$까지를 잘라 낸다. 위치 $k$는 $k$번째 문자의
왼쪽 경계이므로 `\.{substring (0,1) of "abc"}'는 \.{"a"}다. 그리고 $a>b$이면 거꾸로 읽은 문자열이 나온다.

@<함수들@>=
func chopString(p pointer) {
	var a, b int32 // 시작점과 끝점
	var l int32 // 원래 문자열의 길이
	var k int32 // |a|에서 |b|까지 움직인다
	var s strNumber // 원래 문자열
	var reversed bool // |a>b|였나?
	a = roundUnscaled(value(xPartLoc(p)))
	b = roundUnscaled(value(yPartLoc(p)))
	if a <= b {
		reversed = false
	} else {
		reversed = true
		k = a
		a = b
		b = k
	}
	s = curExp
	l = length(s)
	@<|a|와 |b|를 문자열 안의 위치로 잘라 낸다@>
	strRoom(b - a)
	if reversed {
		for k = strStart[s] + b - 1; k >= strStart[s]+a; k-- {
			appendChar(asciiCode(strPool[k]))
		}
	} else {
		for k = strStart[s] + a; k <= strStart[s]+b-1; k++ {
			appendChar(asciiCode(strPool[k]))
		}
	}
	curExp = makeString()
	deleteStrRef(s)
}

@ 위치는 0에서 문자열의 길이~|l| 사이로 잘라 낸다.

@<|a|와 |b|를 문자열 안의 위치로 잘라 낸다@>=
if a < 0 {
	a = 0
	if b < 0 {
		b = 0
	}
}
if b > l {
	b = l
	if a > l {
		a = l
	}
}

@ 연산 \KW{subpath} $(a,b)$ \KW{of} $p$도 같은 생각을 경로에 적용한다. 다만 경로의 ``위치''는 정수가 아니어도 되므로,
끝점이 매듭 사이에 떨어지면 그 삼차 곡선을 |splitCubic|으로 쪼개어 새 매듭을 만들어야 한다.

아래 그림에서 회색 경로는 길이가 3이고, 굵은 선이 $a=0.4$, $b=2.3$일 때의 부분 경로다. 프로시저는 먼저 $q$를 $\lfloor
a\rfloor$번 앞으로 옮기고 $a$와 $b$에서 그만큼 뺀다. 그다음 $q$에서 시작해 매듭 $\lceil b\rceil+1$개를 베껴 |pp|에서
|qq|까지의 경로를 만들고, 첫 조각을 $a$에서, 마지막 조각을 $b$의 소수 부분에서 쪼갠다. 첫 조각과 마지막 조각이 같은
조각이면 첫 쪼개기 다음에 $b$의 눈금을 다시 맞추어야 하는데, 첫 쪼개기로 조각의 매개변수가 늘어났기 때문이다. 이것이
|rr=ss|인 경우의 |makeScaled(b,unity-a)|다.

$$\mplibcode
beginfig(23);
save u, P, a, b; numeric u, a, b; path P; u := 30pt;
P := (0,0) .. (2u,1.2u) .. (4.4u,.4u) .. (6.6u,1.6u);
a := .4; b := 2.3;
draw P withcolor .6white;
draw subpath (a,b) of P withpen pencircle scaled 1.6pt;
for k = 0 upto 3: dot(point k of P); endfor
label.bot(btex $z_0$ etex, point 0 of P);
label.top(btex $z_1$ etex, point 1 of P);
label.bot(btex $z_2$ etex, point 2 of P);
label.top(btex $z_3$ etex, point 3 of P);
odot(point a of P); odot(point b of P);
label.ulft(btex $t=a$ etex, point a of P);
label.lrt(btex $t=b$ etex, point b of P);
endfig;
\endmplibcode$$

@<함수들@>=
func chopPath(p pointer) {
	var q pointer // 원래 경로의 매듭
	var pp, qq, rr, ss pointer // 경로 노드 사본의 연결 변수
	var a, b, k, l scaled // 자르기 첨자
	var reversed bool // |a>b|였나?
	l = pathLength()
	a = value(xPartLoc(p))
	b = value(yPartLoc(p))
	if a <= b {
		reversed = false
	} else {
		reversed = true
		k = a
		a = b
		b = k
	}
	@<|a<0|이거나 |b>l|인 경우를 처리한다@>
	q = curExp
	for a >= unity {
		q = link(q)
		a = a - unity
		b = b - unity
	}
	if b == a {
		@<|pp|에서 |qq|까지 길이 0인 경로를 만든다@>
	} else {
		@<|pp|에서 |qq|까지 길이가 $\lceil b\rceil$인 경로를 만든다@>
	}
	setLeftType(pp, endpoint)
	setRightType(qq, endpoint)
	setLink(qq, pp)
	tossKnotList(curExp)
	if reversed {
		curExp = link(htapYpoc(pp))
		tossKnotList(pp)
	} else {
		curExp = pp
	}
}

@ 순환 경로에서는 $a$와 $b$를 함께 $l$의 배수만큼 옮겨 $0\le a<l$이 되게 한다. 열린 경로에서는 그냥 $[0,l]$ 안으로
잘라 낸다.

@<|a<0|이거나 |b>l|인...@>=
if a < 0 {
	if leftType(curExp) == endpoint {
		a = 0
		if b < 0 {
			b = 0
		}
	} else {
		for {
			a = a + l
			b = b + l
			if a >= 0 {
				break
			}
		} // 순환 경로의 길이는 언제나 |l>0|이다
	}
}
if b > l {
	if leftType(curExp) == endpoint {
		b = l
		if a > l {
			a = l
		}
	} else {
		for a >= l {
			a = a - l
			b = b - l
		}
	}
}

@ @<|pp|에서 |qq|까지 길이가...@>=
pp = copyKnot(q)
qq = pp
for {
	q = link(q)
	rr = qq
	qq = copyKnot(q)
	setLink(rr, qq)
	b = b - unity
	if b <= 0 {
		break
	}
}
if a > 0 {
	ss = pp
	pp = link(pp)
	splitCubic(ss, a*0o10000, xCoord(pp), yCoord(pp))
	pp = link(ss)
	freeNode(ss, knotNodeSize)
	if rr == ss {
		b = makeScaled(b, unity-a)
		rr = pp
	}
}
if b < 0 {
	splitCubic(rr, (b+unity)*0o10000, xCoord(qq), yCoord(qq))
	freeNode(qq, knotNodeSize)
	qq = link(rr)
}

@ @<|pp|에서 |qq|까지 길이 0인...@>=
if a > 0 {
	qq = link(q)
	splitCubic(q, a*0o10000, xCoord(qq), yCoord(qq))
	q = link(q)
}
pp = copyKnot(q)
qq = pp

@ 루틴 |pairValue|는 현재 식을 주어진 순서쌍으로 바꾼다.

@<함수들@>=
func pairValue(x, y scaled) {
	var p pointer // 쌍 노드
	p = getNode(valueNodeSize)
	flushCurExp(p)
	curType = pairType
	setType(p, pairType)
	setNameType(p, capsule)
	initBigNode(p)
	p = value(p)
	setType(xPartLoc(p), known)
	setValue(xPartLoc(p), x)
	setType(yPartLoc(p), known)
	setValue(yPartLoc(p), y)
}

@ @<이항 연산자의 다른 경우들@>=
case pointOf, precontrolOf, postcontrolOf:
	if curType == pairType {
		pairToPath()
	}
	if curType == pathType && typ(p) == known {
		findPoint(value(p), c)
	} else {
		badBinary(p, c)
	}
case penOffsetOf:
	if curType == futurePen {
		materializePen()
	}
	if curType == penType && nicePair(p, typ(p)) {
		setUpOffset(value(p))
	} else {
		badBinary(p, penOffsetOf)
	}
case directionTimeOf:
	if curType == pairType {
		pairToPath()
	}
	if curType == pathType && nicePair(p, typ(p)) {
		setUpDirectionTime(value(p))
	} else {
		badBinary(p, directionTimeOf)
	}

@ 원본에서 이 두 프로시저는 저마다 한 곳에서만 불리지만, 원본의 짜임을 따라 함수로 남겼다.

@<함수들@>=
func setUpOffset(p pointer) {
	findOffset(value(xPartLoc(p)), value(yPartLoc(p)), curExp)
	pairValue(curX, curY)
}

func setUpDirectionTime(p pointer) {
	flushCurExp(findDirectionTime(value(xPartLoc(p)), value(yPartLoc(p)), curExp))
}

@ 순환 경로에서 음의 시각 $v$는 $n-1-((-v-1)\bmod n)$으로 바꾼다. 이것은 $v\bmod n$을 음이 아닌 나머지로 구하는
셈인데, $v$가 $n$의 배수일 때 $n$이 아니라 0이 나오도록 $-1$과 $+1$을 끼워 넣은 것이다(여기서 1은 |scaled|의 가장 작은
단위다).

@<함수들@>=
func findPoint(v scaled, c quarterword) {
	var p pointer // 경로
	var n scaled // 그 길이
	var q pointer // |p|의 다음 매듭
	p = curExp
	if leftType(p) == endpoint {
		n = -unity
	} else {
		n = 0
	}
	for {
		p = link(p)
		n = n + unity
		if p == curExp {
			break
		}
	}
	@<시각 |v|를 경로의 범위 안으로 옮긴다@>
	p = curExp
	for v >= unity {
		p = link(p)
		v = v - unity
	}
	if v != 0 {
		@<삼차 곡선을 쪼개어 분수 위치의 노드를 끼워 넣는다@>
	}
	@<현재 식을 원하는 경로 좌표로 놓는다@>
}

@ 열린 경로에서는 시각을 $[0,n]$ 안으로 잘라 내고, 순환 경로에서는 $n$을 법으로 한 나머지를 취한다.

@<시각 |v|를 경로의 범위 안으로 옮긴다@>=
if n == 0 {
	v = 0
} else if v < 0 {
	if leftType(p) == endpoint {
		v = 0
	} else {
		v = n - 1 - ((-v - 1) % n)
	}
} else if v > n {
	if leftType(p) == endpoint {
		v = n
	} else {
		v = v % n
	}
}

@ @<삼차 곡선을 쪼개어...@>=
q = link(p)
splitCubic(p, v*0o10000, xCoord(q), yCoord(q))
p = link(p)

@ @<현재 식을 원하는 경로...@>=
switch c {
case pointOf:
	pairValue(xCoord(p), yCoord(p))
case precontrolOf:
	if leftType(p) == endpoint {
		pairValue(xCoord(p), yCoord(p))
	} else {
		pairValue(leftX(p), leftY(p))
	}
case postcontrolOf:
	if rightType(p) == endpoint {
		pairValue(xCoord(p), yCoord(p))
	} else {
		pairValue(rightX(p), rightY(p))
	}
} // 다른 경우는 없다

@ @<이항 연산자의 다른 경우들@>=
case intersect:
	if typ(p) == pairType {
		q = stashCurExp()
		unstashCurExp(p)
		pairToPath()
		p = stashCurExp()
		unstashCurExp(q)
	}
	if curType == pairType {
		pairToPath()
	}
	if curType == pathType && typ(p) == pathType {
		pathIntersection(value(p), curExp)
		pairValue(curT, curTt)
	} else {
		badBinary(p, intersect)
	}

@* 문장과 명령.
\MF의 최고 집행자는 |doStatement| 루틴이다. 여기에는 \MF의 여러 부분이 올바른 순서로 저마다의 일을 하게 하는 주
스위치가 들어 있다.

어떤 뜻에서 이것은 프로그램의 대단원이다. 공들여 만든 모든 도구를 여기서 쓴다. 다른 뜻에서 이것은 프로그램에서 가장
지저분한 부분이다. 사방의 다른 코드 조각을 가리킬 수밖에 없으므로, 다른 곳에서 정의한 관례를 떠올리려고 앞뒤로
뒤적이지 않고는 무슨 일이 일어나는지 온전히 이해할 수 없다. 우리는 이제 거미줄의 한가운데에 와 있다.

루틴 |doStatement| 자체의 짜임은 꽤 간단하다. 문장의 첫 토큰을 |getXNext|로 가져온다. 그것이 식의 첫 토큰이 될 수
있으면 방정식이나 대입문이나 제목을 찾는다. 그렇지 않으면 |switch| 문으로 여러 갖가지 명령을 처리하는 알맞은 루틴으로
빠르게 갈라진다. 명령마다 필요한 일을 하는 ``동작 프로시저''가 있다.

프로그램은
$$\hbox{|minPrimaryCommand=maxStatementCommand=typeName|}$$
이라는 사실을 써서, 이를테면 `\KW{string}'으로 시작하는 문장을 불 식이 아니라 형 선언으로 해석한다.

@<함수들@>=
func doStatement() { // \MF의 활동을 다스린다
	curType = vacuous
	getXNext()
	if curCmd > maxPrimaryCommand {
		@<잘못된 문장을 걱정한다@>
	} else if curCmd > maxStatementCommand {
		@<방정식, 대입문, 제목, 또는 `$\langle\,$식$\,\rangle\,$\KW{endgroup}'을 처리한다@>
	} else {
		@<식으로 시작하지 않는 문장을 처리한다@>
	}
	if curCmd < semicolon {
		@<문장 뒤에서 찾은 해석할 수 없는 쓰레기를 치운다@>
	}
	errorCount = 0
}

@ 문장의 첫머리에 올 수 있는 |>maxPrimaryCommand|인 명령 코드는 |semicolon|과 그 위의 것뿐이다. 이것들은 문장이 빈
문장일 때 나타난다.

@<잘못된 문장을...@>=
if curCmd < semicolon {
	printErr("A statement can't begin with `")
@.A statement can't begin with x@>
	printCmdMod(curCmd, curMod)
	printChar('\'')
	help5("I was looking for the beginning of a new statement.",
		"If you just proceed without changing anything, I'll ignore",
		"everything up to the next `;'. Please insert a semicolon",
		"now in front of anything that you don't want me to delete.",
		"(See Chapter 27 of The METAFONTbook for an example.)")
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
	backError()
	getXNext()
}

@ 여기서 찍는 도움말은 쌍반점까지 모든 것을 치운다고 말하지만, 실제로는 명령 |endGroup|과 |stop|도 문장을 끝낸다.

@<문장 뒤에서 찾은...@>=
printErr("Extra tokens will be flushed")
@.Extra tokens will be flushed@>
help6("I've just read as much of that statement as I could fathom,",
	"so a semicolon should have been next. It's very puzzling...",
	"but I'll try to get myself back together, by ignoring",
	"everything up to the next `;'. Please insert a semicolon",
	"now in front of anything that you don't want me to delete.",
	"(See Chapter 27 of The METAFONTbook for an example.)")
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
backError()
scannerStatus = flushing
for {
	getNext()
	@<현재 토큰이 문자열이면...@>
	if endOfStatement() { // |curCmd=semicolon|, |endGroup|, |stop| 가운데 하나
		break
	}
}
scannerStatus = normal

@ 루틴 |doStatement|가 |curCmd=endGroup|으로 끝나면, 문장이 그냥 식이었던 경우가 아니라면 |curType=vacuous|여야 한다. 식이었던
경우에는 |curType|과 |curExp|가 그 식을 나타내야 한다.

@<식으로 시작하지 않는...@>=
if internal[tracingCommands] > 0 {
	showCurCmdMod()
}
switch curCmd {
case typeName:
	doTypeDeclaration()
case macroDef:
	if curMod > varDef {
		makeOpDef()
	} else if curMod > endDef {
		scanDef()
	}
@<특정한 명령을 부르는 |doStatement|의 경우들@>
} // 다른 경우는 없다
curType = vacuous

@ 가장 중요한 문장은 식으로 시작한다.

@<방정식, 대입문, 제목, 또는...@>=
varFlag = assignment
scanExpression()
if curCmd < endGroup {
	if curCmd == equals {
		doEquation()
	} else if curCmd == assignment {
		doAssignment()
	} else if curType == stringType {
		@<제목을 처리한다@>
	} else if curType != vacuous {
		expErr("Isolated expression")
@.Isolated expression@>
		help3("I couldn't find an `=' or `:=' after the",
			"expression that is shown above this error message,",
			"so I guess I'll just ignore it and carry on.")
		putGetError()
	}
	flushCurExp(0)
	curType = vacuous
}

@ @<제목을 처리한다@>=
if internal[tracingTitles] > 0 {
	printNl("")
	slowPrint(curExp)
	updateTerminal()
}
if internal[proofing] > 0 {
	@<현재 식을 제목으로 출력 파일에 보낸다@>
}

@ 방정식과 대입문은 서로 재귀적인 두 루틴 |doEquation|과 |doAssignment|가 처리한다. 이 루틴들은 저마다
@^recursion@>
|curCmd=equals|일 때와 |curCmd=assignment|일 때 불린다. 왼쪽 변은 |curType|과 |curExp|에 있고 오른쪽 변은 아직 훑지
않았다. 루틴이 끝나면 |curType|과 |curExp|는 오른쪽 변(대개 왼쪽 변과 같다)과 같아진다.

`\.{a=b=c}'나 `\.{a:=b:=c}'처럼 이어진 문장은 오른쪽부터 처리된다. 루틴 |doEquation|은 오른쪽 식을 훑은 다음 거기에 또
`\.='나 `\.{:=}'가 오면 먼저 자기 자신(또는 |doAssignment|)을 불러 오른쪽 사슬을 끝내고, 그 결과를 왼쪽 변과 같게
놓는다. \PASCAL에서는 |doAssignment|를 미리 \KW{forward}로 선언해야 했지만 \GO/에서는 그럴 필요가 없다.

@<함수들@>=
func doEquation() {
	var lhs pointer // 왼쪽 변의 캡슐
	var p pointer // 임시 레지스터
	lhs = stashCurExp()
	getXNext()
	varFlag = assignment
	scanExpression()
	if curCmd == equals {
		doEquation()
	} else if curCmd == assignment {
		doAssignment()
	}
	if internal[tracingCommands] > two {
		@<현재 방정식을 추적한다@>
	}
	if curType == unknownPath {
		if typ(lhs) == pairType {
			p = stashCurExp()
			unstashCurExp(lhs)
			lhs = p
		}
	} // 이 경우 |makeEq|가 쌍을 경로로 바꿀 것이다
	makeEq(lhs) // |lhs|를 |(curType,curExp)|와 같게 놓는다
}

@ 루틴 |doAssignment|는 |doEquation|과 비슷하다.

@<함수들@>=
func doAssignment() {
	var lhs pointer // 왼쪽 변의 토큰 목록
	var p pointer // 왼쪽 값이 저장된 곳
	var q pointer // 오른쪽 값을 위한 임시 캡슐
	if curType != tokenList {
		expErr("Improper `:=' will be changed to `='")
@.Improper `:='@>
		help2("I didn't find a variable name at the left of the `:=',",
			"so I'm going to pretend that you said `=' instead.")
		reportError()
		doEquation()
	} else {
		lhs = curExp
		curType = vacuous
		getXNext()
		varFlag = assignment
		scanExpression()
		if curCmd == equals {
			doEquation()
		} else if curCmd == assignment {
			doAssignment()
		}
		if internal[tracingCommands] > two {
			@<현재 대입을 추적한다@>
		}
		if info(lhs) > hashEnd {
			@<현재 식을 내부 변수에 대입한다@>
		} else {
			@<현재 식을 변수 |lhs|에 대입한다@>
		}
		flushNodeList(lhs)
	}
}

@ @<현재 방정식을...@>=
beginDiagnostic()
printNl("{(")
printExp(lhs, 0)
printStr(")=(")
printExp(null, 0)
printStr(")}")
endDiagnostic(false)

@ @<현재 대입을...@>=
beginDiagnostic()
printNl("{")
if info(lhs) > hashEnd {
	slowPrint(intName[info(lhs)-hashEnd])
} else {
	showTokenList(lhs, null, 1000, 0)
}
printStr(":=")
printExp(null, 0)
printChar('}')
endDiagnostic(false)

@ @<현재 식을 내부 변수에...@>=
if curType == known {
	internal[info(lhs)-hashEnd] = curExp
} else {
	expErr("Internal quantity `")
@.Internal quantity...@>
	slowPrint(intName[info(lhs)-hashEnd])
	printStr("' must receive a known value")
	help2("I can't set an internal quantity to anything but a known",
		"numeric value, so I'll have to ignore this assignment.")
	putGetError()
}

@ 대입은 방정식으로 바뀐다. 변수의 옛 값을 재활용하고 형만 남긴 ``새'' 변수를 만든 다음, 그것을 오른쪽 변과 같게
놓는 것이다.

@<현재 식을 변수 |lhs|에...@>=
p = findVariable(lhs)
if p != null {
	q = stashCurExp()
	curType = undType(p)
	recycleValue(p)
	setType(p, curType)
	setValue(p, null)
	makeExpCopy(p)
	p = stashCurExp()
	unstashCurExp(q)
	makeEq(p)
} else {
	obliterated(lhs)
	putGetError()
}

@ 이제 본론이다. 프로시저 |makeEq|는 현재 식과 같게 놓을 캡슐을 가리키는 포인터를 받는다.

원본의 레이블 셋 가운데 |restart|와 |done|은 남았다. 중복되거나 모순된 방정식을 보고하는 곳의 |notFound|는 조건을
다시 짜서 없앴다.

@<함수들@>=
func makeEq(lhs pointer) {
	var t smallNumber // 왼쪽 변의 형
	var v int32 // 왼쪽 변의 값
	var p, q pointer // 큰 노드 안의 포인터
restart:
	t = typ(lhs)
	if t <= pairType {
		v = value(lhs)
	}
	switch t {
	@<형 |t|마다 방정식을 세우고, |curType|이 |t|와 맞지 않는 경우가 아니면 |goto done|한다@>
	} // 모든 경우를 늘어놓았다
	@<방정식을 세울 수 없다고 알린다@>
done:
	checkArith()
	recycleValue(lhs)
	freeNode(lhs, valueNodeSize)
}

@ @<방정식을 세울 수 없다고...@>=
dispErr(lhs, "")
expErr("Equation cannot be performed (")
@.Equation cannot be performed@>
if typ(lhs) <= pairType {
	printType(typ(lhs))
} else {
	printStr("numeric")
}
printChar('=')
if curType <= pairType {
	printType(curType)
} else {
	printStr("numeric")
}
printChar(')')
help2("I'm sorry, but I don't know how to make such things equal.",
	"(See the two expressions just above the error message.)")
putGetError()

@ @<형 |t|마다 방정식을...@>=
case booleanType, stringType, penType, pathType, pictureType:
	if curType == t+unknownTag {
		nonlinearEq(v, curExp, false)
		unstashCurExp(curExp)
		goto done
	} else if curType == t {
		@<중복되거나 모순된 방정식을 보고하고 |goto done|@>
	}
case unknownBoolean, unknownString, unknownPen, unknownPicture, unknownPath:
	if curType == t-unknownTag {
		nonlinearEq(curExp, lhs, true)
		goto done
	} else if curType == t {
		ringMerge(lhs, curExp)
		goto done
	} else if curType == pairType && t == unknownPath {
		pairToPath()
		goto restart
	}
case transformType, pairType:
	if curType == t {
		@<여러 방정식을 세우고 |goto done|@>
	}
case known, dependent, protoDependent, independent:
	if curType >= known {
		tryEq(lhs, null)
		goto done
	}
case vacuous:
	// 아무것도 하지 않는다

@ 이미 값을 아는 두 양 사이의 방정식은 쓸모가 없다. 불 값이나 문자열이면 두 값이 같은지 볼 수 있으므로 ``중복''과
``모순''을 가려 말하지만, 펜이나 경로나 그림은 같은지 비교할 수단이 없어서 그냥 ``중복이거나 모순''이라고 말한다.

@<중복되거나 모순된 방정식을 보고하고 |goto done|@>=
if curType > stringType {
	printErr("Redundant or inconsistent equation")
@.Redundant or inconsistent equation@>
	help2("An equation between already-known quantities can't help.",
		"But don't worry; continue and I'll just ignore it.")
	putGetError()
} else if (curType == stringType && strVsStr(v, curExp) != 0) ||
	(curType != stringType && v != curExp) {
	printErr("Inconsistent equation")
@.Inconsistent equation@>
	help2("The equation I just read contradicts what was said before.",
		"But don't worry; continue and I'll just ignore it.")
	putGetError()
} else {
	@<중복된 방정식에...@>
}
goto done

@ @<여러 방정식을...@>=
p = v + bigNodeSize[t]
q = value(curExp) + bigNodeSize[t]
for {
	p = p - 2
	q = q - 2
	tryEq(p, q)
	if p == v {
		break
	}
}
goto done

@ 프로시저 |tryEq|의 첫 인자는 곧 재활용될 캡슐 안의 값 노드의 위치다. 둘째 인자는 |curExp|가 가리키는 쌍 노드나 변환 노드
안의 위치이거나, |null|(곧 |curExp| 자체가 둘째 인자 구실을 한다는 뜻)이다. 생각은 |curExp|를 바꾸지 않은 채 두
피연산자를 같게 놓는 것이다.

방법은 이렇다. 방정식 $l=r$을 $r-l=0$으로 바꾸어, 왼쪽 피연산자의 부호를 바꾼 종속 목록 |p|에 오른쪽 피연산자를
더한다. 결과가 상수뿐이면 방정식은 중복이거나 모순이고, 그렇지 않으면 |linearEq|가 독립 변수 하나를 없앤다.

@<함수들@>=
func tryEq(l, r pointer) {
	var p pointer // 오른쪽 피연산자 빼기 왼쪽 피연산자의 종속 목록
	var t smallNumber // 목록 |p|의 형; |known .. independent|
	var q pointer // |p|의 상수항이 여기 있다
	var pp pointer // 오른쪽 피연산자의 종속 목록
	var tt smallNumber // 목록 |pp|의 형; |dependent .. independent|
	var copied bool // 재활용해야 할 목록을 베꼈나?
	@<왼쪽 피연산자를 그 그릇에서 꺼내 부호를 바꾸고, 상수항이~|q|인 종속 목록~|p|에 넣는다@>
	@<오른쪽 피연산자를 목록 |p|에 더한다@>
	if info(p) == null {
		@<중복되거나 모순된 방정식을 처리한다@>
	} else {
		linearEq(p, t)
		if r == null && curType != known && typ(curExp) == known {
			pp = curExp
			curExp = value(curExp)
			curType = known
			freeNode(pp, valueNodeSize)
		}
	}
}

@ @<왼쪽 피연산자를 그 그릇에서...@>=
t = typ(l)
if t == known {
	t = dependent
	p = constDependency(-value(l))
	q = p
} else if t == independent {
	t = dependent
	p = singleDependency(l)
	setValue(p, -value(p))
	q = depFinal
} else {
	p = depList(l)
	q = p
	for {
		setValue(q, -value(q))
		if info(q) == null {
			break
		}
		q = link(q)
	}
	setLink(prevDep(l), link(q))
	setPrevDep(link(q), prevDep(l))
	setType(l, known)
}

@ 차이가 64보다 크면, 곧 $64/65536\approx0.001$ 이상 어긋나면 모순으로 본다. 그보다 작은 어긋남은 반올림 오차로 여겨
너그럽게 넘긴다.

@<중복되거나 모순된 방정식을 처리한다@>=
if abs(value(p)) > 64 { // .001 이상 어긋남
	printErr("Inconsistent equation")
@.Inconsistent equation@>
	printStr(" (off by ")
	printScaled(value(p))
	printChar(')')
	help2("The equation I just read contradicts what was said before.",
		"But don't worry; continue and I'll just ignore it.")
	putGetError()
} else if r == null {
	@<중복된 방정식에...@>
}
freeNode(p, depNodeSize)

@ 원본의 |done1| 레이블은 오른쪽 피연산자가 알려진 두 경우를 |if|의 앞 갈래로 끌어올려 없앴다.

@<오른쪽 피연산자를 목록 |p|에...@>=
if r == null && curType == known {
	setValue(q, value(q)+curExp)
} else if r != null && typ(r) == known {
	setValue(q, value(q)+value(r))
} else {
	if r == null {
		tt = curType
		if tt == independent {
			pp = singleDependency(curExp)
		} else {
			pp = depList(curExp)
		}
	} else {
		tt = typ(r)
		if tt == independent {
			pp = singleDependency(r)
		} else {
			pp = depList(r)
		}
	}
	if tt != independent {
		copied = false
	} else {
		copied = true
		tt = dependent
	}
	@<형이 |tt|인 종속 목록 |pp|를 형이~|t|인 종속 목록~|p|에 더한다@>
	if copied {
		flushNodeList(pp)
	}
}

@ @<형이 |tt|인 종속 목록...@>=
watchCoefs = false
if t == tt {
	p = pPlusQ(p, pp, t)
} else if t == protoDependent {
	p = pPlusFq(p, unity, pp, protoDependent, dependent)
} else {
	q = p
	for info(q) != null {
		setValue(q, roundFraction(value(q)))
		q = link(q)
	}
	t = protoDependent
	p = pPlusQ(p, pp, t)
}
watchCoefs = true

@ 다음 목표는 형 선언을 처리하는 것이다. 이 목적에는 $\langle\,$선언된 변수$\,\rangle$를 훑어 해당하는 토큰 목록을
돌려주는 프로시저가 있으면 편리하다. 다음 프로시저가 일을 마치면 선언된 변수 다음의 토큰을 이미 훑었으므로, 그것이
|curCmd|, |curMod|, |curSym|에 나타난다.

원본의 |done| 레이블은 반복문의 |break|가 되었다.

@<함수들@>=
func scanDeclaredVariable() pointer {
	var x pointer // 변수 뿌리의 해시 주소
	var h, t pointer // 돌려줄 토큰 목록의 머리와 꼬리
	var l pointer // 왼쪽 대괄호의 해시 주소
	getSymbol()
	x = curSym
	if curCmd != tagToken {
		clearSymbol(x, false)
	}
	h = getAvail()
	setInfo(h, x)
	t = h
	for {
		getXNext()
		if curSym == 0 {
			break
		}
		if curCmd != tagToken && curCmd != internalQuantity {
			if curCmd == leftBracket {
				@<집합적 첨자를 지나 내려간다@>
			} else {
				break
			}
		}
		setLink(t, getAvail())
		t = link(t)
		setInfo(t, curSym)
	}
	if eqType(x)%outerTag != tagToken {
		clearSymbol(x, false)
	}
	if equiv(x) == null {
		newRoot(x)
	}
	return h
}

@ 첨자가 집합적이지 않으면 그것을 선언된 변수의 일부로 받아들이지 않는다.

@<집합적 첨자를...@>=
l = curSym
getXNext()
if curCmd != rightBracket {
	backInput()
	curSym = l
	curCmd = leftBracket
	break
} else {
	curSym = collectiveSubscript
}

@ 형 선언은 다음 원시 연산들로 시작한다.

@<\MF의 원시 명령을...@>=
primitive("numeric", typeName, numericType)
@!@:numeric_}{\KW{numeric} primitive@>
primitive("string", typeName, stringType)
@!@:string_}{\KW{string} primitive@>
primitive("boolean", typeName, booleanType)
@!@:boolean_}{\KW{boolean} primitive@>
primitive("path", typeName, pathType)
@!@:path_}{\KW{path} primitive@>
primitive("pen", typeName, penType)
@!@:pen_}{\KW{pen} primitive@>
primitive("picture", typeName, pictureType)
@!@:picture_}{\KW{picture} primitive@>
primitive("transform", typeName, transformType)
@!@:transform_}{\KW{transform} primitive@>
primitive("pair", typeName, pairType)
@!@:pair_}{\KW{pair} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case typeName:
	printType(m)

@ 이제 방금 |typeName|을 훑었다고 가정하고 형 선언을 처리할 준비가 되었다.

@<함수들@>=
func doTypeDeclaration() {
	var t smallNumber // 선언하는 형
	var p pointer // 선언된 변수의 토큰 목록
	var q pointer // 변수의 값 노드
	if curMod >= transformType {
		t = curMod
	} else {
		t = curMod + unknownTag
	}
	for {
		p = scanDeclaredVariable()
		flushVariable(equiv(info(p)), link(p), false)
		q = findVariable(p)
		if q != null {
			setType(q, t)
			setValue(q, null)
		} else {
			printErr("Declared variable conflicts with previous vardef")
@.Declared variable conflicts...@>
			help2("You can't use, e.g., `numeric foo[]' after `vardef foo'.",
				"Proceed, and I'll ignore the illegal redeclaration.")
			putGetError()
		}
		flushList(p)
		if curCmd < comma {
			@<선언된 변수 뒤의 가짜 기호들을 치운다@>
		}
		if endOfStatement() {
			break
		}
	}
}

@ @<선언된 변수 뒤의...@>=
printErr("Illegal suffix of declared variable will be flushed")
@.Illegal suffix...flushed@>
help5("Variables in declarations must consist entirely of",
	"names and collective subscripts, e.g., `x[]a'.",
	"Are you trying to use a reserved word in a variable name?",
	"I'm going to discard the junk I found here,",
	"up to the next comma or the end of the declaration.")
if curCmd == numericToken {
	helpLine[2] = "Explicit subscripts like `x15a' aren't permitted."
}
putGetError()
scannerStatus = flushing
for {
	getNext()
	@<현재 토큰이 문자열이면...@>
	if curCmd >= comma { // |endOfStatement|이거나 |curCmd=comma|다
		break
	}
}
scannerStatus = normal

@ \MF의 |mainControl| 프로시저는 사용자 프로그램의 끝에 이를 때까지 그냥 |doStatement|를 되풀이해 부른다.
루틴 |doStatement|는 매번 |curCmd|가 |semicolon|, |endGroup|, |stop| 가운데 하나인 채로 끝난다.

@<함수들@>=
func mainControl() {
	for {
		doStatement()
		if curCmd == endGroup {
			printErr("Extra `endgroup'")
@.Extra `endgroup'@>
			help2("I'm not currently working on a `begingroup',",
				"so I had better not try to end anything.")
			flushError(0)
		}
		if curCmd == stop {
			break
		}
	}
}

@ @<\MF의 원시 명령을...@>=
primitive("end", stop, 0)
@!@:end_}{\KW{end} primitive@>
primitive("dump", stop, 1)
@!@:dump_}{\KW{dump} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case stop:
	if m == 0 {
		printStr("end")
	} else {
		printStr("dump")
	}

@* 명령.
이제 명령문의 성격 때문에 ``명령''으로 분류되는 문장으로 넘어가자. 명령 처리를 |doStatement| 루틴에 어떻게
걸어 두는지 분명해지도록 간단한 것부터 시작하고, 그다음 더 까다로운 명령에 맞서겠다.

가장 간단한 것 하나는 이렇다.

@<특정한 명령을 부르는...@>=
case randomSeed:
	doRandomSeed()

@ @<함수들@>=
func doRandomSeed() {
	getXNext()
	if curCmd != assignment {
		missingErr(":=")
@.Missing `:='@>
		help1("Always say `randomseed:=<numeric expression>'.")
		backError()
	}
	getXNext()
	scanExpression()
	if curType != known {
		expErr("Unknown value will be ignored")
@.Unknown value...ignored@>
		help2("Your expression was too random for me to handle,",
			"so I won't change the random seed just now.")
		putGetFlushError(0)
	} else {
		@<난수 씨앗을 |curExp|로 초기화한다@>
	}
}

@ @<난수 씨앗을...@>=
initRandoms(curExp)
if selector >= logOnly {
	oldSetting = selector
	selector = logOnly
	printNl("{randomseed:=")
	printScaled(curExp)
	printChar('}')
	printNl("")
	selector = oldSetting
}

@ 또 하나의 간단한 것(맛은 조금 다르다)이다.

@<특정한 명령을 부르는...@>=
case modeCommand:
	printLn()
	interaction = curMod
	@<|interaction|에 따라 찍기 |selector|를 초기화한다@>
	if logOpened {
		selector = selector + 2
	}
	getXNext()

@ @<\MF의 원시 명령을...@>=
primitive("batchmode", modeCommand, batchMode)
@!@:batch_mode_}{\KW{batchmode} primitive@>
primitive("nonstopmode", modeCommand, nonstopMode)
@!@:nonstop_mode_}{\KW{nonstopmode} primitive@>
primitive("scrollmode", modeCommand, scrollMode)
@!@:scroll_mode_}{\KW{scrollmode} primitive@>
primitive("errorstopmode", modeCommand, errorStopMode)
@!@:error_stop_mode_}{\KW{errorstopmode} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case modeCommand:
	switch m {
	case batchMode:
		printStr("batchmode")
	case nonstopMode:
		printStr("nonstopmode")
	case scrollMode:
		printStr("scrollmode")
	default:
		printStr("errorstopmode")
	}

@ `\KW{inner}'와 `\KW{outer}' 명령은 조금 더 어려울 뿐이다.

@<특정한 명령을 부르는...@>=
case protectionCommand:
	doProtection()

@ @<\MF의 원시 명령을...@>=
primitive("inner", protectionCommand, 0)
@!@:inner_}{\KW{inner} primitive@>
primitive("outer", protectionCommand, 1)
@!@:outer_}{\KW{outer} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case protectionCommand:
	if m == 0 {
		printStr("inner")
	} else {
		printStr("outer")
	}

@ @<함수들@>=
func doProtection() {
	var m int32 // 보호를 풀려면 0, 보호하려면 1
	var t halfword // 바꾸기 전의 |eqType|
	m = curMod
	for {
		getSymbol()
		t = eqType(curSym)
		if m == 0 {
			if t >= outerTag {
				setEqType(curSym, t-outerTag)
			}
		} else if t < outerTag {
			setEqType(curSym, t+outerTag)
		}
		getXNext()
		if curCmd != comma {
			break
		}
	}
}

@ \MF는 토큰 `\.('과 `\.)'를 원시 명령으로 정의하지 않지만, 플레인 \MF는 선언 `\KW{delimiters} \.{()}'으로 시작한다.
그런 선언은 `\.{(}'에 명령 코드 |leftDelimiter|를, `\.{)}'에 |rightDelimiter|를 준다. 각 구분자의 |equiv|는 짝의 해시
주소다.

@<특정한 명령을 부르는...@>=
case delimiters:
	defDelims()

@ @<함수들@>=
func defDelims() {
	var lDelim, rDelim pointer // 새 구분자 쌍
	getClearSymbol()
	lDelim = curSym
	getClearSymbol()
	rDelim = curSym
	setEqType(lDelim, leftDelimiter)
	setEquiv(lDelim, rDelim)
	setEqType(rDelim, rightDelimiter)
	setEquiv(rDelim, lDelim)
	getXNext()
}

@ 다음은 \MF가 어떤 오른쪽 구분자가 반드시 있어야 하는 곳에 이르렀을 때 부르는 프로시저다.

@<함수들@>=
func checkDelimiter(lDelim, rDelim pointer) {
	if curCmd == rightDelimiter && curMod == lDelim {
		return
	}
	if curSym != rDelim {
		missingErr(text(rDelim))
@.Missing `)'@>
		help2("I found no right delimiter to match a left one. So I've",
			"put one in, behind the scenes; this may fix the problem.")
		backError()
	} else {
		printErr("The token `")
		slowPrint(text(rDelim))
@.The token...delimiter@>
		printStr("' is no longer a right delimiter")
		help3("Strange: This token has lost its former meaning!",
			"I'll read it as a right delimiter this time;",
			"but watch out, I'll probably miss it later.")
		reportError()
	}
}

@ 다음 네 명령은 토큰에 딸린 값을 저장하거나 바꾼다.

@<특정한 명령을 부르는...@>=
case saveCommand:
	for {
		getSymbol()
		saveVariable(curSym)
		getXNext()
		if curCmd != comma {
			break
		}
	}
case interimCommand:
	doInterim()
case letCommand:
	doLet()
case newInternal:
	doNewInternal()

@ 명령 \KW{interim}은 내부 수치량을 저장 스택에 저장해 두고 나서, 그 이름을 되돌려 대입문으로 다시 읽게 한다. 그래서
`\KW{interim} |x|\.{:=}|e|'는 `|x|\.{:=}|e|'와 같되 그룹이 끝날 때 옛 값이 되살아난다. 여기서 |doInterim|이
|doStatement|를 부르므로 두 프로시저는 서로 재귀적이다.
@^recursion@>

@<함수들@>=
func doInterim() {
	getXNext()
	if curCmd != internalQuantity {
		printErr("The token `")
@.The token...quantity@>
		if curSym == 0 {
			printStr("(%CAPSULE)")
		} else {
			slowPrint(text(curSym))
		}
		printStr("' isn't an internal quantity")
		help1("Something like `tracingonline' should follow `interim'.")
		backError()
	} else {
		saveInternal(curMod)
		backInput()
	}
	doStatement()
}

@ 다음 프로시저는 `{\tt let x=x}' 같은 명령이 놀라운 효과를 내지 않도록, 왼쪽 기호를 너무 일찍 정의되지 않은
상태로 만들지 않게 조심한다.

@<함수들@>=
func doLet() {
	var l pointer // 왼쪽 기호의 해시 위치
	getSymbol()
	l = curSym
	getXNext()
	if curCmd != equals && curCmd != assignment {
		missingErr("=")
@.Missing `='@>
		help3("You should have said `let symbol = something'.",
			"But don't worry; I'll pretend that an equals sign",
			"was present. The next token I read will be `something'.")
		backError()
	}
	getSymbol()
	switch curCmd {
	case definedMacro, secondaryPrimaryMacro, tertiarySecondaryMacro, expressionTertiaryMacro:
		addMacRef(curMod)
	default:
		// 아무것도 하지 않는다
	}
	clearSymbol(l, false)
	setEqType(l, curCmd)
	if curCmd == tagToken {
		setEquiv(l, null)
	} else {
		setEquiv(l, curMod)
	}
	getXNext()
}

@ @<함수들@>=
func doNewInternal() {
	for {
		if intPtr == maxInternal {
			overflow("number of internals", maxInternal)
		}
@:METAFONT capacity exceeded number of int}{\quad number of internals@>
		getClearSymbol()
		intPtr++
		setEqType(curSym, internalQuantity)
		setEquiv(curSym, intPtr)
		intName[intPtr] = text(curSym)
		internal[intPtr] = 0
		getXNext()
		if curCmd != comma {
			break
		}
	}
}

@ 여러 `\KW{show}' 명령은 여느 때처럼 수식어 필드로 구별한다.

@<정의@>=
const (
	@!showTokenCode = iota // 토큰 하나의 뜻을 보인다
	@!showStatsCode // 현재 메모리와 문자열 사용량을 보인다
	@!showCode // 식의 목록을 보인다
	@!showVarCode // 변수와 그 자손을 보인다
	@!showDependenciesCode // 종속 변수를 독립 변수로 나타내어 보인다
)

@ @<\MF의 원시 명령을...@>=
primitive("showtoken", showCommand, showTokenCode)
@!@:show_token_}{\KW{showtoken} primitive@>
primitive("showstats", showCommand, showStatsCode)
@!@:show_stats_}{\KW{showstats} primitive@>
primitive("show", showCommand, showCode)
@!@:show_}{\KW{show} primitive@>
primitive("showvariable", showCommand, showVarCode)
@!@:show_var_}{\KW{showvariable} primitive@>
primitive("showdependencies", showCommand, showDependenciesCode)
@!@:show_dependencies_}{\KW{showdependencies} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case showCommand:
	switch m {
	case showTokenCode:
		printStr("showtoken")
	case showStatsCode:
		printStr("showstats")
	case showCode:
		printStr("show")
	case showVarCode:
		printStr("showvariable")
	default:
		printStr("showdependencies")
	}

@ @<특정한 명령을 부르는...@>=
case showCommand:
	doShowWhatever()

@ 수식자 |curMod|의 값은 |printExp| 루틴의 |verbosity|를 다스린다. 그 값이 |showCode|면 복잡한 구조를 줄여 보이고, 그렇지 않으면 줄이지
않는다.

@<함수들@>=
func doShow() {
	for {
		getXNext()
		scanExpression()
		printNl(">> ")
@.>>@>
		printExp(null, 2)
		flushCurExp(0)
		if curCmd != comma {
			break
		}
	}
}

@ @<함수들@>=
func dispToken() {
	printNl("> ")
@.>\relax@>
	if curSym == 0 {
		@<수치 토큰이나 문자열 토큰이나 캡슐 토큰을 보인다@>
	} else {
		slowPrint(text(curSym))
		printChar('=')
		if eqType(curSym) >= outerTag {
			printStr("(outer) ")
		}
		printCmdMod(curCmd, curMod)
		if curCmd == definedMacro {
			printLn()
			showMacro(curMod, null, 100000)
		} // 이렇게 하여 |showMacro|와 |printCmdMod| 사이의 재귀를 피한다
@^recursion@>
	}
}

@ @<수치 토큰이나 문자열...@>=
if curCmd == numericToken {
	printScaled(curMod)
} else if curCmd == capsuleToken {
	printCapsule(curMod)
} else {
	printChar('"')
	slowPrint(curMod)
	printChar('"')
	deleteStrRef(curMod)
}

@ 다음 |printCmdMod|의 경우들은 |dispToken|과 관련하여 생길 수 있는데, 원시 토큰에 꼭 해당하지는 않는다.

@<|printCmdMod|에서 원시 명령을...@>=
case leftDelimiter, rightDelimiter:
	if c == leftDelimiter {
		printStr("lef")
	} else {
		printStr("righ")
	}
	printStr("t delimiter that matches ")
	slowPrint(text(m))
case tagToken:
	if m == null {
		printStr("tag")
	} else {
		printStr("variable")
	}
case definedMacro:
	printStr("macro:")
case secondaryPrimaryMacro, tertiarySecondaryMacro, expressionTertiaryMacro:
	printCmdMod(macroDef, c)
	printStr("'d macro:")
	printLn()
	showTokenList(link(link(m)), null, 1000, 0)
case repeatLoop:
	printStr("[repeat the loop]")
case internalQuantity:
	slowPrint(intName[m])

@ @<함수들@>=
func doShowToken() {
	for {
		getNext()
		dispToken()
		getXNext()
		if curCmd != comma {
			break
		}
	}
}

@ 원본은 통계 코드를 \.{stat}$\ldots$\.{tats}로 감싸고 그 끝에 `\.{if false then}'을 붙이는 꾀를 썼다. 통계를 모을
때는 쓰인 낱말 수를 찍고, 모으지 않을 때는 \.{unknown}을 찍게 하는 것이다. \GO/에서는 그냥 |if|--|else|다.

@<함수들@>=
func doShowStats() {
	printNl("Memory usage ")
@.Memory usage...@>
	if stat {
		printInt(varUsed)
		printChar('&')
		printInt(dynUsed)
	} else {
		printStr("unknown")
	}
	printStr(" (")
	printInt(hiMemMin - loMemMax - 1)
	printStr(" still untouched)")
	printLn()
	printNl("String usage ")
	printInt(strPtr - initStrPtr)
	printChar('&')
	printInt(poolPtr - initPoolPtr)
	printStr(" (")
	printInt(maxStrings - maxStrPtr)
	printChar('&')
	printInt(poolSize - maxPoolPtr)
	printStr(" still untouched)")
	printLn()
	getXNext()
}

@ 다음은 |doShowVar|가 쓰는, 변수를 줄여서 설명하는 재귀 프로시저다.

@<함수들@>=
func dispVar(p pointer) {
	var q pointer // 속성과 첨자를 훑는다
	var n int32 // 보일 매크로 텍스트의 양; |0 .. maxPrintLine|
	if typ(p) == structured {
		@<구조를 따라 내려간다@>
	} else if typ(p) >= unsuffixedMacro {
		@<변수 매크로를 보인다@>
	} else if typ(p) != undefined {
		printNl("")
		printVariableName(p)
		printChar('=')
		printExp(p, 0)
	}
}

@ @<구조를 따라...@>=
q = attrHead(p)
for {
	dispVar(q)
	q = link(q)
	if q == endAttr {
		break
	}
}
q = subscrHead(p)
for nameType(q) == subscr {
	dispVar(q)
	q = link(q)
}

@ @<변수 매크로를...@>=
printNl("")
printVariableName(p)
if typ(p) > unsuffixedMacro {
	printStr("@@#") // |suffixedMacro|
}
printStr("=macro:")
if fileOffset >= maxPrintLine-20 {
	n = 5
} else {
	n = maxPrintLine - fileOffset - 15
}
showMacro(value(p), null, n)

@ 원본의 |done| 레이블은 조건을 하나로 묶은 |if|--|else|로 사라졌다.

@<함수들@>=
func doShowVar() {
	for {
		getNext()
		if curSym > 0 && curSym <= hashEnd && curCmd == tagToken && curMod != null {
			dispVar(curMod)
		} else {
			dispToken()
		}
		getXNext()
		if curCmd != comma {
			break
		}
	}
}

@ @<함수들@>=
func doShowDependencies() {
	var p pointer // 모든 종속 관계를 훑는 연결
	p = link(depHead)
	for p != depHead {
		if interesting(p) {
			printNl("")
			printVariableName(p)
			if typ(p) == dependent {
				printChar('=')
			} else {
				printStr(" = ") // 여분의 빈칸은 원형 종속임을 나타낸다
			}
			printDependency(depList(p), typ(p))
		}
		p = depList(p)
		for info(p) != null {
			p = link(p)
		}
		p = link(p)
	}
	getXNext()
}

@ 마침내 모든 \KW{show} 명령을 다스리는 프로시저에 이르렀다.

@<함수들@>=
func doShowWhatever() {
	if interaction == errorStopMode {
		wakeUpTerminal()
	}
	switch curMod {
	case showTokenCode:
		doShowToken()
	case showStatsCode:
		doShowStats()
	case showCode:
		doShow()
	case showVarCode:
		doShowVar()
	case showDependenciesCode:
		doShowDependencies()
	} // 다른 경우는 없다
	if internal[showstopping] > 0 {
		printErr("OK")
@.OK@>
		if interaction < errorStopMode {
			help0()
			errorCount--
		} else {
			help1("This isn't an error message; I'm just showing something.")
		}
		if curCmd == semicolon {
			reportError()
		} else {
			putGetError()
		}
	}
}

@ `\KW{addto}' 명령에는 다음 원시 명령들이 더 필요하다.

@<정의@>=
const (
	@!dropCode = 0 // `\KW{dropping}'의 명령 수식어
	@!keepCode = 1 // `\KW{keeping}'의 명령 수식어
)

@ @<\MF의 원시 명령을...@>=
primitive("contour", thingToAdd, contourCode)
@!@:contour_}{\KW{contour} primitive@>
primitive("doublepath", thingToAdd, doublePathCode)
@!@:double_path_}{\KW{doublepath} primitive@>
primitive("also", thingToAdd, alsoCode)
@!@:also_}{\KW{also} primitive@>
primitive("withpen", withOption, penType)
@!@:with_pen_}{\KW{withpen} primitive@>
primitive("withweight", withOption, known)
@!@:with_weight_}{\KW{withweight} primitive@>
primitive("dropping", cullOp, dropCode)
@!@:dropping_}{\KW{dropping} primitive@>
primitive("keeping", cullOp, keepCode)
@!@:keeping_}{\KW{keeping} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case thingToAdd:
	if m == contourCode {
		printStr("contour")
	} else if m == doublePathCode {
		printStr("doublepath")
	} else {
		printStr("also")
	}
case withOption:
	if m == penType {
		printStr("withpen")
	} else {
		printStr("withweight")
	}
case cullOp:
	if m == dropCode {
		printStr("dropping")
	} else {
		printStr("keeping")
	}

@ @<함수들@>=
func scanWith() bool {
	var t smallNumber // |known|이나 |penType|
	var result bool // 돌려줄 값
	t = curMod
	curType = vacuous
	getXNext()
	scanExpression()
	result = false
	if curType != t {
		@<형이 알맞지 않다고 불평한다@>
	} else if curType == penType {
		result = true
	} else {
		@<임시 무게를 검사한다@>
	}
	return result
}

@ @<형이 알맞지 않다고...@>=
expErr("Improper type")
@.Improper type@>
help2("Next time say `withweight <known numeric expression>';",
	"I'll ignore the bad `with' clause and look for another.")
if t == penType {
	helpLine[1] = "Next time say `withpen <known pen expression>';"
}
putGetFlushError(0)

@ @<임시 무게를...@>=
curExp = roundUnscaled(curExp)
if abs(curExp) < 4 && curExp != 0 {
	result = true
} else {
	printErr("Weight must be -3, -2, -1, +1, +2, or +3")
@.Weight must be...@>
	help1("I'll ignore the bad `with' clause and look for another.")
	putGetFlushError(0)
}

@ \KW{addto}나 비슷한 명령을 구문 분석했을 때 할 일 하나는, \KW{picture} 변수로 여겨지는 것의 토큰 목록이 주어졌을 때
|curEdges|를 그 변수의 머리로 놓는 것이다.

@<함수들@>=
func findEdgesVar(t pointer) {
	var p pointer
	p = findVariable(t)
	curEdges = null
	if p == null {
		obliterated(t)
		putGetError()
	} else if typ(p) != pictureType {
		printErr("Variable ")
		showTokenList(t, null, 1000, 0)
@.Variable x is the wrong type@>
		printStr(" is the wrong type (")
		printType(typ(p))
		printChar(')')
		help2("I was looking for a \"known\" picture variable.",
			"So I'll not change anything just now.")
		putGetError()
	} else {
		curEdges = value(p)
	}
	flushNodeList(t)
}

@ @<특정한 명령을 부르는...@>=
case addToCommand:
	doAddTo()

@ @<함수들@>=
func doAddTo() {
	var lhs, rhs pointer // 왼쪽의 변수, 오른쪽의 경로
	var w int32 // 임시 무게
	var p pointer // 목록 조작 레지스터
	var q pointer // 겹친 경로의 뒤쪽 절반의 처음
	var addToType int32 // \KW{addto}의 수식어; |doublePathCode .. alsoCode|
	getXNext()
	varFlag = thingToAdd
	scanPrimary()
	if curType != tokenList {
		@<변수가 없으므로 가장자리 명령을 버린다@>
	} else {
		lhs = curExp
		addToType = curMod
		curType = vacuous
		getXNext()
		scanExpression()
		if addToType == alsoCode {
			@<어떤 가장자리를 다른 것으로 늘린다@>
		} else {
			@<윤곽을 칠할 준비를 하고 칠한다@>
		}
	}
}

@ @<변수가 없으므로...@>=
expErr("Not a suitable variable")
@.Not a suitable variable@>
help4("At this point I needed to see the name of a picture variable.",
	"(Or perhaps you have indeed presented me with one; I might",
	"have missed it, if it wasn't followed by the proper token.)",
	"So I'll not change anything just now.")
putGetFlushError(0)

@ @<어떤 가장자리를...@>=
findEdgesVar(lhs)
if curEdges == null {
	flushCurExp(0)
} else if curType != pictureType {
	expErr("Improper `addto'")
@.Improper `addto'@>
	help2("This expression should have specified a known picture.",
		"So I'll not change anything just now.")
	putGetFlushError(0)
} else {
	mergeEdges(curExp)
	flushCurExp(0)
}

@ @<윤곽을 칠할...@>=
if curType == pairType {
	pairToPath()
}
if curType != pathType {
	expErr("Improper `addto'")
@.Improper `addto'@>
	help2("This expression should have been a known path.",
		"So I'll not change anything just now.")
	putGetFlushError(0)
	flushTokenList(lhs)
} else {
	rhs = curExp
	w = 1
	curPen = nullPen
	for curCmd == withOption {
		if scanWith() {
			if curType == known {
				w = curExp
			} else {
				@<임시 펜을 바꾼다@>
			}
		}
	}
	@<윤곽 칠하기 연산을 마친다@>
	deletePenRef(curPen)
}

@ 여기서 |curPen|을 바꾼 다음 `|addPenRef(curPen)|; |flushCurExp(0)|'이라고 할 수도 있다. 그러나 그것은 아무 효과가
없을 것이다. 현재 식은 치워지지 않을 것이기 때문이다. 그래서 (지나치게 교묘해질 위험을 무릅쓰고) 코드를 조금
아낀다. 다음 \KW{with} 절을 훑을 때 |scanWith|는 |curType|을 그냥 |vacuous|로 놓을 뿐 현재 식을 치우지 않고, 문장이
끝날 때 |doStatement|도 마찬가지다. 그러니 펜에 대한 참조는 |curPen| 하나뿐이다.

@<임시 펜을...@>=
deletePenRef(curPen)
curPen = curExp

@ 원본은 열린 경로를 \KW{contour}로 칠하려 할 때의 오류에서 |notFound|로 건너뛰었다. 여기서는 그 경우를 |if|의 앞
갈래로 끌어올려 레이블을 없앴다.

@<윤곽 칠하기 연산을...@>=
findEdgesVar(lhs)
if curEdges == null {
	tossKnotList(rhs)
} else {
	lhs = null
	curPathType = addToType
	if leftType(rhs) == endpoint && curPathType != doublePathCode {
		@<순환 경로가 아니라고 불평한다@>
	} else {
		if leftType(rhs) == endpoint {
			@<경로를 겹친다@>
		} else if curPathType == doublePathCode {
			lhs = htapYpoc(rhs)
		}
		curWt = w
		rhs = makeSpec(rhs, maxOffset(curPen), internal[tracingSpecs])
		@<회전수를 검사한다@>
		if maxOffset(curPen) == 0 {
			fillSpec(rhs)
		} else {
			fillEnvelope(rhs)
		}
		if lhs != null {
			revTurns = true
			lhs = makeSpec(lhs, maxOffset(curPen), internal[tracingSpecs])
			revTurns = false
			if maxOffset(curPen) == 0 {
				fillSpec(lhs)
			} else {
				fillEnvelope(lhs)
			}
		}
	}
}

@ 명령 \KW{doublepath} $p$는 경로 $p$를 갔다가 거꾸로 되돌아오는 순환 경로를 칠하는 것과 같다. 열린 경로 $z_0\ldots z_n$을
겹치려면 |htapYpoc|으로 거꾸로 된 사본 $z_n\ldots z_0$을 만들고, 두 끝 $z_0$과 $z_n$에서 중복된 매듭을 하나씩 없애며 이어
붙인다. 그러면 $z_0\to z_1\to\cdots\to z_n\to z_{n-1}\to\cdots\to z_1\to z_0$을 도는 고리가 된다. 이 고리가 둘러싼
넓이는 0이지만, 펜으로 칠하면 펜 모양이 경로를 따라 쓸고 간 자국이 남는다. 회전수가 0인 것이 당연하므로 아래의 회전수
검사는 \KW{doublepath}를 건너뛴다.

순환 경로를 \KW{doublepath}로 칠할 때는 이음을 할 필요가 없다. 원래 고리와 거꾸로 된 고리(|lhs|)를 따로따로 칠하면
되고, 거꾸로 된 고리는 회전수가 음수가 되므로 |revTurns|를 켜 둔다.

$$\mplibcode
beginfig(24);
save u, P, d; numeric u, d; path P; u := 30pt; d := 3pt;
P := (0,0) .. (2u,1u) .. (4.4u,.2u) .. (6u,1.2u);
drawarrow P shifted (0,d) withpen pencircle scaled .5pt;
drawarrow reverse P shifted (0,-d) withpen pencircle scaled .5pt;
draw (point 3 of P shifted (0,d)) .. (point 3 of P + (d,0)) .. (point 3 of P shifted (0,-d)) withpen pencircle scaled .5pt;
draw (point 0 of P shifted (0,-d)) .. (point 0 of P - (d,0)) .. (point 0 of P shifted (0,d)) withpen pencircle scaled .5pt;
for k = 0 upto 3: dot(point k of P); endfor
label.lft(btex $z_0$ etex, point 0 of P - (d,0));
label.top(btex $z_1$ etex, point 1 of P + (0,d));
label.bot(btex $z_2$ etex, point 2 of P - (0,d));
label.rt(btex $z_3$ etex, point 3 of P + (d,0));
endfig;
\endmplibcode$$

@<경로를 겹친다@>=
if link(rhs) == rhs {
	@<점 하나짜리 사소한 순환 경로를 만든다@>
} else {
	p = htapYpoc(rhs)
	q = link(p)
	setRightX(pathTail, rightX(q))
	setRightY(pathTail, rightY(q))
	setRightType(pathTail, rightType(q))
	setLink(pathTail, link(q))
	freeNode(q, knotNodeSize)
	setRightX(p, rightX(rhs))
	setRightY(p, rightY(rhs))
	setRightType(p, rightType(rhs))
	setLink(p, link(rhs))
	freeNode(rhs, knotNodeSize)
	rhs = p
}

@ @<점 하나짜리 사소한...@>=
setRightX(rhs, xCoord(rhs))
setRightY(rhs, yCoord(rhs))
setLeftX(rhs, xCoord(rhs))
setLeftY(rhs, yCoord(rhs))
setLeftType(rhs, explicit)
setRightType(rhs, explicit)

@ @<순환 경로가 아니라고...@>=
printErr("Not a cycle")
@.Not a cycle@>
help2("That contour should have ended with `..cycle' or `&cycle'.",
	"So I'll not change anything just now.")
putGetError()
tossKnotList(rhs)

@ \KW{contour}로 칠할 경로는 시계 반대 방향이어야 한다. 회전수가 음수인 경로는 무게의 부호를 바꾸어 바로잡을 수 있지만
(펜이 없을 때), 그 밖의 경우에는 \\{turningcheck}가 양수이면 경고한다. 원본의 |done| 레이블은 경고하지 않아도 되는
경우를 |if|의 한 갈래로 떼어 내어 없앴다.

@<회전수를 검사한다@>=
if turningNumber <= 0 && curPathType != doublePathCode && internal[turningCheck] > 0 {
	if turningNumber < 0 && link(curPen) == null {
		curWt = -curWt
	} else if turningNumber == 0 && internal[turningCheck] <= unity && link(curPen) == null {
		// 경고하지 않는다
	} else {
		if turningNumber == 0 {
			printStrange("Strange path (turning number is zero)")
@.Strange path...@>
		} else {
			printStrange("Backwards path (turning number is negative)")
@.Backwards path...@>
		}
		help3("The path doesn't have a counterclockwise orientation,",
			"so I'll probably have trouble drawing it.",
			"(See Chapter 27 of The METAFONTbook for more help.)")
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
		putGetError()
	}
}

@ @<특정한 명령을 부르는...@>=
case shipOutCommand:
	doShipOut()
case displayCommand:
	doDisplay()
case openWindow:
	doOpenWindow()
case cullCommand:
	doCull()

@ @<함수들@>=
func doShipOut() {
	var c int32 // 문자 코드
	getXNext()
	varFlag = semicolon
	scanExpression()
	if curType != tokenList {
		if curType == pictureType {
			curEdges = curExp
		} else {
			@<변수가 없으므로...@>
			return
		}
	} else {
		findEdgesVar(curExp)
		curType = vacuous
	}
	if curEdges != null {
		c = roundUnscaled(internal[charCode]) % 256
		if c < 0 {
			c = c + 256
		}
		@<문자 코드~|c|의 너비 정보를 저장한다@>
		if internal[proofing] >= 0 {
			shipOut(c)
		}
	}
	flushCurExp(0)
}

@ 원본은 레이블 셋(|notFound|, |commonEnding|, |exit|)으로 오류의 두 경우를 한데 모았다. 창 번호가 알려지지 않았으면
곧바로 오류로 가고, 알려졌지만 범위를 벗어나면 그것을 |scaled|로 되돌려 오류 메시지에 보인다. 여기서는 이것을 중첩된
|if|로 바꾸었다.

그런데 이 되돌리기 |curExp*unity|는 넘칠 수 있다. 창 번호로 계산해 얻은 값 32767.9를 주면
(상수 \.{32767.9}는 4096을 넘으므로 훑을 때 이미 줄어든다) |roundUnscaled|가 32768을 내고, $32768\cdot2^{16}=2^{31}$은 32비트 정수로 나타낼 수 없다. 2의 보수로 돌아 감는
산술에서는 $-2^{31}$이 되고, |printScaled|가 그 부호를 바꾸려 해도 또 넘치므로 이 프로그램은 오류 메시지 위에
\.{>> --32768}을 찍는다. \TeX\ Live의 C 판은 \.{>> -32768}을 찍는다. 어느 쪽이든 틀렸지만 메시지가 틀릴 뿐 해는 없으니
원본대로 두었다.
@^bugs@>

@<함수들@>=
func doDisplay() {
	var e pointer // 그림 변수의 토큰 목록
	getXNext()
	varFlag = inWindow
	scanPrimary()
	if curType != tokenList {
		@<변수가 없으므로...@>
	} else {
		e = curExp
		curType = vacuous
		getXNext()
		scanExpression()
		if curType == known {
			curExp = roundUnscaled(curExp)
			if curExp >= 0 && curExp <= 15 && windowOpen[curExp] {
				findEdgesVar(e)
				if curEdges != null {
					dispEdges(curExp)
				}
				return
			}
			curExp = curExp * unity
		}
		expErr("Bad window number")
@.Bad window number@>
		help1("It should be the number of an open window.")
		putGetFlushError(0)
		flushTokenList(e)
	}
}

@ `\KW{openwindow}'에서 어려운 점은 문법이 사용자를 여러 갈래로 헤매게 할 수 있다는 것뿐이다. 다음 서브루틴은 필요한
프로그램을 적당히 짧고 깔끔하게 지키도록 돕는다.

@<함수들@>=
func getPair(c int32) bool {
	var p pointer // 알려진 (것이기를 바라는) 값의 쌍
	var b bool // 그런 쌍을 찾았나?
	if curCmd != c {
		return false
	}
	getXNext()
	scanExpression()
	if nicePair(curExp, curType) {
		p = value(curExp)
		curX = value(xPartLoc(p))
		curY = value(yPartLoc(p))
		b = true
	} else {
		b = false
	}
	flushCurExp(0)
	return b
}

@ 원본의 |notFound| 레이블은 성공하는 경로만 중첩된 |if| 안에서 |return|하게 하여 없앴다. 어느 단계에서든 실패하면
함수 끝의 오류 메시지로 떨어진다.

@<함수들@>=
func doOpenWindow() {
	var k int32 // 문제의 창 번호
	var r0, c0, r1, c1 scaled // 창 좌표
	getXNext()
	scanExpression()
	if curType == known {
		k = roundUnscaled(curExp)
		if k >= 0 && k <= 15 && getPair(fromToken) {
			r0 = curX
			c0 = curY
			if getPair(toToken) {
				r1 = curX
				c1 = curY
				if getPair(atToken) {
					openAWindow(k, r0, c0, r1, c1, curX, curY)
					return
				}
			}
		}
	}
	printErr("Improper `openwindow'")
@.Improper `openwindow'@>
	help2("Say `openwindow k from (r0,c0) to (r1,c1) at (x,y)',",
		"where all quantities are known and k is between 0 and 15.")
	putGetError()
}

@ 명령 \KW{cull}은 그림에서 무게가 주어진 범위 $[a,b]$ 안에 드는 점만 남기거나(\KW{keeping}) 버린다(\KW{dropping}). 남는
점의 무게는 \KW{withweight}로 준 값이 된다.


@<함수들@>=
func doCull() {
	var e pointer // 그림 변수의 토큰 목록
	var keeping int32 // |cullOp|의 수식어; |dropCode .. keepCode|
	var w, wIn, wOut int32 // 추려 내기 무게
	w = 1
	getXNext()
	varFlag = cullOp
	scanPrimary()
	if curType != tokenList {
		@<변수가 없으므로...@>
	} else {
		e = curExp
		curType = vacuous
		keeping = curMod
		if !getPair(cullOp) {
			goto notFound
		}
		for curCmd == withOption && curMod == known {
			if scanWith() {
				w = curExp
			}
		}
		@<추려 내기 무게를 정하거나, 문턱이 나쁘면 |goto notFound|@>
		@<그림 변수를 찾아 추려 내고 |return|한다@>
	notFound:
		printErr("Bad culling amounts")
@.Bad culling amounts@>
		help1("Always cull by known amounts that exclude 0.")
		putGetError()
		flushTokenList(e)
	}
}

@ 무게는 정수이므로 범위의 아래 끝은 올림하고 위 끝은 내림해서 |cullEdges|에 넘긴다.

여기서 나는 넘침을 하나 찾았다. 원본은 아래 끝의 올림을 |floorUnscaled(curX+unity-1)|로 계산하는데, |curX|가
$32767$보다 크면 |curX+unity-1|이 $2^{31}-1$을 넘는다. 이를테면 계산으로 얻은 값 $a=32767.5$와 $b=32767.9$로
`\.{cull} \.{p} \.{keeping} \.{(a,b)}'라고 하면, 무게가 그 범위에 드는 점이 하나도 없으므로 빈 그림이 남아야 한다.
그런데 2의 보수로 돌아 감는 산술에서는 아래 끝이 $-32768$이 되어 구간 $[-32768,32767]$이 0까지 품게 된다. 바로 앞의
검사(|curX<=0|이고 |curY>=0|이면 거부한다)는 반올림하기 전의 |curX|로 했으므로 이것을 막지 못하고, |cullEdges|의
전제, 곧 ``무게 0인 화소는 무게 0으로 남는다''가 깨진다. 그러면 가장자리 구조 바깥의 무한히 많은 화소가 무게~1을
얻으려 하므로 그림이 망가진다. 실제로 이 프로그램을 원본대로 옮겼더니 \.{totalweight} \.{p}가 $-0.1875$로 나왔다.
표준 \PASCAL에서 정수 넘침은 오류이고, \TeX\ Live의 C 판에서는 정의되지 않은 동작인데 컴파일러가 우연히 수학적으로
맞는 값을 계산해서 0이 나온다.

그래서 여기서는 올림을 $\lceil x\rceil=-\lfloor -x\rfloor$로 바꾸어 |-floorUnscaled(-curX)|로 계산한다. 넘치지 않는
모든 값에서 두 식은 같은 값을 내므로 \.{TRAP} 테스트의 결과는 바뀌지 않는다. 또 |curX>=-elGordo|이므로 |-curX|는
넘치지 않는다.
@^bugs@>

@<그림 변수를 찾아 추려 내고...@>=
findEdgesVar(e)
if curEdges != null {
	cullEdges(-floorUnscaled(-curX), floorUnscaled(curY), wOut, wIn)
}
return

@ @<추려 내기 무게를...@>=
if curX > curY {
	goto notFound
}
if keeping == dropCode {
	if curX > 0 || curY < 0 {
		goto notFound
	}
	wOut = w
	wIn = 0
} else {
	if curX <= 0 && curY >= 0 {
		goto notFound
	}
	wOut = 0
	wIn = w
}

@ \KW{everyjob} 명령은 전역 변수 |startSym|에 0이 아닌 값을 줄 뿐이다.

@<특정한 명령을 부르는...@>=
case everyJobCommand:
	getSymbol()
	startSym = curSym
	getXNext()

@ @<전역 변수@>=
var @!startSym halfword // 작업의 처음에 끼워 넣을 기호 토큰

@ @<핵심 변수들의...@>=
startSym = 0

@ 마지막으로 ``메시지'' 명령만 남았다.

@<정의@>=
const (
	@!messageCode = 0
	@!errMessageCode = 1
	@!errHelpCode = 2
)

@ @<\MF의 원시 명령을...@>=
primitive("message", messageCommand, messageCode)
@!@:message_}{\KW{message} primitive@>
primitive("errmessage", messageCommand, errMessageCode)
@!@:err_message_}{\KW{errmessage} primitive@>
primitive("errhelp", messageCommand, errHelpCode)
@!@:err_help_}{\KW{errhelp} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case messageCommand:
	if m < errMessageCode {
		printStr("message")
	} else if m == errMessageCode {
		printStr("errmessage")
	} else {
		printStr("errhelp")
	}

@ @<특정한 명령을 부르는...@>=
case messageCommand:
	doMessage()

@ @<함수들@>=
func doMessage() {
	var m int32 // 메시지의 종류; |messageCode .. errHelpCode|
	m = curMod
	getXNext()
	scanExpression()
	if curType != stringType {
		expErr("Not a string")
@.Not a string@>
		help1("A message should be a known string expression.")
		putGetError()
	} else {
		switch m {
		case messageCode:
			printNl("")
			slowPrint(curExp)
		case errMessageCode:
			@<문자열 |curExp|를 오류 메시지로 찍는다@>
		case errHelpCode:
			@<문자열 |curExp|를 |errHelp|로 저장한다@>
		} // 다른 경우는 없다
	}
	flushCurExp(0)
}

@ 전역 변수 |errHelp|는 사용자가 가장 최근에 빈 도움말 문자열을 주었거나 한 번도 준 적이 없으면 0이다.

@<문자열 |curExp|를 |errHelp|로...@>=
if errHelp != 0 {
	deleteStrRef(errHelp)
}
if length(curExp) == 0 {
	errHelp = 0
} else {
	errHelp = curExp
	addStrRef(errHelp)
}

@ 명령 \KW{errmessage}가 사용자 정의 \KW{errhelp} 없이 |scrollMode|에서 자주 나오면 매번 긴 도움말을 주고 싶지 않다. 그래서
긴 설명은 한 번만 준다.

@<전역 변수@>=
var @!longHelpSeen bool // 긴 \KW{errmessage} 도움말을 썼나?

@ @<핵심 변수들의...@>=
longHelpSeen = false

@ @<문자열 |curExp|를 오류 메시지로...@>=
printErr("")
slowPrint(curExp)
if errHelp != 0 {
	useErrHelp = true
} else if longHelpSeen {
	help1("(That was another `errmessage'.)")
} else {
	if interaction < errorStopMode {
		longHelpSeen = true
	}
	help4("This error message was generated by an `errmessage'",
		"command, so I can't give any explicit help.",
		"Pretend that you're Miss Marple: Examine all clues,",
@^Marple, Jane@>
		"and deduce the truth by inspired guesses.")
}
putGetError()
useErrHelp = false

@* 글꼴 계량 자료.
\TeX은 글꼴에 관한 지식을 글꼴 계량 파일, 곧 \.{TFM} 파일에서 얻는다. `\.{TFM}'의 `\.T'는 \TeX을 뜻하지만, 다른
@:TFM files}{\.{TFM} files@>
@^font metric files@>
프로그램들도 이 파일을 안다. \MF의 임무 하나는 사용자의 글꼴을 조판에 바로 쓸 수 있도록 \.{TFM} 파일을 쓰는
것이다.

\.{TFM} 파일의 정보는 8비트 바이트의 나열로 나타난다. 바이트 수는 언제나 4의 배수이므로 파일을 32비트 낱말의
나열로 볼 수도 있지만, \MF는 바이트 해석을 쓴다. \.{TFM} 파일의 형식은 라일 램쇼가 1980년에 설계했다. 그 목적은
@^Ramshaw, Lyle Harold@>
여러 가지 다른 종류의 정보를 간결하면서도 쓸모 있는 꼴로 전하는 것이다.

@<전역 변수@>=
var @!tfmFile byteFile // 글꼴 계량 출력이 여기로 간다
var @!metricFileName strNumber // 글꼴 계량 파일의 전체 이름

@ \.{TFM} 파일의 처음 24바이트(6낱말)에는 뒤따르는 여러 부분의 길이를 주는 16비트 정수 열두 개가 들어 있다.
이 열두 정수는 차례로 다음과 같다.
$$\vbox{\halign{\hfil#&$\null=\null$#\hfil\cr
|lf|&파일 전체의 길이, 낱말 단위;\cr
|lh|&머리 자료의 길이, 낱말 단위;\cr
|bc|&글꼴에서 가장 작은 문자 코드;\cr
|ec|&글꼴에서 가장 큰 문자 코드;\cr
|nw|&너비 표의 낱말 수;\cr
|nh|&높이 표의 낱말 수;\cr
|nd|&깊이 표의 낱말 수;\cr
|ni|&기울임 보정 표의 낱말 수;\cr
|nl|&합자/커닝 표의 낱말 수;\cr
|nk|&커닝 표의 낱말 수;\cr
|ne|&늘일 수 있는 문자 표의 낱말 수;\cr
|np|&글꼴 매개변수 낱말의 수.\cr}}$$
이것들은 모두 음이 아니고 $2^{15}$보다 작다. 또 |bc-1<=ec<=255|, |ne<=256|이어야 하고
$$\hbox{|lf=6+lh+(ec-bc+1)+nw+nh+nd+ni+nl+nk+ne+np|}$$
여야 한다. 글꼴에는 문자가 256개까지(|bc=0|이고 |ec=255|면) 들어 있을 수도 있고, 하나도(|bc=ec+1|이면) 없을 수도
있다는 데 주목하라.

덧붙여 말하면, 8비트 바이트 둘 이상을 합쳐서 16비트 이상의 정수를 만들 때는 가장 높은 자리의 바이트가 파일에서
먼저 나타난다. 이것을 빅엔디언(BigEndian) 순서라고 한다.
@!@^BigEndian order@>

@ \.{TFM} 파일의 나머지는 비공식적으로 다음과 같이 명세되는 자료 배열 열 개의 나열로 볼 수 있다.
$$\vbox{\halign{\hfil#&$\,:\,$#\hfil\cr
\ID{header}$[0\to\ID{lh}-1]$&\ID{stuff}\cr
\ID{charInfo}$[\ID{bc}\to\ID{ec}]$&\ID{charInfoWord}\cr
\ID{width}$[0\to\ID{nw}-1]$&\ID{fixWord}\cr
\ID{height}$[0\to\ID{nh}-1]$&\ID{fixWord}\cr
\ID{depth}$[0\to\ID{nd}-1]$&\ID{fixWord}\cr
\ID{italic}$[0\to\ID{ni}-1]$&\ID{fixWord}\cr
\ID{ligKern}$[0\to\ID{nl}-1]$&\ID{ligKernCommand}\cr
\ID{kern}$[0\to\ID{nk}-1]$&\ID{fixWord}\cr
\ID{exten}$[0\to\ID{ne}-1]$&\ID{extensibleRecipe}\cr
\ID{param}$[1\to\ID{np}]$&\ID{fixWord}\cr}}$$
여기서 쓰이는 가장 중요한 자료형은 \ID{fixWord}인데, 이것은 이진 분수의 32비트 표현이다. 이 자료형은 부호
있는 양으로서, 음수는 낱말 전체의 2의 보수로 나타낸다. 그 32비트 가운데 정확히 12비트가 이진 소수점의 왼쪽에
있다. 그러므로 가장 큰 \ID{fixWord} 값은 $2048-2^{-20}$이고 가장 작은 것은 $-2048$이다. 그러나 아래에서 보겠지만
\ID{fixWord} 값 가운데 둘을 빼고는 모두 $-16$과 $+16$ 사이에 있어야 한다.

@ 첫 자료 배열은 머리 정보의 덩어리로서, 글꼴에 관한 일반적인 사실들을 담는다. 머리에는 적어도 두 낱말
\ID{header}$[0]$과 \ID{header}$[1]$이 들어 있어야 하는데, 그 뜻은 아래에서 설명한다. 다른 소프트웨어 루틴에 쓸모
있는 머리 정보가 더 들어 있을 수도 있는데, \.{headerbyte} 명령이 나오면 \MF는 그런 정보도 만들어 낸다. 이를테면
제록스 팰로앨토 연구소에서는 머리 정보 16낱말을 더 쓴다. 처음 열 낱말은 쓰인 문자 코드 체계(이를테면
`\.{XEROX TEXT}'나 `\.{TEX MATHSY}')를, 다음 다섯 낱말은 글꼴 집안 이름(이를테면 `\.{HELVETICA}'나 `\.{CMSY}')을,
마지막 낱말은 ``얼굴 바이트''를 준다.

\yskip\hang 낱말 \ID{header}$[0]$은 32비트 검사합으로서, \MF는 이것을 \.{GF} 출력 파일에 베껴 넣는다. 이것은 파일들
사이의 일관성을 지키는 데 도움이 된다. \TeX은 자기가 읽은 \.{TFM}의 검사합을 기록해 두는데, 그것은 실제로 쓰이는
글꼴의 검사합과 맞아야 하기 때문이다. 이 검사합과 \.{TFM} 파일의 나머지 사이의 실제 관계는 중요하지 않다.
검사합은 호환되지 않는 글꼴들이 거의 언제나 서로 다른 검사합을 가진다는 성질을 지닌 식별 번호일 뿐이다.
@^check sum@>

\yskip\hang 낱말 \ID{header}$[1]$은 글꼴의 설계 크기를 \TeX\ 포인트 단위로 담은 \ID{fixWord}다. 이 수는 적어도
1.0이어야 한다. 꽤 임의적이지만, 대개 ``10포인트'' 글꼴, 곧 10포인트 크기에서 가장 보기 좋도록 설계된
글꼴(그것이 정말 무엇을 뜻하든)의 설계 크기는 10.0이다. \TeX\ 사용자가 글꼴을 `\.{at} $\delta$ \.{pt}'로
요구하면, 설계 크기를 $\delta$로 바꾸고 글꼴 이미지의 점들의 $x$와~$y$ 좌표에 $\delta$를 설계 크기로 나눈 인자를
곱하는 효과가 있다. {\sl \.{TFM} 파일의 다른 모든 치수는 설계 크기 단위의 \ID{fixWord}\kern-1pt\ 수다.} 그래서
이를테면 \.{em} 단위를 정의하는 \ID{param}$[6]$의 값은 흔히 \ID{fixWord} 값 $2^{20}=1.0$이다. 많은 글꼴의 설계
크기가 1\,em과 같기 때문이다. 다른 치수들은 절댓값이 설계 크기 단위로 16보다 작아야 한다. 그러므로
\ID{header}$[1]$과 \ID{param}$[1]$은 \.{TFM} 파일 전체에서 첫 바이트가 0이나 255가 아닐 수도 있는 유일한
\ID{fixWord} 항목이다.
@^design size@>

@ 다음에는 배열 \ID{charInfo}가 오는데, 여기에는 문자마다 \ID{charInfoWord} 하나가 들어 있다. 파일의 이 부분의 각
낱말에는 여섯 필드가 다음과 같이 네 바이트에 꾸려져 있다.

\yskip\hang 첫 바이트: \ID{widthIndex} (8비트)\par
\hang 둘째 바이트: \ID{heightIndex} (4비트) 곱하기 16, 더하기 \ID{depthIndex} (4~비트)\par
\hang 셋째 바이트: \ID{italicIndex} (6비트) 곱하기 4, 더하기 \ID{tag} (2~비트)\par
\hang 넷째 바이트: \ID{remainder} (8비트)\par
\yskip\noindent
문자의 실제 너비는 설계 크기 단위로 \ID{width}$[\ID{widthIndex}]$다. 이것은 정보를 압축하는 장치다. 많은 문자가
너비가 같기 때문이다. 많은 문자가 높이나 깊이나 기울임 보정이 같은 것도 흔하므로, \.{TFM} 형식은 서로 다른 높이
16개, 서로 다른 깊이 16개, 서로 다른 기울임 보정 64개로 제한한다.

덧붙여 말하면, 관계 $\ID{width}[0]=\ID{height}[0]=\ID{depth}[0]=\ID{italic}[0]=0$이 언제나 성립해야 한다. 그래야
첨자 0이 값 0을 뜻하게 된다. 첨자 \ID{widthIndex}는 문자가 글꼴에 없을 때 말고는 결코 0이면 안 된다. 문자는
|bc|와 |ec| 사이에 있고 \ID{widthIndex}가 0이 아닐 때, 그리고 오직 그때에만 올바르기 때문이다.

@ 낱말 \ID{charInfoWord}의 \ID{tag} 필드에는 \ID{remainder} 필드를 어떻게 해석할지 알려 주는 값이 넷 있다.

\def\hangg#1 {\hang\hbox{#1 }}
\yskip\hangg$\ID{tag}=0$ (|noTag|)은 \ID{remainder}를 쓰지 않는다는 뜻이다.\par
\hangg$\ID{tag}=1$ (|ligTag|)은 이 문자에 배열 |ligKern|의 위치 \ID{remainder}에서 시작하는 합자/커닝 프로그램이
있다는 뜻이다.\par
\hangg$\ID{tag}=2$ (|listTag|)은 이 문자가 크기가 커지는 문자들의 사슬의 일부이고, 그 사슬에서 가장 큰 것은
아니라는 뜻이다. 이때 \ID{remainder} 필드는 다음으로 큰 문자의 문자 코드를 준다.\par
\hangg$\ID{tag}=3$ (|extTag|)은 이 문자 코드가 늘일 수 있는 문자, 곧 작은 조각들로 쌓아 올려서 얼마든지 크게 만들
수 있는 문자를 나타낸다는 뜻이다. 그 조각들은 |exten|$[\ID{remainder}]$에 지정되어 있다.\par
\yskip\noindent
태그가 2나 3인 문자는 수식의 특별한 상황에서 쓰일 때 말고는 태그가 0인 문자로 다루어진다. 이를테면 \TeX의
\.{\\sum} 연산은 |listTag|를 찾고, \.{\\left} 연산은 |listTag|와 |extTag|를 둘 다 찾는다.

@<정의@>=
const (
	@!noTag = 0 // 평범한 문자
	@!ligTag = 1 // 합자/커닝 프로그램이 있는 문자
	@!listTag = 2 // 문자 목록에 후계자가 있는 문자
	@!extTag = 3 // 늘일 수 있는 문자
)

@ 배열 |ligKern|에는 특별한 글자 쌍에 대해 무엇을 할지 설명하는 간단한 프로그래밍 언어의 명령들이 들어 있다.
이 배열의 낱말은 저마다 네 바이트짜리 \ID{ligKernCommand}다.

\yskip\hang 첫 바이트: |skipByte|. 이 바이트가 128 이상이면 이것이 프로그램의 마지막 단계이고, 그렇지 않으면
그 수만큼의 사이에 있는 단계를 건너뛰어 다음 단계를 얻는다.\par
\hang 둘째 바이트: |nextChar|. ``|nextChar|가 현재 문자 다음에 오면 연산을 하고 멈추어라. 그렇지 않으면
계속하라.''\par
\hang 셋째 바이트: |opByte|. 128보다 작으면 합자 단계를, 그렇지 않으면 커닝 단계를 나타낸다.\par
\hang 넷째 바이트: \ID{remainder}.\par
\yskip\noindent
커닝 단계에서는 $\ID{kern}[256(\ID{opByte}-128)+\ID{remainder}]$와 같은 추가 간격이 현재 문자와 |nextChar| 사이에
들어간다. 이 양은 흔히 음수여서 문자들이 커닝으로 더 가까워지지만, 양수일 수도 있다.

합자 단계에는 여덟 가지가 있는데, |opByte| 코드는 $4a+2b+c$이고 $0\le a\le b+c$이며 $0\le b,c\le1$이다. 코드가
\ID{remainder}인 문자가 현재 문자와 |nextChar| 사이에 들어가고, $b=0$이면 현재 문자를 지우고 $c=0$이면
|nextChar|를 지운다. 그런 다음 $a$~개의 문자를 지나 다음 현재 문자(이것에도 자기 합자/커닝 프로그램이 있을 수
있다)에 이른다.

배열 |ligKern|의 맨 처음 명령의 |skipByte|가 255면 그 |nextChar| 바이트가 이른바 이 글꼴의 경계 문자다. 그 값은
|bc|와~|ec| 사이에 있지 않아도 된다. 배열 |ligKern|의 맨 마지막 명령의 |skipByte|가 255면, 왼쪽의 경계 문자를 위한
특별한 합자/커닝 프로그램이 위치 $256\cdot\ID{opByte}+\ID{remainder}$에서 시작한다. 이것은 \TeX이 같은 글꼴의
잇달린 문자열마다 그 앞뒤에 암묵적인 경계 문자를 놓는다는 뜻이다. 이 암묵적인 문자들은 출력에 나타나지 않지만
합자와 커닝에 영향을 줄 수 있다.

문자의 |ligKern| 프로그램의 맨 처음 명령의 |skipByte|가 128보다 크면, 그 프로그램은 실은 위치
$256\cdot\ID{opByte}+\ID{remainder}$에서 시작한다. 이 기능 덕분에 큰 |ligKern| 배열에도 접근할 수 있다. 그렇지
않으면 첫 명령은 255 이하인 위치에 나타나야 하기 때문이다.

배열 |ligKern|에서 |skipByte|가 128보다 큰 명령은 모두
$$256\cdot\ID{opByte}+\ID{remainder}<\ID{nl}$$
라는 조건을 만족해야 한다. 보통의 프로그램 실행 중에 그런 명령을 만나면 그것은 무조건 멈춤을 뜻한다. 합자나
커닝 명령은 수행되지 않는다.

\.{WEB} 매크로 \\{skip\_byte}, \\{next\_char} 따위는 첨자를 받아 배열 |ligKern|의 필드를 읽고 쓰는 함수 짝이 되었다.

@<정의@>=
const (
	@!stopFlag = 128 + minQuarterword // 합자/커닝 프로그램에서 `\.{STOP}'을 나타내는 값
	@!kernFlag = 128 + minQuarterword // 커닝 단계의 연산 코드
)

func skipByte(k int32) quarterword        { return ligKern[k].b0 }
func setSkipByte(k int32, v quarterword)  { ligKern[k].b0 = v }
func nextChar(k int32) quarterword        { return ligKern[k].b1 }
func setNextChar(k int32, v quarterword)  { ligKern[k].b1 = v }
func opByte(k int32) quarterword          { return ligKern[k].b2 }
func setOpByte(k int32, v quarterword)    { ligKern[k].b2 = v }
func remByte(k int32) quarterword         { return ligKern[k].b3 }
func setRemByte(k int32, v quarterword)   { ligKern[k].b3 = v }

@ 늘일 수 있는 문자는 \ID{extensibleRecipe}로 지정하는데, 이것은 \ID{top}, \ID{mid}, \ID{bot}, \ID{rep}라는 네
바이트로(이 순서로) 이루어진다. 이 바이트들은 큰 기호를 쌓아 올리는 데 쓰는 낱낱의 조각들의 문자 코드다.
조각 \ID{top}이나 \ID{mid}나 \ID{bot}이 0이면 그것은 쌓아 올린 결과에 나타나지 않는다. 이를테면 늘일 수 있는 세로
줄은 늘일 수 있는 대괄호와 같되, 위와 아래 조각이 없는 것이다.

기호 $T$, $M$, $B$, $R$로 저마다의 조각(조각이 없으면 빈 상자)을 나타내자. 그러면 늘일 수 있는 문자는 위에서
아래로 어떤 $k\ge0$에 대해 $TR^kMR^kB$의 꼴이다. 다만 $M$이 없으면 짝수와 홀수 $k$ 모두에 대해 $TR^kB$일 수
있다. 늘일 수 있는 문자의 너비는 $R$의 너비이고, 높이 더하기 깊이는 쓰인 구성 요소들의 높이 더하기 깊이의
합이다. 조각들이 세로 목록 안에서 맞붙여지기 때문이다.

@<정의@>=
func setExtTop(k int32, v quarterword) { exten[k].b0 = v } // 조립법의 \ID{top} 조각
func setExtMid(k int32, v quarterword) { exten[k].b1 = v } // 조립법의 \ID{mid} 조각
func setExtBot(k int32, v quarterword) { exten[k].b2 = v } // 조립법의 \ID{bot} 조각
func setExtRep(k int32, v quarterword) { exten[k].b3 = v } // 조립법의 \ID{rep} 조각

@ \.{TFM} 파일의 마지막 부분은 배열 |param|인데, 이것도 \ID{fixWord} 값의 나열이다.

\yskip\hang 매개변수 \ID{param}$[1]=\ID{slant}$는 기울기의 양으로서, 악센트의 위치를 정하는 데 쓰인다. 이를테면
$\ID{slant}=.25$는 한 단위 위로 올라가면 오른쪽으로도 .25단위 간다는 뜻이다. 이 값은 순수한 수다. 설계 크기
자체 말고는 설계 크기로 눈금이 매겨지지 않는 유일한 \ID{fixWord}다.
@^design size@>

\hang 매개변수 \ID{param}$[2]=\ID{space}$는 텍스트의 낱말 사이의 보통 간격이다. 글꼴의 문자 |0o40|은 공백과 아무 관계가
없어도 된다는 데 주목하라.

\hang 매개변수 \ID{param}$[3]=\ID{spaceStretch}$는 낱말 사이 글루의 늘어남의 양이다.

\hang 매개변수 \ID{param}$[4]=\ID{spaceShrink}$는 낱말 사이 글루의 줄어듦의 양이다.

\hang 매개변수 \ID{param}$[5]=\ID{xHeight}$는 그 글꼴의 1\,ex의 크기다. 이것은 악센트를 올리거나 내리지 않아도 되는
글자들의 높이이기도 하다.

\hang 매개변수 \ID{param}$[6]=\ID{quad}$는 그 글꼴의 1\,em의 크기다.

\hang 매개변수 \ID{param}$[7]=\ID{extraSpace}$는 문장 끝에서 \ID{param}$[2]$에 더하는 양이다.

\yskip\noindent
매개변수가 일곱 개보다 적으면 \TeX은 빠진 매개변수들을 0으로 놓는다. 원본은 여기서 일곱 매개변수의 번호에
\\{slant\_code}부터 \\{extra\_space\_code}까지 이름을 붙여 두었지만, \MF의 코드는 그 이름들을 한 번도 쓰지 않으므로
옮기지 않았다.

@ \.{TFM} 파일에 담긴 것은 이와 같다. \MF의 임무 하나는 그런 정보를 내놓는 것인데, 작업이 끝날 때 한꺼번에 한다.
그 광란의 활동을 준비하려고, 정보가 생기는 대로 필요한 사실들을 여러 배열에 쟁여 둔다.

문자 치수(\KW{charwd}, \KW{charht}, \KW{chardp}, \KW{charic})는 저마다 |tfmWidth|, |tfmHeight|, |tfmDepth|,
|tfmItalCorr|에 저장한다. 문자에 관한 다른 정보(이를테면 합자나 후계자에 관한 것)는 배열 |charTag|와
|charRemainder|로 접근한다. 글꼴 전체에 관한 다른 정보는 |headerByte|, |ligKern|, |kern|, |exten|, |param|이라는
배열들에 둔다.

@<정의@>=
const @!undefinedLabel = ligTableSize // 정의되지 않은 지역 레이블

@ @<전역 변수@>=
var @!bc, @!ec eightBits // 내보낸 가장 작은 문자 코드와 가장 큰 문자 코드
var @!tfmWidth [256]scaled // \KW{charwd} 값
var @!tfmHeight [256]scaled // \KW{charht} 값
var @!tfmDepth [256]scaled // \KW{chardp} 값
var @!tfmItalCorr [256]scaled // \KW{charic} 값
var @!charExists [256]bool // 이 코드를 내보냈나?
var @!charTag [256]int32 // \ID{remainder}의 범주; |noTag .. extTag|
var @!charRemainder [256]int32 // \ID{remainder} 바이트; |0 .. ligTableSize|
var @!headerByte [headerSize + 1]int32 // \.{TFM} 머리의 바이트, 놓지 않았으면 $-1$; 첨자는 |1 .. headerSize|
var @!ligKern [ligTableSize + 1]fourQuarters // 합자/커닝 표
var @!nl int32 // 지금까지의 합자/커닝 단계 수; |0 .. 32767-256|
var @!kern [maxKerns + 1]scaled // 서로 다른 커닝 양
var @!nk int32 // 지금까지의 서로 다른 커닝 양의 수; |0 .. maxKerns|
var @!exten [256]fourQuarters // 늘일 수 있는 문자의 조립법
var @!ne int32 // 지금까지의 늘일 수 있는 문자의 수; |0 .. 256|
var @!param [maxFontDimen + 1]scaled // \KW{fontdimen} 매개변수; 첨자는 |1 .. maxFontDimen|
var @!np int32 // 지금까지 지정한 가장 큰 \KW{fontdimen} 매개변수; |0 .. maxFontDimen|
var @!nw, @!nh, @!nd, @!ni int32 // \.{TFM} 부분표의 크기; |0 .. 256|
var @!skipTable [256]int32 // 지역 레이블의 상태; |0 .. ligTableSize|
var @!lkStarted bool // 이 명령에서 합자/커닝 단계가 이미 있었나?
var @!bchar int32 // 오른쪽 경계 문자
var @!bchLabel int32 // 왼쪽 경계의 시작 위치; |0 .. ligTableSize|
var @!ll, @!lll int32 // 합자/커닝 처리에 쓰는 레지스터; |0 .. ligTableSize|
var @!labelLoc [257]int32 // 합자/커닝 시작 주소; |-1 .. ligTableSize|
var @!labelChar [257]eightBits // |labelLoc|의 문자; 첨자는 |1 .. 256|
var @!labelPtr int32 // |labelLoc|에서 차지한 가장 높은 위치; |0 .. 256|

@ @<핵심 변수들의...@>=
for k = 0; k <= 255; k++ {
	tfmWidth[k] = 0
	tfmHeight[k] = 0
	tfmDepth[k] = 0
	tfmItalCorr[k] = 0
	charExists[k] = false
	charTag[k] = noTag
	charRemainder[k] = 0
	skipTable[k] = undefinedLabel
}
for k = 1; k <= headerSize; k++ {
	headerByte[k] = -1
}
bc = 255
ec = 0
nl = 0
nk = 0
ne = 0
np = 0
internal[boundaryChar] = -unity
bchLabel = undefinedLabel
labelLoc[0] = -1
labelPtr = 0

@ 문자 치수는 $2048\,\rm pt$보다 작아야 한다. 그보다 크면 \.{TFM}의 \ID{fixWord}로 나타낼 수 없기 때문이다.

@<함수들@>=
func tfmCheck(m smallNumber) scaled {
	if abs(internal[m]) >= fractionHalf {
		printErr("Enormous ")
		printStr(intName[m])
@.Enormous charwd...@>
@.Enormous chardp...@>
@.Enormous charht...@>
@.Enormous charic...@>
@.Enormous designsize...@>
		printStr(" has been reduced")
		help1("Font metric dimensions must be less than 2048pt.")
		putGetError()
		if internal[m] > 0 {
			return fractionHalf - 1
		}
		return 1 - fractionHalf
	}
	return internal[m]
}

@ @<문자 코드~|c|의 너비 정보를...@>=
if c < bc {
	bc = c
}
if c > ec {
	ec = c
}
charExists[c] = true
gfDx[c] = internal[charDx]
gfDy[c] = internal[charDy]
tfmWidth[c] = tfmCheck(charWd)
tfmHeight[c] = tfmCheck(charHt)
tfmDepth[c] = tfmCheck(charDp)
tfmItalCorr[c] = tfmCheck(charIc)

@ 이제 \MF의 \.{TFM}을 위한 특별한 명령들을 살펴보자.

@<특정한 명령을 부르는...@>=
case tfmCommand:
	doTfmCommand()

@ @<정의@>=
const (
	@!charListCode = iota
	@!ligTableCode
	@!extensibleCode
	@!headerByteCode
	@!fontDimenCode
)

@ @<\MF의 원시 명령을...@>=
primitive("charlist", tfmCommand, charListCode)
@!@:char_list_}{\KW{charlist} primitive@>
primitive("ligtable", tfmCommand, ligTableCode)
@!@:lig_table_}{\KW{ligtable} primitive@>
primitive("extensible", tfmCommand, extensibleCode)
@!@:extensible_}{\KW{extensible} primitive@>
primitive("headerbyte", tfmCommand, headerByteCode)
@!@:header_byte_}{\KW{headerbyte} primitive@>
primitive("fontdimen", tfmCommand, fontDimenCode)
@!@:font_dimen_}{\KW{fontdimen} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case tfmCommand:
	switch m {
	case charListCode:
		printStr("charlist")
	case ligTableCode:
		printStr("ligtable")
	case extensibleCode:
		printStr("extensible")
	case headerByteCode:
		printStr("headerbyte")
	default:
		printStr("fontdimen")
	}

@ 문자 코드는 0에서 255 사이의 수로 줄 수도 있고 길이가 1인 문자열로 줄 수도 있다. 원본의 |found| 레이블은 성공한
두 경우에서 곧바로 |return|하는 것으로 바뀌었다.

@<함수들@>=
func getCode() eightBits { // 문자 코드 값을 훑는다
	var c int32 // 찾은 코드 값
	getXNext()
	scanExpression()
	if curType == known {
		c = roundUnscaled(curExp)
		if c >= 0 && c < 256 {
			return c
		}
	} else if curType == stringType && length(curExp) == 1 {
		return int32(strPool[strStart[curExp]])
	}
	expErr("Invalid code has been replaced by 0")
@.Invalid code...@>
	help2("I was looking for a number between 0 and 255, or for a",
		"string of length 1. Didn't find it; will use 0 instead.")
	putGetFlushError(0)
	return 0
}

@ @<함수들@>=
func setTag(c halfword, t smallNumber, r halfword) {
	if charTag[c] == noTag {
		charTag[c] = t
		charRemainder[c] = r
		if t == ligTag {
			labelPtr++
			labelLoc[labelPtr] = r
			labelChar[labelPtr] = c
		}
	} else {
		@<문자 태그가 부딪친다고 불평한다@>
	}
}

@ 원본은 여기서 |c=256|인 경우(경계 문자)도 다루지만, |setTag|가 그런 |c|로 불리는 일은 없다. 경계 문자의 레이블은
|setTag|를 거치지 않고 |bchLabel|에 바로 기록되기 때문이다. 그러니 그 갈래는 죽은 코드인데, 그대로 옮겨 두었다.
(게다가 \GO/에서는 |setTag| 첫머리에서 |charTag[256]|을 읽다가 첨자 범위를 벗어나 멈출 테니, 그 갈래에는 이를 수조차 없다.)

@<문자 태그가 부딪친다고...@>=
printErr("Character ")
if c > ' ' && c < 127 {
	printStr(c)
} else if c == 256 {
	printStr("||")
} else {
	printStr("code ")
	printInt(c)
}
printStr(" is already ")
@.Character c is already...@>
switch charTag[c] {
case ligTag:
	printStr("in a ligtable")
case listTag:
	printStr("in a charlist")
case extTag:
	printStr("extensible")
} // 다른 경우는 없다
help2("It's not legal to label a character more than once.",
	"So I'll not change anything just now.")
putGetError()

@ @<함수들@>=
func doTfmCommand() {
	var c, cc int32 // 문자 코드; |0 .. 256|
	var k int32 // 배열 |kern|의 첨자; |0 .. maxKerns|
	var j int32 // |headerByte|나 |param|의 첨자
	switch curMod {
	case charListCode:
		c = getCode() // 문자 후계자의 목록을 저장할 것이다
		for curCmd == colon {
			cc = getCode()
			setTag(c, listTag, cc)
			c = cc
		}
	case ligTableCode:
		@<합자/커닝 단계의 목록을 저장한다@>
	case extensibleCode:
		@<늘일 수 있는 문자의 조립법을 정의한다@>
	case headerByteCode, fontDimenCode:
		c = curMod
		getXNext()
		scanExpression()
		if curType != known || curExp < halfUnit {
			expErr("Improper location")
@.Improper location@>
			help2("I was looking for a known, positive number.",
				"For safety's sake I'll ignore the present command.")
			putGetError()
		} else {
			j = roundUnscaled(curExp)
			if curCmd != colon {
				missingErr(":")
@.Missing `:'@>
				help1("A colon should follow a headerbyte or fontdimen location.")
				backError()
			}
			if c == headerByteCode {
				@<머리 바이트의 목록을 저장한다@>
			} else {
				@<글꼴 치수의 목록을 저장한다@>
			}
		}
	} // 다른 경우는 없다
}

@ 원본의 레이블 |continue|와 |done|은 레이블 붙은 반복문 |nextStep|의 |continue|와 |break|가 되었다. 반복문이 그냥
끝나는 경우(쉼표가 더 없을 때)에만 마지막 단계에 멈춤 표시를 붙여야 하므로, 그 일을 반복문 안의 |break| 바로 앞에
두었다. \KW{skipto}를 처리하고 빠져나가는 경우에는 멈춤 표시를 붙이지 않는다.

@<합자/커닝 단계의 목록을...@>=
lkStarted = false
nextStep:
for {
	getXNext()
	if curCmd == skipTo && lkStarted {
		@<|skipTo| 명령을 처리하고 |break nextStep|@>
	}
	if curCmd == bcharLabel {
		c = 256
		curCmd = colon
	} else {
		backInput()
		c = getCode()
	}
	if curCmd == colon || curCmd == doubleColon {
		@<합자/커닝 부프로그램에 레이블을 기록하고 |continue nextStep|@>
	}
	if curCmd == ligKernToken {
		@<합자/커닝 명령을 번역한다@>
	} else {
		printErr("Illegal ligtable step")
@.Illegal ligtable step@>
		help1("I was looking for `=:' or `kern' here.")
		backError()
		setNextChar(nl, qi(0))
		setOpByte(nl, qi(0))
		setRemByte(nl, qi(0))
		setSkipByte(nl, stopFlag+1) // 이것은 무조건 멈춤을 지정한다
	}
	if nl == ligTableSize {
		overflow("ligtable size", ligTableSize)
	}
@:METAFONT capacity exceeded ligtable size}{\quad ligtable size@>
	nl++
	if curCmd == comma {
		continue
	}
	if skipByte(nl-1) < stopFlag {
		setSkipByte(nl-1, stopFlag)
	}
	break
}

@ @<\MF의 원시 명령을...@>=
primitive("=:", ligKernToken, 0)
@!@:=:_}{\.{=:} primitive@>
primitive("=:|", ligKernToken, 1)
@!@:=:/_}{\.{=:\char'174} primitive@>
primitive("=:|>", ligKernToken, 5)
@!@:=:/>_}{\.{=:\char'174>} primitive@>
primitive("|=:", ligKernToken, 2)
@!@:=:/_}{\.{\char'174=:} primitive@>
primitive("|=:>", ligKernToken, 6)
@!@:=:/>_}{\.{\char'174=:>} primitive@>
primitive("|=:|", ligKernToken, 3)
@!@:=:/_}{\.{\char'174=:\char'174} primitive@>
primitive("|=:|>", ligKernToken, 7)
@!@:=:/>_}{\.{\char'174=:\char'174>} primitive@>
primitive("|=:|>>", ligKernToken, 11)
@!@:=:/>_}{\.{\char'174=:\char'174>>} primitive@>
primitive("kern", ligKernToken, 128)
@!@:kern_}{\KW{kern} primitive@>

@ @<|printCmdMod|에서 원시 명령을...@>=
case ligKernToken:
	switch m {
	case 0:
		printStr("=:")
	case 1:
		printStr("=:|")
	case 2:
		printStr("|=:")
	case 3:
		printStr("|=:|")
	case 5:
		printStr("=:|>")
	case 6:
		printStr("|=:>")
	case 7:
		printStr("|=:|>")
	case 11:
		printStr("|=:|>>")
	default:
		printStr("kern")
	}

@ 지역 레이블은 배열 |skipTable|을 유지하여 구현한다. 항목 |skipTable[c]|는 |undefinedLabel|이거나, 지역 레이블~|c|로
건너뛰는 가장 최근의 합자/커닝 명령의 주소다. 뒤의 경우 그 명령의 |skipByte|는 이 레이블로 앞서 건너뛴 적이 없으면
(잠정적으로) 0이고, 그렇지 않으면 앞선 건너뛰기까지의 거리다. 곧 아직 풀리지 않은 건너뛰기들은 |skipByte|를 연결
고리로 삼은 사슬을 이룬다.

127개보다 많은 합자/커닝 단계를 건너뛰는 건너뛰기는 취소해야 할 수도 있다. \.{WEB} 매크로 \\{cancel\_skips}와
\\{skip\_error}는 함수 |cancelSkips|와 |skipError|가 되었다.

@<함수들@>=
func cancelSkips(k int32) { // 위치 |k|에서 끝나는 건너뛰기 사슬을 멈춤으로 바꾼다
	ll = k
	for {
		lll = qo(skipByte(ll))
		setSkipByte(ll, stopFlag)
		ll = ll - lll
		if lll == 0 {
			break
		}
	}
}

func skipError(k int32) {
	printErr("Too far to skip")
@.Too far to skip@>
	help1("At most 127 lig/kern steps can separate skipto1 from 1::.")
	reportError()
	cancelSkips(k)
}

@ @<|skipTo| 명령을 처리하고...@>=
c = getCode()
if nl-skipTable[c] > 128 {
	skipError(skipTable[c])
	skipTable[c] = undefinedLabel
}
if skipTable[c] == undefinedLabel {
	setSkipByte(nl-1, qi(0))
} else {
	setSkipByte(nl-1, qi(nl-skipTable[c]-1))
}
skipTable[c] = nl - 1
break nextStep

@ @<합자/커닝 부프로그램에 레이블을...@>=
if curCmd == colon {
	if c == 256 {
		bchLabel = nl
	} else {
		setTag(c, ligTag, nl)
	}
} else if skipTable[c] < undefinedLabel {
	ll = skipTable[c]
	skipTable[c] = undefinedLabel
	for {
		lll = qo(skipByte(ll))
		if nl-ll > 128 {
			skipError(ll)
			continue nextStep
		}
		setSkipByte(ll, qi(nl-ll-1))
		ll = ll - lll
		if lll == 0 {
			break
		}
	}
}
continue nextStep

@ @<합자/커닝 명령을...@>=
setNextChar(nl, qi(c))
setSkipByte(nl, qi(0))
if curMod < 128 { // 합자 연산
	setOpByte(nl, qi(curMod))
	setRemByte(nl, qi(getCode()))
} else {
	getXNext()
	scanExpression()
	if curType != known {
		expErr("Improper kern")
@.Improper kern@>
		help2("The amount of kern should be a known numeric value.",
			"I'm zeroing this one. Proceed, with fingers crossed.")
		putGetFlushError(0)
	}
	kern[nk] = curExp
	k = 0
	for kern[k] != curExp {
		k++
	}
	if k == nk {
		if nk == maxKerns {
			overflow("kern", maxKerns)
		}
@:METAFONT capacity exceeded kern}{\quad kern@>
		nk++
	}
	setOpByte(nl, kernFlag+(k/256))
	setRemByte(nl, qi(k%256))
}
lkStarted = true

@ 원본의 매크로 \\{missing\_extensible\_punctuation}은 여기서만 쓰이므로 지역 클로저 |missingPunct|로 옮겼다.

@<늘일 수 있는 문자의 조립법을...@>=
missingPunct := func(s string) {
	missingErr(s)
@.Missing `\char`\#'@>
	help1("I'm processing `extensible c: t,m,b,r'.")
	backError()
}
if ne == 256 {
	overflow("extensible", 256)
}
@:METAFONT capacity exceeded extensible}{\quad extensible@>
c = getCode()
setTag(c, extTag, ne)
if curCmd != colon {
	missingPunct(":")
}
setExtTop(ne, qi(getCode()))
if curCmd != comma {
	missingPunct(",")
}
setExtMid(ne, qi(getCode()))
if curCmd != comma {
	missingPunct(",")
}
setExtBot(ne, qi(getCode()))
if curCmd != comma {
	missingPunct(",")
}
setExtRep(ne, qi(getCode()))
ne++

@ @<머리 바이트의 목록을...@>=
for {
	if j > headerSize {
		overflow("headerbyte", headerSize)
	}
@:METAFONT capacity exceeded headerbyte}{\quad headerbyte@>
	headerByte[j] = getCode()
	j++
	if curCmd != comma {
		break
	}
}

@ @<글꼴 치수의 목록을...@>=
for {
	if j > maxFontDimen {
		overflow("fontdimen", maxFontDimen)
	}
@:METAFONT capacity exceeded fontdimen}{\quad fontdimen@>
	for j > np {
		np++
		param[np] = 0
	}
	getXNext()
	scanExpression()
	if curType != known {
		expErr("Improper font parameter")
@.Improper font parameter@>
		help1("I'm zeroing this one. Proceed, with fingers crossed.")
		putGetFlushError(0)
	}
	param[j] = curExp
	j++
	if curCmd != comma {
		break
	}
}

@ 좋다. \.{TFM} 파일에 필요한 자료를 모두 저장했다. 남은 일은 그것을 올바른 형식으로 내보내는 것뿐이다.

여기에 얽힌 재미있는 문제가 하나 있다. \.{TFM} 형식에는 너비가 많아야 256개, 높이 16개, 깊이 16개, 기울임 보정
64개만 들어갈 수 있다. 자료에 이보다 많은 서로 다른 값이 있으면, 주어진 값을 되도록 적게 흔들어서 필요한 제한을
맞추고 싶다.

\MF는 이 문제를 두 단계로 푼다. 먼저 한 종류(너비, 높이, 깊이, 기울임 보정)의 값들을 정렬하고, 그다음 필요하면
정렬한 값의 목록을 흔든다.

정렬 연산은 현재 목록의 끝에 사실상 무한한 |value|를 가진 특별한 노드를 두면 쉬워진다.

@<표의 항목들을...@>=
setValue(infVal, fractionFour)

@ 목록이 대개 아주 길지는 않으므로 곧은 선형 삽입으로 정렬하면 충분하다. 자료를 다루는 동안 현재 목록은
|link(tempHead)|에서 시작해서 |infVal|에서 끝난다. 이 목록의 노드들은 |value| 필드가 늘어나는 차례로 놓인다.

그런 목록이 주어지면 함수 |sortIn|은 값을 받아서 그 값이 목록의 어디에 있는지 가리키는 포인터를 돌려준다. 필요하면
값을 알맞은 자리에 끼워 넣는다.

이 연산이 필요할 때쯤이면 \MF의 일은 대부분 끝났으므로 가지고 놀 메모리가 넉넉하다. 정렬을 위해 할당한 값 노드는
결코 빈 저장소로 돌려주지 않는다.

@<함수들@>=
func clearTheList() { setLink(tempHead, infVal) }

func sortIn(v scaled) pointer {
	var p, q, r pointer // 목록 조작 레지스터
	p = tempHead
	for {
		q = link(p)
		if v <= value(q) {
			break
		}
		p = q
	}
	if v < value(q) {
		r = getNode(valueNodeSize)
		setValue(r, v)
		setLink(r, q)
		setLink(p, r)
	}
	return link(p)
}

@ 이제 재미있는 부분, 곧 목록이 필요한 크기가 될 때까지 줄이는 부분에 이르렀다. 이 과정의 바탕은 루틴 |minCover|다.
이것은 현재의 정렬된 목록의 값들을 너비가~|d|인 구간 |m|개로 덮을 수 있는 가장 작은 수~|m|을 계산한다. 또 전역
변수 |perturbation|을, 이 알고리즘이 찾은 덮개가 달라질 가장 작은 값 $d'>d$로 놓는다.

특히 |minCover(0)|은 현재 목록에 있는 서로 다른 값의 수를 돌려주고, |perturbation|을 이웃한 값 사이의 가장 작은
거리로 놓는다.

덮개는 탐욕적으로 찾는다. 아직 덮이지 않은 가장 작은 값 $l$에서 구간 $[l,l+d]$를 시작하고, 그 구간에 드는 값을
모두 건너뛴 다음 같은 일을 되풀이한다. 정렬된 점들을 고정된 너비의 구간으로 덮는 문제에서는 이 탐욕법이 최적이다.

@<함수들@>=
func minCover(d scaled) int32 {
	var p pointer // 현재 목록을 훑는다
	var l scaled // 현재 구간이 덮는 가장 작은 원소
	var m int32 // 가장 작은 덮개의 크기의 아래 경계
	m = 0
	p = link(tempHead)
	perturbation = elGordo
	for p != infVal {
		m++
		l = value(p)
		for {
			p = link(p)
			if value(p) > l+d {
				break
			}
		}
		if value(p)-l < perturbation {
			perturbation = value(p) - l
		}
	}
	return m
}

@ @<전역 변수@>=
var @!perturbation scaled // \.{TFM} 반올림에 관련된 양
var @!excess int32 // 목록이 이만큼 너무 길다

@ 주어진 목록을 구간 |m|개로 덮을 수 있는 가장 작은 |d|는 루틴 |threshold|가 정한다. 이것은 |minCover|의 일종의
역이다. 먼저 구간 크기를 빠르게 (두 배씩) 늘려서 범위를 찾은 다음, 정확한 경계선을 찾을 때까지 차례로 나아간다.

함수 |minCover(d)|가 |perturbation|으로 돌려주는 값은 덮개가 바뀌는 다음 문턱이므로, |d|를 그 값으로 옮기는 것은 결과가
달라질 수 있는 바로 다음 후보로 건너뛰는 것이다. 그래서 두 번째 반복문은 후보를 하나도 빠뜨리지 않는다.

@<함수들@>=
func threshold(m int32) scaled {
	var d scaled // 가장 작은 구간 크기의 아래 경계
	excess = minCover(0) - m
	if excess <= 0 {
		return 0
	}
	for {
		d = perturbation
		if minCover(d+d) <= m {
			break
		}
	}
	for minCover(d) > m {
		d = perturbation
	}
	return d
}

@ 프로시저 |skimp|는 필요하면 값을 바꾸어 현재 목록을 많아야 |m|개의 항목으로 줄인다. 또 |value(p)|가 결과 목록의
|k|번째 서로 다른 값이면 |info(p):=k|로 놓고, |perturbation|을 어느 |value| 필드가 바뀐 가장 큰 양으로 놓는다. 결과
목록의 크기를 |skimp|의 값으로 돌려준다.

아래 그림은 값 아홉 개를 넷으로 줄이는 예다. 너비가~|d|인 구간마다 그 안의 값들을 구간에 든 가장 작은 값과 가장 큰
값의 한가운데로 옮긴다. 합친 값의 수가 넘치는 만큼(|excess|)이 되면 |d|를 0으로 놓아 더는 합치지 않으므로, 필요한
것보다 많이 흔들지 않는다.

$$\mplibcode
beginfig(25);
save u, d, ya, yb; numeric u, d, ya, yb; u := 60pt; d := .6; ya := 0; yb := -.6u;
draw (-.1u,ya) -- (5.2u,ya) withcolor .6white;
draw (-.1u,yb) -- (5.2u,yb) withcolor .6white;
for v = 0, .4, .5, 1.6, 2.0, 2.2, 3.5, 4.4, 4.6: dot((v*u,ya)); endfor
for l = 0, 1.6, 3.5, 4.4:
  draw (l*u, ya-5pt) -- (l*u, ya-8pt) -- ((l+d)*u, ya-8pt) -- ((l+d)*u, ya-5pt) withpen pencircle scaled .4pt;
endfor
for v = .25, 1.9, 3.5, 4.5: dot((v*u,yb)); endfor
drawarrow (.3u, ya-9pt) -- (.25u, yb+4pt) withpen pencircle scaled .3pt withcolor .4white;
drawarrow (1.9u, ya-9pt) -- (1.9u, yb+4pt) withpen pencircle scaled .3pt withcolor .4white;
drawarrow (3.8u, ya-9pt) -- (3.5u, yb+4pt) withpen pencircle scaled .3pt withcolor .4white;
drawarrow (4.7u, ya-9pt) -- (4.5u, yb+4pt) withpen pencircle scaled .3pt withcolor .4white;
label.rt(btex $d$ etex, (5.0u, ya-6.5pt));
label.lft(btex 원래 값 etex, (-.1u,ya));
label.lft(btex 바꾼 값 etex, (-.1u,yb));
endfig;
\endmplibcode$$

@<함수들@>=
func skimp(m int32) int32 {
	var d scaled // 합치는 구간의 크기
	var p, q, r pointer // 목록 조작 레지스터
	var l scaled // 현재 구간의 가장 작은 값
	var v scaled // 절충한 값
	d = threshold(m)
	perturbation = 0
	q = tempHead
	m = 0
	p = link(tempHead)
	for p != infVal {
		m++
		l = value(p)
		setInfo(p, m)
		if value(link(p)) <= l+d {
			@<값의 구간을 그 가운데 점으로 바꾼다@>
		}
		q = p
		p = link(p)
	}
	return m
}

@ @<값의 구간을...@>=
for {
	p = link(p)
	setInfo(p, m)
	excess--
	if excess == 0 {
		d = 0
	}
	if value(link(p)) > l+d {
		break
	}
}
v = l + half(value(p)-l)
if value(p)-v > perturbation {
	perturbation = value(p) - v
}
r = q
for {
	r = link(r)
	setValue(r, v)
	if r == p {
		break
	}
}
setLink(q, p) // 현재 목록에서 겹치는 값을 없앤다

@ 무언가를 $1/16$\thinspace pt보다 많이 흔들 때마다 경고 메시지를 낸다.

@<함수들@>=
func tfmWarning(m smallNumber) {
	printNl("(some ")
	printStr(intName[m])
@.some charwds...@>
@.some chardps...@>
@.some charhts...@>
@.some charics...@>
	printStr(" values had to be adjusted by as much as ")
	printScaled(perturbation)
	printStr("pt)")
}

@ 다음은 이 루틴들을 쓰는 방법의 한 예다. 너비 자료는 서로 다른 너비가 256개일 때에만 흔들면 되는데, 아주 드문
경우이지만 \MF는 이 경우를 검사해야 한다.

이 코드를 쓸 때 정수 변수 |k|가 정의되어 있을 것이다. 배열 |dimenHead|에는 정렬된 치수 목록을 가리키는 포인터가
들어 있게 된다. 정렬하고 나면 |tfmWidth[k]| 따위에는 치수 자체가 아니라 그 치수를 담은 목록 노드의 포인터가
들어간다. 그 노드의 |info| 필드가 \.{TFM}에 쓸 첨자다.

@<\.{TFM} 너비를 다듬는다@>=
clearTheList()
for k = bc; k <= ec; k++ {
	if charExists[k] {
		tfmWidth[k] = sortIn(tfmWidth[k])
	}
}
nw = skimp(255) + 1
dimenHead[1] = link(tempHead)
if perturbation >= 0o10000 {
	tfmWarning(charWd)
}

@ @<전역 변수@>=
var @!dimenHead [5]pointer // \.{TFM} 치수의 목록; 첨자는 |1 .. 4|

@ 높이와 깊이와 기울임 보정은 목록 길이가 더 엄하게 제한된다는 점뿐 아니라, 0인 값을 목록에 넣지 않아도 된다는
점에서도 너비와 다르다.

@<\.{TFM} 높이, 깊이, 기울임 보정을 다듬는다@>=
clearTheList()
for k = bc; k <= ec; k++ {
	if charExists[k] {
		if tfmHeight[k] == 0 {
			tfmHeight[k] = zeroVal
		} else {
			tfmHeight[k] = sortIn(tfmHeight[k])
		}
	}
}
nh = skimp(15) + 1
dimenHead[2] = link(tempHead)
if perturbation >= 0o10000 {
	tfmWarning(charHt)
}
@<\.{TFM} 깊이를 다듬는다@>
@<\.{TFM} 기울임 보정을 다듬는다@>

@ 깊이와 기울임 보정도 높이와 똑같이 다룬다. 다만 기울임 보정은 64개까지 둘 수 있다.

@<\.{TFM} 깊이를 다듬는다@>=
clearTheList()
for k = bc; k <= ec; k++ {
	if charExists[k] {
		if tfmDepth[k] == 0 {
			tfmDepth[k] = zeroVal
		} else {
			tfmDepth[k] = sortIn(tfmDepth[k])
		}
	}
}
nd = skimp(15) + 1
dimenHead[3] = link(tempHead)
if perturbation >= 0o10000 {
	tfmWarning(charDp)
}

@ @<\.{TFM} 기울임 보정을 다듬는다@>=
clearTheList()
for k = bc; k <= ec; k++ {
	if charExists[k] {
		if tfmItalCorr[k] == 0 {
			tfmItalCorr[k] = zeroVal
		} else {
			tfmItalCorr[k] = sortIn(tfmItalCorr[k])
		}
	}
}
ni = skimp(63) + 1
dimenHead[4] = link(tempHead)
if perturbation >= 0o10000 {
	tfmWarning(charIc)
}

@ @<표의 항목들을...@>=
setValue(zeroVal, 0)
setInfo(zeroVal, 0)

@ 머리의 바이트 5--8은 사용자가 무언가 엉뚱한 까닭으로 다르게 지정하지 않는 한 설계 크기로 놓는다.
@^design size@>

이 프로시저를 부를 때는 오류 메시지를 낼 수 없으므로 대신 경고를 찍는다.

값 |maxTfmDimen|은
$$\hbox{|makeScaled(16*maxTfmDimen,internal[designSize])|} < \\{three\_bytes}$$
가 되도록 계산한다.

@<정의@>=
const @!threeBytes = 0o100000000 // $2^{24}$

@ @<함수들@>=
func fixDesignSize() {
	var d scaled // 설계 크기
	d = internal[designSize]
	if d < unity || d >= fractionHalf {
		if d != 0 {
			printNl("(illegal design size has been changed to 128pt)")
		}
@.illegal design size...@>
		d = 0o40000000
		internal[designSize] = d
	}
	if headerByte[5] < 0 && headerByte[6] < 0 && headerByte[7] < 0 && headerByte[8] < 0 {
		headerByte[5] = d / 0o4000000
		headerByte[6] = (d / 4096) % 256
		headerByte[7] = (d / 16) % 256
		headerByte[8] = (d % 16) * 16
	}
	maxTfmDimen = 16*internal[designSize] - 1 - internal[designSize]/0o10000000
	if maxTfmDimen >= fractionHalf {
		maxTfmDimen = fractionHalf - 1
	}
}

@ 프로시저 |dimenOut|은 설계 크기에 대한 상대값으로 \ID{fixWord}를 계산한다. 자료가 범위를 벗어났으면 바로잡고 전역
변수 |tfmChanged|를 하나 늘린다.

@<함수들@>=
func dimenOut(x scaled) int32 {
	if abs(x) > maxTfmDimen {
		tfmChanged++
		if x > 0 {
			x = maxTfmDimen
		} else {
			x = -maxTfmDimen
		}
	}
	x = makeScaled(x*16, internal[designSize])
	return x
}

@ @<전역 변수@>=
var @!maxTfmDimen scaled // 너비, 높이, 커닝 따위의 경계
var @!tfmChanged int32 // 경계를 벗어난 자료 항목의 수

@ 사용자가 머리의 처음 네 바이트를 하나도 지정하지 않았으면, 프로시저 |fixCheckSum|은 그것들을 설계 크기에 대한
|tfmWidth| 자료에서 계산한 ``검사합''으로 바꾼다.
@^check sum@>

@<함수들@>=
func fixCheckSum() {
	var k eightBits // 문자 코드를 훑는다
	var b1, b2, b3, b4 eightBits // 검사합의 바이트
	var x int32 // 검사합 계산에 쓰는 해시 값
	if headerByte[1] < 0 && headerByte[2] < 0 && headerByte[3] < 0 && headerByte[4] < 0 {
		@<검사합을 |(b1,b2,b3,b4)|에 계산한다@>
		headerByte[1] = b1
		headerByte[2] = b2
		headerByte[3] = b3
		headerByte[4] = b4
		return
	}
	for k = 1; k <= 4; k++ {
		if headerByte[k] < 0 {
			headerByte[k] = 0
		}
	}
}

@ @<검사합을...@>=
b1 = bc
b2 = ec
b3 = bc
b4 = ec
tfmChanged = 0
for k = bc; k <= ec; k++ {
	if charExists[k] {
		x = dimenOut(value(tfmWidth[k])) + (k+4)*0o20000000 // 이것은 양수다
		b1 = (b1 + b1 + x) % 255
		b2 = (b2 + b2 + x) % 253
		b3 = (b3 + b3 + x) % 251
		b4 = (b4 + b4 + x) % 247
	}
}

@ 마침내 \.{TFM} 정보를 실제로 쓸 준비가 되었다. 다음은 이 목적을 위한 몇 가지 쓸모 있는 루틴이다.

음수를 2의 보수로 내보내는 |tfmFour|에서 원본은 $2^{31}$을 한꺼번에 더하지 않고 $2^{30}$씩 두 번 더한다. 32비트
산술에서 $2^{31}$ 자체를 나타낼 수 없기 때문인데, 이 조심성은 \GO/의 |int32|에서도 그대로 쓸모가 있다.

@<함수들@>=
func tfmOut(x int32) { bPut(&tfmFile, x) } // 바이트 하나를 |tfmFile|로 내보낸다

func tfmTwo(x int32) { // 두 바이트를 |tfmFile|로 내보낸다
	tfmOut(x / 256)
	tfmOut(x % 256)
}

func tfmFour(x int32) { // 네 바이트를 |tfmFile|로 내보낸다
	if x >= 0 {
		tfmOut(x / threeBytes)
	} else {
		x = x + 0o10000000000 // 음수에는 2의 보수를 쓴다
		x = x + 0o10000000000
		tfmOut((x / threeBytes) + 128)
	}
	x = x % threeBytes
	tfmOut(x / unity)
	x = x % unity
	tfmOut(x / 0o400)
	tfmOut(x % 0o400)
}

func tfmQqqq(x fourQuarters) { // 쿼터워드 넷을 |tfmFile|로 내보낸다
	tfmOut(qo(x.b0))
	tfmOut(qo(x.b1))
	tfmOut(qo(x.b2))
	tfmOut(qo(x.b3))
}

@ @<\.{TFM} 파일을 마무리한다@>=
if jobName == 0 {
	openLogFile()
}
packJobName(str(".tfm"))
for !bOpenOut(&tfmFile) {
	promptFileName("file name for font metrics", str(".tfm"))
}
metricFileName = bMakeNameString(&tfmFile)
@<부분 파일 크기와 머리 바이트를 내보낸다@>
@<문자 정보 바이트를 내보내고 치수 자체를 내보낸다@>
@<합자/커닝 프로그램을 내보낸다@>
@<늘일 수 있는 문자 조립법과 글꼴 계량 매개변수를 내보낸다@>
if stat {
	if internal[tracingStats] > 0 {
		@<\.{TFM} 파일의 부분 파일 크기를 기록한다@>
	}
}
printNl("Font metrics written on ")
slowPrint(metricFileName)
printChar('.')
@.Font metrics written...@>
bClose(&tfmFile)

@ 이 코드를 쓸 때 정수 변수 |lh|, |k|, |lkOffset|이 정의되어 있을 것이다.

@<부분 파일 크기와...@>=
k = headerSize
for headerByte[k] < 0 {
	k--
}
lh = (k + 3) / 4 // 이것이 머리 낱말의 수다
if bc > ec {
	bc = 1 // 문자가 없으면 |ec=0|이고 |bc=1|이다
}
@<합자/커닝 프로그램의 오프셋을 계산하고 왼쪽 경계 레이블을 심는다@>
tfmTwo(6 + lh + (ec - bc + 1) + nw + nh + nd + ni + nl + lkOffset + nk + ne + np)
// 이것이 내보낼 파일 낱말의 총수다
tfmTwo(lh)
tfmTwo(bc)
tfmTwo(ec)
tfmTwo(nw)
tfmTwo(nh)
tfmTwo(nd)
tfmTwo(ni)
tfmTwo(nl + lkOffset)
tfmTwo(nk)
tfmTwo(ne)
tfmTwo(np)
for k = 1; k <= 4*lh; k++ {
	if headerByte[k] < 0 {
		headerByte[k] = 0
	}
	tfmOut(headerByte[k])
}

@ @<문자 정보 바이트를...@>=
for k = bc; k <= ec; k++ {
	if !charExists[k] {
		tfmFour(0)
	} else {
		tfmOut(info(tfmWidth[k])) // 너비 첨자
		tfmOut((info(tfmHeight[k]))*16 + info(tfmDepth[k]))
		tfmOut((info(tfmItalCorr[k]))*4 + charTag[k])
		tfmOut(charRemainder[k])
	}
}
tfmChanged = 0
for k = 1; k <= 4; k++ {
	tfmFour(0)
	p = dimenHead[k]
	for p != infVal {
		tfmFour(dimenOut(value(p)))
		p = link(p)
	}
}

@ 오른쪽 경계 문자를 지정하거나 255를 넘는 시작 주소를 다루려면 배열 |ligKern|의 처음에 특별한 명령을 내보내야 한다.
배열 |labelLoc|과 |labelChar|에 모든 시작 주소를 기록해 두었다. 이때 $-1=|labelLoc|[0]<|labelLoc|[1]\le\cdots
\le|labelLoc|[|labelPtr|]$이다.

생각은 이렇다. 문자의 |charRemainder|는 한 바이트이므로 255를 넘는 시작 주소를 바로 담을 수 없다. 그래서 배열의 맨
앞에 ``위치 $n$으로 건너뛰라''는 방향 바꾸기 명령을 |lkOffset|개 끼워 넣고, 주소가 큰 문자들의 |charRemainder|가
그 방향 바꾸기 명령을 가리키게 한다. 방향 바꾸기를 끼워 넣으면 나머지 명령들의 주소가 그만큼 밀리므로, 필요한
|lkOffset|은 가장 큰 주소부터 거꾸로 세어 가며 찾는다.

@<합자/커닝 프로그램의 오프셋을...@>=
bchar = roundUnscaled(internal[boundaryChar])
if bchar < 0 || bchar > 255 {
	bchar = -1
	lkStarted = false
	lkOffset = 0
} else {
	lkStarted = true
	lkOffset = 1
}
@<가장 작은 |lkOffset|을 찾고 모든 나머지를 고친다@>
if bchLabel < undefinedLabel {
	setSkipByte(nl, qi(255))
	setNextChar(nl, qi(0))
	setOpByte(nl, qi((bchLabel+lkOffset)/256))
	setRemByte(nl, qi((bchLabel+lkOffset)%256))
	nl++ // |nl=ligTableSize+1|일 수도 있다
}

@ @<가장 작은 |lkOffset|을...@>=
k = labelPtr // 할당하지 않은 가장 큰 레이블의 포인터
if labelLoc[k]+lkOffset > 255 {
	lkOffset = 0
	lkStarted = false // 위치 0이 두 몫을 할 수 있다
	for {
		charRemainder[labelChar[k]] = lkOffset
		for labelLoc[k-1] == labelLoc[k] {
			k--
			charRemainder[labelChar[k]] = lkOffset
		}
		lkOffset++
		k--
		if lkOffset+labelLoc[k] < 256 {
			break
		}
	} // 주의: |k=0|이면 |lkOffset=256|이 이 조건을 만족한다
}
if lkOffset > 0 {
	for k > 0 {
		charRemainder[labelChar[k]] = charRemainder[labelChar[k]] + lkOffset
		k--
	}
}

@ @<합자/커닝 프로그램을 내보낸다@>=
for k = 0; k <= 255; k++ {
	if skipTable[k] < undefinedLabel {
		printNl("(local label ")
		printInt(k)
		printStr(":: was missing)")
@.local label l:: was missing@>
		cancelSkips(skipTable[k])
	}
}
if lkStarted { // 특별한 |bchar|를 위해 |lkOffset=1|이다
	tfmOut(255)
	tfmOut(bchar)
	tfmTwo(0)
} else {
	for k = 1; k <= lkOffset; k++ { // 방향 바꾸기 명세를 내보낸다
		ll = labelLoc[labelPtr]
		if bchar < 0 {
			tfmOut(254)
			tfmOut(0)
		} else {
			tfmOut(255)
			tfmOut(bchar)
		}
		tfmTwo(ll + lkOffset)
		for {
			labelPtr--
			if labelLoc[labelPtr] < ll {
				break
			}
		}
	}
}
for k = 0; k <= nl-1; k++ {
	tfmQqqq(ligKern[k])
}
for k = 0; k <= nk-1; k++ {
	tfmFour(dimenOut(kern[k]))
}

@ @<늘일 수 있는 문자 조립법과...@>=
for k = 0; k <= ne-1; k++ {
	tfmQqqq(exten[k])
}
for k = 1; k <= np; k++ {
	if k == 1 {
		if abs(param[1]) < fractionHalf {
			tfmFour(param[1] * 16)
		} else {
			tfmChanged++
			if param[1] > 0 {
				tfmFour(elGordo)
			} else {
				tfmFour(-elGordo)
			}
		}
	} else {
		tfmFour(dimenOut(param[k]))
	}
}
if tfmChanged > 0 {
	if tfmChanged == 1 {
		printNl("(a font metric dimension")
@.a font metric dimension...@>
	} else {
		printNl("(")
		printInt(tfmChanged)
@.font metric dimensions...@>
		printStr(" font metric dimensions")
	}
	printStr(" had to be decreased)")
}

@ @<\.{TFM} 파일의 부분 파일 크기를...@>=
wlogLn(" ")
if bchLabel < undefinedLabel {
	nl--
}
wlogLn("(You used ", nw, "w,", nh, "h,", nd, "d,", ni, "i,",
	nl, "l,", nk, "k,", ne, "e,", np, "p metric file positions")
wlogLn("  out of ", "256w,16h,16d,64i,", ligTableSize, "l,", maxKerns, "k,256e,",
	maxFontDimen, "p)")

@* 일반 글꼴 파일 형식.
\MF를 한 번 돌려서 얻는 가장 중요한 출력은 그려 낸 문자들의 비트 무늬를 지정하는 ``일반 글꼴''(\.{GF}) 파일이다.
{\sl 일반\/}이라는 말은 이 파일 형식이 어느 이름난 제조사의 관례에도 맞추지 않았다는 뜻이다. 그러나 \.{GF} 파일은
거의 모든 디지털 사진 식자기가 요구하는 특별한 형식으로 쉽게 바꿀 수 있다. \TeX이 쓰는 \.{DVI} 파일과 \MF가 쓰는
\.{GF} 파일 사이에는 강한 유사점이 있으며, 실제로 두 파일 형식에는 공통점이 많다.

\.{GF} 파일은 기계 같은 언어의 명령의 나열로 볼 수 있는 8비트 바이트의 흐름이다. 각 명령의 첫 바이트는 연산
코드이고, 그 뒤에 명령에 매개변수를 주는 바이트가 0개 이상 따른다. 매개변수 자체가 잇따른 여러 바이트로 이루어질
수도 있다. 이를테면 `|boc|'(문자의 시작) 명령에는 매개변수가 여섯 있는데, 저마다 네 바이트다. 매개변수는 대개 음이
아닌 정수로 여기지만, 네 바이트짜리 매개변수는 양수일 수도 음수일 수도 있어서 그 값의 범위는 $-2^{31}$에서
$2^{31}-1$까지다. \.{TFM} 파일에서처럼 한 바이트보다 많은 자리를 차지하는 수는 빅엔디언 순서로 나타나고, 음수는
2의 보수 표기로 나타난다.

\.{GF} 파일은 ``서문''과 그 뒤에 이어지는 하나 이상의 ``문자''와 그 뒤의 ``후문''으로 이루어진다. 서문은 파일을
소개하는 매개변수를 지닌 |pre| 명령일 뿐이다. 이것이 맨 먼저 와야 한다. 각 ``문자''는 |boc| 명령과 그 뒤에 이어지는
``검은'' 화소를 지정하는 다른 명령 여러 개와 그 뒤의 |eoc| 명령으로 이루어진다. 문자들은 \MF가 만들어 낸 차례로
나타난다. (파일의 어느 두 명령 사이에나 허용되는) 무연산 명령을 무시하면, 각 |eoc| 명령 바로 뒤에는 |boc| 명령이나
|post| 명령이 따른다. 뒤의 경우 파일에 문자가 더 없고, 나머지 바이트들이 후문을 이룬다. 후문에 관한 더 자세한 것은
나중에 설명한다.

\.{GF} 명령의 몇몇 매개변수는 ``포인터''다. 이것은 파일의 다른 어떤 바이트의 위치 번호를 주는 네 바이트짜리 양이다.
파일의 첫 바이트가 0번이고, 다음이 1번이고, 그런 식이다.

@ \.{GF} 형식은 간결하면서도 기계가 해석하기 쉽도록 설계되었다. 간결함은 대부분의 정보를 절대적이 아니라 상대적으로
나타내어 얻는다. \.{GF}를 읽는 프로그램은 문자의 명령들을 읽는 동안 두 양을 추적한다. (a)~현재 열 번호~|m|과
(b)~현재 행 번호~|n|이다. 이것들은 32비트 부호 있는 정수이지만, \.{GF} 파일에서 만들어 내는 실제 글꼴 형식은 대개
실용적인 제약 때문에 이 방대한 범위를 줄여야 할 것이다. (\MF의 출력에서는 $\vert m\vert$나 $\vert n\vert$이 아주
커지는 일이 결코 없지만, \.{GF} 형식은 더 일반적이려고 애쓴다.)

\.{GF}의 행 번호와 열 번호는 \TeX과 \MF의 관례와 어떻게 대응할까? \TeX이 보기에 문자의 ``기준점''은 행~0 열~0인
화소의 왼쪽 아래 구석에 있다고 여겨진다. 이 점은 기준선과 활자의 왼쪽 가장자리가 만나는 점이고, \MF\ 프로그램의
위치 $(0,0)$에 해당한다. 그러므로 \.{GF}의 행~0 열~0인 화소는 \MF의 단위 정사각형, 곧 두 좌표가 모두 0과~1 사이에
있는 평면의 영역이다. \.{GF}의 행~|n| 열~|m|인 화소는 \MF\ 좌표 |(x,y)|가 |m<=x<=m+1|이고 |n<=y<=n+1|인 점들로
이루어진다. 좌표 |m|과~|x|의 음수 값은 기준점 {\sl 왼쪽\/}의 화소 열에 해당하고, |n|과~|y|의 음수 값은 기준선
{\sl 아래\/}의 화소 행에 해당한다.

두 값 |m|과 |n| 말고도 현재 상태에는 세 번째 측면, 곧 언제나 |black|이거나 |white|인 \\{paintSwitch}가 있다. 각
\\{paint} 명령은 |m|을 지정된 양~|d|만큼 나아가게 하는데, \\{paintSwitch}가 |black|이면 그 사이의 화소들을 검게
칠한다. 그다음 \\{paintSwitch}는 반대 상태로 바뀐다. \.{GF}의 명령들은 한 행 안에서 |m|이 결코 줄지 않고 한 문자
안에서 |n|이 결코 늘지 않도록 설계되었으므로, 한 번 검게 칠한 화소를 하얗게 되돌릴 방법은 없다.

@ 다음은 \.{GF} 파일에 나타날 수 있는 모든 명령의 목록이다. 각 명령은 그 기호 이름(이를테면 |boc|), 연산 코드
바이트(이를테면 67), 그리고 (있다면) 매개변수로 지정한다. 매개변수 뒤의 대괄호 안의 수는 그것이 차지하는 바이트
수다. 이를테면 `\ID{d}$[2]$'는 매개변수 \ID{d}가 두 바이트라는 뜻이다.

\yskip\hang|paint0| 0. 이것은 $d=0$인 \\{paint} 명령이다. \\{paintSwitch}를 \\{black}에서 \\{white}로, 또는 그
반대로 바꾸는 일밖에 하지 않는다.

\yskip\hang\\{paint1}부터 \\{paint63}까지 (연산 코드 1에서 63). 이것들은 $d=1$에서~63인 \\{paint} 명령으로서,
다음과 같이 정의된다. \\{paintSwitch}가 |black|이면 현재 행~|n|의 화소 $d$개, 곧 열 |m|부터 $m+d-1$까지(양 끝
포함)를 검게 칠한다. 그다음 어느 경우에나 \\{paintSwitch}를 뒤집고 |m|을 $d$만큼 나아가게 한다.

\yskip\hang|paint1| 64 \ID{d}$[1]$. 이것은 값~$d$를 지정하는 \\{paint} 명령이다. \MF는 $64\le d<256$일 때 이것으로
칠한다.

\yskip\hang\\{paint2} 65 \ID{d}$[2]$. |paint1|과 같지만 $d$가~65535까지 될 수 있다.

\yskip\hang\\{paint3} 66 \ID{d}$[3]$. |paint1|과 같지만 $d$가 $2^{24}-1$까지 될 수 있다. \MF는 이 명령이 필요한
적이 없고, 누군가 이것을 실용적으로 쓰는 것은 상상하기 어렵다. 문자가 이만큼 커질 수 있다면 분명히 더 간결한
부호화가 바람직할 것이다. 그래도 만일을 위해 이 명령이 있다.

\yskip\hang|boc| 67 \ID{c}$[4]$ \ID{p}$[4]$ \ID{minM}$[4]$ \ID{maxM}$[4]$ \ID{minN}$[4]$ \ID{maxN}$[4]$. 문자의
시작. 여기서 $c$는 문자 코드이고, $p$는 문자 코드를 256으로 나눈 나머지가 같은 문자들 가운데 바로 앞 문자의 시작을
(있다면) 가리킨다. (그런 앞선 문자가 없었으면 포인터 $p$는 $-1$이다.) 이 문자를 위해 뒤따르는 명령들이 정하는
레지스터 |m|과 |n|의 값은 $\ID{minM}\le m\le\ID{maxM}$과 $\ID{minN}\le n\le\ID{maxN}$을 만족해야 한다. (경계 \ID{maxM}과
\ID{minN}의 값은 가능한 가장 빡빡한 경계가 아니어도 된다.) \.{GF}를 읽는 프로그램은 |boc|를 보면 \ID{minM},
\ID{maxM}, \ID{minN}, \ID{maxN}으로 배열의 경계를 초기화할 수 있다. 그다음 $m:=\ID{minM}$, $n:=\ID{maxN}$,
$\\{paintSwitch}:=\\{white}$로 놓는다.

\yskip\hang|boc1| 68 \ID{c}$[1]$ \ID{delM}$[1]$ \ID{maxM}$[1]$ \ID{delN}$[1]$ \ID{maxN}$[1]$. |boc|와 같지만 $p$를
$-1$로 여긴다. 또 \ID{minM}과 \ID{minN} 대신 $\ID{delM}=\ID{maxM}-\ID{minM}$과 $\ID{delN}=\ID{maxN}-\ID{minN}$을
준다. 한 바이트짜리 매개변수는 0에서 255 사이(양 끝 포함)여야 한다. (이 줄인 |boc|는 흔한 경우에 문자마다
19~바이트를 아낀다.)

\yskip\hang|eoc| 69. 문자의 끝. 지금까지 검게 칠한 모든 화소가 이 문자의 무늬를 이룬다. 특히 완전히 빈 문자에서는
|boc| 바로 뒤에 |eoc|가 올 수도 있다.

\yskip\hang|skip0| 70. $n$을 1 줄이고 $m:=\ID{minM}$, $\\{paintSwitch}:=\\{white}$로 놓는다. (이것은 한 행을 끝내고
다른 행을 시작하는데, 새 행의 맨 왼쪽 화소를 하얗게 둘 준비를 한다.)

\yskip\hang|skip1| 71 \ID{d}$[1]$. $n$을 $d+1$만큼 줄이고 $m:=\ID{minM}$, $\\{paintSwitch}:=\\{white}$로 놓는다.
이것은 온통 흰 행을 $d$개 만드는 방법이다.

\yskip\hang\\{skip2} 72 \ID{d}$[2]$. |skip1|과 같지만 $d$가 65535까지 될 수 있다.

\yskip\hang\\{skip3} 73 \ID{d}$[3]$. |skip1|과 같지만 $d$가 $2^{24}-1$까지 될 수 있다. \MF는 물론 이 명령이 필요한
적이 없다.

\yskip\hang|newRow0| 74. $n$을 1 줄이고 $m:=\ID{minM}$, $\\{paintSwitch}:=\\{black}$으로 놓는다. (이것은 한 행을
끝내고 다른 행을 시작하는데, 새 행의 맨 왼쪽 화소를 {\sl 검게\/} 칠할 준비를 한다.)

\yskip\hang\\{newRow1}부터 \\{newRow164}까지 (연산 코드 75에서 238). |newRow0|과 같지만 저마다 $m:=\ID{minM}+1$부터
$\ID{minM}+164$까지로 놓는다.

\yskip\hang|xxx1| 239 \ID{k}$[1]$ \ID{x}$[k]$. 이 명령은 일반적으로는 정의되지 않는다. 특별한 \.{GF} 읽개를 쓰지
않는 한 $(k+2)$바이트짜리 \\{noOp}으로 작용한다. \MF는 \KW{special} 문자열을 만나면 \\{xxx} 명령을 만들어 낸다.
이것은 \.{GF} 파일에서 문자들 사이에만, 서문 뒤 후문 앞에만 나타난다. 그러나 다른 처리기가 만든 \.{GF} 파일에서는
\\{xxx} 명령이 문자 안에 나타날 수도 있다. 문자열 $x$는 키워드 하나와 그 키워드에 관련된 매개변수들의 꼴인 문자열이 좋다.

\yskip\hang\\{xxx2} 240 \ID{k}$[2]$ \ID{x}$[k]$. |xxx1|과 같지만 $0\le k<65536$이다.

\yskip\hang|xxx3| 241 \ID{k}$[3]$ \ID{x}$[k]$. |xxx1|과 같지만 $0\le k<2^{24}$이다. \MF는 길이가 255를 넘는
\KW{special} 문자열을 보낼 때 이것을 쓴다.

\yskip\hang\\{xxx4} 242 \ID{k}$[4]$ \ID{x}$[k]$. |xxx1|과 같지만 $k$가 터무니없이 클 수 있다. 다만 $k$는 음수면 안 된다.

\yskip\hang|yyy| 243 \ID{y}$[4]$. 이 명령은 일반적으로는 정의되지 않는다. 특별한 \.{GF} 읽개를 쓰지 않는 한
5바이트짜리 \\{noOp}으로 작용한다. \MF는 \KW{numspecial} 명령의 결과로 |scaled| 수를 |yyy|에 넣는다. 그 뜻은 바로
앞의 \\{xxx} 명령에 수치 매개변수를 주려는 것이다.

\yskip\hang\\{noOp} 244. 무연산, 아무것도 하지 않는다. \.{GF} 명령들 사이에는 \\{noOp}이 몇 개든 올 수 있지만,
명령과 그 매개변수 사이나 두 매개변수 사이에 \\{noOp}을 끼워 넣을 수는 없다.

\yskip\hang|charLoc| 245 \ID{c}$[1]$ \ID{dx}$[4]$ \ID{dy}$[4]$ \ID{w}$[4]$ \ID{p}$[4]$. 이 명령은 곧 설명할 후문에만
나타난다.

\yskip\hang\\{charLoc0} 246 \ID{c}$[1]$ \ID{dm}$[1]$ \ID{w}$[4]$ \ID{p}$[4]$. |charLoc|과 같지만 \ID{dy}를 0으로
여기고 \ID{dx}의 값을 $65536\cdot\ID{dm}$으로 여긴다. 여기서 $0\le\ID{dm}<256$이다.

\yskip\hang|pre| 247 \ID{i}$[1]$ \ID{k}$[1]$ \ID{x}$[k]$. 서문의 시작. 이것은 파일의 맨 처음에 와야 한다. 매개변수
$i$는 \.{GF} 형식의 식별 번호로서 지금은 131이다. 다른 정보는 그저 주석일 뿐이다. \\{xxx} 명령처럼 특별한 해석을
받지 않는다. (\\{xxx} 명령은 서문 바로 뒤, 첫 |boc| 앞에 올 수도 있다는 데 주목하라.)

\yskip\hang|post| 248. 후문의 시작. 아래를 보라.

\yskip\hang|postPost| 249. 후문의 끝. 아래를 보라.

\yskip\noindent 명령 250--255는 지금은 정의되지 않는다.

@<정의@>=
const @!gfIdByte = 131 // 여기서 설명하는 종류의 \.{GF} 파일을 식별한다

@ \MF는 다음 연산 코드들을 명시적으로 가리킨다.

@<정의@>=
const (
	@!paint0 = 0 // \\{paint} 명령들의 시작
	@!paint1 = 64 // 주어진 수만큼의 열을 오른쪽으로 옮긴 다음, 검정${}\leftrightarrow{}$흰색
	@!boc = 67 // 문자의 시작
	@!boc1 = 68 // |boc|의 짧은 꼴
	@!eoc = 69 // 문자의 끝
	@!skip0 = 70 // 빈 행을 건너뛰지 않는다
	@!skip1 = 71 // 빈 행들을 건너뛴다
	@!newRow0 = 74 // 한 행 아래로 옮긴 다음 오른쪽으로
	@!maxNewRow = 164 // 가장 큰 \\{newRow} 명령은 \\{newRow164}다
	@!xxx1 = 239 // \KW{special} 문자열을 위해
	@!xxx3 = 241 // 긴 \KW{special} 문자열을 위해
	@!yyy = 243 // \KW{numspecial} 수를 위해
	@!charLoc = 245 // 후문의 문자 위치 표시
	@!pre = 247 // 서문
	@!post = 248 // 후문의 시작
	@!postPost = 249 // 후문의 끝
)

@ \.{GF} 파일의 마지막 문자 뒤에는 `|post|'가 따른다. 이 명령은 \MF가 모아 둔 중요한 사실들을 요약하는 후문을
소개한다. 후문은 다음 꼴이다.
$$\vbox{\halign{\hbox{#\hfil}\cr
  |post| \ID{p}$[4]$ \ID{ds}$[4]$ \ID{cs}$[4]$ \ID{hppp}$[4]$ \ID{vppp}$[4]$
   \ID{minM}$[4]$ \ID{maxM}$[4]$ \ID{minN}$[4]$ \ID{maxN}$[4]$\cr
  $\langle\,$문자 위치 표시$\,\rangle$\cr
  |postPost| \ID{q}$[4]$ \ID{i}$[1]$ 223들$[{\ge}4]$\cr}}$$
여기서 $p$는 파일의 마지막 |eoc| 다음 바이트를 (문자가 없으면 서문 다음 바이트를) 가리키는 포인터다. 이것으로
후문 앞에 왔을지도 모르는 \\{xxx} 명령들의 시작을 찾을 수 있다. 매개변수 \ID{ds}와 \ID{cs}는 저마다 설계 크기와
@^design size@> @^check sum@>
검사합으로서, \MF가 이번 실행에서 만드는 (또는 만들었을) \.{TFM} 파일의 머리에 넣는 바로 그 값이다. 매개변수
\ID{hppp}와 \ID{vppp}는 포인트당 화소의 비율을 가로와 세로로 |scaled| 정수로(곧 $2^{16}$을 곱해서) 나타낸 것이다.
이것으로 글꼴을 특정한 장치의 해상도, 확대율, ``at 크기''와 관련지을 수 있다. 그다음에 \ID{minM}, \ID{maxM},
\ID{minN}, \ID{maxN}이 오는데, 이것들은 이 \.{GF} 파일의 모든 문자에서 레지스터 |m|과~|n|이 갖는 값의 경계다. (이
경계는 가장 좋은 것이 아니어도 된다. 한편 \ID{maxM}과 \ID{minN}은 |boc| 명령의 비슷한 경계보다 더 빡빡할 수도 있다.
이를테면 어떤 문자의 |boc|에서는 $\ID{minN}=-100$이지만 어느 문자에서도 $n$이 $-50$보다 낮아지지 않을 수 있다.
그러면 \ID{minN}은 $-50$ 이하의 어떤 값이든 될 수 있다. 파일에 문자가 없으면 $\ID{minM}>\ID{maxM}$이나
$\ID{minN}>\ID{maxN}$일 수도 있다.)

@ 문자 위치 표시는 |charLoc| 명령으로 시작한다. 이것은 문자 나머지~$c$, 문자 이동량 $(\ID{dx},\ID{dy})$, 문자
너비~$w$, 그 문자의 시작을 가리키는 포인터~$p$를 지정한다. (코드를 256으로 나눈 나머지~$c$가 같은 문자가 둘 이상
있으면 마지막 것만 표시한다. 나머지는 뒤 포인터를 따라가서 찾을 수 있다. 코드가 256의 배수만큼 다른 문자들은 같은
글꼴 계량 정보를 나눠 쓴다고 여기므로, \.{TFM} 파일에는 문자 코드를 256으로 나눈 나머지만 들어 있다. 이 관례는
문자 모양은 많지만 서로 다른 너비는 적은 동양 언어를 위한 것이다.)
@^oriental characters@>@^Chinese characters@>@^Japanese characters@>

문자 이동량 $(\ID{dx},\ID{dy})$는 \MF의 \KW{chardx}와 \KW{chardy} 매개변수의 값이다. 단위는 |scaled| 화소, 곧
\ID{dx}는 가로 화소 단위 곱하기 $2^{16}$이고 \ID{dy}는 세로 화소 단위 곱하기 $2^{16}$이다. 이것은 문자를 조판한
다음 옮겨 갈 의도된 거리다. \.{DVI} 파일에서는 \ID{dy}가 0이어야 하지만, 다른 문서 파일 형식은 0이 아닌 세로 이동을
허락한다.

문자 너비~$w$는 \.{TFM} 파일의 정보를 되풀이한 것이다. 이것은 설계 크기에 대한 \ID{fixWord} 값이고, 확대율에 매이지
않아야 한다.

뒤 포인터 $p$는 문자의 |boc|를 가리키거나, |boc| 바로 앞에 잇따른 \\{xxx}나 |yyy|나 \\{noOp} 명령이 있으면 그
가운데 첫 것을 가리킨다. 그런 ``특별'' 명령은 사실상 그 문자에 속하고, 마지막 문자 뒤의 특별 명령은 후문에(곧
글꼴 전체에) 속한다. 포인터 |p|에 관한 이 관례는 |boc| 명령의 뒤 포인터에도 적용된다. 명령 |boc|를 설명할 때는 말하지 않았지만
말이다. @^backpointers@>

문자가 \.{TFM} 파일에는 있지만 \.{GF} 파일에는 없으면 포인터 $p$가 $-1$일 수도 있다. 이 드문 상황은 사용자가 문자를
내보낼 때는 $\\{proofing}<0$이었다가 \.{GF} 파일을 얻으려고 $\\{proofing}\ge0$으로 바꾼 경우에 \MF의 출력에서 생길
수 있다.

@ 문자 위치 표시의 끝을 나타내는 |postPost| 바이트 다음에 오는 후문의 마지막 부분에는, 후문을 시작한 |post| 명령을
가리키는 포인터 $q$가 들어 있다. 다음에는 식별 바이트 $i$가 오는데, 서문에서처럼 지금은 131이다.

바이트 $i$ 뒤에는 모두 십진수 223(곧 팔진수 |0o337|)과 같은 바이트가 넷 이상 따른다. \MF는 파일의 전체 길이가
네 바이트의 배수가 될 때까지 이 꼬리 바이트를 넷에서 일곱 개 내놓는다. 낱말마다 네 바이트를 꾸리는 기계에서 이것이
가장 잘 맞기 때문이다. 그러나 적어도 넷이기만 하면 223이 몇 개든 허용된다. 사실상 223은 맨 끝에 덧붙이는 일종의
서명이다.
@^Fuchs, David Raymond@>

\.{GF} 파일을 끝맺는 이 묘한 방식 덕분에, \MF는 후문을 마지막에 쓰고 싶어 하는데도 \.{GF}를 읽는 프로그램은 대부분의
컴퓨터에서 후문을 먼저 찾을 수 있다. 대부분의 운영체제는 파일의 낱낱의 낱말이나 바이트에 임의 접근을 허락하므로,
\.{GF} 읽개는 끝에서 시작해서 식별 바이트를 찾을 때까지 223들을 거꾸로 건너뛸 수 있다. 그다음 네 바이트를 되짚어
$q$를 읽고 파일의 바이트 $q$로 옮겨 간다. 이 바이트에는 물론 값 248(|post|)이 들어 있어야 한다. 이제 후문을 읽을 수
있으므로 \.{GF} 읽개는 낱낱의 문자에 필요한 모든 정보를 알아낼 수 있다.

그러나 안타깝게도 표준 \PASCAL에는 파일의 임의의 위치에 접근하는 능력은 물론 파일의 길이를 알아내는 능력조차
@^system dependencies@>
없다. 요즘의 거의 모든 시스템은 필요한 능력을 제공하므로, \.{GF} 형식은 현대 운영체제에서 가장 효율적으로 돌도록
설계되었다. 그러나 \.{GF} 파일을 표준 \PASCAL의 제약 아래서 처리해야 한다면 그냥 앞에서 뒤로 읽으면 된다. 대부분의
쓰임새에는 이것으로 충분하다. 그래도 후문을 먼저 읽는 방식은 두 \.{GF} 파일을 합치면서 한쪽의 자료를 다른 쪽의
대응하는 자료로 덮어쓰는 프로그램을 쉽게 만들어 줄 것이다. (\GO/에서는 |os.File|의 |Seek|로 이런 임의 접근을 할 수
있다.)

@* 문자 내보내기.
아래에서 설명할 프로시저 |shipOut|은 가장자리 구조를 가리키는 포인터를 받는다. 그 임무는 양의 화소들을 \.{GF}
꼴로 기술하여 ``문자'' 하나를 |gfFile|로 내보내는 것이다.

글꼴 파일 전체에 관한 정보를 담는 전역 변수가 몇 있다. 변수 |gfMinM|, |gfMaxM|, |gfMinN|, |gfMaxN|은 지금까지 내보낸
\.{GF} 좌표의 최소와 최대다. 변수 |gfPrevPtr|는 출력에서 서문이나 마지막 |eoc| 명령 다음의 바이트 번호다.
변수 |totalChars|는 내보낸 문자(곧 |boc .. eoc| 토막)의 총수다. 또 후문에 필요한 대로 파일에서 각 문자가 시작하는 위치를
담은 배열 |charPtr|가 있다. 문자 코드~|c|를 아직 내보내지 않았으면 |charPtr[c]=-1|이다.

@<전역 변수@>=
var @!gfMinM, @!gfMaxM, @!gfMinN, @!gfMaxN int32 // 경계 사각형
var @!gfPrevPtr int32 // 현재/다음 문자가 시작한/시작할 곳
var @!totalChars int32 // 지금까지 내보낸 문자의 수
var @!charPtr [256]int32 // 낱낱의 문자가 시작한 곳
var @!gfDx, @!gfDy [256]int32 // 장치 이동량

@ @<핵심 변수들의...@>=
gfPrevPtr = 0
totalChars = 0

@ \.{GF} 바이트는 바이트마다 |gfFile|로 보내지 않고 버퍼로 내보낸다. 그러면 서브루틴 호출의 부담을 많이 덜기
때문이다. \MF는 |gfFile|에 대해 \TeX이 \\{dviFile}에 쓰는 것과 같은 관례를 쓴다. 그러므로 시스템에 따라 바꿀 것이
있다면 아마 두 프로그램에서 같을 것이다.

출력 버퍼는 같은 크기의 두 부분으로 나뉜다. 배열 |gfBuf|의 첨자 0부터 |halfBuf-1|까지의 바이트가 앞
절반을, |halfBuf|부터 |gfBufSize-1|까지의 바이트가 뒤 절반을 이룬다. 전역 변수 |gfPtr|는 다음 출력 바이트를 받을 위치를 가리킨다. 변수 |gfPtr|가 언제나 두 값
|halfBuf|와 |gfBufSize| 가운데 하나와 같은 |gfLimit|에 이르면, 다음에 침범할 반쪽 버퍼를 출력으로 보내고 |gfLimit|를
다른 값으로 바꾼다. 그래서 작업의 맨 처음을 빼고는 언제나 적어도 반쪽 버퍼만큼의 정보가 남아 있다.

\.{GF} 파일의 바이트는 0부터 차례로 번호가 매겨진다. 다음에 만들 바이트는 |gfOffset+gfPtr|번이다.

@<전역 형@>=
type @!gfIndex = int32 // 출력 버퍼의 첨자; |0 .. gfBufSize|

@ @<전역 변수@>=
var @!gfBuf [gfBufSize + 1]eightBits // \.{GF} 출력을 위한 버퍼
var @!halfBuf gfIndex // |gfBufSize|의 절반
var @!gfLimit gfIndex // 현재 반쪽 버퍼의 끝
var @!gfPtr gfIndex // 다음에 쓸 수 있는 버퍼 주소
var @!gfOffset int32 // 출력 버퍼를 다 비운 횟수 곱하기 |gfBufSize|

@ 처음에는 버퍼가 한 덩어리다. 처음 가득 찬 다음에야 그 절반을 내보낸다.

@<핵심 변수들의...@>=
halfBuf = gfBufSize / 2
gfLimit = gfBufSize
gfPtr = 0
gfOffset = 0

@ 버퍼 |gfBuf[a .. b]|를 |gfFile|로 실제로 내보내는 일은 |writeGf(a,b)|를 불러서 한다. 그리고 |writeGf(a,b)|를 부를 때 |a|와 |b+1|이
둘 다 4의 배수라고 가정해도 안전하다.
@^system dependencies@>

@<함수들@>=
func writeGf(a, b gfIndex) {
	var k gfIndex
	for k = a; k <= b; k++ {
		bPut(&gfFile, gfBuf[k])
	}
}

@ 원본은 바이트 하나를 버퍼에 넣을 때마다 프로시저를 부르는 비용을 치르지 않으려고 매크로 \\{gf\_out}을 썼다.
\GO/에서는 작은 함수 |gfOut|으로 충분하다. 컴파일러가 알아서 인라인할 것이다.

@<함수들@>=
func gfOut(x int32) {
	gfBuf[gfPtr] = x
	gfPtr++
	if gfPtr == gfLimit {
		gfSwap()
	}
}

func gfSwap() { // 버퍼의 절반을 내보낸다
	if gfLimit == gfBufSize {
		writeGf(0, halfBuf-1)
		gfLimit = halfBuf
		gfOffset = gfOffset + gfBufSize
		gfPtr = 0
	} else {
		writeGf(halfBuf, gfBufSize-1)
		gfLimit = gfBufSize
	}
}

@ \MF가 일을 다 마쳤을 때 버퍼를 비우는 방법이다. 이때 |gfPtr|는 4의 배수일 것이다.

@<|gfBuf|에서 마지막 바이트들을 비운다@>=
if gfLimit == halfBuf {
	writeGf(halfBuf, gfBufSize-1)
}
if gfPtr > 0 {
	writeGf(0, gfPtr-1)
}

@ 프로시저 |gfFour|는 산술 넘침의 위험 없이 네 바이트를 2의 보수 표기로 내보낸다. 프로시저 |tfmFour|와 똑같은 꾀다.

@<함수들@>=
func gfFour(x int32) {
	if x >= 0 {
		gfOut(x / threeBytes)
	} else {
		x = x + 0o10000000000
		x = x + 0o10000000000
		gfOut((x / threeBytes) + 128)
	}
	x = x % threeBytes
	gfOut(x / unity)
	x = x % unity
	gfOut(x / 0o400)
	gfOut(x % 0o400)
}

@ 물론 두 바이트나 세 바이트만 내보내기는 더 쉽다.

@<함수들@>=
func gfTwo(x int32) {
	gfOut(x / 0o400)
	gfOut(x % 0o400)
}

func gfThree(x int32) {
	gfOut(x / unity)
	gfOut((x % unity) / 0o400)
	gfOut(x % 0o400)
}

@ 알맞은 종류의 \\{paint} 명령을 만드는 간단한 루틴이 필요하다.

@<함수들@>=
func gfPaint(d int32) { // 여기서 |0<=d<65536|이다
	if d < 64 {
		gfOut(paint0 + d)
	} else if d < 256 {
		gfOut(paint1)
		gfOut(d)
	} else {
		gfOut(paint1 + 1)
		gfTwo(d)
	}
}

@ 그리고 |gfString|은 문자열 하나나 둘을 내보낸다. 첫 문자열 번호가 0이 아니면 \\{xxx} 명령을 만든다.

@<함수들@>=
func gfString(s, t strNumber) {
	var k poolPointer
	var l int32 // 내보낼 문자열의 길이
	if s != 0 {
		l = length(s)
		if t != 0 {
			l = l + length(t)
		}
		if l <= 255 {
			gfOut(xxx1)
			gfOut(l)
		} else {
			gfOut(xxx3)
			gfThree(l)
		}
		for k = strStart[s]; k <= strStart[s+1]-1; k++ {
			gfOut(int32(strPool[k]))
		}
	}
	if t != 0 {
		for k = strStart[t]; k <= strStart[t+1]-1; k++ {
			gfOut(int32(strPool[k]))
		}
	}
}

@ 두 |boc| 명령 사이의 선택은 |gfBoc|가 맡는다. 매개변수가 모두 한 바이트에 들어가고 뒤 포인터가 $-1$이면 짧은 꼴
|boc1|을 쓴다. 원본의 매크로 \\{one\_byte}는 지역 클로저 |oneByte|가 되었다.

@<함수들@>=
func gfBoc(minM, maxM, minN, maxN int32) {
	oneByte := func(x int32) bool { return x >= 0 && x < 256 }
	if minM < gfMinM {
		gfMinM = minM
	}
	if maxN > gfMaxN {
		gfMaxN = maxN
	}
	if bocP == -1 && oneByte(bocC) && oneByte(maxM-minM) && oneByte(maxM) &&
		oneByte(maxN-minN) && oneByte(maxN) {
		gfOut(boc1)
		gfOut(bocC)
		gfOut(maxM - minM)
		gfOut(maxM)
		gfOut(maxN - minN)
		gfOut(maxN)
		return
	}
	gfOut(boc)
	gfFour(bocC)
	gfFour(bocP)
	gfFour(minM)
	gfFour(maxM)
	gfFour(minN)
	gfFour(maxN)
}

@ 프로시저 |gfBoc|의 매개변수 가운데 둘은 전역 변수다.

@<전역 변수@>=
var @!bocC, @!bocP int32 // 다음 |boc| 명령의 매개변수

@ 다음은 \.{GF} 파일을 시작하는 루틴이다.

@<함수들@>=
func checkGf() {
	if outputFileName == 0 {
		initGf()
	}
}

func initGf() {
	var k eightBits // 가능한 모든 문자 코드를 훑는다
	var t int32 // 이번 실행의 시각
	gfMinM = 4096
	gfMaxM = -4096
	gfMinN = 4096
	gfMaxN = -4096
	for k = 0; k <= 255; k++ {
		charPtr[k] = -1
	}
	@<파일 확장자 |gfExt|를 정한다@>
	setOutputFileName()
	gfOut(pre)
	gfOut(gfIdByte) // 서문을 내보내기 시작한다
	oldSetting = selector
	selector = newString
	printStr(" METAFONT output ")
	printInt(roundUnscaled(internal[year]))
	printChar('.')
	printDd(roundUnscaled(internal[month]))
	printChar('.')
	printDd(roundUnscaled(internal[day]))
	printChar(':')
	t = roundUnscaled(internal[time])
	printDd(t / 60)
	printDd(t % 60)
	selector = oldSetting
	gfOut(curLength())
	gfString(0, makeString())
	strPtr--
	poolPtr = strStart[strPtr] // 그 문자열을 메모리에서 치운다
	gfPrevPtr = gfOffset + gfPtr
}

@ 확장자의 수는 해상도를 인치당 화소 수로 나타낸 것이다. 값 \\{hppp}는 포인트당 화소이므로 72.27을 곱하면 되는데,
|makeScaled|로 $2^{32}/72.27\approx59429463.07$로 나누어 이 곱셈을 한다. 이를테면 \\{hppp}가
$600/72.27$이면 확장자는 \.{.600gf}가 된다.

@<파일 확장자...@>=
if internal[hppp] <= 0 {
	gfExt = str(".gf")
} else {
	oldSetting = selector
	selector = newString
	printChar('.')
	printInt(makeScaled(internal[hppp], 59429463)) // $2^{32}/72.27\approx59429463.07$
	printStr("gf")
	gfExt = makeString()
	selector = oldSetting
}

@ 이런 준비가 끝나면 |shipOut|은 그리 어렵지 않다.

@<함수들@>=
func shipOut(c eightBits) {
	var f int32 // 현재 문자 확장
	var prevM, m, mm int32 // 앞의 화소 열 번호와 현재 화소 열 번호
	var prevN, n int32 // 앞의 화소 행 번호와 현재 화소 행 번호
	var p, q pointer // 목록을 훑는다
	var prevW, w, ww int32 // 옛 무게와 새 무게
	var d int32 // 가장자리 무게 노드의 자료
	var delta int32 // 건너뛸 행의 수
	var curMinM int32 // 현재 오프셋에 대한 시작 열
	var xOff, yOff int32 // 정수로 반올림한 오프셋
	checkGf()
	f = roundUnscaled(internal[charExt])
	xOff = roundUnscaled(internal[xOffset])
	yOff = roundUnscaled(internal[yOffset])
	if termOffset > maxPrintLine-9 {
		printLn()
	} else if termOffset > 0 || fileOffset > 0 {
		printChar(' ')
	}
	printChar('[')
	printInt(c)
	if f != 0 {
		printChar('.')
		printInt(f)
	}
	updateTerminal()
	bocC = 256*f + c
	bocP = charPtr[c]
	charPtr[c] = gfPrevPtr
	if internal[proofing] > 0 {
		@<0이 아닌 오프셋을 출력 파일로 보낸다@>
	}
	@<|curEdges|가 나타내는 문자를 내보낸다@>
	gfOut(eoc)
	gfPrevPtr = gfOffset + gfPtr
	totalChars++
	printChar(']')
	updateTerminal() // 진행 보고
	if internal[tracingOutput] > 0 {
		printEdges(" (just shipped out)", true, xOff, yOff)
	}
}

@ 여기서 |xOff*unity|도 \KW{display}에서 본 것과 같은 넘침을 일으킬 수 있다. 만일 \\{xoffset}이 32767.5 이상이면
|roundUnscaled|가 32768을 내고, $32768\cdot2^{16}$은 32비트에 들어가지 않는다. 그러면 \.{GF} 파일의 |yyy| 명령에
$-32768$이 들어간다. 그만한 오프셋은 어차피 쓸모가 없으니 실제로 문제가 되지는 않는다.
@^bugs@>

@<0이 아닌 오프셋을...@>=
if xOff != 0 {
	gfString(str("xoffset"), 0)
	gfOut(yyy)
	gfFour(xOff * unity)
}
if yOff != 0 {
	gfString(str("yoffset"), 0)
	gfOut(yyy)
	gfFour(yOff * unity)
}

@ 가장자리 구조의 행들을 위에서 아래로(|knil|을 따라) 훑으면서 \.{GF} 행으로 내보낸다. 아래 그림은 다섯 화소 너비의
`T' 모양 문자가 어떻게 부호화되는지 보여 준다. 행마다 오른쪽에 그 행을 만드는 명령을 적었다. 처음에
\\{paintSwitch}는 하얗고 $m=\ID{minM}=0$이다. 첫 행은 \\{paint}$_0$로 검정으로 바꾼 다음 \\{paint}$_5$로 다섯 화소를
칠한다. 그다음 행들은 저마다 \\{newRow}$_2$로 한 행 내려가 열~2에서 검정으로 시작하고, \\{paint}$_1$로 한 화소를
칠한다. 모든 행을 끝내면 |eoc|가 온다. 이 문자의 \.{GF} 표현은 |boc1|의 6바이트, 명령 10바이트, |eoc|의 1바이트,
모두 17바이트다.

$$\mplibcode
beginfig(26);
save u; numeric u; u := 14pt;
for n = 0 upto 4: for m = 0 upto 4:
  draw unitsquare scaled u shifted (m*u, n*u) withcolor .7white;
endfor endfor
fill unitsquare xscaled 5u yscaled u shifted (0,4u);
for n = 0 upto 3: fill unitsquare scaled u shifted (2u, n*u); endfor
for m = 0 upto 4: label.bot(textext("$" & decimal m & "$"), ((m+.5)*u, 0)); endfor
for n = 0 upto 4: label.lft(textext("$" & decimal n & "$"), (0, (n+.5)*u)); endfor
label.bot(btex $m$ etex, (2.5u, -1.1u));
label.lft(btex $n$ etex, (-1.1u, 2.5u));
dot((0,0));
label.rt(btex {\it paint}$_0$\ {\it paint}$_5$ etex, (5.6u, 4.5u));
for n = 0 upto 3:
  label.rt(btex {\it newRow}$_2$\ {\it paint}$_1$ etex, (5.6u, (n+.5)*u));
endfor
endfig;
\endmplibcode$$

@<|curEdges|가 나타내는...@>=
prevN = 4096
p = knil(curEdges)
n = nMax(curEdges) - zeroField
for p != curEdges {
	@<가장자리 행 |p|의 화소들을 글꼴 행 |n|으로 내보낸다@>
	p = knil(p)
	n--
}
if prevN == 4096 {
	@<온통 빈 문자를 마무리한다@>
} else if prevN+yOff < gfMinN {
	gfMinN = prevN + yOff
}

@ @<온통 빈 문자를...@>=
gfBoc(0, 0, 0, 0)
if gfMaxM < 0 {
	gfMaxM = 0
}
if gfMinN > 0 {
	gfMinN = 0
}

@ 이 반복문에서 |prevW|는 지금까지 출력에 반영된 가장 최근의 열인 열 |prevM|에서의 무게를 나타내고, |w|는 가장자리
자료에서 가장 최근의 열인 열~|m|에서의 무게를 나타낸다. 여러 가장자리가 같은 열 위치에서 서로 상쇄될 수 있으므로,
실제로 무언가를 내보내기 전에 열~|mm|까지 미리 보아야 한다.

\.{GF}에서 검은 화소란 무게가 양수인 화소다. 그래서 무게가 0 이하에서 양수로 바뀌는 곳에서 검정을 시작하고, 양수에서
0 이하로 바뀌는 곳에서 검정을 멈춘다.

@<가장자리 행 |p|의 화소들을 글꼴 행 |n|으로 내보낸다@>=
if unsorted(p) > void {
	sortEdges(p)
}
q = sorted(p)
w = 0
prevM = -fractionOne // $|fractionOne|\approx\infty$
ww = 0
prevW = 0
m = prevM
for {
	if q == sentinel {
		mm = fractionOne
	} else {
		d = ho(info(q))
		mm = d / 8
		ww = ww + (d % 8) - zeroW
	}
	@<열이 바뀌었으면 무게의 부호를 보아 검정을 시작하거나 멈춘다@>
	w = ww
	q = link(q)
	if mm == fractionOne {
		break
	}
}
if w != 0 { // 이것은 있을 수 없는 일이어야 한다
	printNl("(There's unbounded black in character shipped out!)")
}
@.There's unbounded black...@>
if prevM-mOffset(curEdges)+xOff > gfMaxM {
	gfMaxM = prevM - mOffset(curEdges) + xOff
}

@ 열 |mm|이 열 |m|과 다르면 열 |m|에서의 무게 |w|가 확정된 것이다. 그 무게의 부호가 앞서 내보낸 무게 |prevW|의
부호와 다르면 검정을 시작하거나 멈춘다.

@<열이 바뀌었으면 무게의 부호를 보아 검정을 시작하거나 멈춘다@>=
if mm != m {
	if prevW <= 0 {
		if w > 0 {
			@<$(m,n)$에서 검정을 시작한다@>
		}
	} else if w <= 0 {
		@<$(m,n)$에서 검정을 멈춘다@>
	}
	m = mm
}

@ @<$(m,n)$에서 검정을 시작한다@>=
if prevM == -fractionOne {
	@<$(m,n)$에서 새 행을 시작한다@>
} else {
	gfPaint(m - prevM)
}
prevM = m
prevW = w

@ @<$(m,n)$에서 검정을 멈춘다@>=
gfPaint(m - prevM)
prevM = m
prevW = w

@ 원본에서는 바로 다음 행으로 내려갈 때 \\{newRow} 명령을 내보내고 |done|으로 건너뛰어 흰 칠하기를 생략했다. 여기서는
그 흰 칠하기를 필요한 갈래 안으로 옮겨 레이블을 없앴다.

@<$(m,n)$에서 새 행을...@>=
if prevN == 4096 {
	gfBoc(mMin(curEdges)+xOff-zeroField, mMax(curEdges)+xOff-zeroField,
		nMin(curEdges)+yOff-zeroField, n+yOff)
	curMinM = mMin(curEdges) - zeroField + mOffset(curEdges)
	gfPaint(m - curMinM) // 흰색을 칠하며 열 $m$으로 건너뛴다
} else if prevN > n+1 {
	@<|prevN-n|행 아래로 건너뛴다@>
	gfPaint(m - curMinM)
} else {
	@<다음 행의 열 $m$으로 건너뛰거나, 행을 0개 건너뛴다@>
}
prevN = n

@ @<다음 행의 열 $m$으로...@>=
delta = m - curMinM
if delta > maxNewRow {
	gfOut(skip0)
	gfPaint(m - curMinM)
} else {
	gfOut(newRow0 + delta)
}

@ @<|prevN-n|행 아래로...@>=
delta = prevN - n - 1
if delta < 0o400 {
	gfOut(skip1)
	gfOut(delta)
} else {
	gfOut(skip1 + 1)
	gfTwo(delta)
}

@ 프로시저 |shipOut|을 마쳤으니, 사용자가 \.{GF} 파일로 무언가를 보내는 다른 명령들을 보자.

@<특정한 명령을 부르는...@>=
case specialCommand:
	doSpecial()

@ @<\MF의 원시 명령을...@>=
primitive("special", specialCommand, stringType)
@!@:special_}{\KW{special} primitive@>
primitive("numspecial", specialCommand, known)
@!@:num_special_}{\KW{numspecial} primitive@>

@ @<함수들@>=
func doSpecial() {
	var m smallNumber // |stringType|이거나 |known|
	m = curMod
	getXNext()
	scanExpression()
	if internal[proofing] >= 0 {
		if curType != m {
			@<부적당한 특별 연산이라고 불평한다@>
		} else {
			checkGf()
			if m == stringType {
				gfString(curExp, 0)
			} else {
				gfOut(yyy)
				gfFour(curExp)
			}
		}
	}
	flushCurExp(0)
}

@ @<부적당한 특별 연산이라고...@>=
expErr("Unsuitable expression")
@.Unsuitable expression@>
help1("The expression shown above has the wrong type to be output.")
putGetError()

@ @<현재 식을 제목으로...@>=
checkGf()
gfString(str("title "), curExp)
@.title@>

@ @<번호로 쓰이는 문자열 상수들@>=
"title ",

@ @<|printCmdMod|에서 원시 명령을...@>=
case specialCommand:
	if m == known {
		printStr("numspecial")
	} else {
		printStr("special")
	}

@ @<문자가 내보내졌는지...@>=
curExp = roundUnscaled(curExp) % 256
if curExp < 0 {
	curExp = curExp + 256
}
booleanReset(charExists[curExp])
curType = booleanType

@ 프로그램이 끝날 때 후문을 써서 일을 마무리해야 한다. \.{TFM} 정보를 먼저 계산해 두었어야 한다.

이 루틴을 위해 정수 변수 |k|와 |scaled| 변수 |x|가 선언되어 있을 것이다.

@<\.{GF} 파일을 마무리한다@>=
gfOut(post) // 후문의 시작
gfFour(gfPrevPtr)
gfPrevPtr = gfOffset + gfPtr - 5 // |post|의 위치
gfFour(internal[designSize] * 16)
for k = 1; k <= 4; k++ {
	gfOut(headerByte[k]) // 검사합
}
gfFour(internal[hppp])
gfFour(internal[vppp])
gfFour(gfMinM)
gfFour(gfMaxM)
gfFour(gfMinN)
gfFour(gfMaxN)
@<문자 위치 표시들을 내보낸다@>
gfOut(postPost)
gfFour(gfPrevPtr)
gfOut(gfIdByte)
k = 4 + ((gfBufSize - gfPtr) % 4) // 223의 개수
for k > 0 {
	gfOut(223)
	k--
}
@<|gfBuf|에서 마지막 바이트들을...@>
@<\.{GF} 파일을 다 썼다고 알리고 닫는다@>

@ 문자 위치 표시는 내보낸 문자마다 하나씩이다. 세로 이동이 없고 가로 이동이 0에서 255 사이의 정수 화소이면 짧은 꼴
\\{charLoc0}(곧 |charLoc+1|)을 쓴다. 문자 너비는 \.{TFM}에 쓴 것과 같은 \ID{fixWord}여야 하므로 |dimenOut|과 같은
계산을 하는데, 범위를 벗어나는 너비는 |tfmChanged|를 늘리지 않고 그냥 가장 큰 값으로 바꾼다.

@<문자 위치 표시들을...@>=
for k = 0; k <= 255; k++ {
	if charExists[k] {
		x = gfDx[k] / unity
		if gfDy[k] == 0 && x >= 0 && x < 256 && gfDx[k] == x*unity {
			gfOut(charLoc + 1)
			gfOut(k)
			gfOut(x)
		} else {
			gfOut(charLoc)
			gfOut(k)
			gfFour(gfDx[k])
			gfFour(gfDy[k])
		}
		x = value(tfmWidth[k])
		if abs(x) > maxTfmDimen {
			if x > 0 {
				x = threeBytes - 1
			} else {
				x = 1 - threeBytes
			}
		} else {
			x = makeScaled(x*16, internal[designSize])
		}
		gfFour(x)
		gfFour(charPtr[k])
	}
}

@ @<\.{GF} 파일을 다 썼다고...@>=
printNl("Output written on ")
slowPrint(outputFileName)
@.Output written...@>
printStr(" (")
printInt(totalChars)
printStr(" character")
if totalChars != 1 {
	printChar('s')
}
printStr(", ")
printInt(gfOffset + gfPtr)
printStr(" bytes).")
bClose(&gfFile)

@* 표의 덤프와 언덤프.
\.{INIMF}가 매크로를 한 무더기 보고 나면, 필요한 정보를 모두 보조 파일에 써 둘 수 있다. 그래서 실무용 \MF가 그
메모리를 빠른 속도로 초기화할 수 있다. 프로그램의 이 부분이 그런 출력과 입력을 맡는다. 둘 사이의 역관계가 분명하도록
저장과 복원 과정을 함께 살펴보겠다.
@.INIMF@>

전역 변수 |baseIdent|는 \MF가 시작할 준비가 되었을 때 |banner| 줄 바로 뒤에 찍는 문자열이다. \.{INIMF}에서 이 문자열은
그저 `\.{ (INIMF)}'라고 하고, 다른 판의 \MF에서는 이를테면 `\.{ (preloaded base=plain 1984.2.29)}'라고 해서 기반
파일을 만든 해와 달과 날을 보인다. \MF의 표를 불러오기 전에는 |baseIdent=0|이다.

@<전역 변수@>=
var @!baseIdent strNumber

@ @<핵심 변수들의...@>=
baseIdent = 0

@ @<표의 항목들을...@>=
baseIdent = str(" (INIMF)")

@ @<번호로 쓰이는 문자열 상수들@>=
" (INIMF)",

@ 다음 프로시저는 \.{INIMF}에서만 쓰인다.

@<함수들@>=
func storeBaseFile() {
	var k int32 // 만능 첨자
	var p, q pointer // 만능 포인터
	var x int32 // 덤프할 무언가
	var w fourQuarters // ASCII 코드 네 개
	dumpFourASCII := func() {
		w.b0 = qi(so(strPool[k]))
		w.b1 = qi(so(strPool[k+1]))
		w.b2 = qi(so(strPool[k+2]))
		w.b3 = qi(so(strPool[k+3]))
		dumpQqqq(w)
	}
	@<|baseIdent|를 만들고, 기반 파일을 열고, 덤프를 시작했다고 알린다@>
	@<일관성 검사를 위한 상수들을 덤프한다@>
	@<문자열 풀을 덤프한다@>
	@<동적 메모리를 덤프한다@>
	@<등가물 표와 해시 표를 덤프한다@>
	@<몇 가지 더와 마무리 검사 낱말을 덤프한다@>
	@<기반 파일을 닫는다@>
}

@ 기반 파일을 덤프하는 프로시저에 대응해서, 기반 파일을 읽어 들이는 함수가 있다. 이 함수는 덤프된 기반이 지금 \MF의
표 크기 따위와 맞지 않으면 |false|를 돌려준다.

원본에서는 매크로 \\{undump}가 값이 범위를 벗어나면 곧바로 |goto offBase|했다. 그러나 \GO/의 함수는 부른 쪽의 레이블로
갈 수 없다. 그래서 \.{TeX}의 \GO/ 판에서 한 것처럼 |undump(a,b,&x)|와 |undumpSize(a,b,s,&x)|는 값이 맞으면 |x|에 넣고
|true|를, 그렇지 않으면 |false|를 돌려주며, 부르는 쪽이 |goto offBase|한다.

@<함수들@>=
func loadBaseFile() bool {
	var k int32 // 만능 첨자
	var p, q pointer // 만능 포인터
	var x int32 // 언덤프한 무언가
	var w fourQuarters // ASCII 코드 네 개
	undumpFourASCII := func() {
		w = undumpQqqq()
		strPool[k] = si(qo(w.b0))
		strPool[k+1] = si(qo(w.b1))
		strPool[k+2] = si(qo(w.b2))
		strPool[k+3] = si(qo(w.b3))
	}
	@<일관성 검사를 위한 상수들을 언덤프한다@>
	@<문자열 풀을 언덤프한다@>
	@<동적 메모리를 언덤프한다@>
	@<등가물 표와 해시 표를 언덤프한다@>
	@<몇 가지 더와 마무리 검사 낱말을 언덤프한다@>
	return true // 됐다!
offBase:
	wakeUpTerminal()
	wtermLn("(Fatal base file error; I'm stymied)")
@.Fatal base file error@>
	return false
}

@ 기반 파일은 |memoryWord| 항목들로 이루어지고, 여러 형의 낱말을 덤프하는 데 다음 함수들을 쓴다.

@<전역 변수@>=
var @!baseFile wordFile // 기반 정보의 입력이나 출력에 쓴다

@ @<함수들@>=
func dumpWd(w memoryWord)      { baseFile.buf = w; wPut(&baseFile) }
func dumpInt(x int32)          { baseFile.buf = memoryWord{sc: x}; wPut(&baseFile) }
func dumpHh(h twoHalves)       { baseFile.buf = memoryWord{hh: h}; wPut(&baseFile) }
func dumpQqqq(q fourQuarters)  { baseFile.buf = memoryWord{qqqq: q}; wPut(&baseFile) }

@ 낱말 파일의 기본 연산은 현재 원소 |f.buf|를 파일에 쓰는 |wPut|과 다음 원소를 |f.buf|에 읽어 오는 |wGet|이다. 형
|memoryWord|는 필드가 따로따로인 구조체이므로(\secref{memory-word}), 한 낱말을 쓸 때 모든 필드를 차례로 쓴다. 32비트
정수 아홉 개, 모두 36바이트다. 바이트 순서는 리틀 엔디언으로 정한다. 기반 파일이 다 그렇듯이, 이 형식의 파일은 이
프로그램으로 만든 \MF끼리만 주고받을 수 있다.
@^system dependencies@>

\PASCAL의 파일 변수에는 ``버퍼 변수'' |baseFile^|가 딸려 있어서, 파일을 열면 첫 원소가 곧바로 그 안에 들어온다.
함수 |wOpenIn|이 첫 |wGet|을 부르는 것은 이 동작을 흉내 낸 것이다. 그래서 언덤프의 첫 낱말은 |wGet| 없이 |baseFile.buf|에서
바로 읽는다. 읽기에 실패하면 |atEOF|를 켜는데, 이것이 \PASCAL의 |eof|에 해당한다.

@<함수들@>=
func wPut(f *wordFile) { // |f.buf|를 파일에 쓴다
	var b [36]byte
	var v = [9]uint32{uint32(f.buf.sc),
		uint32(f.buf.hh.rh), uint32(f.buf.hh.lh), uint32(f.buf.hh.b0), uint32(f.buf.hh.b1),
		uint32(f.buf.qqqq.b0), uint32(f.buf.qqqq.b1), uint32(f.buf.qqqq.b2), uint32(f.buf.qqqq.b3)}
	for i, x := range v {
		b[4*i], b[4*i+1], b[4*i+2], b[4*i+3] = byte(x), byte(x>>8), byte(x>>16), byte(x>>24)
	}
	f.w.Write(b[:])
}

func wGet(f *wordFile) { // 다음 원소를 |f.buf|에 읽어 온다
	var b [36]byte
	var v [9]uint32
	if _, err := io.ReadFull(f.r, b[:]); err != nil {
		f.atEOF = true
		return
	}
	for i := range v {
		v[i] = uint32(b[4*i]) | uint32(b[4*i+1])<<8 | uint32(b[4*i+2])<<16 | uint32(b[4*i+3])<<24
	}
	f.buf.sc = int32(v[0])
	f.buf.hh = twoHalves{rh: int32(v[1]), lh: int32(v[2]), b0: int32(v[3]), b1: int32(v[4])}
	f.buf.qqqq = fourQuarters{int32(v[5]), int32(v[6]), int32(v[7]), int32(v[8])}
}

@ 언덤프 함수들은 조금 더 복잡하다. 읽어 들이는 값의 범위를 검사해야 하기 때문이다. 우리는 `|undump(a,b,&x)|'라고
해서 |a<=x<=b| 범위에 있어야 할 정수 값 |x|를 읽는다. 언덤프하는 동안에는 시스템 오류 메시지를 억눌러야 한다.
@^system dependencies@>

@<함수들@>=
func undumpWd() memoryWord     { wGet(&baseFile); return baseFile.buf }
func undumpInt() int32         { wGet(&baseFile); return baseFile.buf.sc }
func undumpHh() twoHalves      { wGet(&baseFile); return baseFile.buf.hh }
func undumpQqqq() fourQuarters { wGet(&baseFile); return baseFile.buf.qqqq }

func undump(a, b int32, v *int32) bool {
	x := undumpInt()
	if x < a || x > b {
		return false
	}
	*v = x
	return true
}

func undumpSize(a, b int32, s string, v *int32) bool {
	x := undumpInt()
	if x < a {
		return false
	}
	if x > b { // 표가 너무 작다
		wakeUpTerminal()
		wtermLn("---! Must increase the ", s)
@.Must increase the x@>
		return false
	}
	*v = x
	return true
}

@ \seclabel{dump-constants}프로그램의 다음 몇 절을 보면 덤프와 언덤프 함수를 어떻게 쓰는지 분명해질 것이다. 원본은
첫 낱말에 \.{WEB}의 문자열 풀 검사합 \.{@@\$}를 덤프한다. 여기서는 그 대신 문자열 상수 목록의 검사합 |poolCheckSum|을
덤프한다(\secref{pool-check}).

@<일관성 검사를 위한 상수들을 덤프한다@>=
dumpInt(poolCheckSum())
dumpInt(memMin)
dumpInt(memTop)
dumpInt(hashSize)
dumpInt(hashPrime)
dumpInt(maxInOpen)

@ 검사합 함수 |poolCheckSum|은 미리 불러 두는 문자열들의 문자와 길이로부터 계산한다.

@<함수들@>=
func poolCheckSum() int32 { // 미리 불러 두는 문자열들의 검사합
	var a int32 = 314159
	for _, s := range poolLiterals {
		for i := 0; i < len(s); i++ {
			a = (a*31 + int32(s[i])) % 0o10000000000
		}
		a = (a*37 + int32(len(s))) % 0o10000000000
	}
	return a
}

@ 원본은 ``주석 처리된 \.{WEB} 프로그램의 절들도 문자열 풀에 문자열을 보태므로 \.{INIMF}와 \MF는 같은 문자열을 가진다''고
말한다. 여기서는 프로그램 하나가 \.{INIMF}와 실무용 판을 겸하므로, 둘은 언제나 같은 문자열 상수 목록을 가진다. (그리고
물론 그렇게 되는 것은 좋은 일이다.)
@.WEB@>
@^string pool@>

@<일관성 검사를 위한 상수들을 언덤프한다@>=
x = baseFile.buf.sc
if x != poolCheckSum() {
	goto offBase // 문자열들이 같은지 검사한다
}
x = undumpInt()
if x != memMin {
	goto offBase
}
x = undumpInt()
if x != memTop {
	goto offBase
}
x = undumpInt()
if x != hashSize {
	goto offBase
}
x = undumpInt()
if x != hashPrime {
	goto offBase
}
x = undumpInt()
if x != maxInOpen {
	goto offBase
}

@ 문자열 풀은 네 문자씩 한 낱말에 꾸려 덤프한다. 마지막 낱말은 |poolPtr-4|에서 시작하므로 앞 낱말과 겹칠 수 있지만,
같은 문자를 두 번 쓸 뿐이니 해가 없다. (변수 |poolPtr|는 처음 256개의 문자열만으로도 4보다 훨씬 크다.)

@<문자열 풀을 덤프한다@>=
dumpInt(poolPtr)
dumpInt(strPtr)
for k = 0; k <= strPtr; k++ {
	dumpInt(strStart[k])
}
k = 0
for k+4 < poolPtr {
	dumpFourASCII()
	k = k + 4
}
k = poolPtr - 4
dumpFourASCII()
printLn()
printInt(strPtr)
printStr(" strings of total length ")
printInt(poolPtr)

@ @<문자열 풀을 언덤프한다@>=
if !undumpSize(0, poolSize, "string pool size", &poolPtr) {
	goto offBase
}
if !undumpSize(0, maxStrings, "max strings", &strPtr) {
	goto offBase
}
for k = 0; k <= strPtr; k++ {
	if !undump(0, poolPtr, &strStart[k]) {
		goto offBase
	}
	strRef[k] = maxStrRef
}
k = 0
for k+4 < poolPtr {
	undumpFourASCII()
	k = k + 4
}
k = poolPtr - 4
undumpFourASCII()
initStrPtr = strPtr
initPoolPtr = poolPtr
maxStrPtr = strPtr
maxPoolPtr = poolPtr

@ 배열 |mem|의 가변 크기 부분에서 쓸 수 있는 공간 목록을 정렬하면, 대개 동적 메모리를 그리 많이 덤프하지 않아도 된다.
빈 노드들을 위치 순서로 정렬해 두면, 각 빈 노드의 첫 두 낱말(크기와 연결)만 덤프하고 나머지는 건너뛸 수 있기 때문이다.

또 |varUsed|와 |dynUsed|를 다시 계산해서, 통계를 모으지 않았을 때도 \.{INIMF}가 올바른 정보를 덤프하게 한다.

@<동적 메모리를 덤프한다@>=
sortAvail()
varUsed = 0
dumpInt(loMemMax)
dumpInt(rover)
p = memMin
q = rover
x = 0
for {
	for k = p; k <= q+1; k++ {
		dumpWd(mem[k])
	}
	x = x + q + 2 - p
	varUsed = varUsed + q - p
	p = q + nodeSize(q)
	q = rlink(q)
	if q == rover {
		break
	}
}
varUsed = varUsed + loMemMax - p
dynUsed = memEnd + 1 - hiMemMin
for k = p; k <= loMemMax; k++ {
	dumpWd(mem[k])
}
x = x + loMemMax + 1 - p
dumpInt(hiMemMin)
dumpInt(avail)
for k = hiMemMin; k <= memEnd; k++ {
	dumpWd(mem[k])
}
x = x + memEnd + 1 - hiMemMin
@<동적 메모리 사용량을 덤프하고 알린다@>

@ @<동적 메모리 사용량을...@>=
p = avail
for p != null {
	dynUsed--
	p = link(p)
}
dumpInt(varUsed)
dumpInt(dynUsed)
printLn()
printInt(x)
printStr(" memory locations dumped; current usage is ")
printInt(varUsed)
printChar('&')
printInt(dynUsed)

@ @<동적 메모리를 언덤프한다@>=
if !undump(loMemStatMax+1000, hiMemStatMin-1, &loMemMax) {
	goto offBase
}
if !undump(loMemStatMax+1, loMemMax, &rover) {
	goto offBase
}
p = memMin
q = rover
for {
	for k = p; k <= q+1; k++ {
		mem[k] = undumpWd()
	}
	p = q + nodeSize(q)
	if p > loMemMax || (q >= rlink(q) && rlink(q) != rover) {
		goto offBase
	}
	q = rlink(q)
	if q == rover {
		break
	}
}
for k = p; k <= loMemMax; k++ {
	mem[k] = undumpWd()
}
if !undump(loMemMax+1, hiMemStatMin, &hiMemMin) {
	goto offBase
}
if !undump(null, memTop, &avail) {
	goto offBase
}
memEnd = memTop
for k = hiMemMin; k <= memEnd; k++ {
	mem[k] = undumpWd()
}
varUsed = undumpInt()
dynUsed = undumpInt()

@ 해시 표를 압축하는 데는 다른 방식을 쓴다. 그 아래쪽 영역은 대개 성기기 때문이다. 위치 |p<=hashUsed|에 대해
|text(p)!=0|이면 세 낱말, 곧 |p|와 |hash[p]|와 |eqtb[p]|를 출력한다. 위치 |p>=hashUsed|에서는 해시 표가 물론 촘촘히 차 있으므로
나머지 항목은 한 덩어리로 출력한다.

@<등가물 표와 해시 표를 덤프한다@>=
dumpInt(hashUsed)
stCount = frozenInaccessible - 1 - hashUsed
for p = 1; p <= hashUsed; p++ {
	if text(p) != 0 {
		dumpInt(p)
		dumpHh(hash[p])
		dumpHh(eqtb[p])
		stCount++
	}
}
for p = hashUsed + 1; p <= hashEnd; p++ {
	dumpHh(hash[p])
	dumpHh(eqtb[p])
}
dumpInt(stCount)
printLn()
printInt(stCount)
printStr(" symbolic tokens")

@ @<등가물 표와 해시 표를 언덤프한다@>=
if !undump(1, frozenInaccessible, &hashUsed) {
	goto offBase
}
p = 0
for {
	if !undump(p+1, hashUsed, &p) {
		goto offBase
	}
	hash[p] = undumpHh()
	eqtb[p] = undumpHh()
	if p == hashUsed {
		break
	}
}
for p = hashUsed + 1; p <= hashEnd; p++ {
	hash[p] = undumpHh()
	eqtb[p] = undumpHh()
}
stCount = undumpInt()

@ 이미 통계를 많이 찍었으므로, 그것이 다시 나타나지 않도록 |tracingStats:=0|으로 놓는다.

마지막 검사 낱말 69069는 아무 뜻 없는 수가 아니다. 크누스가 좋아하는 선형 합동 난수 생성기의 곱수 가운데 하나다.

@<몇 가지 더와 마무리 검사 낱말을 덤프한다@>=
dumpInt(intPtr)
for k = 1; k <= intPtr; k++ {
	dumpInt(internal[k])
	dumpInt(intName[k])
}
dumpInt(startSym)
dumpInt(interaction)
dumpInt(baseIdent)
dumpInt(bgLoc)
dumpInt(egLoc)
dumpInt(serialNo)
dumpInt(69069)
internal[tracingStats] = 0

@ \PASCAL의 |eof(baseFile)|은 마지막 검사 낱말을 실제로 읽지 못했을 때, 곧 파일이 잘렸을 때 참이 된다. 그것이
|baseFile.atEOF|다.

@<몇 가지 더와 마무리 검사 낱말을 언덤프한다@>=
if !undump(maxGivenInternal, maxInternal, &intPtr) {
	goto offBase
}
for k = 1; k <= intPtr; k++ {
	internal[k] = undumpInt()
	if !undump(0, strPtr, &intName[k]) {
		goto offBase
	}
}
if !undump(0, frozenInaccessible, &startSym) {
	goto offBase
}
if !undump(batchMode, errorStopMode, &interaction) {
	goto offBase
}
if !undump(0, strPtr, &baseIdent) {
	goto offBase
}
if !undump(1, hashEnd, &bgLoc) {
	goto offBase
}
if !undump(1, hashEnd, &egLoc) {
	goto offBase
}
serialNo = undumpInt()
x = undumpInt()
if x != 69069 || baseFile.atEOF {
	goto offBase
}

@ @<|baseIdent|를 만들고...@>=
selector = newString
printStr(" (preloaded base=")
printStr(jobName)
printChar(' ')
printInt(roundUnscaled(internal[year]))
printChar('.')
printInt(roundUnscaled(internal[month]))
printChar('.')
printInt(roundUnscaled(internal[day]))
printChar(')')
if interaction == batchMode {
	selector = logOnly
} else {
	selector = termAndLog
}
strRoom(1)
baseIdent = makeString()
strRef[baseIdent] = maxStrRef
packJobName(baseExtension)
for !wOpenOut(&baseFile) {
	promptFileName("base file name", baseExtension)
}
printNl("Beginning to dump on file ")
@.Beginning to dump...@>
slowPrint(wMakeNameString(&baseFile))
flushString(strPtr - 1)
printNl("")
slowPrint(baseIdent)

@ @<기반 파일을 닫는다@>=
wClose(&baseFile)

@* 주 프로그램.
이것이 바로 그것이다. 우리가 써 온 그 모든 프로시저를 실행하는 \MF의 부분이다.

음---거의 그렇다. 원본은 여기서 구문 분석 서브루틴들과 |forward|로 선언했던 프로시저들을 비로소 프로그램에 넣는다.
\PASCAL에서는 프로시저를 쓰기 전에 선언해야 하기 때문이다. \GO/에서는 그런 순서가 필요 없으므로 그것들은 모두 이미
|@<함수들@>|에 들어 있다. 우리가 잊었을지도 모르는 루틴 몇 개를 위해 자리를 남겨 두자.

@<함수들@>=
@<마지막 순간의 프로시저들@>

@ \MF84에는 두 판이 있다고 말했다. 하나는 \.{INIMF}라고 부르는데, 먼저 실행해야 한다. 이것은 기반 파일을 읽지 않고
@.INIMF@>
모든 것을 처음부터 초기화하고, 기반 파일을 덤프하는 능력이 있다. 다른 하나는 `\.{VIRMF}'라고 부른다. 이것은 시작하려면
@.VIRMF@>
기반 파일을 입력해야 하는 ``처녀'' 프로그램이다. 대개 \.{VIRMF}는 \.{INIMF}보다 메모리 용량이 조금 크다. 덤프와 언덤프
루틴과 |primitive|의 수많은 호출 따위가 차지하는 공간이 필요 없기 때문이다.

물론 \.{VIRMF} 프로그램은 기반 파일을 순식간에 읽을 수는 없다. 그래서 가장 좋은 구현에서는, \PASCAL\ 목적 코드를
불러들이는 루틴을 건너뛸 뿐 아니라 기반 파일까지 미리 불러 둔 실무용 \MF를 만들 수 있다. 표준 \PASCAL을 고집하면
이것은 불가능하다. 그러나 많은 시스템을 속여서 초기화를 피하게 하는 간단한 방법이 있다. (1)~|readyAlready|라는 전역
정수 변수를 선언한다. \.{VIRMF}를 처음 불러들였을 때 이 변수가 314159 같은 특정한 값을 가질 확률은 무시할 만하다.
(2)~기반 파일을 읽어 들이고 모든 것을 초기화한 뒤에 |readyAlready=314159|로 한다. (3)~곧 \.{VIRMF}는 `\.*'를 찍고
입력을 더 기다릴 것이다. 이때 프로그램을 끊고 그 코어 이미지를 운영체제가 빨리 다시 불러들일 수 있는 꼴로 저장한다.
(4)~그 코어 이미지를 작동시키면 프로그램은 처음부터 다시 시작한다. 그러나 이제 |readyAlready=314159|이고 다른 모든
전역 변수도 초깃값을 가지고 있다. 이전의 순결은 사라졌다!

다시 말해 |readyAlready|에 값을 배정하기 전에 조건 |readyAlready=314159|를 검사하는 것을 스스로 허락하면 긴 초기화를
피할 수 있다. 더러운 속임수가 이렇게 큰 보상을 주는 일은 드물다.
@^dirty \PASCAL@>
@^system dependencies@>

그런 미리 불러 두기를 허락하는 시스템에서는 \.{MF}라는 표준 프로그램이 \.{plain} 기반을 미리 불러 둔 것이어야 한다.
그것이 {\sl The {\logos METAFONT\/}book}과 맞기 때문이다. 다른 판들, 이를테면 \.{CMMF}도 \.{cmbase}처럼 흔히 쓰는
기반을 위해 마련해야 한다.
@:METAFONTbook}{\sl The {\logos METAFONT\/}book@>
@.cmbase@>
@.plain@>

\GO/ 프로그램은 늘 모든 전역 변수를 0으로 하고 시작하므로, 코어 이미지를 저장해 둘 수 없는 시스템에서는 이 속임수가
아무 일도 하지 않는다. 그래도 해가 없으므로 그대로 둔다.

@<전역 변수@>=
var @!readyAlready int32 // 경제를 위해 순수를 희생한다

@ \seclabel{main}이제 정말로 그것이다. \MF는 여기서 시작하고 여기서 끝난다.

변수 |readyAlready|에 관한 처음의 검사는 실행 시스템이 그런 ``실수''를 찾아낼 만큼 영리하면 지워야 한다.
@^system dependencies@>

다른 프로시저에서 레이블 |endOfMF|나 |finalEnd|로 갈 때는 그 레이블을 값으로 |panic|을 일으키므로
(\secref{outer-labels}), |main|은 맨 처음에 그것을 |recover|로 받는 함수를 미루어(|defer|) 둔다. 그 함수는 받은 값이
|endOfMF|이면 |closeFilesAndTerminate|를 부르고, 어느 쪽이든 |finalEnd| 뒤의 일을 한다. 정상적인 흐름에서는 주 프로그램
안에서 |endOfMF|로 뛰는 곳이 없으므로 그 레이블은 주석으로만 남는다. \.{INIMF}인지는 명령줄의 첫 인자가 `\.{-ini}'인지로
정한다.

@<주 프로그램@>=
func main() { // |startHere|
	@<바깥 레이블로 가는 |panic|을 받을 함수를 미루어 둔다@>
	iniVersion = len(os.Args) > 1 && os.Args[1] == "-ini"
	@<끼어들기 신호를 받으면...@>
	history = fatalErrorStop // 초기화하는 동안 그만둘 때를 대비한다
	tOpenOut() // 터미널을 출력용으로 연다
	if readyAlready == 314159 {
		goto startOfMF
	}
	@<``상수'' 값들이 서로 맞는지 검사한다@>
	if bad > 0 {
		wtermLn("Ouch---my internal constants have been clobbered!", "---case ", bad)
@.Ouch...clobbered@>
		goto finalEnd
	}
	initialize() // 전역 변수들을 처음 값으로 정한다
	if iniVersion {
		@<문자열 풀과 표와 원시 명령을 초기화한다; 문자열을 읽을 수 없으면 |goto finalEnd|@>
	}
	readyAlready = 314159
startOfMF:
	@<출력 루틴들을 초기화한다@>
	@<입력의 첫 줄을 얻고 시작할 준비를 한다@>
	history = spotless // 출발 준비 완료!
	if startSym > 0 { // `\KW{everyjob}' 기호를 끼워 넣는다
		curSym = startSym
		backInput()
	}
	mainControl() // 살아난다
	finalCleanup() // 죽을 준비를 한다
	closeFilesAndTerminate() // |endOfMF|
finalEnd:
	readyAlready = 0
	@<터미널의 마지막 줄을 끝내고 출력 버퍼를 비운다@>
}

@ \.{INIMF}만 하는 초기화다. 문자열 풀을 채우고, 표의 항목들을 다시 초기화하고, 원시 명령들을 해시 표에 넣고, 문자열
통계의 기준점을 정한다.

\.{INIMF}가 표의 항목들을 두 번 초기화하는 것에 주목하라. 한 번은 |initialize| 안에서, 또 한 번은 문자열 풀을 채운
다음 |initTab| 안에서다. 원본에서 이렇게 하는 까닭은 표의 항목 가운데 문자열을 쓰는 것이 있기 때문인 듯하다. 이
프로그램의 |str|은 풀 없이도 문자열 번호를 계산하므로 두 번째 초기화는 필요 없지만, 해가 없으니 원본을 따랐다.

@<문자열 풀과 표와 원시 명령을...@>=
if !getStringsStarted() {
	goto finalEnd
}
initTab() // 표들을 초기화한다
initPrim() // 원시 명령마다 |primitive|를 부른다
initStrPtr = strPtr
initPoolPtr = poolPtr
maxStrPtr = strPtr
maxPoolPtr = poolPtr
fixDateAndTime()

@ 텍스트 파일의 마지막 줄이 끝나지 않았으면 줄 끝을 손수 덧붙이고, 버퍼에 남은 터미널 출력도 비운다.

@<터미널의 마지막 줄을 끝내고...@>=
if termOffset > 0 {
	wtermCr()
}
updateTerminal()

@ 다음은 바깥 레이블로 가는 |panic|을 받는 함수다.

@<바깥 레이블로 가는...@>=
defer func() {
	r := recover()
	if r == nil {
		return
	}
	if r == endOfMF {
		closeFilesAndTerminate()
	} else if r != finalEnd {
		panic(r)
	}
	readyAlready = 0 // |finalEnd|
	@<터미널의 마지막 줄을 끝내고...@>
}()

@ 주 프로그램을 뼈대 끝에 둔다.

@<함수들@>=
@<주 프로그램@>

@ 여기서는 지역 운영체제에서 \MF의 일을 우아하게 마치는 데 필요한 일은 무엇이든 한다. 여기 코드는 치명적 오류 뒤에
작동할 수도 있다. 그러므로 오류 메시지를 낼 수 없는 ``안전한'' 연산으로만 이루어져야 한다. 이를테면 이때 |strRoom|이나
|makeString|을 부르는 것은 잘못일 것이다. 그러면 |overflow|를 부르게 되어 끝없는 루프로 이어질 수도 있기 때문이다.
@^system dependencies@>

프로시저 |finalCleanup|을 건너뛰면 이 프로그램은 아직 열려 있을지도 모르는 입력 파일들을 닫는 수고를 하지 않는다.

@<마지막 순간의...@>=
func closeFilesAndTerminate() {
	var k int32 // 만능 첨자
	var lh int32 // \.{TFM} 머리의 길이, 낱말 단위
	var lkOffset int32 // 배열 |ligKern|의 처음에 끼워 넣는 여분의 낱말; |0 .. 256|
	var p pointer // \.{TFM} 치수의 목록을 훑는다
	var x scaled // \.{GF} 파일로 내보내는 |tfmWidth| 값
	if stat {
		if internal[tracingStats] > 0 {
			@<이 작업에 관한 통계를 출력한다@>
		}
	}
	wakeUpTerminal()
	@<\.{TFM} 파일과 \.{GF} 파일을 마무리한다@>
	if logOpened {
		wlogCr()
		aClose(&logFile)
		selector = selector - 2
		if selector == termOnly {
			printNl("Transcript written on ")
@.Transcript written...@>
			slowPrint(logName)
			printChar('.')
		}
	}
}

@ \.{GF} 파일은 이미 시작했을 때, 그리고 오직 그때에만 마무리하고 싶다. 그것은 |gfPrevPtr|가 양수일 때, 그리고 오직
그때에만 참이다. \.{TFM} 파일은 \\{fontmaking}이 양수일 때, 그리고 오직 그때에만 만들고 싶다. \.{GF} 파일이 있으면
\.{TFM} 파일이 없더라도 \.{TFM} 너비는 계산해야 한다. \.{GF}의 후문에 너비가 들어가기 때문이다.

메모리 용량을 이미 넘긴 뒤에 또 메모리가 넘칠 일이 없도록, 이 지점에서 가변 크기 메모리를 모두 되찾는다.

@<\.{TFM} 파일과 \.{GF} 파일을...@>=
if gfPrevPtr > 0 || internal[fontmaking] > 0 {
	@<동적 메모리를 커다란 빈 노드 하나로 만든다@>
	@<\.{TFM} 너비를 다듬는다@>
	fixDesignSize()
	fixCheckSum()
	if internal[fontmaking] > 0 {
		@<\.{TFM} 높이, 깊이, 기울임 보정을 다듬는다@>
		internal[fontmaking] = 0 // 치명적 오류가 날 때 고리에 빠지지 않게 한다
		@<\.{TFM} 파일을 마무리한다@>
	}
	if gfPrevPtr > 0 {
		@<\.{GF} 파일을 마무리한다@>
	}
}

@ @<동적 메모리를 커다란...@>=
rover = loMemStatMax + 1
setLink(rover, emptyFlag)
loMemMax = hiMemMin - 1
if loMemMax-rover > maxHalfword {
	loMemMax = maxHalfword + rover
}
setNodeSize(rover, loMemMax-rover)
setLlink(rover, rover)
setRlink(rover, rover)
setLink(loMemMax, null)
setInfo(loMemMax, null)

@ 이 절은 |printStr| 명령을 쓰는 대신 기록 파일에 바로 쓴다. {\bf stat} 판이 아닌 \MF를 쓸 때 이 문자열들이 |strPool|
메모리를 차지할 필요가 없기 때문이다.

@<이 작업에 관한 통계를...@>=
if logOpened {
	wlogLn(" ")
	wlogLn("Here is how much of METAFONT's memory", " you used:")
@.Here is how much...@>
	wlog(" ", maxStrPtr-initStrPtr, " string")
	if maxStrPtr != initStrPtr+1 {
		wlog("s")
	}
	wlogLn(" out of ", maxStrings-initStrPtr)
	wlogLn(" ", maxPoolPtr-initPoolPtr, " string characters out of ", poolSize-initPoolPtr)
	wlogLn(" ", loMemMax-memMin+memEnd-hiMemMin+2, " words of memory out of ", memEnd+1-memMin)
	wlogLn(" ", stCount, " symbolic tokens out of ", hashSize)
	wlogLn(" ", maxInStack, "i,", intPtr, "n,", maxRoundingPtr, "r,", maxParamStack, "p,",
		maxBufStack+1, "b stack positions out of ",
		stackSize, "i,", maxInternal, "n,", maxWiggle, "r,", paramSize, "p,", bufSize, "b")
}

@ \KW{end}나 \KW{dump}를 훑었으면 루틴 |finalCleanup|에 이른다.

@<마지막 순간의...@>=
func finalCleanup() {
	var c smallNumber // \KW{end}이면 0, \KW{dump}이면 1
	c = curMod
	if jobName == 0 {
		openLogFile()
	}
	for inputPtr > 0 {
		if tokenState() {
			endTokenList()
		} else {
			endFileReading()
		}
	}
	for loopPtr != null {
		stopIteration()
	}
	for openParens > 0 {
		printStr(" )")
		openParens--
	}
	@<끝나지 않은 조건문들을 알리고 없앤다@>
	if history != spotless && (history == warningIssued || interaction < errorStopMode) &&
		selector == termAndLog {
		selector = termOnly
		printNl("(see the transcript file for additional information)")
@.see the transcript file...@>
		selector = termAndLog
	}
	if c == 1 {
		if iniVersion {
			storeBaseFile()
			return
		}
		printNl("(dump is performed only by INIMF)")
@.dump...only by INIMF@>
		return
	}
}

@ 여기서 원본은 비어 있는 |loopPtr|를 임시 포인터로 빌려 쓴다.

@<끝나지 않은 조건문들을...@>=
for condPtr != null {
	printNl("(end occurred when ")
@.end occurred...@>
	printCmdMod(fiOrElse, curIf) // `\KW{if}'나 `\KW{elseif}'나 `\KW{else}'
	if ifLine != 0 {
		printStr(" on line ")
		printInt(ifLine)
	}
	printStr(" was incomplete)")
	ifLine = ifLineField(condPtr)
	curIf = nameType(condPtr)
	loopPtr = condPtr
	condPtr = link(condPtr)
	freeNode(loopPtr, ifNodeSize)
}

@ 이 프로시저들은 \.{INIMF}에서만 쓰인다.

@<마지막 순간의...@>=
func initPrim() { // 모든 원시 명령을 초기화한다
	@<\MF의 원시 명령을 저마다 해시 표에 넣는다@>
}

func initTab() { // 다른 표들을 초기화한다
	var k int32 // 만능 첨자
	@<표의 항목들을 초기화한다(\.{INIMF}만 한다)@>
}

@ \seclabel{startup}다음 코드를 시작할 때 \MF의 표에는 아직 쓰레기가 들어 있을 수도 있다. 문자열조차 없을지도 모른다.
그러므로 조심스럽게 나아가며 스스로를 일으켜 세워야 한다.

그러나 프로그램의 이 부분을 마치면 \MF는 |mainControl| 루틴을 불러 일을 시킬 준비가 된다.

@<입력의 첫 줄을 얻고...@>=
@<입력 루틴들을 초기화한다@>
if baseIdent == 0 || buffer[loc] == '&' {
	if baseIdent != 0 {
		initialize() // 미리 불러 둔 기반을 지운다
	}
	if !openBaseFile() {
		goto finalEnd
	}
	if !loadBaseFile() {
		wClose(&baseFile)
		goto finalEnd
	}
	wClose(&baseFile)
	for loc < limit && buffer[loc] == ' ' {
		loc++
	}
}
buffer[limit] = '%'
fixDateAndTime()
initRandoms(sysTime + sysDay*unity)
@<|interaction|에 따라 찍기 |selector|를 초기화한다@>
if loc < limit && buffer[loc] != '\\' {
	startInput() // \KW{input}을 가정한다
}

@* 디버깅.
\MF가 일단 작동하면 \.{show} 명령과 다른 진단 기능으로 대부분의 오류를 진단할 수 있을 것이다. 그러나 디버깅의 초기
단계와, 정말로 깊은 수수께끼를 밝히는 데에는, 실행 시간 검사와 디버거를 비롯한 도구 몇 가지를 더 넣어 \MF를
컴파일할 수 있다. 오류 메시지 뒤에 `\.D'를 치면 |debugHelp|라는 루틴도 작동한다. 이 루틴은 치명적 오류 때문에 \MF가
굴복하기 바로 전에도 나타난다.
@^debugging@>
@^system dependencies@>

루틴 |debugHelp|와의 접속은 원시적이지만, 중단점을 걸고 변수를 읽고 값을 바꿀 수 있게 해 주는 디버거와 함께 쓰면
충분하다. `\.{debug \#}'라는 재촉 기호를 받고 나면 음수(이것은 |debugHelp|를 빠져나간다)나 0(이것은 중단점을 걸 수 있는
곳으로 가서 디버거와의 대화로 들어간다)을 치거나, 양수 |m|과 그 뒤에 인자 |n|을 친다. 두 수 |m|과 |n|의 뜻은 아래
프로그램을 보면 분명할 것이다. (만일 |m=13|이면 인자 |l|이 하나 더 있다.)
@.debug \#@>

이 프로시저는 |debug|가 참일 때에만 불린다. 터미널에서 수를 읽을 때는 |fmt.Fscan|을 쓴다. \GO/의 디버거(이를테면
\.{dlv})로 중단점을 걸고 싶으면 레이블 |breakpoint| 다음 줄에 걸면 된다.

@<마지막 순간의...@>=
func debugHelp() { // 여러 가지를 보이는 루틴
	var k, l, m, n int32
	clearTerminal()
	for {
		wakeUpTerminal()
		printNl("debug # (-1 to exit):")
		updateTerminal()
@.debug \#@>
		fmt.Fscan(termIn.r, &m)
		if m < 0 {
			return
		} else if m == 0 {
			goto breakpoint // 선언한 모든 레이블에 적어도 한 번은 간다
		breakpoint:
			m = 0 // `BREAKPOINT'
		} else {
			fmt.Fscan(termIn.r, &n)
			switch m {
			@<|debugHelp|의 번호 붙은 경우들@>
			default:
				printStr("?")
			}
		}
	}
}

@ @<|debugHelp|의 번호 붙은...@>=
case 1:
	printWord(mem[n]) // |mem[n]|을 모든 꼴로 보인다
case 2:
	printInt(info(n))
case 3:
	printInt(link(n))
case 4:
	printInt(eqType(n))
	printChar(':')
	printInt(equiv(n))
case 5:
	printVariableName(n)
case 6:
	printInt(internal[n])
case 7:
	doShowDependencies()
case 9:
	showTokenList(n, null, 100000, 0)
case 10:
	slowPrint(n)
case 11:
	checkMem(n > 0) // 올바른지 검사한다; |n>0|이면 새로 바쁜 위치를 찍는다
case 12:
	searchMem(n) // |n|을 가리키는 포인터를 찾는다
case 13:
	fmt.Fscan(termIn.r, &l)
	printCmdMod(n, l)
case 14:
	for k = 0; k <= n; k++ {
		printStr(buffer[k])
	}
case 15:
	panicking = !panicking

@* 시스템에 따른 변경.
\MF를 특정한 설치 환경에서 작동하게 하는 데 필요한 특별한 수정이 있다면 이 부를 그것으로 바꿔야 한다. 원본은 앞선 절들에
대한 바꿈이 절 번호를 지키도록 바꿈 파일을 짜는 것이 대개 가장 좋다고 권한다. 그러면 모든 사람의 판이 출판된 프로그램과
맞는다. 새 절을 들여오는 더 큰 바꿈은 여기에 끼워 넣을 수 있다. 그러면 찾아보기만 새 절 번호를 얻는다.
@^system dependencies@>

이 \GO/ 판에서 시스템에 따라 바꾼 것은 바꿈 파일이 아니라 본문 곳곳에 녹아 있다. 한데 모아 두면 다음과 같다.

\smallskip\item{$\bullet$} 파일 입출력은 |os|와 |bufio| 꾸러미로 한다(3부). 낱말 파일은 32비트 정수 아홉 개를 리틀
엔디언으로 쓴다(48부).

\smallskip\item{$\bullet$} 입력 파일은 먼저 현재 디렉터리에서, 다음에 환경 변수 \.{MFINPUTS}가 가리키는 곳에서, 마지막으로
\.{kpsewhich}가 알려 주는 입력 디렉터리들을 한 번 훑어 만든 표에서 찾는다(\secref{external-name}). 기반 파일은 \.{MFBASES}에서 찾는다(38부).

\smallskip\item{$\bullet$} 명령줄의 첫 인자가 `\.{-ini}'이면 \.{INIMF}로 돈다(\secref{main}). 나머지 인자들은 입력의 첫
줄이 된다.

\smallskip\item{$\bullet$} 끼어들기 신호(\.{SIGINT})를 받으면 |interrupt|를 놓는다(6부).

\smallskip\item{$\bullet$} \PASCAL의 |goto|로 프로시저 바깥의 레이블로 뛰던 곳은 |panic|과 |recover|로 흉내 낸다
(\secref{outer-labels}).

\smallskip\item{$\bullet$} 용량 상수 |memMax|, |bufSize|, |fileNameSize|와 하프워드의 범위를 키웠다(1부, 9부).

\smallskip\noindent
그 밖에 화면 출력(27부)은 실제 화면에 그리지 않는다. 함수 |initScreen|이 |false|를 돌려주므로 \KW{openwindow}와
\KW{display}는 아무것도 보이지 않는다.


@* 찾아보기.
다음은 프로그램에서 각 식별자가 쓰인 곳을 모두 찾을 수 있는 곳이다. 밑줄 친 항목은 그 식별자가 정의된 곳을 가리킨다.
다만 식별자가 한 글자짜리이면 밑줄 친 항목만 보인다. {\sl 모든 참조는 쪽 번호가 아니라 절 번호다.}

이 찾아보기에는 오류 메시지와, 언젠가 찾아보고 싶을지도 모르는 프로그램의 다른 측면들도 올라 있다. 이를테면
``system dependencies'' 항목에는 새 운영 환경에 \MF를 설치하는 사람이 특별히 눈여겨보아야 할 절들이 모두 나온다.
일어날 수 없는 갖가지 일들의 목록은 ``this can't happen'' 아래에 있다. ``inner loop'' 아래에는 25개쯤의 절이 올라
있는데, 이것들이 입력과 출력을 빼고 \MF\ 실행 시간의 60\pct! 넘게 차지한다. 이 번역에서 찾은 원본의 문제들은
``bugs'' 아래에 모아 두었다.
