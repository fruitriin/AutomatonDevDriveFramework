# ADDF エコシステム概要 — インデックス

> 生成日: 2026-03-28 | コミット: 0d6fd5af [ノウハウ] 既存プロジェクト導入パターンとリリース責務分割を記録

AutomatonDevDrive Framework — AI コーディングエージェントのためのリポジトリ構成フレームワーク。
計画駆動・ノウハウ蓄積・品質ゲートの三本柱で、エージェントの自律的な開発を支える。

概念システム別に分類したドキュメント群。実装種別（スキル/エージェント/フック）では分けていない。

## 概念システム一覧

| ファイル | システム | 主な構成要素 |
|---|---|---|
| [system-planning.md](system-planning.md) | 計画駆動 | addf-dev, TODO.md, Progress.md, Feedback.md, docs/plans/ |
| [system-knowhow.md](system-knowhow.md) | ノウハウ蓄積 | addf-knowhow, addf-knowhow-index, addf-knowhow-filter, addf-knowhow-agent, addf-experience |
| [system-quality.md](system-quality.md) | 品質ゲート | addf-code-review-agent, addf-security-review-agent, addf-lint, addf-contribution-agent |
| [system-session.md](system-session.md) | セッション管理 | CLAUDE.md Boot Sequence, hooks, settings.json, Behavior.toml, addf-permission-audit |
| [system-distribution.md](system-distribution.md) | 配布・導入 | addf-init, addf-migrate, addf-release, addf-lock.json, docs/guides/, addf-overview |
| [system-visual-testing.md](system-visual-testing.md) | 視覚テスト | addf-gui-test, addf-annotate-grid, addf-clip-image, addf-ui-test-agent, addfTools/ |

## 補完ドキュメント

| ファイル | 内容 |
|---|---|
| [claude-md-deps.md](claude-md-deps.md) | CLAUDE.md 依存グラフ・Boot Sequence |
| [phase-flows.md](phase-flows.md) | フェーズ進行スキル一覧（自動検出） |
| [interactions.md](interactions.md) | システム間相互作用アスキーアート |

## 全要素カウント

- スキル: 14本（うち .exp.md あり: 3本）
- エージェント定義: 5体
- フックスクリプト: 4本
- ガイドドキュメント: 7本（docs/guides/）
- ノウハウ: 9件（docs/knowhow/）
- 概念システム: 6
