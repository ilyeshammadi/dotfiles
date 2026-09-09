# nvim_pack

`../nvim` ported from lazy.nvim to Neovim 0.12's built-in `vim.pack`.
Chezmoi puts it at `~/.config/nvim_pack`, so it runs alongside the current config:

```fish
NVIM_APPNAME=nvim_pack nvim
```

`lua/ilyes/pack.lua` holds the build hooks, the plugin list, and the setup order.
`lua/ilyes/plugins/*.lua` are plain setup modules. `lua/ilyes/core/*` is unchanged
except `core/init.lua`. Commit `nvim-pack-lock.json`, never hand-edit it.

## Behaviour changes vs. the lazy config

1. **which-key options now apply.** lazy skips `setup(opts)` when a `config`
   function is given, and the old one never called it — so `preset = 'modern'`,
   the 500ms delay, the border and `icons.mappings = false` were dead. The popup
   will look different; delete the `wk.setup` call to revert.
2. **`terraform-ls` → `terraformls`.** The hyphenated name matched no lspconfig
   entry, so that server never started. (The mason package name was correct.)
3. **Keymaps load after plugins**, so personal maps win.
4. **No `VeryLazy`.** The snacks debug globals that hung off it now run inline.

Gone: `checker` update notifications, `change_detection`, the `:Lazy` UI.
