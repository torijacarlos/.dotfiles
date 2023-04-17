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
            disable_devicons = true,
        }
    }
})

