# 計画駆動 — Plan-driven development loop

> 概念単位の記録。実装がスキル/エージェント/フック/ファイルのどれであっても、
> 「計画からタスク完遂までの開発ループ」に関わるものをまとめている。

## 構成要素

| 種別 | 名前 | 役割 |
|---|---|---|
| スキル | addf-dev | TODO から1タスクを選び、実装→品質検証→コミットまで完遂する |
| ファイル | TODO.md | ダウンストリームのタスクバックログ |
| ファイル | docs/plans-add/TODO.addf.md | ADDF 開発のタスクバックログ |
| ファイル | .claude/Progress.md | 現在のタスク進捗・運用ルール（チェックリスト作成・品質検証フロー） |
| ファイル | .claude/Feedback.md | 問題・改善アクションの記録。タスク完了時に追記 |
| ディレクトリ | docs/plans/ | ダウンストリーム実装計画ファイル |
| ディレクトリ | docs/plans-add/ | ADDF 自身の開発計画ファイル（15件） |
| テンプレート | .claude/templates/ProgressTemplate.md | ダウンストリーム用 Progress テンプレート |
| テンプレート | .claude/templates/ProgressTemplate.addf.md | ADDF 開発用 Progress テンプレート |

## 設計思想

ADDF の第一の柱。CLAUDE.md のブートシーケンスがこのシステムの起点となる:

1. Feedback.md を読む → 未対応の改善アクション確認
2. TODO.md を読む → タスクバックログ把握
3. Progress.md を読む → 進行中タスク継続

「コードではなく計画をレビューする」（CONTRIBUTING.md）が基本方針。人間が計画の方向性を判断し、実装品質は AI（品質ゲートシステム）が担保する。

Progress.md には運用ルールが埋め込まれており、タスク開始→作業中→完了時の各フェーズで何をすべきかを規定している。これにより addf-dev スキルはステートマシンとして動作する。

## 主要フロー

```
ブートシーケンス
  │
  ├─ Feedback.md 読み込み
  ├─ TODO.md 読み込み（ADDF: TODO.addf.md も）
  └─ Progress.md 読み込み
       │
       ▼
  タスク選択（addf-dev）
  優先度: ブロッカー解消 > インフラ整備 > 若番
       │
       ▼
  Progress.md にチェックリスト作成
       │
       ▼
  実装ループ（サブタスク単位）
       │
       ▼
  品質検証（→ system-quality）
       │
       ▼
  完了処理
  ├─ Plan に完了状況反映
  ├─ Feedback.md に記録
  ├─ Progress.md アーカイブ
  └─ コミット
```

## 下流でのカスタマイズ

- `TODO.md` と `docs/plans/` に独自のタスクと計画を配置する
- `ProgressTemplate.md` を編集して品質検証フローをカスタマイズ（Stage 1 のみ or Stage 1+2）
- CLAUDE.repo.md でブートシーケンスの補足を追加可能

## 関連するシステム

- **ノウハウ蓄積**: ブートシーケンス Step 5 で knowhow-agent を起動、実装完了時に knowhow 記録
- **品質ゲート**: Progress.md の「タスク完了時 — 品質検証」で品質ゲートシステムを起動
- **セッション管理**: ブートシーケンスが計画駆動の起点
