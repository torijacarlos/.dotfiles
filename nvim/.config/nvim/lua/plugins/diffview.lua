vim.pack.add({
  'https://github.com/sindrets/diffview.nvim',
})

local diffview = require('diffview')
diffview.setup()

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>')
vim.keymap.set('n', '<leader>gc', '<cmd>DiffviewClose<cr>')
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>')