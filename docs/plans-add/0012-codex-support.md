# 計画: Codex サポート

GitHub Issue: #1

## 動機

Codex（OpenAI のコーディングエージェント）を主に使っているが ADDF を試したいというユーザー層が存在する。
ADDF は現在 Claude Code 固有の機能（Hooks、Skills、Agents、settings.json）に強く依存しており、
Codex ユーザーがそのまま利用することはできない。
マルチエージェント対応により、ADDF の受益者が増え、他の改善（init、README、knowhow）の複利効果も増大する。

## 前提調査

Codex と Claude Code の機能差分を調査し、対応方針を決定する必要がある。

### 調査項目

1. **Codex の設定ファイル形式** — Claude Code の `CLAUDE.md` に相当するものはあるか
2. **Codex のエージェント/スキル機構** — Skills、Agents に相当する拡張ポイントはあるか
3. **Codex の Hooks 機構** — SessionStart、PreToolUse 等に相当するものはあるか
4. **Codex のファイルアクセス制限** — `.claudeignore` に相当するものはあるか
5. **Codex の権限管理** — `settings.json` の allow/deny に相当するものはあるか

### ADDF 機能の Codex 互換性マッピング

| ADDF 機能 | Claude Code | Codex | 対応方針 |
|---|---|---|---|
| ブートシーケンス | CLAUDE.md `@` メンション | 調査必要 | |
| スキル | `.claude/commands/` | 調査必要 | |
| エージェント | `.claude/agents/` | 調査必要 | |
| Hooks | `.claude/settings.json` hooks | 調査必要 | |
| 権限管理 | `.claude/settings.json` permissions | 調査必要 | |
| GUI テスト | addfTools (Swift) | 対象外 | Codex は CLI/sandbox なので不要 |
| ノウハウ管理 | knowhow/ + スキル | 調査必要 | |
| 品質ゲート | エージェント並列起動 | 調査必要 | |

## 設計方針（調査後に確定）

### A案: 互換レイヤー

ADDF のコア概念（ブートシーケンス、計画駆動、ノウハウ蓄積）をエージェント非依存の形で定義し、
Claude Code / Codex それぞれのアダプターを提供する。

### B案: ドキュメント対応

Codex での手動セットアップ手順をドキュメントとして提供。
ADDF のコア（CLAUDE.md、計画ファイル、knowhow）は Markdown ベースなので、
Codex の設定ファイルに手動で転記する手順を案内する。

### C案: デュアル生成

`addf-init`（Phase 13）でターゲットエージェントを選択させ、
Claude Code 用と Codex 用の設定ファイルをそれぞれ生成する。

## 影響範囲

調査結果次第。最小で:
- ドキュメント追加（Codex 向けセットアップガイド）
- `addf-init` への Codex オプション追加

最大で:
- エージェント抽象レイヤーの導入
- Codex 用設定ファイルテンプレート群の追加

## 見積もり

調査: 10-15 分
実装: 調査結果次第（20-60 分）
