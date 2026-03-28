# フェーズ進行スキル一覧

> 毎回の実行時に全スキルをスキャンして自動生成。対象リストは決め打ちしない。
> 検出基準: Phase/Step 番号付き構造、または3ステップ以上の手順フローを持つスキル。
> 生成日: 2026-03-28

## 検出結果: 13本（14本中）

| スキル | フェーズ数 | 概要 |
|---|---|---|
| addf-dev | 5 steps | タスク選択→実装→品質検証→完了処理→ループ |
| addf-init | 5+ phases | 状態確認→情報収集→干渉チェック→ファイル配置→完了報告 |
| addf-migrate | 6 phases | 状態確認→最新取得→差分算出→プレビュー→適用→完了 |
| addf-overview | 7 steps (full) + 4 steps (patch) | データ収集→フロー検出→システム発見→ドキュメント生成→経験記録 |
| addf-release | 4 steps | プロジェクト種別判定→手順ロード→実行→経験更新 |
| addf-permission-audit | 11 steps | 知識取込→種別検出→権限収集→分類→配置→出力→検証→適用 |
| addf-lint | 6 checks | JSON構文→フック権限→frontmatter→TOML→INDEX整合→テンプレート同期 |
| addf-knowhow | 3 phases | 調査（既存スキャン）→記録→自己ブラッシュアップ |
| addf-knowhow-filter | 5 steps | INDEX読込→Plan分析→knowhow走査→関連判定→結果出力 |
| addf-experience | 4 phases | スキャン→判定→修正→検証 |
| addf-gui-test | 7 steps | Behavior確認→権限チェック→ビルド→シナリオ実行→結果判定→クリーンアップ→レポート |
| addf-annotate-grid | 5 steps | 引数解析→ツールビルド→グリッド描画→出力→確認 |
| addf-clip-image | 5 steps | 引数解析→ツールビルド→領域切出し→出力→確認 |

**非該当**: addf-knowhow-index（構造化フェーズなし、参照 or reindex の2モード切替のみ）

---

## addf-dev

> TODO.md から未実施タスクを1つ選んで実装・品質検証・コミットまで完遂する。

1. コンテキスト読み込み（Feedback → TODO → Progress）
2. タスク選択（優先度: ブロッカー解消 > インフラ整備 > 若番）
3. 実装（CLAUDE.md ブートシーケンスに従う、品質ゲート 2段階）
4. 完了処理（Plan反映 → Feedback記録 → Progressアーカイブ → コミット）
5. `/loop` 時: 次のタスクへ継続

---

## addf-init

> ADDF プロジェクトの初期セットアップまたは構造検証を行う。

**外部 URL モード**: URL受取 → raw fetch → Phase 2 へ
**init モード**:
- Phase 1: 状態確認（git, 既存ファイル）
- Phase 2: 情報収集（README 自動検出、プロジェクト名・言語・ビルドコマンド）
- Phase 2.5: 干渉チェック（既存 CLAUDE.md 退避）
- Phase 2.7: 導入前レビュー
- Phase 3: ファイル配置（カテゴリA: 上書き / B: マージ / C: 初期化のみ）
- Phase 4: 完了報告
**check モード**: 5項目の構造検証

---

## addf-migrate

> ADDF フレームワークを最新版にアップグレードする。

- Phase 1: 状態確認（addf-lock.json, git clean）
- Phase 2: 最新版フェッチ（ADDF リポジトリクローン）
- Phase 3: 差分算出（追加/更新/削除ファイル、マージ対象識別）
- Phase 4: 変更プレビュー（カテゴリ別、チェンジログ）
- Phase 5: 適用（settings.json マージ、ファイル配置、CLAUDE.md マージ）
- Phase 6: 完了（lock 更新、サマリ報告）

---

## addf-overview

> エコシステム概要ドキュメントの生成。

**full モード**:
- Step 0: 前回経験読み込み
- Step 1: 全データ収集（A-F 6カテゴリ、並列）
- Step 2: フェーズフロー自動検出
- Step 3: 概念システム探索的発見
- Step 4: ドキュメント生成
- Step 5: 経験記録
- Step 6: .lock 更新
- Step 7: 完了報告

**patch モード**:
- P1: .lock diff 取得
- P2: システムマッピング
- P3: 部分再生成
- P4: 経験記録 + .lock 更新

---

## addf-release

> プロジェクトのリリースを実行する。

1. プロジェクト種別判定（upstream or downstream）
2. リリース手順ロード（upstream: ADDF-Release.addf.md / downstream: .exp.md or 対話構築）
3. リリース手順実行
4. 経験更新

---

## addf-permission-audit

> セッション中の権限要求を3パターンに分類し settings に配置提案する。

1. 知識取込（/addf-knowhow-index）
2. プロジェクト種別検出
3. 権限収集（承認済み + 保留）
4. 公式スペック検証
5. 分類（upstream / downstream / 汎用）
6. 配置先決定（settings.json or settings.local.json）
7. 出力生成
8. 構文検証
9. コントリビューションレビュー
10. apply モード（オプション）
11. ユーザー確認

---

## addf-lint

> フレームワーク整合性チェック（6項目）。

1. JSON 構文チェック（settings.json, settings.local.json）
2. フック実行権限チェック（.claude/hooks/*.sh）
3. スキル frontmatter チェック（name, description, user_invocable）
4. Behavior.toml 構文チェック
5. knowhow INDEX 整合チェック（ファイル vs INDEX エントリ）
6. テンプレート同期チェック（ProgressTemplate vs Progress.md）

---

## addf-knowhow

> 実装知見を記録する。

- Phase 1: 調査（既存 knowhow スキャン、重複チェック）
- Phase 2: 記録（マークダウンテンプレートで知見を構造化）
- Phase 3: 自己ブラッシュアップ（正確性・完全性・明瞭性・有用性の4観点で見直し）

---

## addf-knowhow-filter

> Plan に関連するノウハウだけをフィルタリングして返す。

1. INDEX 読み込み
2. Plan 内容分析
3. knowhow ファイル走査
4. 関連度判定（技術ドメイン・実装リスク・アーキテクチャ影響）
5. 結果出力（パス・要約・関連理由）

---

## addf-experience

> .exp.md の @メンション書式を検証・修正する。

- Phase 1: スキャン（全 .claude/commands/ ファイル）
- Phase 2: 判定（正常 / 要修正 / 例外）
- Phase 3: 修正（クオート除去）
- Phase 4: 検証（修正後の確認）

---

## addf-gui-test

> GUI テストシナリオを実行する。

1. シナリオ引数確認（なしなら一覧表示）
2. Behavior.toml 確認
3. Screen Recording 権限チェック
4. ツールビルド
5. シナリオステップ実行
6. クリーンアップ
7. 結果レポート

---

## addf-annotate-grid / addf-clip-image

> 画像にグリッド描画 / 画像の領域切り出し。

共通フロー:
1. 引数解析（画像パス、オプション）
2. ツールビルド（未ビルドなら build.sh）
3. 処理実行
4. 出力ファイルパス表示
5. 結果確認（Read で画像表示）
