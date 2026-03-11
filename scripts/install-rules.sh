#!/usr/bin/env bash
# Install Support Engineer Plugin rules into the current project's .cursor/rules/
# Run from your project root: ./path/to/install-rules.sh
# Or from this repo: ./scripts/install-rules.sh (when run from a project that contains or is the plugin)

set -e

RULES_DIR=".cursor/rules"
RULE_FILE="support-engineer.mdc"

# Default: use raw GitHub URL (works from any project)
REPO="${SUPPORT_PLUGIN_REPO:-https://github.com/nihalhashim/support-engineer-plugin}"
BRANCH="${SUPPORT_PLUGIN_BRANCH:-main}"
RAW_URL="${REPO/https:\/\/github.com/https://raw.githubusercontent.com/}/$BRANCH/rules/$RULE_FILE"

# If we're inside the plugin repo, copy locally
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_RULES="$SCRIPT_DIR/../rules/$RULE_FILE"
if [ -f "$PLUGIN_RULES" ]; then
  mkdir -p "$RULES_DIR"
  cp "$PLUGIN_RULES" "$RULES_DIR/$RULE_FILE"
  echo "Installed rule from plugin repo: $RULES_DIR/$RULE_FILE"
  exit 0
fi

# Otherwise download from GitHub
mkdir -p "$RULES_DIR"
if command -v curl >/dev/null 2>&1; then
  curl -sSL -o "$RULES_DIR/$RULE_FILE" "$RAW_URL"
elif command -v wget >/dev/null 2>&1; then
  wget -q -O "$RULES_DIR/$RULE_FILE" "$RAW_URL"
else
  echo "Need curl or wget to download the rule." >&2
  exit 1
fi

echo "Installed rule: $RULES_DIR/$RULE_FILE"
