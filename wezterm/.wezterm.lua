-- ctrl+shif+x to get into copy mode and V to visually highlight and y to copy and get out of copy mode in wezterm
local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()
-- Color scheme
config.color_scheme = "Gruvbox Dark (Gogh)"

-- Font settings
config.font = wezterm.font_with_fallback({})
config.font_size = 12

-- scrollbar setup
config.enable_scroll_bar = true -- show scrollbar
config.scrollback_lines = 3500 -- how many lines to keep in history

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- Cursor settings
config.default_cursor_style = "BlinkingBar"
config.cursor_thickness = 2

-- Initial window size (optional)
config.initial_rows = 40
config.initial_cols = 120

-- Default shell / auto-start tmux
-- If the session "main" already exists, you’ll be attached to it.
-- If it doesn’t, tmux will create it for you.
config.default_prog = { "/usr/bin/tmux", "new", "-A", "-s", "main" }

-- Tab bar settings
config.enable_tab_bar = false

config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"

-- Transparency / opacity
config.window_background_opacity = 0.95 -- 0.0 = fully transparent, 1.0 = opaque
config.text_background_opacity = 1.0 -- keep text background solid if needed
config.window_background_image_hsb = {
	brightness = 1.0,
	hue = 1.0,
	saturation = 1.0,
}

-- Tab title format
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local tab_index = tab.tab_index + 1
	local title = tab.active_pane.title
	return { { Text = string.format(" %d: %s ", tab_index, title) } }
end)

-- open terminal in full screen by default
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
