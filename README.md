# AutomatonDevDrive Framework

> ADDF is one of Agentic Driven Development Framework

[English README](README.en.md)

自動人形（Automaton）が開発を自律駆動するフレームワークです。
プロジェクトをクローンし、いくつかのファイルを差し替えて、計画書（`docs/plans/`）を与えれば、AIエージェントが自律的にタスクを選び、実装し、品質検証まで完遂します。

## 特徴

- **ノウハウ蓄積** — 実装で得た知見を `docs/knowhow/` に記録し、以降のタスクで自動参照
- **自己推進ループ** — `/loop 1h /dev-loop` で TODO からタスクを自律選択・実装
- **スキルと経験の分離** — スキル定義（`.md`）と経験蓄積（`.exp.md`）を分離し、経験はローカルに蓄積
- **品質ゲート** — コードレビュー・セキュリティレビュー・コントリビューション検出を自動実行
- **GUI テスト**（オプション） — macOS 向けスクリーンショット撮影・画像解析によるUIの視覚的検証

## セットアップ

### 1. リポジトリをクローン

```bash
git clone https://github.com/your-org/AutomatonDevDriveFramework.git my-project
cd my-project
```

### 2. プロジェクト固有ファイルを差し替え

| ファイル | 操作 | 説明 |
|---|---|---|
| `README.md` | 差し替え | プロジェクト独自の説明に書き換え |
| `CLAUDE.repo.md` | 作成 | `CLAUDE.repo.example.md` を参考に作成（`.gitignore` 対象、ローカルのみ） |
| `CLAUDE.local.md` | 作成（任意） | `CLAUDE.local.example.md` を参考に、開発者個人の設定を記載 |
| `CONTRIBUTING.md` | 差し替え（任意） | 必要に応じてプロジェクトに合わせる |

### 3. 設定の役割

| ファイル | 読み込み方式 | コミット |
|---|---|---|
| `CLAUDE.repo.md` | CLAUDE.md から `@` メンションで展開 | しない（`.gitignore`対象） |
| `CLAUDE.local.md` | Claude Code が自動読み込み | しない（`.gitignore`対象） |
| `.gitignore` | git 標準 | する |
| `.claudeignore` | Claude Code 標準 | する |

`.gitignore` 対象でも Claude Code はパス指定でアクセスできるため、「git 非追跡だが Claude には見せたいファイル」（`*.exp.md` 等）は `.gitignore` にだけ書きます。

### 4. 計画を作成して開発を開始

計画ファイルは簡素なメモや箇条書きから作成できます。たとえば:

```markdown
<!-- こんなメモを plan.md に書いて… -->
- README のスキルセクションが空
- 英語ドキュメントがない
- GUI テストが macOS 専用
```

これを Claude に渡す（`plan.md` とだけ入力する、チャットに箇条書きを貼る、等）だけで、AI が自動的にプロジェクトをレビューし、正式な計画ファイル群に分解して `docs/plans/` と `TODO.md` に投入します。実際に ADDF 自身の開発もこの方法で始まりました。

計画ファイルの書式は [CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。

```
/loop 1h /addf-dev-loop
```

これで AI エージェントが `TODO.md` → `docs/plans/` → 実装 → 品質検証 → コミットのサイクルを自律的に回します。

## ディレクトリ構成

```
.
├── CLAUDE.md                    # ブートシーケンス・開発プロセス定義
├── CLAUDE.repo.example.md       # CLAUDE.repo.md のテンプレート
├── CLAUDE.local.example.md      # CLAUDE.local.md のテンプレート
├── TODO.md                      # タスクバックログ
├── CONTRIBUTING.md              # コントリビューションガイド
├── .claude/
│   ├── Progress.md              # 現在のタスク進捗
│   ├── Feedback.md              # 問題記録・改善アクション
│   ├── Progresses/              # 完了タスクのアーカイブ
│   ├── templates/               # テンプレートファイル
│   ├── skills/                  # スキル定義
│   │   └── optional/            # オプショナルスキル
│   ├── agents/                  # サブエージェント定義
│   └── addfTools/             # GUI テストツール（macOS/Swift）
├── docs/
│   ├── plans/                   # 実装計画ファイル
│   └── knowhow/                 # 実装知見の蓄積
└── .gitignore / .claudeignore
```

## フレームワークスキル

ADDF が提供するスキル（`/コマンド名` で呼び出し）:

### ノウハウ管理

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-knowhow** | `/addf-knowhow <トピック>` | 実装知見を `docs/knowhow/` に記録。既存ノウハウとの重複チェック・統合を自動で行う |
| **addf-knowhow-index** | `/addf-knowhow-index [reindex]` | knowhow インデックスを参照、または `reindex` で再構築 |
| **addf-knowhow-filter** | `/addf-knowhow-filter <plan-path>` | Plan に関連するノウハウだけをフィルタリングして返す |

### 開発ループ

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-dev-loop** | `/loop 1h /addf-dev-loop` | TODO.md から未実施タスクを自律選択し、実装・品質検証・コミットまで完遂するループ |

### 経験管理

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-experience** | `/addf-experience` | スキル経験ファイル（`.exp.md`）のファイルメンション書式を検証 |

### GUI テスト（オプション）

有効化するには `.claude/addf-Behavior.toml` で `enable = true` に設定してください。macOS のみ対応。

| スキル | 呼び出し | 説明 |
|---|---|---|
| **addf-gui-test** | `/addf-gui-test <シナリオ>` | `docs/test-scenarios/` のシナリオに基づき GUI テストを実行 |
| **addf-annotate-grid** | `/addf-annotate-grid <path>` | PNG 画像にグリッド線と座標ラベルを描画（LLM の座標認識用） |
| **addf-clip-image** | `/addf-clip-image <path>` | PNG 画像の指定領域を切り出し（注目領域の抽出用） |

## フレームワークエージェント

品質ゲートやブートシーケンスで自動起動されるサブエージェント:

| エージェント | 用途 | 起動タイミング |
|---|---|---|
| **addf-knowhow-agent** | Plan に関連するノウハウをフィルタリング | ブートシーケンス（タスク開始時） |
| **addf-code-review-agent** | コード品質・可読性のレビュー | タスク完了時の品質検証 |
| **addf-security-review-agent** | セキュリティ脆弱性の検査・報告 | タスク完了時の品質検証（オプション） |
| **addf-contribution-agent** | フレームワークへのコントリビューション候補の検出 | タスク完了時の品質検証 |
| **addf-ui-test-agent** | スクリーンショット・画像解析による UI 検証 | タスク完了時の品質検証（オプション） |

## 開発プロセス

```
計画（Plan）→ 実装 → 品質検証 → コミット
```

- **計画駆動**: コードではなく計画をレビューする。筋の良い計画は受け入れ、実装は AI が担保する
- **ブートシーケンス**: セッション開始時に Feedback → TODO → Progress を順に読み込み、現在の状態を把握
- **品質ゲート**: ビルド・Lint・テスト → コードレビュー → セキュリティレビュー（オプション）
- **並列実装**: git worktree を活用したサブタスクの並列実行

詳細は [CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。

## 実運用の参考

このリポジトリ自体が ADDF を使って開発されています。フレームワークの実際の運用方法は、このリポジトリの git ログ・Plan・ノウハウ・設定ファイルがそのまま参考になります:

- **`docs/plans-add/`** — ADDF 自身の開発計画。Plan の書き方・粒度の実例
- **`docs/knowhow/ADDF/`** — 開発で蓄積されたノウハウ。権限設計・スキル設計パターン・分離戦略など
- **`.claude/settings.json`** — ダウンストリームテンプレートの実例。副作用のない操作のみ allow する設計方針
- **`.claude/Progresses/`** — 完了タスクのアーカイブ。Progress.md の運用フローの実例
- **`git log`** — コミットログ規約・品質ゲートの実際の適用結果

## 名前について

このフレームワークの正式名称は **AutomatonDevDrive Framework**。

……なのですが、頭文字を拾うと **ADDF**。
そして ADDF を展開すると — **A**gentic **D**riven **D**evelopment **F**ramework。

偶然ではありません。

Automaton（自動人形）は、AIエージェントが自律的にタスクを選び、実装し、品質を検証する様子をそのまま指しています。人間が逐一指示しなくても、自動人形は動き続ける。DevDrive はその動力源——開発を駆動するエンジンのような存在です。

表の名前は Automaton、裏の名前は Agentic。どちらも同じものを指している。
気づいた人はニヤリとしてください。
