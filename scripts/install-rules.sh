#!/usr/bin/env bash
# Install Support Engineer Plugin rules into the current project's .cursor/rules/
#
# One-liner (no clone) — run from your project root:
#   mkdir -p .cursor/rules && curl -sSL -o .cursor/rules/support-engineer.mdc https://raw.githubusercontent.com/nihalhashim/support-engineer-plugin/main/rules/support-engineer.mdc
#
# Or run this script: ./path/to/install-rules.sh

set -e

RULES_DIR=".cursor/rules"
RULE_FILE="support-engineer.mdc"

# Primary: download from raw URL (no clone required)
REPO="${SUPPORT_PLUGIN_REPO:-https://github.com/nihalhashim/support-engineer-plugin}"
BRANCH="${SUPPORT_PLUGIN_BRANCH:-main}"
GITHUB_HOST="https://github.com"
RAW_HOST="https://raw.githubusercontent.com"
RAW_URL="${REPO/$GITHUB_HOST/$RAW_HOST}/$BRANCH/rules/$RULE_FILE"

mkdir -p "$RULES_DIR"
if command -v curl >/dev/null 2>&1; then
  if curl -sSL -o "$RULES_DIR/$RULE_FILE" "$RAW_URL"; then
    echo "Installed rule: $RULES_DIR/$RULE_FILE"
    exit 0
  fi
elif command -v wget >/dev/null 2>&1; then
  if wget -q -O "$RULES_DIR/$RULE_FILE" "$RAW_URL"; then
    echo "Installed rule: $RULES_DIR/$RULE_FILE"
    exit 0
  fi
fi

# Fallback: if we're inside the plugin repo, copy locally (no network needed)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_RULES="$SCRIPT_DIR/../rules/$RULE_FILE"
if [ -f "$PLUGIN_RULES" ]; then
  cp "$PLUGIN_RULES" "$RULES_DIR/$RULE_FILE"
  echo "Installed rule from plugin repo: $RULES_DIR/$RULE_FILE"
  exit 0
fi

# No curl/wget or download failed and not in plugin repo
if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
  echo "Need curl or wget to download the rule." >&2
fi
exit 1
