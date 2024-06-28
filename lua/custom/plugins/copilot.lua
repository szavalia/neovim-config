return {
  'github/copilot.vim',
  config = function()
    -- Disable copilot for now
    vim.g.copilot_enabled = 0

    -- Set a keymap to enable and disable copilot
    vim.api.nvim_set_keymap('i', '<C-e>', '<cmd>Copilot enable<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('i', '<C-d>', '<cmd>Copilot disable<CR>', { noremap = true, silent = true })
  end,
}
