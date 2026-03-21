# AutomatonDevDrive Framework

> ADDF is one of Agentic Driven Development Framework

[English README](README.en.md)

自動人形（Automaton）が開発を自律駆動するフレームワークです。
プロジェクトをクローンし、初期化して、計画書を与えれば、AIエージェントが自律的にタスクを選び、実装し、品質検証まで完遂します。

## 特徴

- **ノウハウ蓄積** — 実装で得た知見を `docs/knowhow/` に記録し、以降のタスクで自動参照
- **自己推進ループ** — `/loop 1h /addf-dev-loop` で TODO からタスクを自律選択・実装
- **スキルと経験の分離** — スキル定義（`.md`）と経験蓄積（`.exp.md`）を分離し、経験はローカルに蓄積
- **品質ゲート** — コードレビュー・セキュリティレビュー・コントリビューション検出を自動実行
- **GUI テスト**（オプション） — macOS 向けスクリーンショット撮影・画像解析によるUIの視覚的検証

## クイックスタート

### 1. クローン

```bash
git clone https://github.com/fruitriin/AutomatonDevDriveFramework.git my-project
cd my-project
```

### 2. 初期化

```
/addf-init
```

対話形式でプロジェクト名・種別・ビルドコマンド等を設定し、必要なファイルを自動生成します。

### 3. 計画を作成して開発を開始

計画は簡素なメモから作成できます:

```markdown
- ログイン機能を追加
- テストカバレッジを上げる
```

これを Claude に渡すだけで、AI が計画ファイル群に分解して `docs/plans/` と `TODO.md` に投入します。

```
/loop 1h /addf-dev-loop
```

これで AI エージェントが自律的に開発サイクルを回します。

## ドキュメント

| ガイド | 内容 |
|---|---|
| [詳細セットアップ](docs/guides/setup.md) | 手動セットアップ、設定ファイルの役割、ディレクトリ構成 |
| [スキル一覧](docs/guides/skills.md) | ADDF が提供する全スキルの呼び出し方と説明 |
| [エージェント一覧](docs/guides/agents.md) | 品質ゲートで自動起動されるサブエージェント |
| [開発プロセス](docs/guides/development-process.md) | ブートシーケンス、品質ゲート、タスクのライフサイクル |
| [バージョンアップ](docs/guides/migration.md) | `/addf-migrate` による ADDF のアップグレード手順 |
| [Codex で使う](docs/guides/codex-setup.md) | OpenAI Codex CLI での ADDF 利用ガイド |
| [GUI テスト](docs/guides/gui-test-setup.md) | macOS 向け GUI テストのセットアップ |

## 名前について

このフレームワークの正式名称は **AutomatonDevDrive Framework**。

……なのですが、頭文字を拾うと **ADDF**。
そして ADDF を展開すると — **A**gentic **D**riven **D**evelopment **F**ramework。

偶然ではありません。

Automaton（自動人形）は、AIエージェントが自律的にタスクを選び、実装し、品質を検証する様子をそのまま指しています。人間が逐一指示しなくても、自動人形は動き続ける。DevDrive はその動力源——開発を駆動するエンジンのような存在です。

表の名前は Automaton、裏の名前は Agentic。どちらも同じものを指している。
気づいた人はニヤリとしてください。
