return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()
      require('dap-go').setup()
      require('nvim-dap-virtual-text').setup()

      -- Handled by nvim-dap-go
      dap.adapters.go = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'dlv',
          args = { 'dap', '-l', '127.0.0.1:${port}' },
        },
      }

      vim.keymap.set('n', '<space>dB', dap.toggle_breakpoint, { desc = 'Add breakpoint' })
      vim.keymap.set('n', '<space>dc', dap.run_to_cursor, { desc = 'Run to cursor' })

      -- Eval var under cursor
      vim.keymap.set('n', '<space>d?', function()
        require('dapui').eval(nil, { enter = true })
      end, { desc = 'Eval var under cursor' })

      vim.keymap.set('n', '<space>dc', dap.continue, { desc = 'Continue' })
      vim.keymap.set('n', '<space>di', dap.step_into, { desc = 'Step into' })
      vim.keymap.set('n', '<space>do', dap.step_over, { desc = 'Step over' })
      vim.keymap.set('n', '<space>du', dap.step_out, { desc = 'Step out' })
      vim.keymap.set('n', '<space>db', dap.step_back, { desc = 'Step back' })
      vim.keymap.set('n', '<space>dr', dap.restart, { desc = 'Restart' })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
