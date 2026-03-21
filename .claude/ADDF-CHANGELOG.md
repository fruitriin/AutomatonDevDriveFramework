# ADDF Changelog

ADDF フレームワークの変更履歴。`/addf-migrate` 実行時に該当バージョン間のエントリを表示する。

## [0.2.0] - 2026-03-21

### 追加
- `/addf-init` スキル — プロジェクト初期セットアップと構造検証
- `/addf-release` スキル — リリース自動化（upstream/downstream 自動判定）
- `ADDF-Release.addf.md` — ADDF 本体のリリース手順定義
- `AGENTS.md` — Codex 向けブートシーケンス
- `docs/guides/codex-setup.md` — Codex ユーザー向けセットアップガイド
- 経験ファイルテンプレート（`ExperienceTemplate.md`）と主要3スキルの初期経験
- スキル使用計測フック（`skill-usage-log.sh` / PreToolUse）
- `docs/guides/` にドキュメント分離（setup, skills, agents, development-process, migration）

### 変更
- `/addf-dev-loop` → `/addf-dev` にリネーム（1タスク実施が基本、`/loop` で繰り返し）
- 全スキルの description にトリガー条件（「〜のとき使う」）を追加
- README をクイックスタート中心に簡素化（GitHub Template 準拠のセットアップフロー）
- `addf-lint` の frontmatter チェックで `.exp.md` を除外

### 修正
- `addf-migrate` の対象リストに `settings.json`, `AGENTS.md`, `ADDF-Release.addf.md` を追加

## [0.1.0] - 2026-03-20

### 追加
- `addf-lock.json` — バージョン追跡用ロックファイル
- `/addf-migrate` スキル — ADDF のアップグレードを安全に実行する6フェーズのマイグレーション
- `ADDF-CHANGELOG.md` — フレームワーク変更履歴（本ファイル）
- `settings.json` に `git clone`, `git -C`, `mktemp` 権限を追加

### 初期リリース内容
- ブートシーケンス（CLAUDE.md）による自動コンテキスト読み込み
- ノウハウ管理（`/addf-knowhow`, `/addf-knowhow-index`, `/addf-knowhow-filter`）
- 自律開発（`/addf-dev`、旧 `/addf-dev-loop`）
- 品質ゲート（`addf-code-review-agent`, `addf-security-review-agent`, `addf-contribution-agent`）
- GUI テスト（`/addf-gui-test`, `/addf-annotate-grid`, `/addf-clip-image`）— macOS オプション
- 経験ファイル検証（`/addf-experience`）
- フレームワーク整合性チェック（`/addf-lint`）
- 権限監査（`/addf-permission-audit`）
- ターンカウンターフック（SessionStart / UserPromptSubmit）
