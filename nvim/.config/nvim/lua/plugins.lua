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
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("packer-compile", { clear = true }),
    pattern = "plugins.lua",
    callback = function()
        vim.cmd("source % | PackerCompile")
    end,
})

--- startup and add configure plugins
packer.startup(function()
    use('wbthomason/packer.nvim')
    use('EdenEast/nightfox.nvim')
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    use('neovim/nvim-lspconfig')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-vsnip')
    use('hrsh7th/vim-vsnip')

    use('simrat39/rust-tools.nvim')

    use({
        'kylechui/nvim-surround',
        tag = '*', 
        config = function()
            require('nvim-surround').setup({})
        end
    })

    use({
        'nvim-telescope/telescope.nvim', 
        requires = { {'nvim-lua/plenary.nvim'} }
    })

    use('nvim-tree/nvim-tree.lua')

    use('m4xshen/autoclose.nvim')
end)


