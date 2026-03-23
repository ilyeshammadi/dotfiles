# AGENTS.md — Dotfiles Repository Guide

This repository is a [chezmoi](https://chezmoi.io) dotfiles repo for managing personal configuration
across macOS and Linux (Arch laptop + Ubuntu devbox).

---

## Repository Structure

```
.
├── dot_config/            # Maps to ~/.config/ after chezmoi apply
│   ├── nvim/              # Neovim config (Lua, lazy.nvim)
│   │   └── lua/ilyes/
│   │       ├── core/      # options, keymaps, autocommands
│   │       ├── plugins/   # one file per plugin
│   │       └── lazy.lua   # lazy.nvim bootstrap
│   ├── private_fish/      # Fish shell config (templated)
│   ├── kitty/             # Kitty terminal (laptop only)
│   ├── sway/              # Sway WM (Linux laptop only)
│   ├── waybar/            # Waybar (Linux laptop only)
│   └── starship.toml
├── dot_gitconfig.tmpl     # Git config (templated with name/email)
├── dot_gitignore          # Global gitignore
├── dot_tmux.conf          # tmux config
├── dot_emptty             # emptty display manager config (laptop)
├── .chezmoi.toml.tmpl     # chezmoi config template
├── .chezmoiexternal.toml  # external dependencies (tpm)
├── .chezmoiignore         # conditional file exclusions per OS/machine
├── .stylua.toml           # StyLua formatter config
└── run_onchange_install-packages.sh.tmpl  # Package bootstrap script
```

---

## chezmoi Commands

```sh
# Bootstrap fresh machine
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ilyeshammadi

# Apply all dotfiles
chezmoi apply

# Dry-run (show what would change)
chezmoi apply --dry-run --verbose

# Edit a file via chezmoi (preferred)
chezmoi edit ~/.config/nvim/init.lua

# See diff between source and target
chezmoi diff

# Pull upstream changes and apply
chezmoi update

# Re-run the package install script (force)
chezmoi state delete-bucket --bucket=scriptState && chezmoi apply
```

There are **no lint, build, or test commands** in this repo — it is a dotfiles/config repo,
not a software project. Correctness is validated by `chezmoi apply --dry-run --verbose`.

---

## File Naming Conventions (chezmoi)

| Prefix / Suffix         | Meaning                                      |
|-------------------------|----------------------------------------------|
| `dot_`                  | Maps to a leading `.` in the target path     |
| `private_`              | Installs with mode `0600`                     |
| `.tmpl`                 | Processed as a Go template                   |
| `run_onchange_`         | Script runs whenever the file content changes|
| `run_once_`             | Script runs exactly once (not used here)     |

Never rename chezmoi-managed files without updating any cross-references.

---

## Template Variables (`.chezmoi.toml.tmpl`)

| Variable              | Values                          |
|-----------------------|---------------------------------|
| `.chezmoi.os`         | `"darwin"` or `"linux"`         |
| `.machineType`        | `"laptop"` or `"devbox"`        |
| `.name`               | Full name string                |
| `.email`              | Email address string            |
| `.wezterm.fontSize`   | Number (default `18`)           |

Use `{{ if eq .chezmoi.os "darwin" }}` / `{{ else if eq .chezmoi.os "linux" }}` for OS branches.
Use `{{ if eq .machineType "laptop" }}` for laptop-only config.

---

## Lua (Neovim Config) Style Guidelines

### Formatting — StyLua

Config in `.stylua.toml`:
- **Column width**: 160
- **Indent**: 2 spaces (no tabs)
- **Line endings**: Unix (`\n`)
- **Quote style**: `AutoPreferSingle` (single quotes preferred)
- **Call parentheses**: `None` (omit when unambiguous, e.g., `require 'module'`)

Format a file: `stylua dot_config/nvim/lua/ilyes/plugins/myplugin.lua`
Format all Lua: `stylua dot_config/nvim/lua/`

### Module Structure

Each plugin lives in its own file under `dot_config/nvim/lua/ilyes/plugins/`.
Every plugin file returns a lazy.nvim plugin spec table.

```lua
-- Good: single plugin spec
return {
  'author/plugin-name',
  event = 'VeryLazy',
  config = function()
    require('plugin-name').setup { ... }
  end,
}

-- Good: multiple specs in one file
return {
  { 'author/plugin-a', opts = {} },
  { 'author/plugin-b', opts = {} },
}
```

### Imports / Requires

- Use `require 'module'` (no parentheses) at the top of config blocks.
- Use `require('module').setup { ... }` for plugin setup calls.
- Local aliases: `local conform = require 'conform'`

### Naming Conventions

- Variables: `snake_case`
- Module namespaces: use `ilyes.` prefix (e.g., `require 'ilyes.core'`)
- Augroup names: `kebab-case` strings (e.g., `'ilyes-highlight-yank'`)
- Keymap descriptions: `'[A]bbreviated [W]ord'` style for which-key

### Keymaps

Define global keymaps in `dot_config/nvim/lua/ilyes/core/keymaps.lua` using the local helpers:

```lua
local nnoremap = function(from, to, opts)
  vim.keymap.set('n', from, to, opts)
end
```

Plugin-specific keymaps belong in the plugin's `keys = { ... }` spec (lazy.nvim style).

### Options

All editor options are set via `vim.opt.*`, `vim.o.*`, or `vim.g.*` in
`dot_config/nvim/lua/ilyes/core/options.lua`. Do not scatter option setting across plugin files.

---

## Shell Scripts Style Guidelines

The bootstrap script (`run_onchange_install-packages.sh.tmpl`) follows these conventions:

- Shebang: `#!/usr/bin/env bash`
- Strict mode: `set -eu` at the top of every script
- Guard installs with `if ! command -v <tool> &>/dev/null; then ... fi`
- Use `--needed --noconfirm` with pacman/yay; `-y --no-install-recommends` with apt
- Prefer `tee` + sudo over direct redirection for writing to system files
- Keep macOS and Linux sections separated by `{{ if eq .chezmoi.os "darwin" }}` blocks
- Laptop-specific blocks inside Linux: `{{ if eq .machineType "laptop" }}`

---

## Fish Shell Config Guidelines

- Config lives in `dot_config/private_fish/config.fish.tmpl`
- Use `fish_add_path` (not `set -x PATH`) for PATH modifications
- Use `set -gx` for exported environment variables
- Use `abbr --add` for shell abbreviations, `alias` only for simple command replacements
- OS-specific blocks wrapped in chezmoi templates: `{{ if eq .chezmoi.os "darwin" -}}`
- Fish plugins managed via Fisher (`fish_plugins` file lists one plugin per line)

---

## Git Commit Style

Commits in this repo follow conventional commits:

```
feat: short description
fix: short description
chore: short description
```

Examples from history: `feat: add package install script for all machine profiles`,
`fix: resolve chezmoi apply failures on Ubuntu devbox`.

Auto-commit/push is enabled in `.chezmoi.toml.tmpl` (`autoCommit = true`, `autoPush = true`).
chezmoi will commit and push automatically on `chezmoi apply` when there are source changes.

---

## Key Tool Versions & Dependencies

| Tool       | Notes                                        |
|------------|----------------------------------------------|
| chezmoi    | Dotfile manager; manages this entire repo    |
| Neovim     | Config in `dot_config/nvim/`; uses lazy.nvim |
| Fish       | Primary shell; config in `private_fish/`     |
| stylua     | Lua formatter; config in `.stylua.toml`      |
| prettier   | JS/TS/CSS/HTML/JSON/YAML formatter           |
| ruff       | Python formatter (used in conform.nvim)      |
| gofumpt    | Go formatter                                 |
| shfmt      | Shell script formatter                       |
| sqlfluff   | SQL formatter/linter                         |
| starship   | Cross-shell prompt; config in `starship.toml`|
