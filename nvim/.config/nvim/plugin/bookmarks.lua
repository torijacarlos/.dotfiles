-- Simple bookmarks plugin with file persistence per directory

local json_encode = vim.fn.json_encode
local json_decode = vim.fn.json_decode
local data_dir = vim.fn.stdpath("data") .. "/bookmarks"

local function get_bookmarks_file()
    local cwd = vim.fn.getcwd()
    local name = vim.fn.fnamemodify(cwd, ":t")
    if name == "" or name == "/" then name = "root" end
    return data_dir .. "/" .. name .. ".json"
end

local bookmarks = nil

local function get_bookmarks()
    if bookmarks then return bookmarks end
    vim.fn.mkdir(data_dir, "p")
    local f = io.open(get_bookmarks_file(), "r")
    if f then
        local content = f:read("*all")
        f:close()
        if content and #content > 0 then
            local ok, decoded = pcall(json_decode, content)
            if ok and type(decoded) == "table" then
                bookmarks = decoded
                return bookmarks
            end
        end
    end
    bookmarks = {}
    return bookmarks
end

local function save_bookmarks()
    vim.fn.mkdir(data_dir, "p")
    local f = io.open(get_bookmarks_file(), "w")
    if f then
        f:write(json_encode(get_bookmarks()))
        f:close()
    end
end

local function add_bookmark()
    local path = vim.fn.expand("%:p")
    local line = vim.fn.line(".")
    local name = vim.fn.expand("%:t")
    local b = get_bookmarks()
    for i = 1, #b do
        if b[i].path == path and b[i].line == line then
            print("Already bookmarked: " .. name .. ":" .. line)
            return
        end
    end
    table.insert(b, { path = path, name = name, line = line })
    save_bookmarks()
    print("Added: " .. name .. ":" .. line)
end

local function show_bookmarks()
    local b = get_bookmarks()
    if #b == 0 then
        print("No bookmarks. Press <leader>ha to add.")
        return
    end

    local width = 50
    local height = math.min(#b, 10)
    if height < 4 then height = 4 end

    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "rounded",
        style = "minimal",
    })

    vim.wo[win].cursorline = true
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false

    local selected = 1

    local function render()
        local lines = {}
        for i = 1, #b do
            lines[i] = string.format(" %d %s:%d", i, b[i].name, b[i].line)
        end
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_win_set_cursor(win, { selected, 0 })
    end

    render()

    local function close()
        vim.api.nvim_win_close(win, true)
        vim.api.nvim_buf_delete(buf, { force = true })
    end

    local function handle_action(action)
        if action == "open" then
            close()
            vim.cmd("edit " .. b[selected].path)
            vim.cmd(":" .. b[selected].line)
        elseif action == "delete" then
            table.remove(b, selected)
            save_bookmarks()
            if #b == 0 then
                close()
                print("No bookmarks left")
                return
            end
            if selected > #b then selected = #b end
            render()
        elseif action == "clear" then
            bookmarks = {}
            save_bookmarks()
            close()
            print("All bookmarks cleared")
        end
    end

    local opts = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set("n", "q", close, opts)
    vim.keymap.set("n", "<esc>", close, opts)
    vim.keymap.set("n", "<cr>", function() handle_action("open") end, opts)
    vim.keymap.set("n", "d", function() handle_action("delete") end, opts)
    vim.keymap.set("n", "c", function() handle_action("clear") end, opts)
    vim.keymap.set("n", "o", function() handle_action("open") end, opts)
    vim.keymap.set("n", "j", function()
        if selected < #b then selected = selected + 1; render() end
    end, opts)
    vim.keymap.set("n", "k", function()
        if selected > 1 then selected = selected - 1; render() end
    end, opts)
    vim.keymap.set("n", "J", function()
        if selected < #b then
            b[selected], b[selected + 1] = b[selected + 1], b[selected]
            selected = selected + 1
            save_bookmarks()
            render()
        end
    end, opts)
    vim.keymap.set("n", "K", function()
        if selected > 1 then
            b[selected], b[selected - 1] = b[selected - 1], b[selected]
            selected = selected - 1
            save_bookmarks()
            render()
        end
    end, opts)
    vim.keymap.set("i", "<esc>", close, opts)
end

local function jump_to_bookmark(idx)
    local b = get_bookmarks()
    if b[idx] then
        vim.cmd("edit " .. b[idx].path)
        vim.cmd(":" .. b[idx].line)
    else
        print("No bookmark at position " .. idx)
    end
end

vim.keymap.set("n", "<leader>ha", add_bookmark)
vim.keymap.set("n", "<leader>hh", show_bookmarks)

for i, key in ipairs({ "s", "d", "f", "g" }) do
    vim.keymap.set("n", "<leader>h" .. key, function() jump_to_bookmark(i) end)
end
