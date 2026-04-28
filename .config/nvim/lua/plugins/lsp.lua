require('mason').setup({
  ui = {
    border = 'single',
  },
})
vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>', { desc = 'mason' })

require('mason-tool-installer').setup({
  ensure_installed = {
    'astro-language-server',
    'basedpyright',
    'bash-language-server',
    'css-lsp',
    'fish-lsp',
    'gofumpt',
    'goimports',
    'gopls',
    'html-lsp',
    'json-lsp',
    'lemminx',
    'lua-language-server',
    'markdownlint',
    'marksman',
    'oxlint',
    'prettier',
    'ruff',
    'shellcheck',
    'shfmt',
    'sql-formatter',
    'sqls',
    'stylua',
    'svelte-language-server',
    'taplo',
    'tinymist',
    'vtsls',
    'yaml-language-server',
    'yamllint',
  },
  auto_update = false,
  run_on_start = false,
})

require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

local constants = require('config.constants')

local has_blink, blink = pcall(require, 'blink.cmp')
local capabilities = vim.lsp.protocol.make_client_capabilities()
if has_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

local js_ts_filetypes = {
  'javascript',
  'javascriptreact',
  'javascript.jsx',
  'typescript',
  'typescriptreact',
  'typescript.tsx',
}

local js_ts_inlay_hints = {
  parameterNames = { enabled = 'all' },
  parameterTypes = { enabled = true },
  variableTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
}

local servers = {
  bashls = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'bash' },
    root_markers = { '.git' },
  },
  basedpyright = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
      '.git',
    },
    settings = {
      basedpyright = { analysis = { typeCheckingMode = 'basic' } },
      pyright = { disableOrganizeImports = true },
    },
  },
  astro = {
    cmd = { 'astro-ls', '--stdio' },
    filetypes = { 'astro' },
    root_markers = { 'astro.config.mjs', 'astro.config.ts', 'package.json', '.git' },
  },
  cssls = {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
  },
  fish_lsp = {
    cmd = { 'fish-lsp', 'start' },
    filetypes = { 'fish' },
    root_markers = { '.git' },
  },
  gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.work', 'go.mod', '.git' },
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
        analyses = {
          shadow = true,
          unusedparams = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  html = {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html' },
    root_markers = { 'package.json', '.git' },
    init_options = {
      provideFormatter = true,
      embeddedLanguages = { css = true, javascript = true },
      configurationSection = { 'html', 'css', 'javascript' },
    },
  },
  jsonls = {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_markers = { '.git' },
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      'selene.yml',
      '.git',
    },
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = { globals = { 'vim', 'MiniIcons', 'MiniStatusline' } },
      },
    },
  },
  marksman = {
    cmd = { 'marksman', 'server' },
    filetypes = { 'markdown', 'markdown.mdx' },
    root_markers = { '.marksman.toml', '.git' },
  },
  ruff = {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  },
  svelte = {
    cmd = { 'svelteserver', '--stdio' },
    filetypes = { 'svelte' },
    root_markers = {
      'svelte.config.js',
      'svelte.config.cjs',
      'svelte.config.mjs',
      'svelte.config.ts',
      'package.json',
      '.git',
    },
  },
  sqls = {
    cmd = { 'sqls' },
    filetypes = { 'sql' },
    root_markers = { '.sqls.yml', '.git' },
  },
  taplo = {
    cmd = { 'taplo', 'lsp', 'stdio' },
    filetypes = { 'toml' },
    root_markers = { '.taplo.toml', 'taplo.toml', '.git' },
  },
  tinymist = {
    cmd = { 'tinymist' },
    filetypes = { 'typst' },
    root_markers = { 'typst.toml', '.git' },
    settings = {
      formatterMode = 'typstyle',
    },
  },
  vtsls = {
    cmd = { 'vtsls', '--stdio' },
    filetypes = js_ts_filetypes,
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
    settings = {
      typescript = { inlayHints = js_ts_inlay_hints },
      javascript = { inlayHints = js_ts_inlay_hints },
    },
  },
  yamlls = {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
    root_markers = { '.git' },
    settings = {
      yaml = {
        schemaStore = { enable = false, url = '' },
        schemas = require('schemastore').yaml.schemas(),
        validate = true,
      },
    },
  },
  lemminx = {
    cmd = { 'lemminx' },
    filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
    root_markers = { '.git' },
  },
}

vim.lsp.config('*', {
  capabilities = capabilities,
})

local server_names = {}
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  table.insert(server_names, name)
end

vim.g.managed_lsp_servers = server_names

if not vim.g.disable_auto_lsp then
  vim.lsp.enable(server_names)
end

local highlight_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end

    map('n', '<leader>cr', vim.lsp.buf.rename, 'rename')
    map('n', '<leader>cS', vim.lsp.buf.signature_help, 'signature help')

    local client = vim.lsp.get_clients({ id = event.data.client_id })[1]

    if client and client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end

    if client and client:supports_method('textDocument/documentHighlight') then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
  callback = function(event)
    vim.lsp.buf.clear_references()
    vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event.buf })
  end,
})

vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = 'single',
    source = true,
  },
  virtual_text = false,
  virtual_lines = {
    current_line = true,
    format = function(diagnostic)
      if diagnostic.source then
        return string.format('[%s] %s', diagnostic.source, diagnostic.message)
      end
      return diagnostic.message
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = constants.diagnostic_symbols.error,
      [vim.diagnostic.severity.WARN] = constants.diagnostic_symbols.warn,
      [vim.diagnostic.severity.INFO] = constants.diagnostic_symbols.info,
      [vim.diagnostic.severity.HINT] = constants.diagnostic_symbols.hint,
    },
  },
})
