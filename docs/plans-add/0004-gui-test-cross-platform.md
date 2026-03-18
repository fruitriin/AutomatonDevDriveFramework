# 計画: GUI テストのクロスプラットフォーム抽象化

## 動機
現在の GUI テスト機能は macOS（Swift/ScreenCaptureKit）専用。プラットフォーム設定と抽象インターフェースを導入し、将来の拡張に備える。

## 設計

### 1. `add-Behavier.toml` の拡張（ファイル名 typo: `Behavier` → `Behavior` のリネームも実施する）
```toml
[gui-test]
enable = false
machine = "mac"  # "mac" | "linux" | "windows"
```

### 2. 抽象インターフェース定義
スキル（`add-gui-test.md`）がプラットフォームを意識せず使えるよう、以下の操作を抽象化:
- **window-info**: ウィンドウ一覧取得
- **capture-window**: スクリーンショット撮影
- **annotate-grid**: グリッド描画（プラットフォーム非依存、既存実装で対応可能）
- **clip-image**: 画像切り出し（プラットフォーム非依存、既存実装で対応可能）

### 3. プラットフォーム固有実装
- macOS: 既存の Swift 実装をそのまま使用
- Linux/Windows: 未実装（スタブまたはエラーメッセージ）

### 4. ドキュメント
- GUI テスト機能のセットアップ手順
- macOS での Screen Recording 権限の設定方法

## 影響範囲
- `.claude/add-Behavier.toml`
- `.claude/skills/add-gui-test.md`（プラットフォーム判定ロジック追加）
- ドキュメント追加
