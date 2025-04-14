require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "python", "markdown", "javascript", "lua", "vim", "vimdoc" },
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
