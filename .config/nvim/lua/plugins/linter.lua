local lint = require('lint')

lint.linters_by_ft = {
  bash = { 'shellcheck' },
  javascript = { 'oxlint' },
  javascriptreact = { 'oxlint' },
  lua = { 'selene' },
  markdown = { 'markdownlint' },
  typescript = { 'oxlint' },
  typescriptreact = { 'oxlint' },
  yaml = { 'yamllint' },
}

lint.linters.markdownlint.args = {
  '--disable',
  'MD013',
  '--',
}

lint.linters.yamllint.args = {
  '-d',
  '{extends: default, rules: {line-length: {max: 120}}}',
  '-f',
  'parsable',
  '-',
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufEnter' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.buftype ~= '' then
      return
    end

    if vim.g.disable_auto_lint then
      return
    end

    lint.try_lint()
  end,
})
