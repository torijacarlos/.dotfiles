require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 40,
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
})
