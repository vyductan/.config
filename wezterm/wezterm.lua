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

-- Window screen positions. resurrect only keeps sizes, and WezTerm's Lua API
-- can set a window's position but not read it, so ask macOS (System Events;
-- WezTerm needs Accessibility permission). The native title carries a "[w<id>]"
-- tag so each macOS window can be matched back to its mux window.
local positions_file = state_dir .. "window_positions.json"

wezterm.on("format-window-title", function(tab)
	return tab.active_pane.title .. "  [w" .. tab.window_id .. "]"
end)

local FRAMES_SCRIPT = [[
tell application "System Events" to tell process "wezterm-gui"
	set out to ""
	repeat with w in windows
		set {x, y} to position of w
		set {ww, hh} to size of w
		set out to out & (name of w) & tab & x & tab & y & tab & ww & tab & hh & linefeed
	end repeat
	return out
end tell
]]

local function save_window_positions()
	local ok, stdout, stderr = wezterm.run_child_process({ "osascript", "-e", FRAMES_SCRIPT })
	if not ok then
		wezterm.log_warn("window positions not saved (grant WezTerm Accessibility?): " .. stderr)
		return
	end
	local frames = {}
	for line in stdout:gmatch("[^\n]+") do
		local id, x, y, w, h = line:match("%[w(%d+)%]\t(-?%d+)\t(-?%d+)\t(%d+)\t(%d+)$")
		if id then
			frames[tonumber(id)] = { x = tonumber(x), y = tonumber(y), w = tonumber(w), h = tonumber(h) }
		end
	end
	-- Same order resurrect uses for workspace_state.window_states (and restores in)
	local positions = {}
	local workspace = mux.get_active_workspace()
	for _, win in ipairs(mux.all_windows()) do
		if win:get_workspace() == workspace then
			local frame = frames[win:window_id()]
			-- System Events only sees windows on the visible Space; a partial
			-- snapshot would wipe good positions, so keep the last full one
			if not frame then
				return
			end
			table.insert(positions, frame)
		end
	end
	local f = io.open(positions_file, "w")
	if f then
		f:write(wezterm.json_encode(positions))
		f:close()
	end
end

local function restore_window_positions()
	local f = io.open(positions_file, "r")
	if not f then
		return
	end
	local ok, positions = pcall(wezterm.json_parse, f:read("*a"))
	f:close()
	if not ok or type(positions) ~= "table" then
		return
	end
	local i = 0
	for _, win in ipairs(mux.all_windows()) do
		i = i + 1
		local frame = positions[i]
		local gui = win:gui_window()
		if frame and gui then
			local scale = gui:get_dimensions().dpi / 72
			gui:set_inner_size(frame.w * scale, frame.h * scale)
			-- System Events reports points; set_position/set_inner_size take pixels
			gui:set_position(frame.x * scale, frame.y * scale)
		end
	end
end

local function save_current_workspace()
	local workspace = wezterm.mux.get_active_workspace()
	resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
	resurrect.state_manager.write_current_state(workspace, "workspace")
	save_window_positions()
end

-- Auto-save every 2 minutes. Driven by update-status (fires ~1s in the live
-- config) rather than resurrect's periodic_save timer: WezTerm evaluates the
-- config in several Lua contexts and discards some, and a timer started in a
-- discarded one silently dies. wezterm.GLOBAL is shared, so this throttles
-- across windows and reloads.
local AUTOSAVE_SECONDS = 120
wezterm.on("update-status", function()
	local now = os.time()
	if now - (wezterm.GLOBAL.last_session_save or 0) < AUTOSAVE_SECONDS then
		return
	end
	wezterm.GLOBAL.last_session_save = now
	save_current_workspace()
end)
-- Also save when a window loses focus: update-status pauses while WezTerm is in
-- the background, so this catches moves made just before switching away.
wezterm.on("window-focus-changed", function(window)
	if window:is_focused() then
		return
	end
	local now = os.time()
	if now - (wezterm.GLOBAL.last_session_save or 0) < 10 then
		return
	end
	wezterm.GLOBAL.last_session_save = now
	save_current_workspace()
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
	-- Hold off the first auto-save so it can't overwrite saved state with a
	-- half-restored layout (windows not yet moved back into place)
	wezterm.GLOBAL.last_session_save = os.time()
	local ok = resurrect.state_manager.resurrect_on_gui_startup()
	if not ok or #mux.all_windows() == 0 then
		mux.spawn_window(cmd or {})
		return
	end
	-- GUI windows don't exist yet during gui-startup; position them once they do
	wezterm.time.call_after(1, restore_window_positions)
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
