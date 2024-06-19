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

      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { os.getenv 'HOME' .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
      }

      dap.adapters['node-terminal'] = {
        type = 'executable',
        command = 'node',
        args = { os.getenv 'HOME' .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
      }

      dap.configurations.javascript = {
        {
          name = 'Launch file',
          type = 'node2', -- Use node2 adapter
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
        {
          name = 'Attach to process',
          type = 'node2',
          request = 'attach',
          processId = require('dap.utils').pick_process,
        },
      }

      dap.configurations.typescript = {
        {
          name = 'Launch file',
          type = 'node2', -- Use node2 adapter
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
          outFiles = { '${workspaceFolder}/dist/**/*.js' }, -- Adjust if needed
        },
        {
          name = 'Attach to process',
          type = 'node2',
          request = 'attach',
          processId = require('dap.utils').pick_process,
        },
      }

      vim.keymap.set('n', '<space>db', dap.toggle_breakpoint, { desc = 'Add breakpoint' })
      vim.keymap.set('n', '<space>dc', dap.run_to_cursor, { desc = 'Run to cursor' })

      -- Eval var under cursor
      vim.keymap.set('n', '<space>d?', function()
        require('dapui').eval(nil, { enter = true })
      end, { desc = 'Eval var under cursor' })

      vim.keymap.set('n', '<space>dc', dap.continue, { desc = 'Continue' })
      vim.keymap.set('n', '<space>di', dap.step_into, { desc = 'Step into' })
      vim.keymap.set('n', '<space>do', dap.step_over, { desc = 'Step over' })
      vim.keymap.set('n', '<space>du', dap.step_out, { desc = 'Step out' })
      -- vim.keymap.set('n', '<space>db', dap.step_back, { desc = 'Step back' })
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
