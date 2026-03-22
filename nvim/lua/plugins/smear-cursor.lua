local theme = require("config.theme_selector").get_theme()
local cursor_color = (theme == "gruvbox") and "#fabd2f" or "#cba6f7"

return {
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      cursor_color = cursor_color,
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      stiffness = 0.6,
      trailing_stiffness = 0.3,
      distance_stop_animating = 0.1,
    },
  },
}
