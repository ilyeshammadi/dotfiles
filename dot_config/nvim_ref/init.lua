vim.loader.enable()

require 'ilyes.core.options'
require 'ilyes.core.autocommands'
require 'ilyes.pack'

-- After plugins, so these win over plugin maps.
require 'ilyes.core.keymaps'
