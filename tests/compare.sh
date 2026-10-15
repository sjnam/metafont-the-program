#!/bin/sh
# 글꼴 몇 개를 이 번역의 METAFONT와 진짜 METAFONT(TeX Live의 mf-nowin)로 만들어서
# TFM, GF, 기록 파일을 비교한다. GF 서문의 날짜 주석과 기록 파일의 첫 줄(배너와 날짜)은
# 빼고 비교한다.
#
#   tests/compare.sh                      기본 글꼴들을 200dpi와 600dpi로 비교한다
#   tests/compare.sh cmr10 cmbx12         주어진 글꼴들만 비교한다
#
# 필요한 것: build/mf (make build), TeX Live의 mf-nowin, gftype, kpsewhich
set -e

FONTS=${*:-"cmr10 cmbx12 cmti10 cmmi10 cmsy10 cmex10 cmtt10 cmss10 cmcsc10 cmfib8 logo10"}
TOP=$(cd "$(dirname "$0")/.." && pwd)
OURS=$TOP/build/compare/ours
REAL=$TOP/build/compare/real
rm -rf "$OURS" "$REAL"; mkdir -p "$OURS" "$REAL"

# 각자 plain 기반을 만든다
(cd "$OURS" && "$TOP/build/mf" -ini plain dump </dev/null >/dev/null 2>&1)
(cd "$REAL" && mf-nowin -ini plain dump </dev/null >/dev/null 2>&1)

# GF를 GFtype으로 풀되 서문의 날짜 주석과 GFtype의 배너는 뺀다
gfdump() { gftype -mnemonics "$1" | sed '1d; /METAFONT output/d'; }

fail=0
for mag in 1 3; do                       # lowres(200dpi)와 그 세 배(600dpi)
  dpi=$((200 * mag))
  for f in $FONTS; do
    kpsewhich "$f.mf" >/dev/null || { echo "$f.mf를 찾을 수 없다"; continue; }
    job="\\mode=lowres; mag=$mag; batchmode; input $f"
    (cd "$OURS" && "$TOP/build/mf" "&plain $job" </dev/null >/dev/null 2>&1) || true
    (cd "$REAL" && mf-nowin "&plain $job" </dev/null >/dev/null 2>&1) || true
    msg=""
    for x in "$REAL/$f.tfm" "$OURS/$f.tfm" "$REAL/$f.${dpi}gf" "$OURS/$f.${dpi}gf"; do
      [ -f "$x" ] || msg="$msg ${x#$TOP/build/compare/}없음"
    done
    cmp -s "$REAL/$f.tfm" "$OURS/$f.tfm" || msg="$msg TFM"
    [ "$(gfdump "$REAL/$f.${dpi}gf")" = "$(gfdump "$OURS/$f.${dpi}gf")" ] || msg="$msg GF"
    [ "$(sed 1d "$REAL/$f.log")" = "$(sed 1d "$OURS/$f.log")" ] || msg="$msg log"
    if [ -z "$msg" ]; then
      printf '  %-8s %4sdpi  같다\n' "$f" "$dpi"
    else
      printf '  %-8s %4sdpi  다르다:%s\n' "$f" "$dpi" "$msg"; fail=1
    fi
  done
done
exit $fail
