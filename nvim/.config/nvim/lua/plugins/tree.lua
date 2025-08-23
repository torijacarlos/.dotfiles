return {
    {
        "nvim-tree/nvim-tree.lua",
        config = function()

            vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<cr>")
            vim.keymap.set("n", "<leader>tg", ":NvimTreeFindFile<cr>")

            local tree = require("nvim-tree")
            tree.setup {
              sort_by = "case_sensitive",
              view = {
                width = 50,
                relativenumber = true,
                float = {
                    enable = true,
                },
              },
              renderer = {
                group_empty = true,
                indent_width = 2,
                root_folder_label = false,
              },
              filters = {
                dotfiles = false,
              },
            } 
        end 
    }
}

