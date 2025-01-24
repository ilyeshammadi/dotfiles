return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  -- lazy = true,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    -- auto_suggestions_provider = 'ollama',
    -- provider = 'ollama',
    -- vendors = {
    --   ollama = {
    --     __inherited_from = 'openai',
    --     api_key_name = '',
    --     endpoint = 'http://127.0.0.1:11434/v1',
    --     model = 'codegemma',
    --   },
    -- },
		provider = 'openai',
    openai = {
      model = 'gpt-4o',
    },
    hints = { enabled = false },

    behaviour = {
      auto_suggestions = false,
    },
    windows = {
      edit = {
        start_insert = true,
      },
      ask = {
        start_insert = false,
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
