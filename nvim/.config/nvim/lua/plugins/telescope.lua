return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        config = function()
            -- Telescope
            local builtin = require('telescope.builtin')
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fg", builtin.live_grep)
            vim.keymap.set("n", "<leader>fc", function() 
                builtin.find_files {
                    cwd = vim.fn.stdpath("config")
                }
            end)

            local telescope = require("telescope")
            telescope.load_extension("fzf")
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
                        '-uu'
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        disable_devicons = true,
                        theme = "ivy"
                    },
                    live_grep = {
                        theme = "ivy"
                    },
                },
            }

        end
    }
}
