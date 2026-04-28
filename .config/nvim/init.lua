vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('config.options')
require('config.ftplugin')
require('config.pack')
--
-- require("catppuccin").setup({
--   transparent_background=true
-- })

vim.cmd.colorscheme('evangelion')


require('config.terminal')
require('config.keymaps')
require('config.autocmds')
