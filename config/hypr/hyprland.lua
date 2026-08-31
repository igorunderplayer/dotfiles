local colors = require("themes.rose-pine")

local terminal = "footclient"
local menu = "iumenu -c ~/.config/iumenu/config.toml"
local fileManager = "thunar"

hl.monitor({
	output = "eDP-1",
	scale = 1,
	position = "0x0",
	mode = "1920x1080@60",
})

hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")
hl.env("XCURSOR_SIZE", 24)

hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", 24)

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 4,
		border_size = 4,

		resize_on_border = false,
		allow_tearing = false,

		layout = "dwindle",

		col = {
			active_border = colors.love,
			inactive_border = colors.surface2,
		},
	},

	decoration = {
		rounding = 12,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
		},

		blur = {
			enabled = true,
			size = 8,
			passes = 1,

			vibrancy = 0.1696,
		},
	},

	-- TODO:
	--animations = {
	--  enabled = true,
	--}

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = true,
		disable_hyprland_logo = true,
	},

	input = {
		kb_layout = "br",
		follow_mouse = true,
		sensitivity = 0,
		accel_profile = "flat",
		force_no_accel = true,
		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("wlogout"))
hl.bind("SUPER + M", hl.dsp.exit()) -- TODO: move to hyprshutdown
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + D", hl.dsp.exec_cmd(menu .. " --toggle"))

local directions = { "left", "right", "up", "down" }

for i, direction in ipairs(directions) do
	hl.bind(
		"SUPER + " .. direction,
		hl.dsp.focus({
			direction = direction,
		})
	)

	hl.bind(
		"SUPER + SHIFT + " .. direction,
		hl.dsp.window.move({
			direction = direction,
		})
	)
end

for i = 1, 10 do
	local key = (i >= 10) and 0 or i
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
end

for i = 1, 10 do
	local key = (i >= 10) and 0 or i
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Media buttons
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Bright conytol
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"))

hl.window_rule({
	match = {
		class = "zen|firefox",
	},
	opacity = 0.95,
})

hl.layer_rule({
	blur = true,
	ignore_alpha = false,
	match = {
		namespace = "swaync-control-center",
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd(terminal)
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("foot --server")
	hl.exec_cmd(menu .. " --server")
end)
