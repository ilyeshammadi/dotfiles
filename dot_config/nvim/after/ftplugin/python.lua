-- Diagnostic config is per-namespace, so wait for the client to get its namespace.
vim.api.nvim_create_autocmd('LspAttach', {
  buffer = 0,
  callback = function(event)
    vim.diagnostic.config({ virtual_text = false }, vim.lsp.diagnostic.get_namespace(event.data.client_id))
  end,
})
