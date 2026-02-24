-- nvim entry point
require("config.options")
require("config.lazy")

-- Suppress harmless LSP position encoding warning
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match("position_encoding") then
    return
  end
  notify(msg, ...)
end
