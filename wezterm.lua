-- WezTerm Keybindings Documentation by dragonlobster
-- ===================================================
-- Leader Key:
-- The leader key is set to ALT + q, with a timeout of 2000 milliseconds (2 seconds).
-- To execute any keybinding, press the leader key (ALT + q) first, then the corresponding key.

-- Keybindings:
-- 1. Tab Management:
--    - CTRL|ALT|CMD|SHIFT + c: Create a new tab in the current pane's domain.
--    - CTRL|ALT|CMD|SHIFT + x: Close the current pane (with confirmation).
--    - CTRL|ALT|CMD|SHIFT + b: Switch to the previous tab.
--    - CTRL|ALT|CMD|SHIFT + n: Switch to the next tab.
--    - CTRL|ALT|CMD|SHIFT + <number>: Switch to a specific tab (0–9).

-- 2. Pane Splitting:
--    - CTRL|ALT|CMD|SHIFT + |: Split the current pane horizontally into two panes.
--    - CTRL|ALT|CMD|SHIFT + -: Split the current pane vertically into two panes.
-- 3. Pane Navigation:
--    - CTRL|ALT|CMD|SHIFT + h: Move to the pane on the left.
--    - CTRL|ALT|CMD|SHIFT + j: Move to the pane below.
--    - CTRL|ALT|CMD|SHIFT + k: Move to the pane above.
--    - CTRL|ALT|CMD|SHIFT + l: Move to the pane on the right.

-- 4. Pane Resizing:
--    - CTRL|ALT|CMD|SHIFT + LeftArrow: Increase the pane size to the left by 5 units.
--    - CTRL|ALT|CMD|SHIFT + RightArrow: Increase the pane size to the right by 5 units.
--    - CTRL|ALT|CMD|SHIFT + DownArrow: Increase the pane size downward by 5 units.
--    - CTRL|ALT|CMD|SHIFT + UpArrow: Increase the pane size upward by 5 units.

-- 5. Status Line:
--    - The status line indicates when the leader key is active, displaying an ocean wave emoji (🌊).

-- Miscellaneous Configurations:
-- - Tabs are shown even if there's only one tab.
-- - The tab bar is located at the bottom of the terminal window.
-- - Tab and split indices are zero-based.

-- Pull in the wezterm API
local wezterm = require("wezterm")

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

--[[
============================
Shortcuts
============================
]]
--

-- shortcut_configuration
config.keys = {
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "-",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "CTRL|ALT|CMD|SHIFT",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
}

for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT|CMD|SHIFT",
		action = wezterm.action.ActivateTab(i),
	})
end

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

-- and finally, return the configuration to wezterm
return config
