vim.pack.add({
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-cmdline',
})

local cmp = require('cmp')
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'buffer', keyword_length = 3 },
  },
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Tab>'] = cmp.mapping.select_next_item(select_opts),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline', keyword_length = 3 },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})