---
name: addf-init
description: |
  ADDF プロジェクトの初期セットアップまたは構造検証を行う。
  新規プロジェクトで ADDF を導入するとき、またはプロジェクト構造の整合性を確認したいときに使う。
  引数なしで初期化、`check` で構造検証。
user_invocable: true
---

# ADDF Init — プロジェクト初期化 & 構造検証

## 引数

- **引数なし**: 初期セットアップ（init モード）
- `check`: 構造検証（check モード）

---

## init モード（引数なし）

### Phase 1: 状態確認

1. 既に ADDF 導入済みか判定する:
   - `.claude/addf-lock.json` が存在する → 「ADDF は導入済みです。`/addf-init check` で構造を検証できます」と案内して終了
   - `CLAUDE.md` または `.claude/` が存在するが `addf-lock.json` がない → 「ADDF が手動導入済みの可能性があります。続行すると既存ファイルを保護しつつ初期化を補完します。続行しますか？」と確認を求める
   - どちらも存在しない → 初期セットアップを開始

### Phase 2: 対話的セットアップ

2. ユーザーに以下を質問する（未回答はデフォルト値を使用）:

   **必須:**
   - プロジェクト名（デフォルト: リポジトリ名）
   - プロジェクト種別: `ADDF 利用プロジェクト`（デフォルト） / `ADDF 開発プロジェクト`

   **任意:**
   - ビルドコマンド（例: `npm run build`）
   - Lint コマンド（例: `npm run lint`）
   - テストコマンド（例: `npm test`）
   - コミットログ規約（デフォルト: 日本語 `[領域] 変更内容の要約`）
   - ターゲットエージェント: `Claude Code`（デフォルト） / `Codex` / `両方`

### Phase 3: ファイル生成

以下のファイルを生成する。**既存ファイルは上書きしない**（存在する場合はスキップして通知）。

3. **`CLAUDE.repo.md`** を生成:
   - `CLAUDE.repo.example.md` をベースにする
   - プロジェクト名を反映
   - プロジェクト種別に応じて「プロジェクト種別」セクションを設定
   - ビルド・Lint・テストコマンドを「テスト」セクションに反映
   - コミットログ規約を反映

4. **Codex 対応**（ターゲットが Codex または両方の場合）:
   - `AGENTS.md` がリポジトリに存在することを確認（ADDF 同梱済み）
   - 以下の設定案内を表示:
     ```
     Codex を使用する場合、~/.codex/config.toml に以下を追加してください:

     project_doc_fallback_filenames = ["CLAUDE.md"]
     approval_policy = "on-request"
     sandbox_mode = "workspace-write"
     ```

5. **`CLAUDE.local.md`** を生成:
   - `CLAUDE.local.example.md` の内容をコピー

6. **`.claude/addf-lock.json`** を生成:
   - `git remote get-url origin` でリポジトリ URL を取得する（取得できない場合はユーザーに入力を求める）
   - `git rev-parse HEAD` でコミットハッシュを記録
   - version: `"0.1.0"`
   - repository: 取得した URL
   - このファイルは `/addf-migrate` がバージョン差分を算出する際のアンカーとして使用される

7. **`TODO.md`** を初期化:
   ```markdown
   # TODO

   `docs/plans/` の完了状態・優先度をトラックする。
   `docs/plans/` と TODO が一致しなければ TODO を編集する。

   ## 現在のフェーズ: （次に着手）

   ## バックログ

   | 優先度 | Phase | 計画ファイル | 状態 |
   |---|---|---|---|

   ---

   ## アーカイブ

   | Phase | 計画ファイル | 状態 |
   |---|---|---|
   ```

8. **`docs/plans/`** ディレクトリを作成（存在しなければ）

9. **`docs/knowhow/INDEX.md`** を初期化（存在しなければ）:
   ```markdown
   # Knowhow Index

   > 自動生成。`/addf-knowhow-index reindex` で再生成できる。

   | ファイル | 要約 | キーワード |
   |---|---|---|
   ```

### Phase 4: 完了

10. 生成結果をレポートする:
    ```
    ╔══════════════════════════════════════╗
    ║  ADDF Init Complete                  ║
    ╚══════════════════════════════════════╝

    ✓ CLAUDE.repo.md          — 生成済み
    ✓ CLAUDE.local.md         — 生成済み
    ✓ .claude/addf-lock.json  — 生成済み
    ✓ TODO.md                 — 初期化済み
    ✓ docs/plans/             — 作成済み
    ✓ docs/knowhow/INDEX.md   — 初期化済み
    ○ AGENTS.md               — 既存（スキップ）

    次のステップ:
    1. CLAUDE.repo.md を確認・カスタマイズしてください
    2. docs/plans/ に計画ファイルを作成してください
    3. `/loop 1h /addf-dev-loop` で自律開発を開始できます
    ```

---

## check モード（`/addf-init check`）

読み取り専用で副作用なし。プロジェクト構造の整合性を検証する。

### チェック項目

1. **必須ファイルの存在確認**:
   - `CLAUDE.md` — ブートシーケンス定義
   - `CLAUDE.repo.md` — プロジェクト固有設定
   - `TODO.md` — タスクバックログ
   - `.claude/Progress.md` — 進捗管理
   - `.claude/Feedback.md` — フィードバック記録
   - `.claude/addf-lock.json` — バージョンロック
   - `.claude/settings.json` — 権限設定

2. **`CLAUDE.md` の `@` メンション解決**:
   - `CLAUDE.md` 内の `@ファイル名` パターンを抽出
   - 各参照先ファイルが実在するか確認
   - 解決できない参照があれば WARNING

3. **`TODO.md` と `docs/plans/` の整合性**:
   - TODO に記載された計画ファイルが `docs/plans/` に存在するか
   - `docs/plans/` にあるが TODO に未記載のファイルがないか

4. **`.claude/addf-lock.json` の妥当性**:
   - JSON として valid か
   - `version`, `commit`, `repository` フィールドが存在するか
   - `commit` が 40 文字の hex 文字列形式か（形式チェックのみ、リモート確認は行わない）

5. **AGENTS.md の存在**（情報レベル）:
   - 存在すれば OK、なければ INFO（Codex 非対応として通知）

### レポート形式

```
╔══════════════════════════════════════╗
║  ADDF Structure Check                ║
╚══════════════════════════════════════╝

1. 必須ファイル        ✓ 7/7 存在
2. @ メンション解決    ✓ 全て解決可能
3. TODO ↔ plans 整合   ✓ 一致
4. addf-lock.json      ✓ 有効
5. AGENTS.md           ✓ 存在（Codex 対応）

結果: ✓ All checks passed
```

問題がある場合は `✗` と詳細・修正提案を表示する。

---

## 再生性（Idempotency）

- init モード: 既存ファイルは上書きしない（スキップして通知）
- check モード: 読み取り専用、副作用なし
- 何度実行しても安全

## 経験の活用
- 実行前に `addf-init.exp.md` が存在すれば読み、過去の経験を考慮する
- 実行後、新たな教訓があれば `addf-init.exp.md` に追記する
