return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require'nvim-treesitter.configs'
            configs.setup {
                ensure_installed = { "c", "go", "python", "markdown", "javascript", "lua", "vim", "vimdoc" },
                auto_install = false,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    }
}
