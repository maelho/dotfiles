require('blink.cmp').setup({
  fuzzy = {
    implementation = 'prefer_rust',
  },
  keymap = {
    preset = 'none',
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },
  cmdline = {
    keymap = {
      preset = 'none',
      ['<Tab>'] = { 'show', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'show', 'select_prev', 'fallback' },
    },
    sources = function()
      if vim.fn.getcmdtype() == ':' then
        return { 'cmdline', 'buffer' }
      end
      return {}
    end,
    completion = {
      menu = { auto_show = false },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      ghost_text = { enabled = false },
    },
  },
  sources = {
    default = { 'lsp', 'snippets', 'path', 'buffer' },
    per_filetype = {
      lua = { inherit_defaults = true, 'lazydev' },
    },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = 'single',
      },
    },
    menu = {
      scrollbar = true,
      draw = {
        columns = {
          { 'kind_icon' },
          { 'label', 'label_description', gap = 1 },
          { 'kind' },
        },
      },
    },
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
  },
  signature = {
    enabled = true,
    window = {
      border = 'single',
    },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
})
