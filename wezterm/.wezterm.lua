-- ctrl+shift+c copies (WezTerm selection, or tmux copy-mode/mouse selection), ctrl+shift+v pastes
-- ctrl+shift+x to get into WezTerm's own copy mode and V to visually highlight and y to copy and get out of copy mode
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

-- Prefer a source-built tmux (/usr/local/bin) over the older distro package
local tmux = "/usr/bin/tmux"
local f = io.open("/usr/local/bin/tmux", "r")
if f then
	f:close()
	tmux = "/usr/local/bin/tmux"
end

-- GPU rendering via Vulkan; switch back to "OpenGL" if you see glitches
config.front_end = "WebGpu"

-- Kitty graphics protocol (off by default), used by snacks.nvim to show images/PDFs in nvim
config.enable_kitty_graphics = true
-- Color scheme
config.color_scheme = "Gruvbox Dark (Gogh)"

-- Font settings
config.font = wezterm.font_with_fallback({})
config.font_size = 12

-- scrollbar setup
config.enable_scroll_bar = true -- show scrollbar
config.scrollback_lines = 3500 -- only used outside tmux; inside tmux see history-limit in tmux.conf

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
config.default_prog = { tmux, "new", "-A", "-s", "main" }

-- Copy / paste
-- tmux grabs mouse selections, so WezTerm often has nothing selected. In that case copy the
-- tmux copy-mode selection instead (mouse drags leave the pane in copy mode with the selection kept).
config.keys = {
	{
		key = "C",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			if window:get_selection_text_for_pane(pane) ~= "" then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				return
			end
			wezterm.run_child_process({
				tmux,
				"if-shell",
				"-F",
				"#{pane_in_mode}",
				"send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard -i'",
			})
		end),
	},
	{ key = "V", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
}

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
