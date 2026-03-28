# ノウハウ蓄積 — Implementation knowledge management

> 概念単位の記録。実装がスキル/エージェント/フック/ファイルのどれであっても、
> 「実装知見の記録・検索・活用」に関わるものをまとめている。

## 構成要素

| 種別 | 名前 | 役割 |
|---|---|---|
| スキル | addf-knowhow | 実装知見を docs/knowhow/ に記録（重複チェック・自己ブラッシュアップ付き） |
| スキル | addf-knowhow-index | インデックスの参照・再構築 |
| スキル | addf-knowhow-filter | Plan 内容に基づく関連ノウハウのフィルタリング |
| スキル | addf-experience | .exp.md ファイルの @メンション書式検証・修正 |
| エージェント | addf-knowhow-agent | ブートシーケンスで Plan に関連する knowhow を抽出（Haiku） |
| ディレクトリ | docs/knowhow/ | ノウハウ蓄積ディレクトリ（現在9件） |
| ファイル | docs/knowhow/INDEX.addf.md | ADDF 用ノウハウインデックス |
| ファイル | docs/knowhow/INDEX.md | ダウンストリーム用ノウハウインデックス |
| テンプレート | .claude/templates/ExperienceTemplate.md | .exp.md のテンプレート |
| フック | turn-reminder.sh | ターン10/15でノウハウ抽出を促すリマインダー（※セッション管理と共有） |

## 設計思想

ADDF の第二の柱。「同じ失敗を繰り返さない、同じ発見を再発見しない」ための知識蓄積システム。

二層構造を持つ:
- **knowhow（プロジェクト知見）**: `docs/knowhow/` に蓄積。タスク完了時に記録。全エージェントが参照可能
- **experience（スキル経験）**: `.exp.md` ファイル。スキル単位の「うまくいったパターン / 落とし穴 / 改善点」

knowhow は INDEX でキーワード検索可能にし、knowhow-filter が Plan との関連度でフィルタリングする。これによりブートシーケンスで「このタスクに関連する知見だけ」をコンテキストに載せ、トークン消費を抑制する。

ADDF 本体では `INDEX.addf.md`、ダウンストリームでは `INDEX.md` を使用する分離パターンにより、フレームワーク固有の知見とプロジェクト固有の知見が混在しない。

## 主要フロー

```
タスク開始時:
  Plan 特定 → addf-knowhow-agent → 関連 knowhow をコンテキストに注入

実装中:
  addf-knowhow-filter で追加の知見を検索

タスク完了時:
  /addf-knowhow で新たな知見を記録
  └─ Phase 1: 既存 knowhow スキャン（重複チェック）
  └─ Phase 2: 記録（マークダウンテンプレート）
  └─ Phase 3: 自己ブラッシュアップ（正確性・完全性・明瞭性・有用性）

定期メンテナンス:
  /addf-knowhow-index reindex → INDEX 再構築
  /addf-experience → .exp.md の書式検証
```

## 下流でのカスタマイズ

- `docs/knowhow/` にプロジェクト固有の知見を蓄積（`INDEX.md` で管理）
- ADDF 由来の知見は `docs/knowhow/ADDF/` サブディレクトリに分離される
- ExperienceTemplate.md を編集してスキル経験の記録フォーマットを変更可能

## 関連するシステム

- **計画駆動**: ブートシーケンス Step 5 で knowhow-agent が起動。タスク完了時に knowhow 記録
- **品質ゲート**: コードレビュー・セキュリティレビューで得た知見が knowhow に蓄積される
- **セッション管理**: turn-reminder.sh がターン10/15で knowhow 抽出を促す
