return {
  'klen/nvim-test',
  config = function()
    local nvim_test = require 'nvim-test'
    nvim_test.setup()

    --     The plugin defines the commands:
    --
    -- TestSuite - run the whole test suite
    -- TestFile - run all tests for the current file
    -- TestEdit - edit tests for the current file
    -- TestNearest - run the test nearest to the cursor
    -- TestLast - rerun the latest test
    -- TestVisit - open the last run test in the current buffer
    -- TestInfo - show an information about the plugin

    -- Run the whole test suite
    vim.keymap.set('n', '<leader>ts', function()
      vim.cmd 'TestSuite'
    end, { desc = 'Run the whole test suite' })

    -- Run all tests for the current file
    vim.keymap.set('n', '<leader>tf', function()
      vim.cmd 'TestFile'
    end, { desc = 'Run all tests for the current file' })

    -- Edit tests for the current file
    vim.keymap.set('n', '<leader>te', function()
      vim.cmd 'TestEdit'
    end, { desc = 'Edit tests for the current file' })

    -- Run the test nearest to the cursor
    vim.keymap.set('n', '<leader>tn', function()
      vim.cmd 'TestNearest'
    end, { desc = 'Run the test nearest to the cursor' })

    -- Rerun the latest test
    vim.keymap.set('n', '<leader>tl', function()
      vim.cmd 'TestLast'
    end, { desc = 'Rerun the latest test' })

    -- Open the last run test in the current buffer
    vim.keymap.set('n', '<leader>tv', function()
      vim.cmd 'TestVisit'
    end, { desc = 'Open the last run test in the current buffer' })
  end,
}
