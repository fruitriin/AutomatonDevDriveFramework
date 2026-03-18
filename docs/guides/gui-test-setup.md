# GUI テスト セットアップガイド

## 概要

ADD フレームワークの GUI テスト機能は、スクリーンショット撮影・グリッドアノテーション・画像クリップを使った視覚的な UI 検証を提供します。

現在 **macOS のみ** 対応しています。

## 前提条件

- macOS 15 以降（ScreenCaptureKit 使用）
- Swift コンパイラ（Xcode Command Line Tools）
- Screen Recording 権限

## セットアップ手順

### 1. プラットフォーム設定

`.claude/add-Behavior.toml` を編集:

```toml
[gui-test]
enable = true
machine = "mac"
```

### 2. ツールのビルド

```bash
cd .claude/addToolsSrc
bash build.sh
```

以下の4つのバイナリがビルドされます:
- `window-info` — ウィンドウ一覧・位置・サイズを JSON 出力
- `capture-window` — 指定ウィンドウのスクリーンショット撮影
- `annotate-grid` — PNG 画像にグリッド線と座標ラベルを描画
- `clip-image` — PNG 画像の指定領域を切り出し

### 3. Screen Recording 権限の確認

```bash
bash .claude/addToolsSrc/check-screen-recording.sh
```

権限がない場合は、macOS のシステム設定から付与してください:
- **システム設定** → **プライバシーとセキュリティ** → **画面収録** → ターミナルアプリを追加

## 使い方

### スキルから呼び出し

```
/add-gui-test <シナリオ番号>
```

テストシナリオは `docs/test-scenarios/` に配置します。

### 個別ツールの直接使用

```bash
# ウィンドウ情報を取得
.claude/addToolsSrc/window-info <プロセス名>

# スクリーンショットを撮影
.claude/addToolsSrc/capture-window <プロセス名> tmp/capture.png

# グリッドアノテーション
.claude/addToolsSrc/annotate-grid tmp/capture.png tmp/annotated.png

# 画像クリップ
.claude/addToolsSrc/clip-image tmp/annotated.png tmp/clip.png --rect 100,200,300,400
```

## プラットフォーム対応状況

| プラットフォーム | `machine` 値 | 状態 |
|---|---|---|
| macOS | `"mac"` | 対応済み（Swift/ScreenCaptureKit） |
| Linux | `"linux"` | 未実装 |
| Windows | `"windows"` | 未実装 |

Linux/Windows の GUI テストツール実装はコントリビューションを歓迎します。
`add-gui-test.md` スキルのプラットフォーム判定ロジックは実装済みのため、プラットフォーム固有ツールを `.claude/addToolsSrc/` に追加するだけで対応できます。

## トラブルシューティング

### ビルドに失敗する
- Xcode Command Line Tools がインストールされているか確認: `xcode-select --install`
- macOS 15 以降が必要です

### Screen Recording 権限エラー
- `check-screen-recording.sh` を実行して権限を確認
- ターミナルアプリに Screen Recording 権限が付与されているか確認

### `gui-test.enable = false` と表示される
- `.claude/add-Behavior.toml` の `enable` を `true` に変更してください
