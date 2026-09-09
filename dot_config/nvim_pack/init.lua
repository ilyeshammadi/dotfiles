-- Speeds up `require` by caching compiled Lua. Must be the first line.
vim.loader.enable()

require 'ilyes.core'
require 'ilyes.pack'

-- Loaded after plugins so personal maps win over any a plugin installs.
require 'ilyes.core.keymaps'
