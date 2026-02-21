-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28
config.font_size = 16
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "JetBrains Mono Nerd Font",
  "JetBrainsMonoNF",
  "Hack Nerd Font", -- Second fallback
})

-- Color Theme Matching tmux (Catppuccin Mocha base)
config.color_scheme = 'Catppuccin Mocha'

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

config.colors = {
  background = "#1e1e2e", -- Match tmux status bar background
}

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
-- config.disable_default_key_bindings = true

config.keys = {
  { key = '=', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },
}

-- Finally, return the configuration to wezterm:
return config
