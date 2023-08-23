require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 40,
    hide_root_folder = true,
    relativenumber = true,
    float = {
        enable = true,
    },
  },
  renderer = {
    group_empty = true,
    indent_width = 2,
  },
  filters = {
    dotfiles = false,
  },
})
