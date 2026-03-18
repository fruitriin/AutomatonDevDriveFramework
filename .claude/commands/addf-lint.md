---
name: addf-lint
description: |
  ADDF フレームワークの整合性をチェックする。settings.json 構文・hooks 実行権限・
  スキル frontmatter・Behavior.toml・knowhow INDEX 整合・テンプレート同期を検証する。
  品質ゲート前、CI、設定変更後に使う。
context: fork
user_invocable: true
---

# ADDF Lint — フレームワーク整合性チェック

以下のチェックを順番に実行し、結果をまとめて報告する。
全チェック通過時は `✓ All checks passed` を表示する。
問題がある場合は項目ごとに `✗` と詳細を表示する。

## 1. JSON 構文チェック

```bash
uv run --python 3.11 .claude/addfTools/lint-json.py
```

## 2. Hooks 実行権限チェック

`.claude/hooks/` 内の `*.sh` ファイルが実行権限を持っているか確認する。
実行権限がないファイルがあれば警告する。

## 3. スキル Frontmatter チェック

`.claude/commands/addf-*.md` の全ファイルについて frontmatter の存在と必須フィールド（name, description）を検証する。

```bash
uv run --python 3.11 .claude/addfTools/lint-frontmatter.py
```

## 4. addf-Behavior.toml 構文チェック

```bash
uv run --python 3.11 .claude/addfTools/lint-toml.py
```

## 5. Knowhow INDEX 整合性チェック

`docs/knowhow/INDEX.addf.md`（ADDF 本体の場合）または `docs/knowhow/INDEX.md`（ダウンストリームの場合）を対象に:
- INDEX に記載されているがファイルが存在しないエントリを検出
- `docs/knowhow/` 配下に存在するが INDEX に記載されていない `.md` ファイルを検出
- INDEX ファイル自身（INDEX.md, INDEX.addf.md）は除外する

INDEX ファイルからリンクを抽出するには、テーブル行の `[パス](パス)` パターンをパースする。

## 6. テンプレート同期チェック

`.claude/Progress.md` の「## 運用ルール」セクションがテンプレートの内容を含んでいるか検証する。

```bash
uv run --python 3.11 .claude/addfTools/lint-template-sync.py
```

## 結果報告

全チェックの結果を以下の形式でまとめる:

```
╔══════════════════════════════════════╗
║  ADDF Lint Results                   ║
╚══════════════════════════════════════╝

1. JSON 構文          ✓ / ✗
2. Hooks 実行権限     ✓ / ✗
3. Frontmatter        ✓ / ✗
4. Behavior.toml      ✓ / ✗
5. INDEX 整合性       ✓ / ✗
6. テンプレート同期   ✓ / ✗
```
