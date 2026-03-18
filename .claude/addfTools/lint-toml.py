#!/usr/bin/env python3
"""addf-Behavior.toml 構文チェック"""
import tomllib, sys

try:
    with open('.claude/addf-Behavior.toml', 'rb') as f:
        tomllib.load(f)
    print('OK')
except FileNotFoundError:
    print('SKIP: ファイルなし')
except Exception as e:
    print(f'ERROR: {e}')
    sys.exit(1)
