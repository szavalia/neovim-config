return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    require("lint").linters_by_ft = {
      lua = { "luacheck" },
      python = { "flake8" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      go = { "golangci_lint" },
      json = { "jsonlint" },
    }
    vim.cmd("autocmd BufWritePre * lua require('lint').try_lint()")
    -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    --   callback = function()
    --     require("lint").try_lint()
    --   end,
    -- })
  end,
}
