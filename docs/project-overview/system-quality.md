# 品質ゲート — Multi-agent quality assurance

> 概念単位の記録。実装がスキル/エージェント/フック/ファイルのどれであっても、
> 「コード品質の検証・保証」に関わるものをまとめている。

## 構成要素

| 種別 | 名前 | 役割 |
|---|---|---|
| エージェント | addf-code-review-agent | コード品質・可読性・ベストプラクティスのレビュー（Sonnet） |
| エージェント | addf-security-review-agent | セキュリティ脆弱性の検出・修正案提示（Sonnet） |
| エージェント | addf-contribution-agent | ADDF / プロジェクト固有コードの識別、アップストリーム貢献候補検出（Sonnet） |
| スキル | addf-lint | フレームワーク整合性チェック（6項目: JSON構文・フック権限・frontmatter・Behavior.toml・INDEX整合・テンプレート同期） |
| テスト | .claude/tests/run-all.sh | フレームワーク自動テスト（フック・ツール・スキル） |
| ツール | .claude/addfTools/lint-*.py | Lint 用 Python スクリプト群（JSON, frontmatter, TOML, template-sync） |

## 設計思想

ADDF の第三の柱。「人間がレビューするのは計画の方向性、コード品質は AI が担保する」という CONTRIBUTING.md の方針を実装する。

2段階の品質ゲート:
- **Stage 1（ゲートキーパー）**: ビルド・Lint・テスト。失敗したら実装に差し戻し
- **Stage 2（品質検証チーム）**: code-review, security-review, contribution-agent を並列実行

重要度による対応方針:
- **Critical/High**: 必ずそのフェーズ内で修正（先送り禁止）
- **Medium**: 原則修正、先送りは独立計画へ
- **Low/Info**: 計画に記録

addf-lint はフレームワーク固有の整合性チェッカーで、プロジェクトのビルドツールとは別に動作する。

## 主要フロー

```
タスク実装完了
  │
  ▼
Stage 1: ビルド検証
  ├─ bash .claude/tests/run-all.sh
  ├─ プロジェクト固有の build/lint/test
  └─ 失敗 → 実装に差し戻し
  │
  ▼（Stage 1 通過後）
Stage 2: 品質検証チーム（並列起動）
  ├─ addf-code-review-agent  ─┐
  ├─ addf-security-review-agent ─┤─ フィードバック集約
  └─ addf-contribution-agent  ─┘
  │
  ▼
指摘対応
  ├─ Critical/High → 即修正 → Stage 1 再実行
  ├─ Medium → 修正 or 独立計画
  └─ Low/Info → 計画に記録
```

## 下流でのカスタマイズ

- Stage 2 の品質検証チームの構成を CLAUDE.repo.md で変更可能
- addf-ui-test-agent を追加して GUI テストを品質ゲートに組み込める（オプション）
- addf-contribution-agent はダウンストリームプロジェクトでは ADDF へのフィードバック候補を検出する
- addf-lint の項目はフレームワーク固定だが、プロジェクト固有の Lint は Stage 1 で実行

## 関連するシステム

- **計画駆動**: Progress.md の品質検証フローが品質ゲートを起動する
- **ノウハウ蓄積**: レビューで得た知見が knowhow に蓄積される
- **視覚テスト**: addf-ui-test-agent が Stage 2 に参加可能
