#!/bin/bash
# reset-turn-count.sh
# SessionStart フックで発火。ターンカウンターをリセットする。

COUNTER_FILE="$CLAUDE_PROJECT_DIR/.claude/.turn-count"
echo "0" > "$COUNTER_FILE"
exit 0
