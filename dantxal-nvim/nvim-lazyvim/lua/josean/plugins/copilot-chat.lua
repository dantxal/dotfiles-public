return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = function(_, opts)
      local CopilotChat = require("CopilotChat")

      -- copy defaults so we don’t mutate the global config directly
      local commands = vim.deepcopy(CopilotChat.config.defaults.commands)

      -- remove "clear" command, because it's annoying, history vanishes
      commands.clear = nil

      opts.commands = commands

      return opts
    end,
  },
}
