# フレームワークエージェント

品質ゲートやブートシーケンスで自動起動されるサブエージェント:

| エージェント | 用途 | 起動タイミング |
|---|---|---|
| **addf-knowhow-agent** | Plan に関連するノウハウをフィルタリング | ブートシーケンス（タスク開始時） |
| **addf-code-review-agent** | コード品質・可読性のレビュー | タスク完了時の品質検証 |
| **addf-security-review-agent** | セキュリティ脆弱性の検査・報告 | タスク完了時の品質検証（オプション） |
| **addf-contribution-agent** | フレームワークへのコントリビューション候補の検出 | タスク完了時の品質検証 |
| **addf-ui-test-agent** | スクリーンショット・画像解析による UI 検証 | タスク完了時の品質検証（オプション） |

## 品質ゲートでの使用

タスク完了時、以下の順序で品質検証が実行されます:

1. ビルド・Lint・テスト（失敗時は実装に差し戻し）
2. コードレビュー（`addf-code-review-agent`）
3. コントリビューション検出（`addf-contribution-agent`）

`addf-security-review-agent` と `addf-ui-test-agent` はオプションです。

> **品質ゲート拡張（オプション）**: Stage 1/Stage 2 の2段階構成で並列実行する拡張モードもあります。
> 詳細は `CLAUDE.repo.example.md` の「品質ゲート拡張」セクションを参照してください。
