vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack_changed', { clear = true }),
  callback = function(ev)
    if ev.data.kind == 'delete' then
      return
    end
    local name = ev.data.spec.name
    if name == 'nvim-treesitter' then
      pcall(function()
        vim.cmd('TSUpdate')
      end)
    elseif name == 'mason.nvim' then
      pcall(function()
        vim.cmd('MasonUpdate')
      end)
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/oskarnurm/koda.nvim' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/xero/evangelion.nvim' },

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },

  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },

  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/b0o/schemastore.nvim' },
  { src = 'https://github.com/folke/lazydev.nvim' },

  { src = 'https://github.com/nvim-mini/mini.icons' },
  { src = 'https://github.com/nvim-mini/mini.surround' },
  { src = 'https://github.com/nvim-mini/mini.statusline' },
  { src = 'https://github.com/nvim-mini/mini.clue' },

  { src = 'https://github.com/ibhagwan/fzf-lua' },

  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/NeogitOrg/neogit' },

  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-lint' },

  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },

  { src = 'https://github.com/sschleemilch/slimline.nvim' },
}, { load = true, confirm = false })

require('plugins.mini')
require('plugins.treesitter')
require('plugins.completion')
require('plugins.lsp')
require('plugins.slimline')
require('plugins.picker')
require('plugins.gitsigns')
require('plugins.neogit')
require('plugins.formatter')
require('plugins.linter')
require('plugins.nvim-tree')
