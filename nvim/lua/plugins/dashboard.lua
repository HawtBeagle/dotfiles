return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- New Stylized Header
      dashboard.section.header.val = {
        [[                                                           ]],
        [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗       ]],
        [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║       ]],
        [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║       ]],
        [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║       ]],
        [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║       ]],
        [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝       ]],
        [[                                                           ]],
      }
      dashboard.section.header.opts.hl = "AlphaHeader"

      -- Custom button design
      local function button(sc, txt, keybind)
        local b = dashboard.button(sc, txt, keybind)
        b.opts.hl = "AlphaButton"
        b.opts.hl_shortcut = "AlphaShortcut"
        return b
      end

      dashboard.section.buttons.val = {
        button("f", "󰈞  Find File", ":Telescope find_files <CR>"),
        button("r", "󰄉  Recent Files", ":Telescope oldfiles <CR>"),
        button("g", "󰱽  Find Text", ":Telescope live_grep <CR>"),
        button("c", "󰒓  Config", ":e $MYVIMRC <CR>"),
        button("l", "󰒲  Lazy", ":Lazy<CR>"),
        button("q", "󰅚  Quit", ":qa<CR>"),
      }

      -- Set a nice footer
      dashboard.section.footer.val = "  Blazing Fast Neovim "
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- Adjust spacing
      dashboard.config.opts.margin = 5
      alpha.setup(dashboard.opts)

      -- Define colors matching Catppuccin Mocha
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#cba6f7" }) -- Mauve (Purple)
      vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#cdd6f4" }) -- Text
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#89b4fa", bold = true }) -- Blue
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#a6e3a1", italic = true }) -- Green
    end,
  },
}
