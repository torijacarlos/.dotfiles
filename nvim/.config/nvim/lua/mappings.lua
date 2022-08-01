local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Buffers
map("n", "<leader>[", "<cmd>bp<cr>")
map("n", "<leader>]", "<cmd>bn<cr>")

-- Telescope
map("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>")

-- Autocompletes
map("i", "(", "()<esc>i")
map("i", "{", "{}<esc>i")
map("i", "[", "[]<esc>i")
map("i", "<", "<><esc>i")
map("i", "'", "''<esc>i")
map("i", "\"", "\"\"<esc>i")
