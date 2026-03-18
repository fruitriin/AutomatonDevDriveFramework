---
name: addf-knowhow-index
description: docs/knowhow/INDEX.md を参照して「何を知っているか」を把握する。reindex 引数でインデックスを再構築する。
context: fork
user_invocable: true
---

# Knowhow インデックス

## 引数
- **引数なし**: `docs/knowhow/INDEX.md` を読み、内容をそのまま返す
- **`reindex`**: `docs/knowhow/` の全ファイルを読み込み、`docs/knowhow/INDEX.md` を再構築する

## 目的

インデックスを読むだけで「knowhow として何を知っているか」を把握できる状態にする。
全ファイルを読まなくても、どのファイルにどんな知見があるかが分かる。

---

## 引数なしの場合

1. `docs/knowhow/INDEX.md` を読む
2. 内容をそのまま返す

---

## `reindex` の場合

1. `docs/knowhow/` 内の全 `.md` ファイルを読む（`INDEX.md` 自体は除く）
2. 各ファイルについて以下を抽出する:
   - **ファイルパス**
   - **一行要約**: そのファイルが扱う中心トピック（1文）
   - **キーワード**: 実装判断に影響する特徴的な用語（5〜15個）。API名、パターン名、制約名など具体的なものを優先する
3. `docs/knowhow/INDEX.md` に以下の形式で書き出す:

```markdown
# Knowhow Index

> 自動生成。`/addf-knowhow-index reindex` で再生成できる。

| ファイル | 要約 | キーワード |
|---|---|---|
| [example.md](example.md) | 例の知見 | keyword1, keyword2 |
| ... | ... | ... |
```

4. ファイルをトピック領域ごとにグルーピングして並べる（領域はプロジェクトに応じて自動判定する）

## 経験の活用
- 実行前に `addf-knowhow-index.exp.md` が存在すれば読み、過去の経験（グルーピング判断、キーワード選定の改善等）を考慮する
- 実行後、新たな教訓があれば `addf-knowhow-index.exp.md` に追記する

## 注意

- キーワードは「検索で引っかかる」ことを重視する。抽象的な単語より具体的な API 名・パターン名を優先する
- 新しい knowhow が追加されたら `/addf-knowhow-index reindex` を実行してインデックスを更新する
