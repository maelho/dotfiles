local icons = require('mini.icons')
icons.setup()
icons.mock_nvim_web_devicons()

require('mini.surround').setup({
  mappings = {
    highlight = 'sH',
  },
})

local clue = require('mini.clue')
local clue_options = {
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
  },
  clues = {
    { mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
    { mode = { 'n', 'x' }, keys = '<Leader>c', desc = '+Code' },
    { mode = 'n', keys = '<Leader>e', desc = '+Explorer' },
    { mode = { 'n', 'x' }, keys = '<Leader>f', desc = '+Find' },
    { mode = { 'n', 'x' }, keys = '<Leader>g', desc = '+Git' },
    { mode = { 'n', 'x' }, keys = '<Leader>h', desc = '+Hunks' },
    { mode = 'n', keys = '<Leader>l', desc = '+Plugins' },
    { mode = 'n', keys = '<Leader>m', desc = '+Mason' },
    { mode = 'n', keys = '<Leader>s', desc = '+Search' },
    { mode = 'n', keys = '<Leader>t', desc = '+Tools' },
    { mode = 'n', keys = '<Leader>u', desc = '+Undo' },
    { mode = 'n', keys = '<Leader>w', desc = '+Windows' },
    { mode = 'n', keys = '<Leader>x', desc = '+Quickfix' },
    clue.gen_clues.square_brackets(),
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
  },
  window = {
    delay = 300,
    config = { border = 'single' },
  },
}
clue.setup(clue_options)

-- local constants = require('config.constants')
-- local statusline = require('mini.statusline')
-- statusline.setup({
--   use_icons = true,
--   content = {
--     active = function()
--       local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
--       local git = statusline.section_git({ trunc_width = 40 })
--       local diff = statusline.section_diff({ trunc_width = 75 })
--       local diagnostics = statusline.section_diagnostics({
--         trunc_width = 75,
--         signs = {
--           ERROR = constants.diagnostic_symbols.error,
--           WARN = constants.diagnostic_symbols.warn,
--           INFO = constants.diagnostic_symbols.info,
--           HINT = constants.diagnostic_symbols.hint,
--         },
--       })
--       local lsp = statusline.section_lsp({ trunc_width = 75 })
--       local filename = statusline.section_filename({ trunc_width = 140 })
--       local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
--       local search = statusline.section_searchcount({ trunc_width = 75 })
--
--       local location = (function()
--         if statusline.is_truncated(75) then
--           return '%l│%2v'
--         end
--         return '%P %l│%2v'
--       end)()
--
--       return statusline.combine_groups({
--         { hl = mode_hl, strings = { mode } },
--         { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
--         '%<',
--         { hl = 'MiniStatuslineFilename', strings = { filename } },
--         '%=',
--         { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
--         { hl = mode_hl, strings = { search, location } },
--       })
--     end,
--   },
-- })
