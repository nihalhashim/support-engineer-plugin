# Support Engineer Plugin

A **tool-agnostic** plugin for **plugin and product maintainers** who want AI-assisted customer and developer support. It adds **support-engineer skills** so the agent behaves like a custom support engineer: it understands the user's requirement first (empathy, critical analysis), then answers from your project's support doc and only parses code when the doc is insufficient.

**Currently:** Install and use in **Cursor**. Support for other AI coding tools (e.g. Claude Code, Windsurf) may be added in future.

**Purpose:** Reduce support load by having the AI answer from a single source of truth (`PLUGIN-SUPPORT-DOCS.md`) and suggest `functions.php` snippets or minimal plugin changes instead of editing core files.

## Included skills

| Skill | Purpose and behaviour |
|-------|------------------------|
| **plugin-support-agent** | WordPress plugin support. Runs a support-engineer workflow: (1) understand the requirement with empathy and critical analysis, (2) answer from `PLUGIN-SUPPORT-DOCS.md` when present, (3) parse plugin code only when the doc is insufficient, (4) suggest `functions.php` snippets or minimum plugin changes instead of editing core. Optional version check when the doc lives at workspace root. |

*More skills (e.g. for themes, SDKs, or other product types) can be added to the `skills/` folder and will be picked up by the plugin.*

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
   The repo root should contain `.cursor-plugin/plugin.json` and `skills/` (with `skills/plugin-support-agent/SKILL.md`). Cloning or adding the repo URL as above uses this structure so no extra steps are needed.

### Manual (copy skill into your project)

If you prefer not to use GitHub:

1. Copy the **folder** `skills/plugin-support-agent/` (including its `SKILL.md`) into your project’s skills directory (e.g. `.cursor/skills/` in Cursor).
2. The agent will discover the skill when working in that project.

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
