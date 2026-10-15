#!/usr/bin/env python3
# mf.pdf에서 오류도 경고도 없이 조용히 깨지는 조판을 찾는다. mf.log의 경고 수는
# make check가 따로 센다(빠진 글자도 plain TeX이 ``Missing character''로 남기므로
# 거기서 잡힌다). 여기서 보는 것은 다음 다섯 가지다.
#
#   1. mf.w: \.{...}나 \.X 안의 \' \` \" \= 따위. webmac과 달리 gwebmac의 \.은
#      이것들을 문자로 바꾸지 않으므로 plain TeX의 악센트가 되어 버린다.
#      작은따옴표와 역따옴표는 \char'47과 \char'140으로 쓴다.
#   2. mf.w: webmac에만 있던 한 글자 매크로 \L(<=), \G(>=), \I(!=), \K, \R, \V.
#      plain TeX에서는 \L이 폴란드 문자 Ł가 되는 식으로 엉뚱하게 찍힌다.
#   3. mf.tex: gweave가 잘못 끊은 수 토큰. 이를테면 |0..poolSize|는 \NU{0..poo}와
#      \ID{lSize}로 끊긴다. 숫자와 ..을 띄어 |0 .. poolSize|로 쓴다.
#   4. mf.pdf의 텍스트: 풀리지 않은 절 참조 `§??', 새어 나온 \PB나 @<, 그리고
#      plain TeX의 \L, \o 따위가 낳는 Ł, ø 같은 글자. (pdftotext가 있을 때만)
#   5. mf.tex: 한글 식별자 \ID{가}. 이 프로그램에는 한글 식별자가 없으므로, 이것은
#      |...|의 짝이 엇갈려 산문이 코드로 조판되었다는 뜻이다. 이를테면 산문의
#      |@<문자 |s|가 ...@>|는 이름 안의 |에서 끊기고(바깥 |...|를 떼어 쓴다),
#      주석 속 |...| 안의 @t...@>도 짝을 어긋나게 한다.
#
#   tests/typeset-check.py            (저장소 맨 위에서, make pdf 다음에)
#
# 걸린 것이 있으면 하나씩 찍고 1로 끝난다.
import os
import re
import shutil
import subprocess
import sys

top = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
os.chdir(top)
found = []


def report(where, what):
    found.append(f"{where}: {what}")


# 1과 2: mf.w. 역빗금 문자 \\는 미리 지워 \\b 같은 것에 속지 않게 한다.
src = open("mf.w", encoding="utf-8").read().split("\n")
accent = re.compile(r"\\[`'\"=]|\\[uvHtcdb](?![A-Za-z])")
webmac = re.compile(r"\\([LGIKRV])(?![A-Za-z])")
dot_arg = re.compile(r"\\\.(\{(?:[^{}]|\{[^{}]*\})*\}|\\.|.)")
for n, line in enumerate(src, 1):
    if line.startswith("%"):
        continue
    plain = line.replace("\\\\", "")
    for m in dot_arg.finditer(plain):
        if accent.search(m.group(1)):
            report(f"mf.w:{n}", f"\\. 안의 악센트 매크로: {m.group(0)}")
    code = line.lstrip().startswith(("\\def", "\\let"))
    for m in webmac.finditer(plain):
        if not code:
            report(f"mf.w:{n}", f"webmac에만 있던 매크로 \\{m.group(1)}")

# 3: mf.tex의 수 토큰
number = re.compile(
    r"-?(\d+(\.\d+)?|\.\d+|0o[0-7]+|0x[0-9A-Fa-f]+|\d+\.\.\d+|\\.*)$")
woven = open("mf.tex", encoding="utf-8").read().split("\n")
for n, line in enumerate(woven, 1):
    for m in re.finditer(r"\\NU\{([^}]*)\}((\\W )?\\(ID|KW)\{)?", line):
        if not number.match(m.group(1)):
            report(f"mf.tex:{n}", f"잘못 끊긴 수 \\NU{{{m.group(1)}}}")
        elif m.group(2):
            report(f"mf.tex:{n}", f"수 바로 뒤의 식별자 \\NU{{{m.group(1)}}}")
    for m in re.finditer(r"\\mathord\{\.\}\\NU\{(\.[^}]*)\}", line):
        report(f"mf.tex:{n}", f"..이 소수점으로 읽힘 .\\NU{{{m.group(1)}}}")
    # 5: 한글 식별자
    for m in re.finditer(r"\\ID\{([^}]*[\uac00-\ud7a3][^}]*)\}", line):
        report(f"mf.tex:{n}", f"코드로 조판된 산문 \\ID{{{m.group(1)}}}")

# 4: mf.pdf의 텍스트
if shutil.which("pdftotext"):
    text = subprocess.run(["pdftotext", "mf.pdf", "-"], capture_output=True,
                          text=True, check=True).stdout
    # 브레브가 붙은 ı(ĭ)는 찾아보기의 `Bernshte{\u\i}n'처럼 일부러 쓴 것이므로 허용한다
    odd = re.compile(r"§\s*\?\?|\\(PB|ID|KW|NU)\b|@[<>]|[ŁłøØȷ]|ı(?!\u0306)")
    for page, body in enumerate(text.split("\f"), 1):
        for m in odd.finditer(body):
            around = body[max(0, m.start() - 20):m.end() + 20].replace("\n", " ")
            report(f"mf.pdf {page}쪽", f"{m.group(0)!r} ...{around}...")
else:
    print("pdftotext가 없어 mf.pdf의 텍스트 검사는 건너뛴다")

for f in found:
    print(f)
print(f"조용히 깨진 조판: {len(found)}")
sys.exit(1 if found else 0)
