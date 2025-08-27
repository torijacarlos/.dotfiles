-- From https://github.com/tjdevries/advent-of-nvim/blob/master/README.md

local state = {
  buf = -1,
  win = -1,
}

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.win) then

    if not vim.api.nvim_buf_is_valid(state.buf) then
      state.buf = vim.api.nvim_create_buf(false, true)
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)

    state.win = vim.api.nvim_open_win(state.buf, true, {
      relative = "editor",
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width) / 2),
      row = math.floor((vim.o.lines - height) / 2),
      border = "rounded",
    })
    
    if vim.bo[state.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.win)
  end
end

local execute_cmd = function(cmdstr)
  if not cmdstr then
    return
  end
  toggle_terminal()
  if vim.api.nvim_win_is_valid(state.win) and vim.api.nvim_buf_is_valid(state.buf) then
    vim.fn.chansend(vim.bo[state.buf].channel, { ""..cmdstr.."\r\n" })
  end
end

local execute_make = function(env)
  local make_env = ""
  local current_buf = ""
  if env then 
    make_env = env.."/"
  end
  if not vim.api.nvim_win_is_valid(state.win) or not vim.api.nvim_buf_is_valid(state.buf) then
    current_buf = vim.fs.normalize(vim.api.nvim_buf_get_name(0))
    for token in string.gmatch(current_buf, "([^/]+)") do
      if string.find(token, ".", 1, true) then
        current_buf = string.sub(token, 1, string.find(token, ".", 1, true) - 1)
      end
    end
  end

  execute_cmd("make "..make_env..current_buf.."")
end

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<space>t", toggle_terminal)
vim.keymap.set("n", "<space>g", function() execute_cmd('gfi') end)
vim.keymap.set("n", "<space>.", function() execute_cmd("make") end)
vim.keymap.set("n", "<space>,", function() execute_cmd("make test") end)

vim.keymap.set("n", "<space>d.", function() execute_make('d') end)
vim.keymap.set("n", "<space>r.", function() execute_make('r') end)
