# セッション管理 — Boot sequence, hooks, and configuration

> 概念単位の記録。実装がスキル/エージェント/フック/ファイルのどれであっても、
> 「セッションの開始・維持・設定」に関わるものをまとめている。

## 構成要素

| 種別 | 名前 | 役割 |
|---|---|---|
| ファイル | CLAUDE.md | メインの指示ファイル。ブートシーケンス・開発プロセス・並列方針を定義 |
| ファイル | CLAUDE.repo.md | プロジェクト固有設定（ADDF 本体ではブートシーケンス補足） |
| ファイル | CLAUDE.repo.example.md | ダウンストリーム用テンプレート |
| ファイル | CLAUDE.local.md | 開発者個人設定（.gitignore 対象） |
| ファイル | AGENTS.md | Codex 等の AGENTS.md 互換ツール用 |
| ファイル | .claude/settings.json | フック定義・権限設定（ダウンストリーム配布） |
| ファイル | .claude/settings.local.json | ADDF 開発用ローカル権限（配布しない） |
| ファイル | .claude/addf-Behavior.toml | フレームワーク動作設定（gui-test 有効化等） |
| スキル | addf-permission-audit | 権限を3パターンに分類し settings ファイルへの配置を提案 |
| フック | reset-turn-count.sh | SessionStart: ターンカウンターをリセット |
| フック | turn-reminder.sh | UserPromptSubmit: ターン10/15でリマインダー注入 |
| フック | post-compact-recovery.sh | SessionStart(compact): コンパクション後の復帰手順注入 |
| フック | skill-usage-log.sh | PreToolUse(Skill): スキル呼び出しを JSONL でロギング |

## 設計思想

CLAUDE.md を頂点とする階層的設定構造:

```
CLAUDE.md（汎用テンプレート）
  └─ @CLAUDE.repo.md（プロジェクト固有）
       └─ @CLAUDE.repo.example.md（下流テンプレート）
  └─ CLAUDE.local.md（個人設定、gitignore）
```

この分離により CLAUDE.md のマイグレーションを「ほぼ上書き」に近づける設計方針（Feedback.md で記録済み）。

フック群はセッションライフサイクルの各イベントに対応:
- **SessionStart**: カウンターリセット + コンパクション復帰
- **UserPromptSubmit**: ターンカウント + リマインダー
- **PreToolUse(Skill)**: 使用ログ記録

settings.json は2ファイルに分離:
- `settings.json`: ダウンストリームにも配布される汎用権限
- `settings.local.json`: ADDF 開発プロジェクト固有の権限（addf-permission-audit で分類）

## 主要フロー

```
セッション開始
  │
  ├─ reset-turn-count.sh → ターンカウンター 0
  │
  ├─（コンパクション後のみ）
  │  post-compact-recovery.sh → 復帰ガイダンス注入
  │
  ▼
CLAUDE.md ブートシーケンス
  ├─ 1. Feedback.md
  ├─ 2. TODO.md（ADDF: + TODO.addf.md）
  ├─ 3. Progress.md
  ├─ 4. タスクなし → オーナーに確認
  └─ 5. knowhow-agent 起動
  │
  ▼
各ターン
  ├─ turn-reminder.sh → ターンカウント
  │  ├─ ターン10: knowhow 抽出リマインダー
  │  └─ ターン15: knowhow + コンテキスト整理
  │
  └─ skill-usage-log.sh → スキル使用ログ
```

## 下流でのカスタマイズ

- `CLAUDE.repo.md` にプロジェクト固有の設定を記述（CLAUDE.md は上書きマイグレーション可能に保つ）
- `CLAUDE.local.md` で開発者個人の設定を追加
- `addf-Behavior.toml` で gui-test 有効化やプラットフォーム選択
- `settings.json` の権限ルールを addf-permission-audit で整理
- フックスクリプトのターン閾値を調整可能

## 関連するシステム

- **計画駆動**: ブートシーケンスが計画駆動システムの起点
- **ノウハウ蓄積**: turn-reminder.sh がノウハウ抽出を促す
- **配布・導入**: settings.json / CLAUDE.md は配布対象。マイグレーション時に更新される
