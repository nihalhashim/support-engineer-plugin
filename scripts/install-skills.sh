#!/usr/bin/env bash
# Install Support Engineer Plugin skills into the current project's .cursor/skills/
# Run from your project root: ./path/to/install-skills.sh
# Or from this repo: ./scripts/install-skills.sh (when run from a project that contains or is the plugin)

set -e

SKILLS_BASE=".cursor/skills"
# Skill folder names under skills/ in the plugin repo (each must contain SKILL.md)
SKILL_NAMES=(plugin-support-agent)

# Default: use raw GitHub URL (works from any project)
REPO="${SUPPORT_PLUGIN_REPO:-https://github.com/nihalhashim/support-engineer-plugin}"
BRANCH="${SUPPORT_PLUGIN_BRANCH:-main}"
GITHUB_HOST="https://github.com"
RAW_HOST="https://raw.githubusercontent.com"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_SKILLS="$SCRIPT_DIR/../skills"

install_one_skill() {
  local name="$1"
  local dest_dir="$SKILLS_BASE/$name"
  local skill_file="SKILL.md"

  if [ -d "$PLUGIN_SKILLS/$name" ] && [ -f "$PLUGIN_SKILLS/$name/$skill_file" ]; then
    mkdir -p "$dest_dir"
    cp "$PLUGIN_SKILLS/$name/$skill_file" "$dest_dir/$skill_file"
    echo "Installed skill from plugin repo: $dest_dir/$skill_file"
    return 0
  fi

  # Download from GitHub
  mkdir -p "$dest_dir"
  raw_url="${REPO/$GITHUB_HOST/$RAW_HOST}/$BRANCH/skills/$name/$skill_file"
  if command -v curl >/dev/null 2>&1; then
    curl -sSL -o "$dest_dir/$skill_file" "$raw_url"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$dest_dir/$skill_file" "$raw_url"
  else
    echo "Need curl or wget to download the skill." >&2
    return 1
  fi
  echo "Installed skill: $dest_dir/$skill_file"
}

# If we're inside the plugin repo, try local copy first for all skills
in_plugin_repo=true
for name in "${SKILL_NAMES[@]}"; do
  if [ ! -f "$PLUGIN_SKILLS/$name/SKILL.md" ]; then
    in_plugin_repo=false
    break
  fi
done

if [ "$in_plugin_repo" = true ]; then
  for name in "${SKILL_NAMES[@]}"; do
    install_one_skill "$name"
  done
  exit 0
fi

# Otherwise download each skill from GitHub
for name in "${SKILL_NAMES[@]}"; do
  install_one_skill "$name"
done
