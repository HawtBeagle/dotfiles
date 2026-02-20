return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "filename", "branch" },
          lualine_c = {
            "%=", -- center push
          },
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
        },
      })
    end,
  },
}
