return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local lualine = require('lualine')
            lualine.setup {
                options = {
                    icons_enabled = false,
                    theme = 'gruvbox',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                }
            }
        end
    }
}
