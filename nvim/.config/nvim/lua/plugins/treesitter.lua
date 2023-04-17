vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

local configs = require('nvim-treesitter')
configs.setup {
  ensure_installed = { 'c', 'go', 'python', 'markdown', 'javascript', 'lua', 'vim', 'vimdoc' },
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}