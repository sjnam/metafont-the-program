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
#   make twill      쪽마다 미니 색인을 붙인 문서(mf-twill.pdf)를 gtwill로 만든다
#   make twill-deco 미니 색인과 액자를 함께 붙인 문서(mf-twill-deco.pdf)를 만든다

BUILD = build

.PHONY: all build pdf check base compare trap test clean deco twill twill-deco

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
	$(call movetoc,$(1))
endef

# $(1).pdf의 맨 끝에 있는 차례를 맨 앞으로 옮긴다.
define movetoc
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

# 미니 색인을 붙인 판은 크누스가 TWILL로 TeX: The Program을 찍은 방식을 따른다. 도구는
# gtwill(https://github.com/sjnam/gtwill)이고, 미니 색인을 정렬하는 gtwill-refsort와
# 매크로 gtwimac.tex가 함께 깔려 있어야 한다(gtwill 저장소에서 make install).
# 도구 gtwill이 gweave 자리에 들어가고, luatex는 세 번 돈다. 첫 번째는 \secref가 쓰는
# .ref 파일을 얻으려고, 두 번째는 맞는 \secref로 쪽을 나누어 정렬하지 않은 미니 색인을
# .mref 파일에 쓰려고 돈다. 그것을 gtwill-refsort로 정렬한 .smref 파일을 세 번째가 읽는다.
# 지난번의 .smref 파일이 남아 있으면 앞의 두 번이 그것을 읽어 버리므로 먼저 지운다.
# 쪽 나누기가 바뀌므로 판을 고칠 때마다 처음부터 다시 만들어야 한다.
GTWILL ?= gtwill
GTWILL_REFSORT ?= gtwill-refsort

define twill
	mkdir -p $(BUILD) && $(GTWILL) -o $(BUILD) mf.w $(2) && mv $(BUILD)/mf.tex $(1).tex
	rm -f $(1).smref
	luatex --interaction=nonstopmode $(1).tex >/dev/null
	luatex --interaction=nonstopmode $(1).tex >/dev/null
	$(GTWILL_REFSORT) < $(1).mref > $(1).smref
	luatex --interaction=nonstopmode $(1).tex >/dev/null
	@echo "$(1).pdf: 조판 경고 $$(grep -ac 'Overfull\|Underfull\|Error\|Missing\|Undefined' $(1).log)"
	$(call movetoc,$(1))
endef

mf-twill.pdf: mf.w mf.bux
	$(call twill,mf-twill)

twill: mf-twill.pdf

# 액자도 두르려면 mf-deco.ch를 그대로 쓴다. 거기서 \twillbackground를 \FrameBG로 둔다.
mf-twill-deco.pdf: mf.w mf.bux mf-deco.ch decoframe.pdf
	$(call twill,mf-twill-deco,mf-deco.ch)

twill-deco: mf-twill-deco.pdf

clean:
	rm -rf $(BUILD) mf.go mf.tex mf.log mf.pdf mf.toc mf.ref mf.idx mf.scn\
	  mf-deco.tex mf-deco.log mf-deco.pdf mf-deco.toc mf-deco.ref\
	  mf-twill.tex mf-twill.log mf-twill.pdf mf-twill.toc mf-twill.ref mf-twill.mref mf-twill.smref\
	  mf-twill-deco.tex mf-twill-deco.log mf-twill-deco.pdf mf-twill-deco.toc mf-twill-deco.ref\
	  mf-twill-deco.mref mf-twill-deco.smref
