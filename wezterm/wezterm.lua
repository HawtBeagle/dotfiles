-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- --- Theme Selector ---
local function get_theme()
  local home = os.getenv("HOME")
  local file = io.open(home .. "/Desktop/Personal/dotfiles/.theme_mode", "r")
  if file then
    local theme = file:read("*l")
    file:close()
    if theme then
      theme = theme:gsub("%s+", "")
    end
    return theme or "gruvbox"
  end
  return "gruvbox"
end

local theme = get_theme()

config.initial_cols = 120
config.initial_rows = 28
config.font_size = 16
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "JetBrains Mono Nerd Font",
  "JetBrainsMonoNF",
  "Hack Nerd Font",
})

-- Color Theme
if theme == "gruvbox" then
  config.color_scheme = 'Gruvbox Dark Medium'
  config.colors = { background = "#282828" }
else
  config.color_scheme = 'Catppuccin Mocha'
  config.colors = { background = "#1e1e2e" }
end

-- Smoother cursor animations
config.animation_fps = 120
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

config.window_decorations = "RESIZE"
config.enable_tab_bar = false

config.keys = {
  { key = '=', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },
  { key = 'k', mods = 'CMD', action = wezterm.action.SendString '\x0b' },
}

return config
