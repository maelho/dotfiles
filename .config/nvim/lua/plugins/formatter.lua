local map = vim.keymap.set

require('conform').setup({
  formatters_by_ft = {
    astro = { 'prettier' },
    bash = { 'shfmt' },
    css = { 'prettier' },
    fish = { 'fish_indent' },
    go = { 'goimports', 'gofumpt' },
    html = { 'prettier' },
    javascript = { 'oxfmt', 'prettier', stop_after_first = true },
    javascriptreact = { 'oxfmt', 'prettier', stop_after_first = true },
    json = { 'prettier' },
    jsonc = { 'prettier' },
    less = { 'prettier' },
    lua = { 'stylua' },
    markdown = { 'prettier' },
    python = { 'ruff_format' },
    scss = { 'prettier' },
    sh = { 'shfmt' },
    sql = { 'sql_formatter' },
    svelte = { 'prettier' },
    toml = { 'taplo' },
    typescript = { 'oxfmt', 'prettier', stop_after_first = true },
    typescriptreact = { 'oxfmt', 'prettier', stop_after_first = true },
    yaml = { 'prettier' },
  },
  formatters = {
    shfmt = {
      prepend_args = { '-i', '2', '-ci' },
    },
  },
})

map('n', '<leader>cf', function()
  require('conform').format({ async = true, lsp_format = 'fallback' }, function(err)
    if not err then
      vim.notify('File formatted', vim.log.levels.INFO)
    else
      vim.notify('No formatter available for this filetype', vim.log.levels.WARN)
    end
  end)
end, { desc = 'format buffer' })
