#!/usr/bin/env python3
"""テンプレート同期チェック — Progress.md の運用ルールがテンプレートと一致しているか"""
import sys

def extract_section(path, header='## 運用ルール', end_marker='---'):
    with open(path) as f:
        content = f.read()
    start = content.find(header)
    if start == -1:
        return ''
    end = content.find(end_marker, start + len(header))
    return content[start:end if end != -1 else len(content)]

tmpl = extract_section('.claude/templates/ProgressTemplate.addf.md')
prog = extract_section('.claude/Progress.md')
missing = []
for line in tmpl.splitlines():
    stripped = line.strip()
    if stripped and stripped not in prog:
        missing.append(stripped)

if missing:
    print('テンプレートとの乖離:')
    for m in missing:
        print(f'  MISSING: {m}')
    sys.exit(1)
else:
    print('OK')
