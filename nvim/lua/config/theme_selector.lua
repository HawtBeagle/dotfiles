local M = {}

function M.get_theme()
  local home = os.getenv("HOME")
  local file = io.open(home .. "/Desktop/Personal/dotfiles/.theme_mode", "r")
  if file then
    local theme = file:read("*l")
    file:close()
    return theme or "gruvbox"
  end
  return "gruvbox"
end

return M
