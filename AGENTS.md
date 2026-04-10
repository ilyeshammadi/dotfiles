# AGENTS.md — Dotfiles Repository Guide

This repository manages personal configurations using `chezmoi`.

## Repository Structure Overview
See the directory structure for mapping to the home directory.

## Technical Conventions & Commands

### Neovim (nvim)
- **Formatting**: Use `conform.nvim` (automatic on save/buffer load).
- **Running Tests**: Use `:lua require('neotest').run.run()` (mapped to `tt`).
- **Navigation/Diagnostics**: `gd` (definition), `gr` (references), `gl` (line diagnostics), `K` (hover).

### Shell (Fish)
- Primary shell: Fish. Use `fish_add_path` for PATH modifications.
- Formatting: `stylua dot_config/nvim/lua/`.

### Toolchain & Workflow
- **Linting/Checking**: Use `conform.nvim` to orchestrate formatters (`prettier`, `stylua`, `ruff`, etc.).
- **Code Integrity**: Always validate changes using `chezmoi apply --dry-run --verbose` before committing/applying.
- **Git**: Follow [conventional commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `chore:`).
- **Autosync**: `chezmoi apply` automatically manages and commits local changes.

## Key Quirks
- **Dotfiles**: Config uses Go templates for OS (`darwin`/`linux`) and machine (`laptop`/`devbox`) branching.
- **Templates**: Files with `.tmpl` suffix are processed by `chezmoi` templates.

