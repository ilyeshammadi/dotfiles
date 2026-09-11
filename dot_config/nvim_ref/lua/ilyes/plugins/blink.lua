--- @module 'blink.cmp'
--- @type blink.cmp.Config
require('blink.cmp').setup {
  keymap = {
    -- See `:h blink-cmp-config-keymap`. All presets provide:
    --   <tab>/<s-tab>: move to right/left of your snippet expansion
    --   <c-space>: Open menu or open docs if already open
    --   <c-n>/<c-p> or <up>/<down>: Select next/previous item
    --   <c-e>: Hide menu
    --   <c-k>: Toggle signature help
    preset = 'enter',

    -- Custom keymaps for Tab/Shift-Tab navigation
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    nerd_font_variant = 'mono',
  },

  completion = {
    -- Press `<c-space>` to show the documentation.
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  -- Lua implementation avoids the prebuilt Rust binary download, which also
  -- means blink.cmp needs no build step under vim.pack.
  fuzzy = { implementation = 'lua' },

  signature = { enabled = true },
}
