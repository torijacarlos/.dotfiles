vim.pack.add({
  'https://github.com/3rd/image.nvim',
})

require('image').setup({
  backend = 'kitty',
  processor = 'magick_cli',
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      floating_windows = false,
    },
  },
  editor_only_render_when_focused = true,
  window_overlap_clear_enabled = true,
  tmux_show_only_in_active_window = true,
  max_height_window_percentage = 50,
})