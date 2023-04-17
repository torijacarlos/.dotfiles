local bufopts = { noremap=true, silent=true, buffer=bufnr }

-- Buffers
vim.keymap.set("n", "<leader>o", "<cmd>bp<cr>", bufopts)
vim.keymap.set("n", "<leader>p", "<cmd>bn<cr>", bufopts)
vim.keymap.set("n", "<leader>[", "<cmd>bp<cr>", bufopts)
vim.keymap.set("n", "<leader>]", "<cmd>bn<cr>", bufopts)

-- Telescope
vim.keymap.set("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>", bufopts)
vim.keymap.set("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>", bufopts)
vim.keymap.set("n", "<leader>fq", ":lua require('telescope.builtin').quickfix()<cr>", bufopts)

-- Autocompletes
vim.keymap.set("i", "(", "()<esc>i", bufopts)
vim.keymap.set("i", "{", "{}<esc>i", bufopts)
vim.keymap.set("i", "[", "[]<esc>i", bufopts)
vim.keymap.set("i", "'", "''<esc>i", bufopts)
vim.keymap.set("i", "\"", "\"\"<esc>i", bufopts)


--- Only Html
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("html-braces", { clear = true }),
    pattern = { "html" },
    callback = function()
        vim.keymap.set("i", "<", "<><esc>i", bufopts)
    end
})
