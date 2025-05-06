return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        markdown = {},
        graphql = { 'prettier' },
        lua = { 'stylua' },
        python = { 'ruff' },
        sql = { 'sqlfluff' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        bash = { 'shfmt' },
        go = { 'gofumpt' },
        htmldjango = { 'djlint' },
      },
    }
  end,
}
