# AccrateDevDrive Framework

[English README](README.en.md)

AI駆動自動推進フレームワークです。
プロジェクトをクローンし、いくつかのファイルを差し替えて、計画書（`docs/plans/`）を与えれば、AIエージェントが自律的に開発を推進します。

## 特徴

- **ノウハウ蓄積** — 実装で得た知見を `docs/knowhow/` に記録し、以降のタスクで自動参照
- **自己推進ループ** — `/loop 1h /dev-loop` で TODO からタスクを自律選択・実装
- **スキルと経験の分離** — スキル定義（`.md`）と経験蓄積（`.exp.md`）を分離し、経験はローカルに蓄積
- **品質ゲート** — コードレビュー・セキュリティレビュー・コントリビューション検出を自動実行
- **GUI テスト**（オプション） — macOS 向けスクリーンショット撮影・画像解析によるUIの視覚的検証

## セットアップ

### 1. リポジトリをクローン

```bash
git clone https://github.com/your-org/AccrateDevDriveFramwork.git my-project
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

`docs/plans/` に計画ファイルを作成し、`TODO.md` のバックログに追加します。
計画ファイルの書式は [CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。

```
/loop 1h /add-dev-loop
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
│   └── addToolsSrc/             # GUI テストツール（macOS/Swift）
├── docs/
│   ├── plans/                   # 実装計画ファイル
│   └── knowhow/                 # 実装知見の蓄積
└── .gitignore / .claudeignore
```

## フレームワークスキル

ADD フレームワークが提供するスキル（`/コマンド名` で呼び出し）:

### ノウハウ管理

| スキル | 呼び出し | 説明 |
|---|---|---|
| **add-knowhow** | `/add-knowhow <トピック>` | 実装知見を `docs/knowhow/` に記録。既存ノウハウとの重複チェック・統合を自動で行う |
| **add-knowhow-index** | `/add-knowhow-index [reindex]` | knowhow インデックスを参照、または `reindex` で再構築 |
| **add-knowhow-filter** | `/add-knowhow-filter <plan-path>` | Plan に関連するノウハウだけをフィルタリングして返す |

### 開発ループ

| スキル | 呼び出し | 説明 |
|---|---|---|
| **add-dev-loop** | `/loop 1h /add-dev-loop` | TODO.md から未実施タスクを自律選択し、実装・品質検証・コミットまで完遂するループ |

### 経験管理

| スキル | 呼び出し | 説明 |
|---|---|---|
| **add-experience** | `/add-experience` | スキル経験ファイル（`.exp.md`）のファイルメンション書式を検証 |

### GUI テスト（オプション）

有効化するには `.claude/add-Behavior.toml` で `enable = true` に設定してください。macOS のみ対応。

| スキル | 呼び出し | 説明 |
|---|---|---|
| **add-gui-test** | `/add-gui-test <シナリオ>` | `docs/test-scenarios/` のシナリオに基づき GUI テストを実行 |
| **add-annotate-grid** | `/add-annotate-grid <path>` | PNG 画像にグリッド線と座標ラベルを描画（LLM の座標認識用） |
| **add-clip-image** | `/add-clip-image <path>` | PNG 画像の指定領域を切り出し（注目領域の抽出用） |

## フレームワークエージェント

品質ゲートやブートシーケンスで自動起動されるサブエージェント:

| エージェント | 用途 | 起動タイミング |
|---|---|---|
| **add-knowhow-agent** | Plan に関連するノウハウをフィルタリング | ブートシーケンス（タスク開始時） |
| **add-code-review-agent** | コード品質・可読性のレビュー | タスク完了時の品質検証 |
| **add-security-review-agent** | セキュリティ脆弱性の検査・報告 | タスク完了時の品質検証（オプション） |
| **add-contribution-agent** | フレームワークへのコントリビューション候補の検出 | タスク完了時の品質検証 |
| **add-ui-test-agent** | スクリーンショット・画像解析による UI 検証 | タスク完了時の品質検証（オプション） |

## 開発プロセス

```
計画（Plan）→ 実装 → 品質検証 → コミット
```

- **計画駆動**: コードではなく計画をレビューする。筋の良い計画は受け入れ、実装は AI が担保する
- **ブートシーケンス**: セッション開始時に Feedback → TODO → Progress を順に読み込み、現在の状態を把握
- **品質ゲート**: ビルド・Lint・テスト → コードレビュー → セキュリティレビュー（オプション）
- **並列実装**: git worktree を活用したサブタスクの並列実行

詳細は [CONTRIBUTING.md](CONTRIBUTING.md) を参照してください。
