-- resurrect.wezterm event listener configuration
--
-- This module configures event listeners for the resurrect.wezterm plugin.

local wezterm = require("wezterm")
local notify = require("../notify")

local suppress_notification = false

wezterm.on("resurrect.error", function(error)
	notify.send("Wezterm - ERROR", error, "critical")
end)

wezterm.on("resurrect.periodic_save", function()
	suppress_notification = true
end)

wezterm.on("resurrect.file_io.write_state.finished", function(file_path, event_type)
	local is_workspace_save = file_path:find("state/workspace")

	if is_workspace_save == nil then
		return
	end

	if suppress_notification then
		suppress_notification = false
		return
	end

	local path = file_path:match(".+/([^+]+)$")
	local name = path:match("^(.+)%.json$")
	notify.send("Wezterm - Save workspace", "Saved workspace " .. name .. "\n\n" .. file_path)
end)

wezterm.on("resurrect.load_state.finished", function(name, type)
	local msg = "Completed loading " .. type .. " state: " .. name
	notify.send("Wezterm - Restore session", msg)
end)
