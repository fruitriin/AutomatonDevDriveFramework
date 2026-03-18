# Knowhow Index

> 自動生成。`/addf-knowhow-index reindex` で再生成できる。

| ファイル | 要約 | キーワード |
|---|---|---|
| [ADDF/claude-md-at-mention.md](ADDF/claude-md-at-mention.md) | CLAUDE.md の @FileName メンション展開の仕組みと使い分け | @展開, メンション, クオート, ネスト展開, CLAUDE.md, インライン展開, ファイル参照 |
| [ADDF/ignore-file-strategy.md](ADDF/ignore-file-strategy.md) | .gitignore / .claudeignore / .git/info/exclude の役割分けと運用戦略 | .gitignore, .claudeignore, .git/info/exclude, respectGitignore, settings.json, Glob, Grep, ファイル除外 |
| [ADDF/claude-code-hooks.md](ADDF/claude-code-hooks.md) | Claude Code Hooks の全イベント・exit コードフロー制御・設定方法・ADD フレームワークでの活用パターン | Hooks, PreToolUse, PostToolUse, Stop, SessionStart, exit code, ブロッキング, マッチャー, frontmatter, settings.json |
| [ADDF/upstream-downstream-separation.md](ADDF/upstream-downstream-separation.md) | アップストリーム（ADDF）とダウンストリーム（プロジェクト）のファイル分離パターン3種 | .addf.md, ADDF/, addf-, プレフィックス, plans-add, INDEX.addf.md, ProgressTemplate, ダウンストリーム, アップストリーム |
| [ADDF/permission-settings-pattern.md](ADDF/permission-settings-pattern.md) | 権限を3パターン（アップストリーム/ダウンストリーム/汎用）× 2プロジェクト種別で分類し settings.json / settings.local.json に配置するルール | permissions, settings.json, settings.local.json, アップストリーム, ダウンストリーム, 汎用, allow, ask |
| [ADDF/pretooluse-block-with-rationale.md](ADDF/pretooluse-block-with-rationale.md) | PreToolUse フックで根拠提示型ブロックを行うパターン。/tmp/ 回避・CLAUDE_CODE_TMPDIR・cd 突き抜け防止等の横展開 | PreToolUse, block, reason, /tmp/, CLAUDE_CODE_TMPDIR, 権限要求, ガードフック, 根拠提示, cd突き抜け |
