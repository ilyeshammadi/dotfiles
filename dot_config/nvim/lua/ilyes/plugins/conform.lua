require('conform').setup {
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
    nix = { 'nixfmt' },
  },
  -- Format everything on save except python.
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype ~= 'python' then
      return {}
    end
  end,
}
