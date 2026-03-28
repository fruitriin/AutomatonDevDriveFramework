# CLAUDE.md 依存グラフ・Boot Sequence

> 生成日: 2026-03-28

## CLAUDE.md と CLAUDE.repo.md の関係

```
CLAUDE.md（汎用テンプレート — マイグレーション時に上書き可能）
│
├─ @CLAUDE.repo.md（プロジェクト固有設定）
│    └─ @CLAUDE.repo.example.md（ダウンストリーム用テンプレート）
│         └─ ADDF 本体では: ブートシーケンス補足
│              @docs/plans-add/TODO.addf.md
│
├─ CLAUDE.local.md（開発者個人設定 — .gitignore 対象）
│    └─ @CLAUDE.local.example.md
│
└─ AGENTS.md（Codex 互換 — CLAUDE.md を参照しつつ独立）
```

**設計方針**: CLAUDE.repo.md にプロジェクト固有設定を寄せることで、CLAUDE.md のマイグレーションを単純な上書きに近づける。この方針を崩すとマイグレーション実装が複雑化する（Feedback.md 記録済み）。

## Boot Sequence

CLAUDE.md で定義されるブートシーケンス:

```
セッション開始
│
├─ [Hook] reset-turn-count.sh → .turn-count = 0
├─ [Hook] post-compact-recovery.sh（compact 時のみ）
│
▼
Step 1: @.claude/Feedback.md を読む
│       └─ 未対応の改善アクションを確認
│
Step 2: @TODO.md を読む
│       └─ タスクバックログと優先度を把握
│       └─ [ADDF 本体のみ] @docs/plans-add/TODO.addf.md も読む
│
Step 3: @.claude/Progress.md を読む
│       └─ 進行中タスクがあれば継続
│
Step 4: TODO に未完了タスクがない場合
│       └─ オーナーに次のタスクを確認
│
Step 5: Plan 特定後、knowhow サブエージェントを起動
        ├─ Plan ファイルの内容をサブエージェントに渡す
        ├─ docs/knowhow/ を走査
        └─ 関連 knowhow のパスと要約をメインコンテキストに返す
```

## CLAUDE.md が参照する外部ファイル依存グラフ

```
CLAUDE.md
├─ @.claude/Feedback.md .............. 改善アクション記録
├─ @TODO.md .......................... タスクバックログ
├─ @.claude/Progress.md .............. 現在のタスク進捗
├─ @CLAUDE.repo.md ................... プロジェクト固有設定
│    └─ @CLAUDE.repo.example.md
│         └─ @docs/plans-add/TODO.addf.md
├─ docs/plans/ ....................... 実装計画ファイル群
├─ docs/knowhow/ ..................... ノウハウ蓄積
└─ CONTRIBUTING.md ................... コントリビューションモデル
```

## settings.json のフック定義

| イベント | フック | トリガー条件 | 動作 |
|---|---|---|---|
| SessionStart | reset-turn-count.sh | 常時 | .turn-count を 0 にリセット |
| SessionStart | post-compact-recovery.sh | compact 時のみ | 復帰ガイダンスを stdout 注入 |
| UserPromptSubmit | turn-reminder.sh | 常時 | ターンカウント。10/15 でリマインダー |
| PreToolUse | skill-usage-log.sh | Skill マッチ時 | スキル使用を JSONL ロギング |

## 権限設定構造

| ファイル | 配布対象 | 内容 |
|---|---|---|
| .claude/settings.json | ダウンストリームにも配布 | フック定義 + 汎用権限（read/write/git/test） |
| .claude/settings.local.json | ADDF 開発のみ | ADDF 開発用権限（sed, find, rm, gh issue/pr create 等） |
