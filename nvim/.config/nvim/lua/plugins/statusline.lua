vim.pack.add({
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
})

local lualine = require('lualine')
lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
}