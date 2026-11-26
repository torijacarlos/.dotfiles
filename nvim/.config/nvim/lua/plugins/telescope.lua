vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fc', function()
  builtin.find_files {
    cwd = vim.fn.stdpath('config'),
  }
end)

vim.keymap.set('n', '<leader>fO', function()
  builtin.find_files {
    cwd = '~/kura/code/odin/',
  }
end)
vim.keymap.set('n', '<leader>fo', function()
  builtin.live_grep {
    cwd = '~/kura/code/odin/',
  }
end)

local telescope = require('telescope')
telescope.load_extension('fzf')
telescope.setup {
  defaults = {
    file_ignore_patterns = {
      '%.git',
      'target',
      'Cargo.lock',
      '__pycache__',
      'venv',
      'node_modules',
      'package-lock.json',
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-uu',
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      disable_devicons = true,
      theme = 'ivy',
    },
    live_grep = {
      theme = 'ivy',
    },
  },
}