#!/bin/bash
# スキル使用計測フック
# PreToolUse の Skill マッチャーで発火し、使用をログする

LOG_DIR="${CLAUDE_PROJECT_DIR}/.claude/logs"
LOG_FILE="${LOG_DIR}/skill-usage.jsonl"

# ログディレクトリを作成
mkdir -p "$LOG_DIR"

# stdin から tool_input を読み、スキル名を抽出
INPUT=$(cat)
SKILL_NAME=$(echo "$INPUT" | jq -r '.tool_input.skill // "unknown"' 2>/dev/null || echo "unknown")

# セッション ID（プロセスツリーから推定）
SESSION_ID="${CLAUDE_SESSION_ID:-$(date +%Y%m%d-%H%M%S)}"

# JSONL 形式でログ
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "{\"timestamp\":\"${TIMESTAMP}\",\"skill\":\"${SKILL_NAME}\",\"session_id\":\"${SESSION_ID}\"}" >> "$LOG_FILE"
