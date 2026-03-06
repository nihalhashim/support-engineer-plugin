# Cursor Support Plugin

Cursor plugin that adds **support-engineer skills** for handling customer and developer support. The agent acts as a custom support engineer: understands the requirement first (empathy, critical analysis), then answers from your support doc and only parses code when needed.

## Included skills

| Skill | Use for |
|-------|--------|
| **plugin-support-agent** | WordPress plugin support. Looks for `PLUGIN-SUPPORT-DOCS.md` in the project; suggests `functions.php` snippets and minimum plugin changes when appropriate. |

*More skills (e.g. for themes, SDKs, or other product types) can be added to the `skills/` folder and will be picked up by the plugin.*

## Install (GitHub integration)

Use the **repository URL** — you do not add a specific file. Cursor uses the whole repo to load the plugin and its skills.

1. **Get the repo URL**  
   Use the public GitHub URL of this plugin, e.g.  
   `https://github.com/your-org/cursor-support-plugin`

2. **Add it as a Remote Rule in Cursor**  
   - Open **Cursor Settings** (Cmd+Shift+J on Mac, Ctrl+Shift+J on Windows/Linux).  
   - Go to **Rules**.  
   - Click **Add Rule**.  
   - Choose **Remote Rule (GitHub)**.  
   - Paste the **repository URL** (the repo root URL above), not a path to a file.  
   - Save. Cursor will load the plugin from the repo; the `plugin-support-agent` skill will then be available.

3. **Repo structure**  
   The repo root should contain `.cursor-plugin/plugin.json` and `skills/` (with `skills/plugin-support-agent/SKILL.md`). Cloning or adding the repo URL as above uses this structure so no extra steps are needed.

### Manual (copy skill into your project)

If you prefer not to use GitHub:

1. Copy the **folder** `skills/plugin-support-agent/` (including its `SKILL.md`) into your project’s `.cursor/skills/` directory.
2. The agent will discover the skill when working in that project.

### From Cursor Marketplace (optional, when published)

1. Open Cursor Settings → **Rules** or the marketplace panel.
2. Search for **Cursor Support Plugin** and install.

## Using the plugin support skill

1. In your plugin (or a workspace that contains it), add a support doc: **`PLUGIN-SUPPORT-DOCS.md`** in the project root or plugin directory. Describe features, hooks, settings, and FAQs.
2. Open the project in Cursor and ask support-style questions (e.g. “How do I hide the widget on the contact page?”, “Can I disable module X via code?”).
3. The agent will: understand your need first, then answer from the doc, and only look at code when necessary. For customisation it will prefer `functions.php` snippets over editing plugin core.

## Optional: WordPress agent skills

For better WordPress code suggestions, install [WordPress/agent-skills](https://github.com/WordPress/agent-skills) (e.g. `wp-plugin-development`) in the same environment. The plugin-support skill will use those procedures when suggesting hooks and snippets if they are available.

## Extensibility

This plugin is structured so you can add more product-type skills later:

- Add a new skill under `skills/<skill-name>/` with a `SKILL.md` (see [Cursor skills docs](https://cursor.com/docs/context/skills)).
- The manifest’s `"skills": "skills/"` will discover all such folders. No need to list each skill in `plugin.json`.

Example future skills: theme support (e.g. `THEME-SUPPORT-DOCS.md`), SDK/API support, or other product-specific support workflows.

## License

Use and adapt as needed for your support workflows.
