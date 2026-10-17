vim.cmd("compiler go")
vim.bo.makeprg = "go"

vim.bo.tabstop = 8
vim.bo.shiftwidth = 8

vim.bo.errorformat = table.concat({
  "%-G# %.%#",
  "%A%f:%l:%c: %m",
  "%A%f:%l: %m",
  "%C%*\\s%m",
  "%+G--- FAIL: %.%#",
  "%-G%.%#",
}, ",")
