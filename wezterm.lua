-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- max fps
config.max_fps = 240
config.animation_fps = 240

--[[
============================
Custom Configuration
============================
]]
--

-- Rounded or Square Style Tabs

-- change to square if you don't like rounded tab style
local tab_style = "square"

-- leader active indicator prefix
local leader_prefix = utf8.char(0x1f30a) -- ocean wave

--[[
============================
Font
============================
]]
--

config.font_size = 16

--[[
============================
Colors
============================
]]
--

local color_scheme = "Catppuccin Mocha"
config.color_scheme = color_scheme

-- color_scheme not sufficient in providing available colors
-- local colors = wezterm.color.get_builtin_schemes()[color_scheme]

-- color scheme colors for easy access
local scheme_colors = {
	catppuccin = {
		macchiato = {
			rosewater = "f4dbd6",
			flamingo = "f0c6c6",
			pink = "f5bde6",
			mauve = "c6a0f6",
			red = "ed8796",
			maroon = "ee99a0",
			peach = "#f5a97f",
			yellow = "#eed49f",
			green = "#a6da95",
			teal = "#8bd5ca",
			sky = "#91d7e3",
			sapphire = "#7dc4e4",
			blue = "#8aadf4",
			lavender = "#b7bdf8",
			text = "#cad3f5",
			crust = "#181926",
		},
	},
}

local colors = {
	border = scheme_colors.catppuccin.macchiato.lavender,
	tab_bar_active_tab_fg = scheme_colors.catppuccin.macchiato.mauve,
	tab_bar_active_tab_bg = scheme_colors.catppuccin.macchiato.crust,
	tab_bar_text = scheme_colors.catppuccin.macchiato.crust,
	arrow_foreground_leader = scheme_colors.catppuccin.macchiato.lavender,
	arrow_background_leader = scheme_colors.catppuccin.macchiato.crust,
}

--[[
============================
Border
============================
]]
--

config.window_frame = {
	border_left_width = "0.4cell",
	border_right_width = "0.4cell",
	border_bottom_height = "0.15cell",
	border_top_height = "0.15cell",
	border_left_color = colors.border,
	border_right_color = colors.border,
	border_bottom_color = colors.border,
	border_top_color = colors.border,
}

config.scrollback_lines = 5000

--[[
============================
Session management
============================
]]
--

local session_manager = require("wezterm-session-manager/session-manager")
wezterm.on("save_session", function(window)
	wezterm.log_info("Save session triggered")
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)

--[[
============================
Shortcuts
============================
]]
--

local leader_str = "CTRL|ALT|CMD|SHIFT"
-- shortcut_configuration
config.keys = {
	{
		mods = leader_str,
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = leader_str,
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = leader_str,
		key = "p",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = leader_str,
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = leader_str,
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = leader_str,
		key = "-",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line is nil if you hit Esc, empty if you just hit Enter,
				-- or the text you typed
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action({ EmitEvent = "move-left" }),
	},
	{
		key = "j",
		mods = "CTRL",
		action = wezterm.action({ EmitEvent = "move-down" }),
	},
	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action({ EmitEvent = "move-up" }),
	},
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action({ EmitEvent = "move-right" }),
	},
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action({ EmitEvent = "resize-left" }),
	},
	{
		key = "j",
		mods = "ALT",
		action = wezterm.action({ EmitEvent = "resize-down" }),
	},
	{
		key = "k",
		mods = "ALT",
		action = wezterm.action({ EmitEvent = "resize-up" }),
	},
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action({ EmitEvent = "resize-right" }),
	},
	{
		mods = leader_str,
		key = "[",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		mods = leader_str,
		key = "t",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		mods = leader_str,
		key = "f",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "]",
		mods = leader_str,
		action = wezterm.action.PaneSelect({ mode = "SwapWithActiveKeepFocus" }),
	},
	-- Attach to muxer
	{
		key = "a",
		mods = leader_str,
		action = wezterm.action.AttachDomain("unix"),
	},

	-- Detach from muxer
	{
		key = "d",
		mods = leader_str,
		action = wezterm.action.DetachDomain({ DomainName = "unix" }),
	},
	{
		key = "w",
		mods = leader_str,
		action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},
	{
		key = "W",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for session",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},

	-- Session manager
	{
		key = "s",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ EmitEvent = "save_session" }),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ EmitEvent = "load_session" }),
	},
	{
		key = "r",
		mods = leader_str,
		action = wezterm.action({ EmitEvent = "restore_session" }),
	},
}

--[[
============================
Multiplexer
============================
]]
--

config.unix_domains = {
	{
		name = "unix",
	},
}

--[[
============================
Tab Bar
============================
]]
--

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = " " .. tab.tab_index .. ": " .. tab_title(tab) .. " "
	local left_edge_text = ""
	local right_edge_text = ""

	if tab_style == "rounded" then
		title = tab.tab_index .. ": " .. tab_title(tab)
		title = wezterm.truncate_right(title, max_width - 2)
		left_edge_text = wezterm.nerdfonts.ple_left_half_circle_thick
		right_edge_text = wezterm.nerdfonts.ple_right_half_circle_thick
	end

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	-- title = wezterm.truncate_right(title, max_width - 2)

	if tab.is_active then
		return {
			{ Background = { Color = colors.tab_bar_active_tab_bg } },
			{ Foreground = { Color = colors.tab_bar_active_tab_fg } },
			{ Text = left_edge_text },
			{ Background = { Color = colors.tab_bar_active_tab_fg } },
			{ Foreground = { Color = colors.tab_bar_text } },
			{ Text = title },
			{ Background = { Color = colors.tab_bar_active_tab_bg } },
			{ Foreground = { Color = colors.tab_bar_active_tab_fg } },
			{ Text = right_edge_text },
		}
	end
end)

local os = require("os")

local move_around = function(window, pane, direction_wez, direction_nvim)
	local result = os.execute(
		"env NVIM_LISTEN_ADDRESS=/tmp/nvim"
			.. pane:pane_id()
			.. " "
			.. wezterm.home_dir
			.. "/go/bin/wezterm.nvim.navigator "
			.. direction_nvim
	)
	if result then
		window:perform_action(wezterm.action({ SendString = "\x17" .. direction_nvim }), pane)
	else
		window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
	end
end

wezterm.on("move-left", function(window, pane)
	move_around(window, pane, "Left", "h")
end)

wezterm.on("move-right", function(window, pane)
	move_around(window, pane, "Right", "l")
end)

wezterm.on("move-up", function(window, pane)
	move_around(window, pane, "Up", "k")
end)

wezterm.on("move-down", function(window, pane)
	move_around(window, pane, "Down", "j")
end)

local vim_resize = function(window, pane, direction_wez)
	window:perform_action(wezterm.action({ AdjustPaneSize = { direction_wez, 5 } }), pane)
end

wezterm.on("resize-left", function(window, pane)
	vim_resize(window, pane, "Left")
end)

wezterm.on("resize-right", function(window, pane)
	vim_resize(window, pane, "Right")
end)

wezterm.on("resize-up", function(window, pane)
	vim_resize(window, pane, "Up")
end)

wezterm.on("resize-down", function(window, pane)
	vim_resize(window, pane, "Down")
end)

-- and finally, return the configuration to wezterm
return config
