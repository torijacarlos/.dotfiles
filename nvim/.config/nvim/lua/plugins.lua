local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')

local packer = require('packer')
local util = require('packer.util')

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- Update installed packages automatically
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

--- startup and add configure plugins
packer.startup(function()
    local use = use

    use 'wbthomason/packer.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'sheerun/vim-polyglot'

    use {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end
    }

    use {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'neoclide/coc.nvim', 
        branch = 'release'
    }
end)

require("telescope").setup({
    defaults = { 
        file_ignore_patterns = {'node_modules', '.git', 'package-lock.json'},
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-uu'
        }
    },
    pickers = {
        find_files = {
            hidden = true,
        }
    }
})

require("nightfox").setup({
    options = {
        transparent = false
    }
})
vim.cmd("colorscheme duskfox")

