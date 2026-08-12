{
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = { accept = "<Tab>", next = "<C-]>", prev = "<C-[>" },
      },
      panel = { enabled = false }, -- disable the extra panel UI since you just want inline
    })
  end,
}
