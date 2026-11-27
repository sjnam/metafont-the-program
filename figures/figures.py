#!/usr/bin/env python3
"""그림 모음(mf-figures.tex)을 만든다.

    python3 figures/figures.py build/figures/mf.tex figures/figures.tsv > mf-figures.tex

첫 인자는 gweave가 mf.gw에서 만든 mf.tex다. 그 림보(첫 줄부터 그림들이 함께 쓰는
MetaPost 도우미를 정의한 \\endmplibcode까지)를 그대로 쓰고, 본문에서 beginfig가 든
\\mplibcode 토막을 모두 뽑아 차례로 놓는다. 그림 코드를 손으로 베끼지 않으므로 번역
문서의 그림과 어긋날 일이 없다. 번역의 절 번호와 부 제목도 mf.tex의 \\M, \\N에서 읽는다.

둘째 인자 figures.tsv에는 그림마다 원문의 절 번호와 한글, 영어 제목을 적는다. mf.gw에
있는 그림이 표에 없거나, 표에 있는 그림이 mf.gw에 없으면 멈춘다.
"""
import re
import sys


def braced(s, i):
    """s[i]가 '{'일 때 짝이 맞는 '}'까지의 안쪽과 그다음 위치를 돌려준다."""
    depth = 0
    for j in range(i, len(s)):
        if s[j] == '{':
            depth += 1
        elif s[j] == '}':
            depth -= 1
            if depth == 0:
                return s[i + 1:j], j + 1
    raise ValueError('짝이 맞지 않는 중괄호: ' + s[i:i + 40])


def read_titles(path):
    titles = {}
    for line in open(path, encoding='utf-8'):
        if not line.strip() or line.startswith('#'):
            continue
        n, orig, ko, en = line.rstrip('\n').split('\t')
        titles[int(n)] = (orig, ko, en)
    return titles


def main():
    tex = open(sys.argv[1], encoding='utf-8').read()
    titles = read_titles(sys.argv[2])
    lines = tex.split('\n')
    end = next(i for i, l in enumerate(lines) if l.startswith('\\endmplibcode'))
    limbo = lines[:end + 1]
    body = '\n'.join(lines[end + 1:])

    sec, part, figs = 0, '', []
    token = re.compile(r'\\M\{(\d+)\}|\\N\{\d+\}\{(\d+)\}|\\mplibcode(.*?)\\endmplibcode', re.S)
    for m in token.finditer(body):
        if m.group(1):
            sec = int(m.group(1))
        elif m.group(2):
            sec = int(m.group(2))
            part, _ = braced(body, m.end())
        elif 'beginfig' in m.group(3):
            n = int(re.search(r'beginfig\((\d+)\)', m.group(3)).group(1))
            figs.append((n, sec, part, m.group(3)))

    found = [n for n, _, _, _ in figs]
    missing = sorted(set(found) - set(titles))
    extra = sorted(set(titles) - set(found))
    if missing or extra or len(found) != len(set(found)):
        sys.exit(f'figures.tsv와 mf.gw의 그림이 맞지 않는다: 표에 없는 그림 {missing}, '
                 f'mf.gw에 없는 그림 {extra}')

    out = ['% 이 파일은 make figures가 mf.gw를 gweave한 mf.tex에서 뽑아 만든다.',
           '% 손으로 고치지 말고 mf.gw나 figures/figures.tsv를 고친다.']
    out += limbo
    out.append(r'''
\def\title{\MF\ 그림 모음}
\raggedbottom
\font\titlelogo=logo10 scaled 1653
% \figitem{그림 번호}{번역의 절}{부 제목}{한글 제목}{영어 제목}{원문의 절}
\def\figitem#1#2#3#4#5#6{\grouptoks={#3}\setmark{#2}%
  \bigskip\goodbreak\noindent{\bf 그림~#1.}\enspace #4\hfil\break
  {\it #5}\hfill #6\par}

\centerline{\titlefont {\titlelogo METAFONT}: The Program}
\medskip
\centerline{한글 \.{GWEB} 판의 그림 \number''' + str(len(figs)) + r'''장}
\bigskip
이 문서는 커누스의 {\sl\MF: The Program}을 한국어와 \GO/로 옮긴 \.{mf.gw}에 그린
그림을 모은 것이다(\.{https://github.com/sjnam/metafont-the-program}). 그림의 MetaPost
코드는 \.{mf.gw}에서 그대로 뽑았으므로 번역 문서와 똑같이 그려진다. 그림마다 그 그림이
설명하는 원문 \.{mf.web}의 절 번호와, 그 그림이 들어 있는 번역의 절 번호를 적었다. 그림의
설명은 번역 문서의 그 절에 있다.

\medskip
This document collects the figures drawn in \.{mf.gw}, a translation of
Knuth's {\sl\MF: The Program} into Korean and Go. The MetaPost code of each
figure is taken verbatim from \.{mf.gw}, so the figures are drawn exactly as in
the translation. Each figure gives the section of the original \.{mf.web} that it
illustrates and the section of the translation where it appears; the explanation
(in Korean) is in that section. Some labels are in Korean.
''')
    for n, sec, part, code in figs:
        orig, ko, en = titles[n]
        where = (r'원문에 없음, 번역 \S' if orig == '-' else
                 r'원문 \S' + orig + r', 번역 \S') + str(sec)
        out.append(f'\\figitem{{{n}}}{{{sec}}}{{{part}}}{{{ko}}}{{{en}}}{{{where}}}')
        out.append('$$\\mplibcode' + code + '\\endmplibcode$$')
    out.append('\\bye')
    print('\n'.join(out))


main()
