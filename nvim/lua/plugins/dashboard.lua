return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local utils = require("alpha.utils")

      -- The Exact 3D Logo from your source
      local logo = [[
                                          
       ███████████           █████      ██
      ███████████             █████ 
      ████████████████ ███████████ ███   ███████
     ████████████████ ████████████ █████ ██████████████
    █████████████████████████████ █████ █████ ████ █████
  ██████████████████████████████████ █████ █████ ████ █████
 ██████  ███ █████████████████ ████ █████ █████ ████ ██████
 ██████   ██  ███████████████   ██ █████████████████
      ]]

      local header_val = vim.split(logo, "\n")
      
      -- Define the highlight segments for the stripes
      local header_hl = {
        { { "AlphaHeader0_0", 46, 48 } }, -- Line 1
        {                                 -- Line 2
          { "AlphaHeader1_0", 7,  22 },
          { "AlphaHeader1_1", 33, 40 },
          { "AlphaHeader1_2", 40, 50 }
        },
        { -- Line 3
          { "AlphaHeader2_0", 6,  21 },
          { "AlphaHeader2_1", 33, 45 },
        },
        { -- Line 4
          { "AlphaHeader3_0", 6,  19 },
          { "AlphaHeader3_1", 19, 20 },
          { "AlphaHeader3_2", 20, 35 },
          { "AlphaHeader3_3", 35, 45 },
          { "AlphaHeader3_4", 45, 90 },
        },
        { -- Line 5
          { "AlphaHeader4_0", 5,  18 },
          { "AlphaHeader4_1", 18, 36 },
          { "AlphaHeader4_2", 36, 45 },
          { "AlphaHeader4_3", 45, 90 }
        },
        { -- Line 6
          { "AlphaHeader5_0", 4,  17 },
          { "AlphaHeader5_1", 17, 24 },
          { "AlphaHeader5_2", 24, 28 },
          { "AlphaHeader5_3", 28, 37 },
          { "AlphaHeader5_4", 37, 46 },
          { "AlphaHeader5_5", 46, 90 },
        },
        { -- Line 7
          { "AlphaHeader6_0", 2,  17 },
          { "AlphaHeader6_1", 17, 38 },
          { "AlphaHeader6_2", 38, 45 },
          { "AlphaHeader6_3", 46, 90 },
        },
        { -- Line 8
          { "AlphaHeader7_0", 1,  17 },
          { "AlphaHeader7_1", 17, 38 },
          { "AlphaHeader7_2", 38, 45 },
          { "AlphaHeader7_3", 46, 90 },
        },
        { -- Line 9
          { "AlphaHeader8_0", 1,  37 },
          { "AlphaHeader8_1", 37, 91 },
        },
      }

      -- Convert character-based hl to byte-based for multibyte characters
      header_hl = utils.charhl_to_bytehl(header_hl, header_val, false)
      dashboard.section.header.val = header_val
      dashboard.section.header.opts.hl = header_hl

      -- Custom button design
      local function button(sc, txt, keybind)
        local b = dashboard.button(sc, txt, keybind)
        b.opts.hl = "AlphaButton"
        b.opts.hl_shortcut = "AlphaShortcut"
        return b
      end

      dashboard.section.buttons.val = {
        button("n", "󰝒  New File", ":ene <BAR> startinsert <CR>"),
        button("f", "󰈞  Find File", ":Telescope find_files <CR>"),
        button("r", "󰄉  Recent Files", ":Telescope oldfiles <CR>"),
        button("g", "󰱽  Find Text", ":Telescope live_grep <CR>"),
        button("c", "󰒓  Config", ":e $MYVIMRC <CR>"),
        button("l", "󰒲  Lazy", ":Lazy<CR>"),
        button("q", "󰅚  Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = " 󰄛 Powered by Gemini "
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.config.opts.margin = 5

      -- Theme-aware colors for the stripes
      local theme = require("config.theme_selector").get_theme()
      if theme == "gruvbox" then
        vim.api.nvim_set_hl(0, "AlphaHeader0_0", { fg = "#8ec07c" }) -- Aqua
        vim.api.nvim_set_hl(0, "AlphaHeader1_0", { fg = "#fe8019" }) -- Orange
        vim.api.nvim_set_hl(0, "AlphaHeader1_1", { fg = "#b8bb26" }) -- Green
        vim.api.nvim_set_hl(0, "AlphaHeader1_2", { fg = "#8ec07c" })
        vim.api.nvim_set_hl(0, "AlphaHeader2_0", { fg = "#fe8019" })
        vim.api.nvim_set_hl(0, "AlphaHeader2_1", { fg = "#b8bb26" })
        vim.api.nvim_set_hl(0, "AlphaHeader3_0", { fg = "#fe8019" })
        vim.api.nvim_set_hl(0, "AlphaHeader3_1", { fg = "#fabd2f" }) -- Yellow
        vim.api.nvim_set_hl(0, "AlphaHeader3_2", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "AlphaHeader3_3", { fg = "#b8bb26" })
        vim.api.nvim_set_hl(0, "AlphaHeader3_4", { fg = "#8ec07c" })
        vim.api.nvim_set_hl(0, "AlphaHeader4_0", { fg = "#fe8019" })
        vim.api.nvim_set_hl(0, "AlphaHeader4_1", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "AlphaHeader4_2", { fg = "#b8bb26" })
        vim.api.nvim_set_hl(0, "AlphaHeader4_3", { fg = "#8ec07c" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_0", { fg = "#fe8019" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_1", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_2", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_3", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_4", { fg = "#b8bb26" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_5", { fg = "#8ec07c" })
        vim.api.nvim_set_hl(0, "AlphaHeader6_0", { fg = "#fe8019" })
        vim.api.nvim_set_hl(0, "AlphaHeader6_1", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "AlphaHeader6_2", { fg = "#b8bb26" })
        vim.api.nvim_set_hl(0, "AlphaHeader6_3", { fg = "#8ec07c" })
        vim.api.nvim_set_hl(0, "AlphaHeader7_0", { fg = "#fe8019" })
        vim.api.nvim_set_hl(0, "AlphaHeader7_1", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "AlphaHeader7_2", { fg = "#b8bb26" })
        vim.api.nvim_set_hl(0, "AlphaHeader7_3", { fg = "#8ec07c" })
        vim.api.nvim_set_hl(0, "AlphaHeader8_0", { fg = "#fabd2f" })
        vim.api.nvim_set_hl(0, "AlphaHeader8_1", { fg = "#b8bb26" })

        vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#ebdbb2" })
        vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#83a598", bold = true })
        vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#b8bb26", italic = true })
      else
        -- Catppuccin Colored Stripes
        vim.api.nvim_set_hl(0, "AlphaHeader0_0", { fg = "#94e2d5" }) -- Teal
        vim.api.nvim_set_hl(0, "AlphaHeader1_0", { fg = "#f38ba8" }) -- Red
        vim.api.nvim_set_hl(0, "AlphaHeader1_1", { fg = "#a6e3a1" }) -- Green
        vim.api.nvim_set_hl(0, "AlphaHeader1_2", { fg = "#94e2d5" })
        vim.api.nvim_set_hl(0, "AlphaHeader2_0", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "AlphaHeader2_1", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "AlphaHeader3_0", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "AlphaHeader3_1", { fg = "#f9e2af" }) -- Yellow
        vim.api.nvim_set_hl(0, "AlphaHeader3_2", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "AlphaHeader3_3", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "AlphaHeader3_4", { fg = "#94e2d5" })
        vim.api.nvim_set_hl(0, "AlphaHeader4_0", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "AlphaHeader4_1", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "AlphaHeader4_2", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "AlphaHeader4_3", { fg = "#94e2d5" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_0", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_1", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_2", { fg = "#fab387" }) -- Peach
        vim.api.nvim_set_hl(0, "AlphaHeader5_3", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_4", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "AlphaHeader5_5", { fg = "#94e2d5" })
        vim.api.nvim_set_hl(0, "AlphaHeader6_0", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "AlphaHeader6_1", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "AlphaHeader6_2", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "AlphaHeader6_3", { fg = "#94e2d5" })
        vim.api.nvim_set_hl(0, "AlphaHeader7_0", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "AlphaHeader7_1", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "AlphaHeader7_2", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "AlphaHeader7_3", { fg = "#94e2d5" })
        vim.api.nvim_set_hl(0, "AlphaHeader8_0", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "AlphaHeader8_1", { fg = "#a6e3a1" })

        vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#cdd6f4" })
        vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#89b4fa", bold = true })
        vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#a6e3a1", italic = true })
      end

      alpha.setup(dashboard.opts)
    end,
  },
}
