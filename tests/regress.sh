#!/bin/sh
# 이 가지의 METAFONT(build/mf)가 기준 가지(기본값 main)의 METAFONT와 똑같은 결과를 내는지 본다.
# go-native 실험에서는 무엇을 고치든 출력이 한 바이트도 달라져서는 안 되므로,
# TeX Live의 mf-nowin이 아니라 고치기 전의 이 프로그램과 견준다.
#
#   tests/regress.sh            요약만 찍는다
#   tests/regress.sh -t         같은 작업을 여러 번 돌려 걸린 시간도 견준다
#
# 견주는 것:
#   - TRAP 테스트가 남기는 파일 일곱 개 (tests/trap.sh가 만든 build/trap과)
#   - INIMF로 plain 기반을 만들 때의 기록 파일과 터미널 출력(시간을 잴 때는 ini로 적는다)
#   - 글꼴 열한 개를 200dpi와 600dpi로 만든 GF, TFM, 기록 파일, 터미널 출력.
#     출력의 날짜는 늘 1776년 7월 4일이므로 모두 바이트 그대로 견준다.
#   - cmr10을 2000dpi로 만든 것(cmr10-2000)
#   - 글꼴 열 개를 세 번씩 잇달아 읽어 4007자를 만드는 작업(big, 오류가 1494개 난다)
#   - logo10을 loggingall로 모두 추적해 기록 파일이 커지는 작업(trace)
#   - 2만 자가 넘는 줄로 입력 버퍼를 넘치게 하는 작업(longline)
#   - 문자 두 개를 내보낸 뒤 한 문장에서 오류가 100개 나서 그만두는 작업(fatal)
#
# 필요한 것: build/mf (make build), make trap을 이미 돌린 build/trap, gtangle, go, kpsewhich
set -e

TOP=$(cd "$(dirname "$0")/.." && pwd)
timing=0; [ "$1" = "-t" ] && timing=1
BASE=${BASE:-main}
W=$TOP/build/regress
OURS=$TOP/build/mf
REF=$W/ref/mf
FONTS="cmr10 cmbx12 cmti10 cmmi10 cmsy10 cmex10 cmtt10 cmss10 cmcsc10 cmfib8 logo10"
TRAPFILES="trapin.log trapin.fot trap.log trap.fot trap.typ trap.pl trap.72270gf"

# 1. 기준 가지의 mf.w로 기준 METAFONT와 기준 TRAP 결과를 만든다
rm -rf "$W"; mkdir -p "$W/ref/tests"
git -C "$TOP" show "$BASE:mf.w" > "$W/ref/mf.w"
git -C "$TOP" show "$BASE:tests/trap.sh" > "$W/ref/tests/trap.sh"; chmod +x "$W/ref/tests/trap.sh"
cp "$TOP/go.mod" "$W/ref/"
cp -r "$TOP/tests/trap" "$W/ref/tests/"
(cd "$W/ref" && gtangle mf.w >/dev/null 2>&1 && go build -o mf . && tests/trap.sh >/dev/null 2>&1)

bad=0
same() { # $1: 이름, $2 $3: 견줄 두 파일
  if cmp -s "$2" "$3"; then printf '  %-28s 같다\n' "$1"
  else printf '  %-28s 다르다\n' "$1"; bad=1; diff "$2" "$3" 2>/dev/null | head -10 | sed 's/^/      /'; fi
}

echo "$BASE 가지의 METAFONT와 견준다"
for f in $TRAPFILES; do
  same "TRAP $f" "$W/ref/build/trap/$f" "$TOP/build/trap/$f"
done

# 2. 견줄 작업들을 마련한다
mkdir -p "$W/doc"; cd "$W/doc"
{ echo 'let bye=relax; batchmode;'
  for r in 1 2 3; do for f in cmr10 cmbx12 cmti10 cmmi10 cmsy10 cmex10 cmtt10 cmss10 cmcsc10 cmfib8; do
    echo "input $f;"; done; done
  echo 'end.'; } > big.mf
printf '%s\n' 'batchmode; loggingall; input logo10' > trace.mf
{ printf '%s\n' 'batchmode;' 'show 1;'
  for i in $(seq 3000); do printf '%s' 'abcdefgh '; done; printf '\n%s\n' 'end'; } > longline.mf
{ printf '%s\n' 'batchmode; mode_setup; font_size 10pt#;'
  printf '%s\n' 'beginchar("A",5pt#,6pt#,0); fill unitsquare scaled 5pt; endchar;'
  printf '%s\n' 'beginchar("B",5pt#,6pt#,0); draw (0,0)..(5pt,6pt) withpen pencircle; endchar;'
  printf '%s\n' 'x := 0 for i=1 upto 200: + "a" endfor;' 'end'; } > fatal.mf
# 작업마다 이름과 첫 줄의 인자
jobs() {
  for mag in 1 3; do for f in $FONTS; do
    echo "$f-$((200 * mag))|\\mode=lowres; mag=$mag; batchmode; input $f"; done; done
  echo 'cmr10-2000|\mode=lowres; mag=10; batchmode; input cmr10'
  echo 'big|\mode=lowres; mag=3; input big'
  echo 'trace|\mode=lowres; input trace'
  echo 'longline|\\input longline'
  echo 'fatal|\mode=lowres; input fatal'
}

# 3. 저마다 plain 기반을 만들고 작업들을 돌린다. 작업마다 디렉터리를 따로 둔다.
for who in ref ours; do
  mf=$REF; [ $who = ours ] && mf=$OURS
  mkdir -p "$W/$who/base"; cd "$W/$who/base"
  "$mf" -ini plain dump </dev/null >plain.fot 2>&1
  jobs | while IFS='|' read -r name arg; do
    d=$W/$who/$name; mkdir -p "$d"; cd "$d"
    cp "$W/doc/big.mf" "$W/doc/trace.mf" "$W/doc/longline.mf" "$W/doc/fatal.mf" .
    ln -s ../base/plain.base .
    "$mf" "&plain $arg" </dev/null >terminal.fot 2>&1 || true
    rm -f big.mf trace.mf longline.mf fatal.mf plain.base
  done
done
same "INIMF plain.fot" "$W/ref/base/plain.fot" "$W/ours/base/plain.fot"
same "INIMF plain.log" "$W/ref/base/plain.log" "$W/ours/base/plain.log"
jobs | while IFS='|' read -r name arg; do
  for f in $(cd "$W/ref/$name" && ls) $(cd "$W/ours/$name" && ls); do echo "$f"; done | sort -u |
  while read -r f; do same "$name $f" "$W/ref/$name/$f" "$W/ours/$name/$f"; done
done > "$W/report"
cat "$W/report"
grep -q '다르다' "$W/report" && bad=1

# 4. 원하면 걸린 시간을 견준다(다섯 번 가운데 가장 짧은 것)
if [ "$timing" = 1 ]; then
  echo "걸린 시간(초, 다섯 번 가운데 가장 짧은 것): 기준 / 이 가지"
  for job in ini cmr10-600 cmr10-2000 big; do
    for who in ref ours; do
      mf=$REF; [ $who = ours ] && mf=$OURS
      cd "$W/$who/base"
      case $job in
        ini) set -- -ini plain dump ;;
        cmr10-600) set -- '&plain \mode=lowres; mag=3; batchmode; input cmr10' ;;
        cmr10-2000) set -- '&plain \mode=lowres; mag=10; batchmode; input cmr10' ;;
        big) cp "$W/doc/big.mf" .; set -- '&plain \mode=lowres; mag=3; input big' ;;
      esac
      t=$(for i in 1 2 3 4 5; do /usr/bin/time -p "$mf" "$@" </dev/null 2>&1 >/dev/null |
        awk '/^real/{print $2}'; done | sort -n | head -1)
      eval "t_$who=$t"
    done
    printf '  %-28s %s / %s\n' "$job" "$t_ref" "$t_ours"
  done
fi

[ $bad = 0 ] && echo "모두 같다" || { echo "다른 것이 있다"; exit 1; }
