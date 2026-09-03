-- Hyprland Lua config (migrated from hyprland.conf for 0.55+/0.56, where
-- hyprlang .conf is deprecated: https://hyprland.org/news/26_lua)
-- Refer to the wiki: https://wiki.hypr.land/Configuring/

-- Set programs that you use
local terminal    = "ghostty"
local fileManager = "dolphin"
local menu        = "wofi --conf $HOME/.config/wofi/config"
local lock        = "hyprlock"
local mainMonitor = "desc:Samsung Electric Company C24F390 H4ZM902187"

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = mainMonitor,
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = "1",
})

hl.monitor({
    output   = "desc:BOE 0x092F",
    mode     = "1920x1200@60",
    position = "+1920x0",
    scale    = "1",
})

hl.monitor({
    output   = "desc:HAT Kamvas Pro 16 0x01010101",
    mode     = "preferred",
    position = "0x1200",
    scale    = "1",
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mkdir -p ~/screenshots")
    hl.exec_cmd("swaybg -i ~/.config/lockscreen.png")
    hl.exec_cmd("fcitx5 -d")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 20,
        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = true,
        background_color        = "rgba(3c3c3c00)",
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 }    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 }    } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 }       } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 }    } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 }     } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint",  style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",        style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint",  style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear",  style = "fade" })

------------------
---- WORKSPACES ----
------------------

hl.workspace_rule({ workspace = "1", monitor = mainMonitor, on_created_empty = terminal, default = true })
hl.workspace_rule({ workspace = "2", monitor = mainMonitor })
hl.workspace_rule({ workspace = "3", monitor = mainMonitor })
hl.workspace_rule({ workspace = "4", monitor = "desc:BOE 0x092F" })
hl.workspace_rule({ workspace = "5", monitor = "desc:HAT Kamvas Pro 16 0x01010101", default = true })

-----------
---- INPUT ----
-----------

hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },

        tablet = {
            output = "desc:HAT Kamvas Pro 16 0x01010101",
        },
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

---------------
---- GESTURES ----
---------------

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "up", action = "special", workspace_name = "s" })

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind("ALT + Return", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("grimblast --freeze copy area -"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grimblast --freeze --notify save area ~/screenshots/$(date +%d.%m.%y-%H:%M:%S)"))

hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(lock))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mainMod .. " + ALT + Escape", hl.dsp.exec_cmd("systemctl reboot"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Rotate monitor
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("hyprctl keyword monitor " .. mainMonitor .. ",preferred,auto,auto,transform,3"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("hyprctl keyword monitor " .. mainMonitor .. ",preferred,auto,auto"))

-- Switch workspaces
hl.bind("ALT + M", hl.dsp.focus({ workspace = "1" }))
hl.bind("ALT + comma", hl.dsp.focus({ workspace = "2" }))
hl.bind("ALT + period", hl.dsp.focus({ workspace = "3" }))
hl.bind("ALT + N", hl.dsp.focus({ workspace = "4" }))

-- Move active window to a workspace
hl.bind("ALT + SHIFT + M", hl.dsp.window.move({ workspace = "1", follow = false }))
hl.bind("ALT + SHIFT + comma", hl.dsp.window.move({ workspace = "2", follow = false }))
hl.bind("ALT + SHIFT + period", hl.dsp.window.move({ workspace = "3", follow = false }))
hl.bind("ALT + SHIFT + N", hl.dsp.window.move({ workspace = "4", follow = false }))

-- Scratchpad
hl.bind("ALT + H", hl.dsp.window.move({ workspace = "special:s", follow = false }))
hl.bind("ALT + SHIFT + H", hl.dsp.workspace.toggle_special("s"))

-- Move windows with mouse dragging
hl.bind("ALT + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + SHIFT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
-- Requires brightnessctl
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

------------------------------
---- WINDOWS AND WORKSPACES ----
------------------------------

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name           = "suppress-maximize",
    match          = { class = [[.*]] },
    suppress_event = "maximize",
})

-- Float Dolphin file manager
hl.window_rule({
    name  = "float-dolphin",
    match = { class = [[^(org\.kde\.dolphin)$]] },
    float = true,
})

-- Float dialogs
hl.window_rule({
    name  = "float-open-file",
    match = { title = [[^(Open File)$]] },
    float = true,
})

hl.window_rule({
    name  = "float-save-file",
    match = { title = [[^(Save File)$]] },
    float = true,
})

hl.window_rule({
    name  = "float-color-picker",
    match = { title = [[^(Color Picker)$]] },
    float = true,
})

-- Float Picture-in-Picture
hl.window_rule({
    name  = "float-pip",
    match = { title = [[^(Picture-in-Picture)$]] },
    float = true,
})