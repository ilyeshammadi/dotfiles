vim.cmd 'compiler go'
vim.bo.makeprg = 'go'

vim.bo.errorformat = 'vet: %f:%l:%c: %m,vet: %f:%l: %m,' .. vim.bo.errorformat

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
