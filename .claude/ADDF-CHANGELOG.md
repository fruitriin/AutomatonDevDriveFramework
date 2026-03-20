# ADDF Changelog

ADDF フレームワークの変更履歴。`/addf-migrate` 実行時に該当バージョン間のエントリを表示する。

## [0.1.0] - 2026-03-20

### 追加
- `addf-lock.json` — バージョン追跡用ロックファイル
- `/addf-migrate` スキル — ADDF のアップグレードを安全に実行する6フェーズのマイグレーション
- `ADDF-CHANGELOG.md` — フレームワーク変更履歴（本ファイル）
- `settings.json` に `git clone`, `git -C`, `mktemp` 権限を追加

### 初期リリース内容
- ブートシーケンス（CLAUDE.md）による自動コンテキスト読み込み
- ノウハウ管理（`/addf-knowhow`, `/addf-knowhow-index`, `/addf-knowhow-filter`）
- 自律開発ループ（`/addf-dev-loop`）
- 品質ゲート（`addf-code-review-agent`, `addf-security-review-agent`, `addf-contribution-agent`）
- GUI テスト（`/addf-gui-test`, `/addf-annotate-grid`, `/addf-clip-image`）— macOS オプション
- 経験ファイル検証（`/addf-experience`）
- フレームワーク整合性チェック（`/addf-lint`）
- 権限監査（`/addf-permission-audit`）
- ターンカウンターフック（SessionStart / UserPromptSubmit）
