local mod, terminal = "SUPER", "ghostty"

-- Monitors and workspaces -----------------------------------------------------

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

local monitor_slots, next_slot = {}, 1

local function assign_monitor(monitor)
	if monitor_slots[monitor.name] then
		return
	end

	local slot = next_slot
	monitor_slots[monitor.name], next_slot = slot, slot + 1

	for digit = 0, 9 do
		hl.workspace_rule({
			workspace = tostring(slot * 10 + digit),
			monitor = monitor.name,
			default = digit == 1,
		})
	end

	-- Hyprland may carry an old workspace onto a newly connected output.
	-- Re-number it into this monitor's range instead of leaving duplicates.
	local used, stale = {}, {}
	for _, workspace in ipairs(hl.get_workspaces()) do
		if not workspace.special and workspace.monitor and workspace.monitor.name == monitor.name then
			if workspace.id >= slot * 10 and workspace.id <= slot * 10 + 9 then
				used[workspace.id] = true
			else
				table.insert(stale, workspace)
			end
		end
	end

	local migration_order = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 }
	for _, workspace in ipairs(stale) do
		for _, digit in ipairs(migration_order) do
			local id = slot * 10 + digit
			if not used[id] then
				hl.dispatch(hl.dsp.workspace.change_id({ workspace = workspace, id = id }))
				used[id] = true
				break
			end
		end
	end
end

local monitors = hl.get_monitors()
table.sort(monitors, function(a, b)
	return a.id < b.id
end)
for _, monitor in ipairs(monitors) do
	assign_monitor(monitor)
end
hl.on("monitor.added", assign_monitor)

-- Startup and environment ----------------------------------------------------

hl.on("hyprland.start", function()
	for _, command in ipairs({
		"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
		"mpd",
		"dunst",
		"waybar",
		"swaybg -c fill -i $HOME/pictures/wallpaper/bg.jpg",
		[[swayidle -w timeout 3600 "swaylock -f -c 222222" timeout 3600 "systemctl suspend-then-hibernate" before-sleep "swaylock -f -c 222222"]],
	}) do
		hl.exec_cmd(command)
	end
end)

for name, value in pairs({
	XCURSOR_SIZE = "24",
	GDK_BACKEND = "wayland",
	QT_QPA_PLATFORM = "wayland",
	QT_WAYLAND_DISABLE_WINDOWDECORATION = "1",
	CLUTTER_BACKEND = "wayland",
	SDL_VIDEODRIVER = "wayland",
	XDG_CURRENT_DESKTOP = "Hyprland",
	XDG_SESSION_TYPE = "wayland",
	XDG_SESSION_DESKTOP = "Hyprland",
	BEMENU_BACKEND = "wayland",
	ELECTRON_OZONE_PLATFORM_HINT = "wayland",
}) do
	hl.env(name, value)
end

-- Appearance and input -------------------------------------------------------

hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 1,
		border_size = 1,
		col = {
			active_border = "rgba(88527fee)",
			inactive_border = "rgba(2B1DDF66)",
		},
		resize_on_border = true,
		layout = "master",
	},
	decoration = {
		dim_inactive = false,
		blur = { enabled = false },
		shadow = { enabled = false },
	},
	animations = { enabled = false },
	input = {
		kb_layout = "us,ir",
		kb_options = "grp:alt_shift_toggle,caps:escape",
		follow_mouse = 1,
		sensitivity = 0.5,
		accel_profile = "flat",
		touchpad = {
			natural_scroll = true,
			tap_and_drag = true,
			scroll_factor = 1.0,
		},
	},
	master = {
		mfact = 0.55,
		new_status = "slave",
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		focus_on_activate = false,
		key_press_enables_dpms = true,
		mouse_move_enables_dpms = true,
		enable_swallow = true,
		swallow_exception_regex = ".*yazi.*",
	},
	xwayland = { enabled = false },
	ecosystem = {
		no_update_news = false,
		no_donation_nag = false,
	},
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
for _, workspace in ipairs({ "w[tv1]", "f[1]" }) do
	hl.window_rule({
		match = { float = false, workspace = workspace },
		border_size = 0,
		rounding = 0,
	})
end

-- Key bindings ---------------------------------------------------------------

local function bind(keys, dispatcher, flags)
	hl.bind(keys, dispatcher, flags)
end

local function run(keys, command, flags)
	bind(keys, hl.dsp.exec_cmd(command), flags)
end

run(mod .. " + SPACE", "bemenu-run-custom")
run(mod .. " + RETURN", terminal)
run(mod .. " + ALT + M", "bm-mount")
run(mod .. " + ALT + U", "bm-umount")
run(mod .. " + ALT + Q", "bm-off")
run(mod .. " + ALT + P", "keepassxc")
run(mod .. " + ALT + V", terminal .. " -e wiremix")
run(
	mod .. " + ALT + B",
	"sudo systemctl is-active --quiet bluetooth && sudo systemctl stop bluetooth || sudo systemctl start bluetooth"
)
run(mod .. " + CTRL + M", terminal .. " -e ncmpcpp")
run(mod .. " + ALT + S", "bm-scrot")
run(mod .. " + S", "scrot")
run(mod .. " + SHIFT + H", terminal .. " -e yazi")

bind(mod .. " + P", hl.dsp.layout("swapwithmaster"))
bind(mod .. " + O", hl.dsp.layout("orientationnext"))
bind(mod .. " + SHIFT + O", hl.dsp.layout("orientationprev"))
bind(mod .. " + G", hl.dsp.group.toggle())
bind(mod .. " + ALT + J", hl.dsp.group.prev())
bind(mod .. " + ALT + K", hl.dsp.group.next())
bind(mod .. " + Q", hl.dsp.window.close())
bind(mod .. " + SHIFT + CTRL + Q", hl.dsp.exit())
bind(mod .. " + SHIFT + SPACE", hl.dsp.window.float())
bind(mod .. " + M", hl.dsp.window.fullscreen())
bind(mod .. " + J", hl.dsp.focus({ direction = "l" }))
bind(mod .. " + K", hl.dsp.focus({ direction = "r" }))
bind(mod .. " + SHIFT + K", hl.dsp.focus({ direction = "u" }))
bind(mod .. " + SHIFT + J", hl.dsp.focus({ direction = "d" }))
bind(mod .. " + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
bind(mod .. " + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
bind(mod .. " + TAB", hl.dsp.window.cycle_next())

local function active_workspace(digit)
	local monitor = hl.get_active_monitor()
	if not monitor then
		return nil
	end
	assign_monitor(monitor)
	return monitor_slots[monitor.name] * 10 + digit
end

local function dynamic_workspace(digit, move)
	return function()
		local workspace = active_workspace(digit)
		if not workspace then
			return
		end

		if move then
			hl.dispatch(hl.dsp.window.move({ workspace = workspace, follow = false }))
		else
			hl.dispatch(hl.dsp.focus({ workspace = workspace }))
		end
	end
end

for digit = 0, 9 do
	local key, d = tostring(digit), digit

	-- The active monitor always gets SUPER+[0-9].
	bind(mod .. " + " .. key, dynamic_workspace(d, false))
	bind(mod .. " + SHIFT + " .. key, dynamic_workspace(d, true))

	-- Keep the old second- and third-monitor shortcuts as aliases.
	bind("CTRL + " .. key, hl.dsp.focus({ workspace = 20 + d }))
	bind("CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = 20 + d, follow = false }))
	bind(mod .. " + CTRL + " .. key, hl.dsp.focus({ workspace = 30 + d }))
	bind(mod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = 30 + d, follow = false }))
end

bind(mod .. " + PERIOD", hl.dsp.focus({ monitor = "+1" }))
bind(mod .. " + SHIFT + PERIOD", hl.dsp.window.move({ monitor = "+1", follow = true }))
bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

run("XF86AudioPrev", "mpc -q prev")
run("XF86AudioNext", "mpc -q next")
run("XF86AudioMute", "wpctl set-mute @DEFAULT_SINK@ toggle")
run("SHIFT + XF86AudioPrev", "mpc seek -5")
run("SHIFT + XF86AudioNext", "mpc seek +5")
run("SHIFT + XF86AudioPlay", "mpc toggle")
run("SHIFT + XF86AudioMute", "mpc toggle")

local repeating = { repeating = true }
run("SHIFT + XF86AudioRaiseVolume", "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1%+", repeating)
run("SHIFT + XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-", repeating)
run("XF86AudioRaiseVolume", "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+", repeating)
run("XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", repeating)
run("XF86MonBrightnessDown", "light -U 5", repeating)
run("XF86MonBrightnessUp", "light -A 5", repeating)
run("SHIFT + XF86MonBrightnessDown", "light -U 1", repeating)
run("SHIFT + XF86MonBrightnessUp", "light -A 1", repeating)
