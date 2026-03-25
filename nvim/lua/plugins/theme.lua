local theme = require("config.theme_selector").get_theme()

return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    enabled = (theme == "gruvbox"),
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        transparent_mode = true,
        overrides = {
          -- Dim unused code like IntelliJ
          DiagnosticUnnecessary = { fg = "#a89984", italic = true },
          -- Exhaustive semantic overrides for unused code
          ["@lsp.mod.unused"] = { link = "DiagnosticUnnecessary" },
          ["@lsp.type.import"] = { link = "DiagnosticUnnecessary" },
          ["@lsp.type.keyword"] = { link = "DiagnosticUnnecessary" }, -- Only applied when modified by 'unused'
          
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none", fg = "#83a598" },
          Pmenu = { bg = "none" },
          PmenuSel = { bg = "#3c3836", fg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopeBorder = { bg = "none" },
          NeoTreeNormal = { bg = "none" },
          NeoTreeNormalNC = { bg = "none" },
        },
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = (theme == "catppuccin"),
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          cmp = true, gitsigns = true, nvimtree = true, treesitter = true,
          notify = true, mini = true, neotree = true, telescope = { enabled = true, style = "nvchad" },
          which_key = true, alpha = true,
        },
        custom_highlights = function(colors)
          return {
            -- Dim unused code like IntelliJ
            DiagnosticUnnecessary = { fg = colors.overlay0, italic = true },
            -- Exhaustive semantic overrides for unused code
            ["@lsp.mod.unused"] = { link = "DiagnosticUnnecessary" },
            ["@lsp.type.import"] = { link = "DiagnosticUnnecessary" },

            NormalFloat = { bg = "none" }, FloatBorder = { bg = "none", fg = colors.blue },
            Pmenu = { bg = "none" }, PmenuSel = { bg = colors.surface0, fg = "none" },
            TelescopeNormal = { bg = "none" }, TelescopeBorder = { bg = "none" },
            NeoTreeNormal = { bg = "none" }, NeoTreeNormalNC = { bg = "none" },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
