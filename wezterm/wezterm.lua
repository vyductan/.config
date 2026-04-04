local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local config = {}

-- config.native_macos_fullscreen_mode = true
wezterm.on("gui-startup", function(cmd)
	-- local args = {}
	-- if cmd then
	--   args = cmd.args
	-- end
	--
	-- local developer_dir = '~/Developer'
	-- local tab, editor_pane, window = mux.spawn_window({
	--   workspace = "Developer",
	--   cwd = cmd.cwd,
	--   args = args
	-- })
	-- local terminal_1_pane = editor_pane:split {
	--   direction = 'Bottom',
	--   size = 0.3,
	--   -- cwd = developer_dir
	-- }
	-- local terminal_2_pane = terminal_1_pane:split {
	--   direction = 'Right',
	--   size = 0.5,
	--   -- cwd = developer_dir
	-- }
	-- mux.set_active_workspace("Developer")

	local _, _, window = mux.spawn_window(cmd or {})
	-- window:gui_window():toggle_fullscreen()
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
		key = "b",
		mods = "CMD",
		action = wezterm.action_callback(function(_, pane)
			local pane_id = pane:pane_id()
			local log_path = "/tmp/wez-sidebar-launch.log"
			local sidebar_path = "/Users/vyductan/.local/bin/wez-sidebar"
			local command = table.concat({
				string.format(
					"printf 'start time=%%s parent_pane=%s tty=%%s\\n' \"$(date -Is 2>/dev/null || date)\" \"$(tty 2>/dev/null || printf none)\" >> %q",
					pane_id,
					log_path
				),
				string.format("export WEZTERM_PANE=%s RUST_BACKTRACE=1", pane_id),
				string.format("%q", sidebar_path),
				string.format("rc=$?; printf 'exit=%%s\\n' \"$rc\" >> %q", log_path),
				'if [ "$rc" -ne 0 ]; then sleep 10; fi',
			}, "; ")
			pane:split({
				direction = "Right",
				size = 0.2,
				args = { "/bin/sh", "-lc", command },
			})
		end),
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
