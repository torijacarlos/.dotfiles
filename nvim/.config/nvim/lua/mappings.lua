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

-- Nvim Tree
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<cr>", bufopts)
vim.keymap.set("n", "<leader>tg", ":NvimTreeFindFile<cr>", bufopts)
vim.keymap.set("n", "<leader>tq", ":NvimTreeCollapse<cr>", bufopts)

-- Additional
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)

