# 権限要求パターンと settings ファイルの使い分け

## 発見した知見

### 3つの権限パターン

| パターン | 内容 | 例 |
|---|---|---|
| **アップストリーム** | ADDF フレームワーク開発・メンテナンスに必要な権限 | `sed`（大規模リネーム）、`find`（.gitignore 外探索）、`swiftc`（ツールビルド） |
| **ダウンストリーム** | プロジェクト固有の開発に必要な権限 | プロジェクトのビルドコマンド、テストランナー、デプロイツール |
| **汎用** | どのプロジェクトでも共通して必要な権限 | `git` 操作、ファイル操作（`cp`, `mv`, `rm`, `mkdir`, `ls`）、`chmod` |

### 2つのプロジェクト種別 × 配置先

#### ADDF 開発プロジェクト（このリポジトリ = フレームワーク本体）

| パターン | 配置先 | 理由 |
|---|---|---|
| アップストリーム | `settings.local.json` | ADDF 開発固有の権限。ダウンストリームに持ち込ませない |
| ダウンストリーム | `settings.json` | テンプレートとしてダウンストリームに配布される |
| 汎用 | `settings.json` | 全プロジェクトで共通、コミット対象 |

**ポイント**: このリポジトリの `settings.json` はダウンストリームの初期テンプレートになる。ADDF 開発でしか使わない `sed`, `find`, `swiftc` 等は `settings.local.json` に入れるべき。

#### ADDF 利用プロジェクト（ダウンストリーム）

| パターン | 配置先 | 理由 |
|---|---|---|
| アップストリーム | `settings.json` | ADDF フレームワーク機能（スキル・エージェント・フック）の実行に必要。全開発者で共有 |
| ダウンストリーム | `settings.json` | プロジェクト固有のビルド・テスト権限。全開発者で共有 |
| マシンローカル | `settings.local.json` | 個人の開発環境固有の権限（IDE 連携、個人ツール等） |

## プロジェクトへの適用

### 現在の settings.json の問題点

現在の `settings.json` にはアップストリーム権限（`sed`, `find`, `swiftc`, `git rev-parse`）が混在している。ダウンストリームプロジェクトがこのテンプレートをクローンすると、不要な権限が含まれてしまう。

### あるべき姿

**settings.json**（コミット対象、ダウンストリームのテンプレート）:
```json
{
  "permissions": {
    "allow": [
      "Bash(cp:*)",
      "Bash(mv:*)",
      "Bash(rm:*)",
      "Bash(mkdir:*)",
      "Bash(ls:*)",
      "Bash(chmod:*)",
      "Bash(tail:*)",
      "Bash(cd:*)",
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git log:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "Bash(git rm:*)",
      "Bash(git ls-files:*)",
      "Bash(git branch:*)",
      "Bash(git worktree:*)",
      "Bash(git checkout:*)",
      "Bash(git show:*)",
      "Bash(git merge:*)",
      "Bash(git stash:*)",
      "Bash(bash .claude/tests/run-all.sh:*)"
    ],
    "ask": [
      "Bash(git push:*)",
      "Bash(git reset --hard:*)",
      "Bash(git clean:*)"
    ]
  }
}
```

**settings.local.json**（ADDF 開発プロジェクトのみ、gitignore 対象）:
```json
{
  "permissions": {
    "allow": [
      "Bash(sed:*)",
      "Bash(find:*)",
      "Bash(git rev-parse:*)",
      "Bash(bash .claude/addfTools/build.sh:*)",
      "Bash(swiftc:*)"
    ]
  }
}
```

## 注意点・制約

- `settings.local.json` は `.gitignore` 対象なのでコミットされない
- 権限は `settings.local.json` > `settings.json` の優先順位で解決される
- 新しい権限を追加するときは「これはどのパターンか？」を判断してから配置先を決める
- `ask` に入れるべき破壊的操作（push, reset --hard, clean）はどちらのプロジェクト種別でも共通

## 参照

- `.claude/settings.json` — プロジェクト共有設定
- `.claude/settings.local.json` — ローカル設定
- `docs/knowhow/ADDF/upstream-downstream-separation.md` — 分離パターンの全体像
