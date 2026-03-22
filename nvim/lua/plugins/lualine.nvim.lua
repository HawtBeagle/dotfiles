return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local theme = require("config.theme_selector").get_theme()
      require("lualine").setup({
        options = {
          theme = theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, padding = { left = 0, right = 2 } } },
          lualine_b = { "filename", "branch" },
          lualine_c = { "%=" },
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = { { "location", separator = { right = "" }, padding = { left = 2, right = 0 } } },
        },
      })
    end,
  },
}
