-- `main` branch: parsers installed explicitly, highlighting started per
-- filetype. `:TSUpdate` is handled by the PackChanged hook in ilyes.pack.
local filetypes = {
	 'bash',
	 'c',
	 'diff',
	 'html',
	 'lua',
	 'luadoc',
	 'markdown',
	 'markdown_inline',
	 'query',
	 'vim',
	 'vimdoc',
	 'go',
	 'python',
	 'dockerfile',
	 'fish',
	 'yaml',
	 'helm',
	 'javascript',
	 'typescript',
	 'tsx',
 }

require('nvim-treesitter').install(filetypes)

require('treesitter-context').setup {
	 enable = true,
	 max_lines = 2,
	 multiline_threshold = 1,
	 trim_scope = 'inner',
 }

vim.api.nvim_create_autocmd('FileType', {
	 pattern = vim.list_extend(vim.deepcopy(filetypes), { 'javascriptreact', 'typescriptreact' }),
	 callback = function()
		 vim.treesitter.start()
	 end,
 })
