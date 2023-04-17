vim.pack.add({
  'https://github.com/EdenEast/nightfox.nvim',
})

vim.cmd.colorscheme 'nordfox'

vim.keymap.set('n', '<leader>o', '<cmd>bp<cr>')
vim.keymap.set('n', '<leader>p', '<cmd>bn<cr>')