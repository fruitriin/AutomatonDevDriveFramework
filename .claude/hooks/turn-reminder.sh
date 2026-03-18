#!/bin/bash
# turn-reminder.sh
# UserPromptSubmit フックで発火。ターン数をカウントし、
# 10/15ターン経過時にノウハウ抽出のリマインダーを Claude のコンテキストに注入する。

COUNTER_FILE="$CLAUDE_PROJECT_DIR/.claude/.turn-count"

# カウンター読み込み・インクリメント
COUNT=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
COUNT=$((COUNT + 1))
echo "$COUNT" > "$COUNTER_FILE"

if [ "$COUNT" -eq 10 ]; then
  cat <<'EOF'
<user-prompt-submit-hook>
10ターン経過しました。コンテキストが大きくなっています。
重要な知見があれば /addf-knowhow で記録することを検討してください。
</user-prompt-submit-hook>
EOF
elif [ "$COUNT" -eq 15 ]; then
  cat <<'EOF'
<user-prompt-submit-hook>
15ターン経過しました。コンパクション前にノウハウ抽出を推奨します。
/addf-knowhow で知見を記録し、不要なコンテキストの整理を検討してください。
</user-prompt-submit-hook>
EOF
fi

exit 0
