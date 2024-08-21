return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local lint = require 'lint'

    lint.linters.golangci_lint = {
      sourceName = 'golangci-lint',
      cmd = 'golangci-lint',
      rootPatterns = { 'go.mod' },
      debounce = 100,
      args = { 'run', '--out-format', 'json' },
      parseJson = {
        sourceName = 'Pos',
        errorsRoot = 'Issues',
        line = 'Pos.Line',
        column = 'Pos.Column',
        message = '${Text} [${FromLinter}]',
      },
    }

    lint.linters_by_ft = {
      lua = { 'luacheck' },
      python = { 'flake8' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      json = { 'jsonlint' },
      go = { 'golangci_lint' },
    }

    -- vim.cmd 'autocmd BufWritePre * lua require('
    -- lint ').try_lint()'
    -- Lint on save
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
