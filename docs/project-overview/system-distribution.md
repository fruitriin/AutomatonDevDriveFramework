# 配布・導入 — Framework distribution, installation, and documentation

> 概念単位の記録。実装がスキル/エージェント/フック/ファイルのどれであっても、
> 「ADDF の導入・更新・リリース・ドキュメンテーション」に関わるものをまとめている。

## 構成要素

| 種別 | 名前 | 役割 |
|---|---|---|
| スキル | addf-init | 新規/既存プロジェクトへの ADDF 導入（外部URL・テンプレート・既存採用の3モード） |
| スキル | addf-migrate | addf-lock.json 基準でフレームワークを最新版にアップグレード |
| スキル | addf-release | リリースワークフロー（upstream/downstream 自動切替） |
| スキル | addf-overview | エコシステム概要ドキュメントの生成（本ドキュメント） |
| ファイル | .claude/addf-lock.json | バージョン・コミット・更新日の追跡（現在 v0.2.0） |
| ファイル | CONTRIBUTING.md | コントリビューションモデル（計画駆動レビュー） |
| テンプレート | .claude/templates/Release.md | リリース手順テンプレート |
| ディレクトリ | docs/guides/ | セットアップ・運用ガイド群（7本） |

### docs/guides/ 一覧

| ファイル | 内容 |
|---|---|
| setup.md | ADDF 導入ガイド |
| development-process.md | 開発プロセスガイド |
| skills.md | スキル一覧・使い方 |
| agents.md | エージェント一覧・使い方 |
| gui-test-setup.md | GUI テストセットアップ |
| codex-setup.md | Codex 環境セットアップ |
| migration.md | マイグレーションガイド |

## 設計思想

ADDF は「配布されるフレームワーク」であり、導入→運用→更新のライフサイクルを持つ。

**導入パス**:
1. **新規プロジェクト**: GitHub Template から `addf-init` で初期化
2. **既存プロジェクト**: `addf-init` が既存の CLAUDE.md を退避し、干渉チェック後に統合

**バージョン管理**:
- `addf-lock.json` が現在のバージョンを記録
- `addf-migrate` がロックファイルと最新版の差分を算出し、安全にアップグレード
- CLAUDE.md / CLAUDE.repo.md の分離設計により、マイグレーション時の衝突を最小化

**リリース**:
- `addf-release` が upstream（ADDF 本体）と downstream（利用プロジェクト）で手順を自動切替
- 責務分割: スキル=ルーター、設定ファイル=手順定義、.exp.md=プロジェクト戦略

## 主要フロー

```
導入:
  addf-init
  ├─ 外部URL → GitHub から ADDF をフェッチ → 初期化
  ├─ テンプレート → ADDF テンプレートベースで新規作成
  └─ 既存プロジェクト → CLAUDE.md 退避 → 干渉チェック → 統合

更新:
  addf-migrate
  ├─ addf-lock.json 読み込み
  ├─ 最新版クローン → diff 算出
  ├─ 変更プレビュー → 適用
  └─ lock 更新

リリース:
  addf-release
  ├─ upstream: ADDF-Release.addf.md に従う
  └─ downstream: .exp.md or 対話的に戦略構築
```

## 下流でのカスタマイズ

- `CLAUDE.repo.md` でプロジェクト種別（ADDF 開発 or ADDF 利用）を宣言
- `docs/guides/` にプロジェクト固有のガイドを追加可能
- `addf-release` は downstream で初回実行時に対話的にリリース戦略を構築し、.exp.md に保存

## 関連するシステム

- **セッション管理**: CLAUDE.md, settings.json は配布対象でありセッション管理の構成要素でもある
- **品質ゲート**: addf-lint がフレームワーク整合性を検証（配布物の品質保証）
- **全システム**: addf-overview が全システムを横断的にドキュメント化
