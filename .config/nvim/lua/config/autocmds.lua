local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd({ 'FocusGained', 'BufEnter' }, {
  group = augroup('auto_reload', { clear = true }),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd.checktime()
    end
  end,
})

autocmd('TextYankPost', {
  group = augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = 'Search' })
  end,
})

local exclude_ft = { gitcommit = true, gitrebase = true, help = true }
autocmd('BufReadPost', {
  group = augroup('restore_cursor', { clear = true }),
  callback = function(event)
    if exclude_ft[vim.bo[event.buf].filetype] then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd('FileType', {
  group = augroup('close_with_q', { clear = true }),
  pattern = {
    'checkhealth',
    'git',
    'gitsigns-blame',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'startuptime',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', function()
      local ok = pcall(vim.cmd.bdelete, { bang = true })
      if not ok then
        vim.cmd.quit()
      end
    end, { buffer = event.buf, silent = true, desc = 'Close buffer' })
  end,
})

vim.api.nvim_create_user_command('TrimWhitespace', function()
  local save_cursor = vim.fn.getpos('.')
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos('.', save_cursor)
end, { desc = 'trim trailing whitespace' })

local dominated_filetypes = { help = true, mason = true, NvimTree = true }
autocmd('BufWinEnter', {
  group = augroup('statuscolumn_exclusions', { clear = true }),
  callback = function(event)
    if dominated_filetypes[vim.bo[event.buf].filetype] then
      vim.wo.statuscolumn = ''
      vim.wo.signcolumn = 'no'
    end
  end,
})

autocmd('OptionSet', {
  group = augroup('statuscolumn_exclusions', { clear = false }),
  pattern = 'buftype',
  callback = function()
    local buftype = vim.v.option_new
    if buftype == 'nofile' or buftype == 'terminal' then
      vim.wo.statuscolumn = ''
      vim.wo.signcolumn = 'no'
    end
  end,
})

autocmd('TermOpen', {
  group = augroup('terminal_list', { clear = true }),
  callback = function()
    vim.wo.list = false
  end,
})

vim.lsp.document_color.enable(true, nil, { style = 'virtual' })

autocmd('LspProgress', {
  group = augroup('lsp_progress', { clear = true }),
  desc = 'Display LSP progress in echo area',
  callback = function(ev)
    local value = ev.data.params.value
    local msg = value.message or (value.kind == 'end' and 'done' or '')
    vim.api.nvim_echo({ { msg } }, false, {
      id = 'lsp.' .. ev.data.client_id .. '.' .. ev.data.params.token,
      kind = 'progress',
      source = 'vim.lsp',
      title = value.title,
      status = value.kind ~= 'end' and 'running' or 'success',
      percent = value.percentage,
    })
  end,
})
