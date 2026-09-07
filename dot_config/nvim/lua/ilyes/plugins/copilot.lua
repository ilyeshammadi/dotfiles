return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
				enabled = false,
        auto_trigger = true,
        keymap = { accept = "<Right>", next = "<C-j>", prev = "<C-k>" },
      },
      panel = { enabled = false }, -- disable the extra panel UI since you just want inline
    })
  end
}
