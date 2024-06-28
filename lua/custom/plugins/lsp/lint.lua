return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      lua = { 'luacheck' },
      python = { 'flake8' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      go = { 'golangci_lint' },
      json = { 'jsonlint' },
    }
    -- vim.cmd 'autocmd BufWritePre * lua require('
    -- lint ').try_lint()'
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}
