local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local config = {}

-- config.native_macos_fullscreen_mode = true

-- Session restore (layout: windows/tabs/panes + cwd) via resurrect.wezterm
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local state_dir = wezterm.home_dir .. "/.local/share/wezterm/resurrect/"
resurrect.state_manager.change_state_save_dir(state_dir)
resurrect.state_manager.set_max_nlines(500)

local function save_current_workspace()
	local workspace = wezterm.mux.get_active_workspace()
	resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
	resurrect.state_manager.write_current_state(workspace, "workspace")
end

-- Guard: config reloads would otherwise stack another save loop each time
if not wezterm.GLOBAL.resurrect_periodic_started then
	wezterm.GLOBAL.resurrect_periodic_started = true
	resurrect.state_manager.periodic_save({ interval_seconds = 120, save_workspaces = true })
end
wezterm.on("resurrect.state_manager.periodic_save.finished", function()
	resurrect.state_manager.write_current_state(wezterm.mux.get_active_workspace(), "workspace")
end)
wezterm.on("resurrect.error", function(err)
	wezterm.log_error("resurrect: " .. tostring(err))
end)

wezterm.on("gui-startup", function(cmd)
	-- Launched with explicit args (e.g. `wezterm start -- htop`): don't restore
	if cmd and cmd.args then
		mux.spawn_window(cmd)
		return
	end
	local ok = resurrect.state_manager.resurrect_on_gui_startup()
	if not ok or #mux.all_windows() == 0 then
		mux.spawn_window(cmd or {})
	end
end)

config.default_prog = { "/opt/homebrew/bin/fish" }
-- config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14
config.initial_cols = 140
config.initial_rows = 40
-- config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.8
-- config.underline_position = -4
-- config.underline_thickness = 50

-- config.window_background_image =
-- '/Users/vyductan/Library/CloudStorage/OneDrive-Personal/Pictures/Wallpapers/WallPaper 4.jpg'
-- config.window_background_image_hsb = {
--   -- Darken the background image by reducing it to 1/3rd
--   brightness = 1,
--   -- You can adjust the hue by scaling its value.
--   -- a multiplier of 1.0 leaves the value unchanged.
--   hue = 1.0,
--   -- You can adjust the saturation also.
--   saturation = 1,
-- }

-- Tokyonight - Moon
-- config.color_scheme_dirs =
config.color_scheme = "tokyonight_night"
-- config.colors = {
-- 	background = "black",
-- }

config.keys = {
	-- Nvim bind
	{
		key = "i",
		mods = "CMD",
		action = act.SendKey({
			key = "i",
			mods = "CTRL",
		}),
	},
	{
		key = "d",
		mods = "CMD",
		action = act.SendKey({
			key = "d",
			mods = "CTRL",
		}),
	},
	-- End Nvim bind

	-- This will create a new split and run the `top` program inside it
	{
		key = "s",
		mods = "CMD",
		action = act.SendKey({
			key = "s",
			mods = "CTRL",
		}),
	},
	{
		key = "h",
		mods = "CMD",
		action = act.SendKey({
			key = "h",
			mods = "CTRL",
		}),
	},
	{
		key = "l",
		mods = "CMD",
		action = act.SendKey({
			key = "l",
			mods = "CTRL",
		}),
	},
	{
		key = "\\",
		mods = "SHIFT|SUPER",
		action = wezterm.action.SplitPane({
			direction = "Right",
			-- command = { args = { 'top' } },
			size = { Percent = 50 },
		}),
	},
	{
		key = "-",
		mods = "SHIFT|SUPER",
		action = wezterm.action.SplitPane({
			direction = "Down",
			-- command = { args = { 'top' } },
			size = { Percent = 50 },
		}),
	},
	{
		key = "\\",
		mods = "SHIFT|SUPER",
		action = wezterm.action.SplitPane({
			direction = "Right",
			-- command = { args = { 'top' } },
			size = { Percent = 50 },
		}),
	},
	{
		key = "-",
		mods = "SHIFT|SUPER",
		action = wezterm.action.SplitPane({
			direction = "Down",
			-- command = { args = { 'top' } },
			size = { Percent = 50 },
		}),
	},
	-- Save session layout now (also auto-saved every 2 minutes)
	{
		key = "s",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			save_current_workspace()
			win:toast_notification("WezTerm", "Session saved", nil, 2000)
		end),
	},
	-- Tab Move
	-- { key = ",", mods = "CMD", action = act.MoveTabRelative(-1) },
	-- { key = ".", mods = "CMD", action = act.MoveTabRelative(1) },
	{ key = "[", mods = "CMD", action = act.MoveTabRelative(-1) },
	{ key = "]", mods = "CMD", action = act.MoveTabRelative(1) },
	-- {
	-- 	key = "k",
	-- 	mods = "CTRL|SHIFT|ALT",
	-- 	action = wezterm.action.SplitPane({
	-- 		direction = "Up",
	-- 		-- command = { args = { 'top' } },
	-- 		size = { Percent = 50 },
	-- 	}),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "CTRL|SHIFT|ALT",
	-- 	action = wezterm.action.SplitPane({
	-- 		direction = "Right",
	-- 		-- command = { args = { 'top' } },
	-- 		size = { Percent = 50 },
	-- 	}),
	-- },
	--
	{ key = "h", mods = "CMD", action = act.EmitEvent("ActivatePaneDirection-left") },
	{ key = "j", mods = "CMD", action = act.EmitEvent("ActivatePaneDirection-down") },
	{ key = "k", mods = "CMD", action = act.EmitEvent("ActivatePaneDirection-up") },
	{ key = "l", mods = "CMD", action = act.EmitEvent("ActivatePaneDirection-right") },
	-- {
	-- 	key = "h",
	-- 	mods = "CMD",
	-- 	action = act.ActivatePaneDirection("Left"),
	-- },
	-- {
	-- 	key = "j",
	-- 	mods = "CMD",
	-- 	action = act.ActivatePaneDirection("Down"),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "CMD",
	-- 	action = act.ActivatePaneDirection("Up"),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "CMD",
	-- 	action = act.ActivatePaneDirection("Right"),
	-- },
}

-- https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration
local function isViProcess(pane)
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(
			-- This should match the keybinds you set in Neovim.
			act.SendKey({ key = vim_direction, mods = "CTRL" }),
			pane
		)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditionalActivatePane(window, pane, "Down", "j")
end)

return config
