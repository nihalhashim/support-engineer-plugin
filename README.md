# Support Engineer Plugin

A **tool-agnostic** plugin for **plugin and product maintainers** who want AI-assisted customer and developer support. It adds **support-engineer skills** so the agent behaves as a support engineer: it understands the user's requirement first (empathy, critical analysis), then answers from your project's support doc and only parses code when the doc is insufficient.

**Currently:** Install and use in **Cursor**. Support for other AI coding tools (e.g. Claude Code, Windsurf) may be added in future.

**Purpose:** Reduce support load by having the AI answer from a single source of truth (`PLUGIN-SUPPORT-DOCS.md`) and suggest `functions.php` snippets or minimal plugin changes instead of editing core files.

## What the plugin adds

| Type | Name | Purpose |
|------|------|---------|
| **Rule** | support-engineer | **Full workflow** in one rule (`alwaysApply: true`): understand requirement first, answer from `PLUGIN-SUPPORT-DOCS.md`, parse code only when needed, suggest `functions.php` or minimal plugin changes. Primary instruction for maximum compliance. |
| **Skill** | plugin-support-agent | Same workflow in skill form (for reference or when the rule is not loaded). |

*More skills (e.g. for themes, SDKs) can be added under `skills/` and will be picked up automatically.*

### Set project rules using the plugin (recommended for maximum compliance)

To have the support-engineer instructions **always** applied as **project-local** rules (in `.cursor/rules/`), use either method below. The rule has `alwaysApply: true`, so Cursor will include it in context on every request.

**Option A — One-liner (recommended; no clone):**

No need to clone or download the repo. From your **project root**, run:

```bash
mkdir -p .cursor/rules && curl -sSL -o .cursor/rules/support-engineer.mdc https://raw.githubusercontent.com/nihalhashim/support-engineer-plugin/main/rules/support-engineer.mdc
```

(Use your fork's URL and branch if different.)

**Option B — Install script (when you have the repo):**

If you already have this repo (e.g. as a submodule or in a subfolder), from your **project root** run:

```bash
/path/to/support-engineer-plugin/scripts/install-rules.sh
```

Or from inside the plugin folder: `./cursor-support-plugin/scripts/install-rules.sh`. The script creates `.cursor/rules/` if needed and copies or downloads the rule.

**Manual copy:** You can still [download the rule file](https://raw.githubusercontent.com/nihalhashim/support-engineer-plugin/main/rules/support-engineer.mdc) and save it as `.cursor/rules/support-engineer.mdc`.

### Set project skills (install the plugin-support-agent skill)

To add the **plugin-support-agent** skill to your project’s `.cursor/skills/` so the agent can use it, run one of the following.

**Option A — Install script (from this repo):**

From your **project root**, run:

```bash
/path/to/support-engineer-plugin/scripts/install-skills.sh
```

Or, if your project has the plugin as a submodule or in a subfolder:

```bash
./cursor-support-plugin/scripts/install-skills.sh
```

The script creates `.cursor/skills/plugin-support-agent/` and copies `SKILL.md` into it.

**Option B — One-liner (no clone):**

From your project root, run:

```bash
mkdir -p .cursor/skills/plugin-support-agent && curl -sSL -o .cursor/skills/plugin-support-agent/SKILL.md https://raw.githubusercontent.com/nihalhashim/support-engineer-plugin/main/skills/plugin-support-agent/SKILL.md
```

(Use your fork’s URL and branch if different.)

## Install (GitHub integration)

Use the **repository URL** — you do not add a specific file. Your IDE/tool uses the whole repo to load the plugin and its skills.

1. **Get the repo URL**  
   Use the public GitHub URL of this plugin, e.g.  
   `https://github.com/your-org/support-engineer-plugin`

2. **Add it as a Remote Rule (in Cursor)**  
   - Open **Cursor Settings** (Cmd+Shift+J on Mac, Ctrl+Shift+J on Windows/Linux).  
   - Go to **Rules**.  
   - Click **Add Rule**.  
   - Choose **Remote Rule (GitHub)**.  
   - Paste the **repository URL** (the repo root URL above), not a path to a file.  
   - Save. The plugin and `plugin-support-agent` skill will then be available.

3. **Repo structure**  
   The repo root contains `.cursor-plugin/plugin.json`, `skills/` (plugin-support-agent), and `rules/` (support-engineer). Adding the repo URL as above loads the plugin, skill, and rule; no extra steps are needed.

### If the agent says it has no rules or doesn't follow the plugin

The agent may look for **project-local** rules (e.g. `.cursor/rules/` in the project) and report "no custom rules" even when the plugin is installed. The plugin provides both a **skill** (plugin-support-agent) and a **rule** (support-engineer) that should appear in Cursor’s Rules list after you add the repo.

- **Invoke the skill explicitly** — In Cursor chat, try typing **`/plugin-support-agent`** (if your client supports slash commands) or start your message with “Using the plugin support workflow: …” so the agent applies the skill.
- **Add the rule to this project** — Run the install script or one-liner from **Set project rules using the plugin** above to add the support-engineer rule to `.cursor/rules/`.
- **Or add the skill for per-project behavior** — See **Manual (copy skill into your project)** below.
- **Confirm the plugin is loaded** — In Cursor Settings → Rules, check that the remote rule (this repo) is listed and enabled.

### Manual (copy skill into your project)

If you prefer not to use GitHub or the install script:

1. Copy the **folder** `skills/plugin-support-agent/` (including its `SKILL.md`) into your project’s skills directory (e.g. `.cursor/skills/` in Cursor).
2. Or run the **install-skills** script or one-liner from **Set project skills** above.
3. The agent will discover the skill when working in that project.

### From marketplace (optional, when published)

In Cursor: Settings → **Rules** or the marketplace panel → search for **Support Engineer Plugin** and install.

## Using the plugin support skill

1. In your plugin (or a workspace that contains it), add a support doc: **`PLUGIN-SUPPORT-DOCS.md`** in the project root or plugin directory. Describe features, hooks, settings, and FAQs.
2. Open the project in your IDE and ask support-style questions (e.g. “How do I hide the widget on the contact page?”, “Can I disable module X via code?”).
3. The agent will: understand your need first, then answer from the doc, and only look at code when necessary. For customisation it will prefer `functions.php` snippets over editing plugin core.

## Optional: WordPress agent skills

For better WordPress code suggestions, install [WordPress/agent-skills](https://github.com/WordPress/agent-skills) (e.g. `wp-plugin-development`) in the same environment. The plugin-support skill will use those procedures when suggesting hooks and snippets if they are available.

## Extensibility

This plugin is structured so you can add more product-type skills later:

- Add a new skill under `skills/<skill-name>/` with a `SKILL.md` (see [Agent Skills format](https://cursor.com/docs/context/skills) — used by Cursor and other tools).
- The manifest’s `"skills": "skills/"` will discover all such folders. No need to list each skill in `plugin.json`.

Example future skills: theme support (e.g. `THEME-SUPPORT-DOCS.md`), SDK/API support, or other product-specific support workflows.

## License

Use and adapt as needed for your support workflows.
