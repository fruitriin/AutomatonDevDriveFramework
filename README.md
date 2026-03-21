# AutomatonDevDrive Framework

> ADDF is one of Agentic Driven Development Framework

[English README](README.en.md)

自動人形（Automaton）が開発を自律駆動するフレームワークです。
プロジェクトをクローンし、初期化して、計画書を与えれば、AIエージェントが自律的にタスクを選び、実装し、品質検証まで完遂します。

## 特徴

- **ノウハウ蓄積** — 実装で得た知見を `docs/knowhow/` に記録し、以降のタスクで自動参照
- **自己推進** — `/addf-dev` で1タスク完遂、`/loop 1h /addf-dev` で自律繰り返し
- **スキルと経験の分離** — スキル定義（`.md`）と経験蓄積（`.exp.md`）を分離し、経験はローカルに蓄積
- **品質ゲート** — コードレビュー・セキュリティレビュー・コントリビューション検出を自動実行
- **GUI テスト**（オプション） — macOS 向けスクリーンショット撮影・画像解析によるUIの視覚的検証

## クイックスタート

### 1. テンプレートからリポジトリを作成

GitHub で **[Use this template](https://github.com/fruitriin/AutomatonDevDriveFramework/generate)** をクリックし、新しいリポジトリを作成します。

```bash
git clone https://github.com/your-org/my-project.git
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
/addf-dev
```

1タスクを選択・実装・品質検証・コミットまで完遂します。繰り返し自律実行するには:

```
/loop 1h /addf-dev
```

## スキル

ADDF が提供するスキル（`/コマンド名` で呼び出し）:

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-dev** | `/addf-dev` | TODO からタスクを1つ選び、実装・品質検証・コミットまで完遂 |
| **addf-init** | `/addf-init [check]` | プロジェクト初期化 / 構造検証 |
| **addf-release** | `/addf-release [minor]` | リリース（チェンジログ・バージョン採番・publish） |
| **addf-migrate** | `/addf-migrate` | ADDF フレームワークを最新版にアップグレード |
| **addf-knowhow** | `/addf-knowhow <トピック>` | 実装知見を記録（重複チェック・統合付き） |
| **addf-knowhow-index** | `/addf-knowhow-index [reindex]` | ノウハウインデックスの参照・再構築 |
| **addf-lint** | `/addf-lint` | フレームワーク整合性チェック |
| **addf-permission-audit** | `/addf-permission-audit` | 権限要求の分析・分類・settings への追加提案 |

<details>
<summary>その他のスキル</summary>

| スキル | 説明 |
|---|---|
| **addf-knowhow-filter** | Plan に関連するノウハウをフィルタリング |
| **addf-experience** | 経験ファイル（`.exp.md`）のメンション書式を検証 |
| **addf-gui-test** | GUI テスト実行（macOS オプション） |
| **addf-annotate-grid** | PNG 画像にグリッド線を描画 |
| **addf-clip-image** | PNG 画像の領域切り出し |

</details>

## 組み込みエージェント

品質ゲートで自動起動されるサブエージェント。プロジェクトに合わせて定義を変更・追加できます。

| エージェント | 用途 | カスタマイズ指針 |
|---|---|---|
| **addf-knowhow-agent** | Plan に関連するノウハウをフィルタリング | — |
| **addf-code-review-agent** | コード品質・可読性のレビュー | プロジェクトのコーディング規約を追記 |
| **addf-security-review-agent** | セキュリティ脆弱性の検査（オプション） | 業界固有のセキュリティ基準を追記 |
| **addf-contribution-agent** | フレームワークへのコントリビューション候補検出 | — |
| **addf-ui-test-agent** | スクリーンショットベースの UI 検証（オプション） | **プロジェクトの UI/UX 専門家として定義を書き換える** |

> **テスターエージェントはプロジェクトの専門家であるべきです。**
> `addf-ui-test-agent` や `addf-security-review-agent` の定義（`.claude/agents/`）を、プロジェクトのドメイン知識・テスト基準・品質要件に合わせてカスタマイズしてください。
> 例: EC サイトなら決済フローの検証手順、iOS Native なら iOS シミュレータでの自動テスト手順を追加する、など。

## ドキュメント

| ガイド | 内容 |
|---|---|
| [詳細セットアップ](docs/guides/setup.md) | 手動セットアップ、設定ファイルの役割、ディレクトリ構成 |
| [組み込みエージェント](docs/guides/agents.md) | 品質ゲートで自動起動されるサブエージェントの詳細とカスタマイズ |
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
