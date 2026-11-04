#!/bin/sh
# Go 컴파일러의 프로파일 기반 최적화(PGO)에 쓸 default.pgo를 만든다.
# INIMF로 plain 기반을 만들 때와, 글꼴 열 개를 한 작업에서 세 번씩 잇달아 읽어
# 4007자를 만드는 벤치마크(tests/regress.sh의 big)를 돌릴 때의 CPU 프로파일을 합친다.
# 꾸러미 디렉터리에 default.pgo가 있으면 go build가 저절로 그것을 쓴다.
#
#   tests/pgo.sh
#
# macOS에서는 Go의 CPU 프로파일러가 표본을 마지막 시스템 호출의 스택에 잘못 붙이므로
# 쓸 만한 프로파일이 나오지 않는다. 그래서 리눅스가 아니면 리눅스용으로 빌드해서
# 도커 컨테이너 안에서 돌린다. 프로파일은 함수 이름으로 맞추므로 어느 시스템에서
# 뜬 것이든 다른 시스템의 빌드에 쓸 수 있다.
#
# 필요한 것: go, kpsewhich, 리눅스가 아니면 docker
set -e

TOP=$(cd "$(dirname "$0")/.." && pwd)
W=$TOP/build/pgo
rm -rf "$W"; mkdir -p "$W/inputs"
cd "$W"

# 벤치마크와, 그것이 읽는 파일들을 한곳에 모은다(컨테이너는 배포판을 못 보므로)
{ echo 'let bye=relax; batchmode;'
  for r in 1 2 3; do for f in cmr10 cmbx12 cmti10 cmmi10 cmsy10 cmex10 cmtt10 cmss10 cmcsc10 cmfib8; do
    echo "input $f;"; done; done
  echo 'end.'; } > big.mf
cp "$(kpsewhich plain.mf)" "$(dirname "$(kpsewhich cmr10.mf)")"/*.mf inputs/

run='MFCPUPROFILE=ini.pprof ./mf -ini plain dump </dev/null >/dev/null 2>&1
MFCPUPROFILE=big.pprof ./mf "&plain \\mode=lowres; mag=3; input big" </dev/null >/dev/null 2>&1 || true'
if [ "$(uname)" = Linux ]; then
  (cd "$TOP" && go build -o "$W/mf" .)
  MFINPUTS=.:$W/inputs sh -c "$run"
else
  (cd "$TOP" && CGO_ENABLED=0 GOOS=linux go build -o "$W/mf" .)
  docker run --rm -v "$W":/w -w /w -e MFINPUTS=.:/w/inputs alpine:3.20 sh -c "$run"
fi
test -s ini.pprof && test -s big.pprof
grep -q '4007 characters' big.log
go tool pprof -proto ini.pprof big.pprof > "$TOP/default.pgo" 2>/dev/null
echo "default.pgo를 만들었다 ($(wc -c < "$TOP/default.pgo") 바이트)"
