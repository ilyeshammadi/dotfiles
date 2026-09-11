--- @module 'blink.cmp'
--- @type blink.cmp.Config
require('blink.cmp').setup {
  keymap = {
    -- `:h blink-cmp-config-keymap` for what the preset binds.
    preset = 'enter',

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

  -- Avoids the prebuilt Rust binary download, so no build step under vim.pack.
  fuzzy = { implementation = 'lua' },

  signature = { enabled = true },
}
