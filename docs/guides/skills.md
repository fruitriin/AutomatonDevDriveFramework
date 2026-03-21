# フレームワークスキル

ADDF が提供するスキル（`/コマンド名` で呼び出し）:

## ノウハウ管理

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-knowhow** | `/addf-knowhow <トピック>` | 実装知見を `docs/knowhow/` に記録。既存ノウハウとの重複チェック・統合を自動で行う |
| **addf-knowhow-index** | `/addf-knowhow-index [reindex]` | knowhow インデックスを参照、または `reindex` で再構築 |
| **addf-knowhow-filter** | `/addf-knowhow-filter <plan-path>` | Plan に関連するノウハウだけをフィルタリングして返す |

## 開発ループ

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-dev-loop** | `/loop 1h /addf-dev-loop` | TODO.md から未実施タスクを自律選択し、実装・品質検証・コミットまで完遂するループ |

## プロジェクト管理

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-init** | `/addf-init [check]` | プロジェクトの初期セットアップ（引数なし）または構造検証（`check`） |
| **addf-migrate** | `/addf-migrate [target]` | ADDF フレームワークを最新版にアップグレード |
| **addf-lint** | `/addf-lint` | フレームワーク整合性チェック（JSON構文・権限・frontmatter・INDEX等） |
| **addf-permission-audit** | `/addf-permission-audit` | 権限要求の分析・分類・settings ファイルへの追加提案 |

## 経験管理

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-experience** | `/addf-experience` | スキル経験ファイル（`.exp.md`）のファイルメンション書式を検証 |

## GUI テスト（オプション）

有効化するには `.claude/addf-Behavior.toml` で `enable = true` に設定してください。macOS のみ対応。

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-gui-test** | `/addf-gui-test <シナリオ>` | `docs/test-scenarios/` のシナリオに基づき GUI テストを実行 |
| **addf-annotate-grid** | `/addf-annotate-grid <path>` | PNG 画像にグリッド線と座標ラベルを描画（LLM の座標認識用） |
| **addf-clip-image** | `/addf-clip-image <path>` | PNG 画像の指定領域を切り出し（注目領域の抽出用） |
