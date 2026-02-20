return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- Matches your blurred WezTerm
        show_end_of_buffer = false, -- hide ~ at end of buffer
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = true,
          neotree = true,
          telescope = {
            enabled = true,
            style = "nvchad", -- a very clean transparent style
          },
          which_key = true,
          alpha = true,
        },
        custom_highlights = function(colors)
          return {
            -- Force all floating windows and borders to be transparent
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none", fg = colors.blue },
            Pmenu = { bg = "none" }, -- Completion menu
            PmenuSel = { bg = colors.surface0, fg = "none" }, -- Completion selection
            TelescopeNormal = { bg = "none" },
            TelescopeBorder = { bg = "none" },
            NeoTreeNormal = { bg = "none" },
            NeoTreeNormalNC = { bg = "none" },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
