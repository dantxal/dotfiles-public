return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        python = { "pylint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "williamboman/mason.nvim",
    },
    config = function()
      local sonar_language_server_path =
        require("mason-registry").get_package("sonarlint-language-server"):get_install_path()
      local analyzers_path = sonar_language_server_path .. "/extension/analyzers"

      require("sonarlint").setup({
        server = {
          cmd = {
            sonar_language_server_path .. "/sonarlint-language-server",
            "-stdio",
            "-analyzers",
            vim.fn.expand(analyzers_path .. "/sonarjs.jar"),
            -- vim.fn.expand(analyzers_path .. "/sonarpython.jar"),
            -- vim.fn.expand(analyzers_path .. "/sonarcfamily.jar"),
            -- vim.fn.expand(analyzers_path .. "/sonarjava.jar"),
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          -- "python",
          -- "cpp",
          -- "java",
        },
      })
    end,
  },
}
