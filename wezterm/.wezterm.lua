-- Reference: https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Send the escape sequence Claude Code expects for Shift+Enter (multi-line input)
config.keys = {
	{ key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1b[13;2u") },
}

config.color_scheme = "Catppuccin Mocha"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("DankMono Nerd Font")
config.font_size = 16.0

return config
