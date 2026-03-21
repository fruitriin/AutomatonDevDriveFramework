# ADDF Release — アップストリームリリース設定

> このファイルは ADDF 本体（upstream）のリリース時に `/addf-release` が参照する。
> ダウンストリームプロジェクトでは使用しない。
> 各セクションは `/addf-release` スキルの対応する Phase から呼び出される。

## プレリリースチェック

1. `bash .claude/tests/run-all.sh` が全て通過すること
2. `/addf-lint` が全チェック通過すること
3. `docs/plans-add/TODO.addf.md` に未完了の Critical タスクがないこと

## バージョン更新対象ファイル

| ファイル | 更新内容 |
|---|---|
| `.claude/addf-lock.json` | `version`, `commit`, `updated_at` を更新 |
| `.claude/ADDF-CHANGELOG.md` | 新バージョンのエントリを先頭に追加 |

## チェンジログの書式

Keep a Changelog 形式（https://keepachangelog.com/）に準拠。日本語で記述:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### 追加
- 新機能の説明

### 変更
- 既存機能の変更

### 修正
- バグ修正

### 削除
- 削除された機能
```

## Publish 手順

1. リリースコミットを作成: `[リリース] vX.Y.Z`
2. タグを作成: `git tag vX.Y.Z`
3. push: `git push && git push --tags`
4. GitHub Release を作成: `gh release create vX.Y.Z --generate-notes` を提案

## リリース後

- `addf-lock.json` の `commit` がリリースコミットを指していることを確認
- ダウンストリームプロジェクトが `/addf-migrate` で新バージョンを取得できることを検証（任意）
