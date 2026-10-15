# 한글 GWEB으로 옮긴 METAFONT (mf.w)
#
#   make            프로그램(build/mf)과 문서(mf.pdf)를 만든다
#   make build      mf.w에서 Go 소스를 뽑아(gtangle) build/mf를 만든다
#   make pdf        mf.w를 조판해(gweave, luatex 두 번) mf.pdf를 만든다
#   make check      mf.pdf의 조판 경고와 조용히 깨진 조판을 센다(둘 다 0이어야 한다)
#   make base       build/plain.base를 만든다(INIMF로 plain.mf를 읽고 dump)
#   make compare    글꼴 몇 개를 진짜 METAFONT(mf-nowin)로 만든 것과 비교한다
#   make trap       크누스의 TRAP 테스트를 돌린다
#   make test       compare와 trap을 모두 돌린다
#   make clean      만든 것을 모두 지운다
#   make deco       테두리에 액자를 두른 문서(mf-deco.pdf)를 만든다

BUILD = build

.PHONY: all build pdf check base compare trap test clean deco

all: build pdf

mf.go: mf.w
	gtangle mf.w

$(BUILD)/mf: mf.go go.mod
	@mkdir -p $(BUILD)
	go build -o $(BUILD)/mf .

build: $(BUILD)/mf

# 절 번호 참조(\secref)를 맞추려면 luatex를 두 번 돌려야 한다.
# gweave는 차례를 맨 끝에 두므로, qpdf로 차례를 맨 앞으로 옮긴다. 차례가 몇 쪽인지는
# mf.w의 \topofcontents가 로그에 적어 둔 "TOC begins after page B"로 안다:
# B+1쪽부터 끝까지가 차례다.
# $(1)은 조판할 .tex 파일의 이름(곧 \jobname), $(2)는 바꿈 파일이다.
define weave
	$(if $(2),mkdir -p $(BUILD) && gweave -o $(BUILD) mf.w $(2) && mv $(BUILD)/mf.tex $(1).tex,gweave mf.w)
	luatex --interaction=nonstopmode $(1).tex >/dev/null
	luatex --interaction=nonstopmode $(1).tex >/dev/null
	@b=$$(sed -n 's/^TOC begins after page \([0-9][0-9]*\)$$/\1/p' $(1).log); \
	test -n "$$b" || { echo "$(1).log에 차례의 시작 쪽이 없다" >&2; exit 1; }; \
	echo "qpdf $(1).pdf --pages $(1).pdf $$((b+1))-z,1-$$b -- $(1)-toc.pdf"; \
	qpdf $(1).pdf --pages $(1).pdf $$((b+1))-z,1-$$b -- $(1)-toc.pdf
	mv $(1)-toc.pdf $(1).pdf
endef

mf.pdf: mf.w
	$(call weave,mf)

pdf: mf.pdf

check: mf.pdf
	@n=$$(grep -ac 'Overfull\|Underfull\|Error\|Missing\|Undefined' mf.log); \
	echo "조판 경고: $$n"; test $$n -eq 0
	@python3 tests/typeset-check.py

$(BUILD)/plain.base: $(BUILD)/mf
	cd $(BUILD) && ./mf -ini plain dump </dev/null

base: $(BUILD)/plain.base

compare: $(BUILD)/mf
	tests/compare.sh

trap:
	tests/trap.sh

test: compare trap

# 액자를 두른 판은 mf-deco.pdf로 따로 만들어 mf.pdf를 건드리지 않는다
mf-deco.pdf: mf.w mf-deco.ch decoframe.pdf
	$(call weave,mf-deco,mf-deco.ch)

deco: mf-deco.pdf

clean:
	rm -rf $(BUILD) mf.go mf.tex mf.log mf.pdf mf.toc mf.ref mf.idx mf.scn\
	  mf-deco.tex mf-deco.log mf-deco.pdf mf-deco.toc mf-deco.ref
