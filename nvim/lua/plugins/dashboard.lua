return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Retro Styled Header
      dashboard.section.header.val = {
        [[                                                                    ]],
        [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗                ]],
        [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║                ]],
        [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║                ]],
        [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║                ]],
        [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║                ]],
        [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                ]],
        [[                                                                    ]],
        [[                -  T H E  R E T R O  E D I T O R  -                 ]],
        [[                                                                    ]],
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
        button("n", "󰝒  New File", ":ene <BAR> startinsert <CR>"),
        button("f", "󰈞  Find File", ":Telescope find_files <CR>"),
        button("r", "󰄉  Recent Files", ":Telescope oldfiles <CR>"),
        button("g", "󰱽  Find Text", ":Telescope live_grep <CR>"),
        button("c", "󰒓  Config", ":e $MYVIMRC <CR>"),
        button("l", "󰒲  Lazy", ":Lazy<CR>"),
        button("q", "󰅚  Quit", ":qa<CR>"),
      }

      -- Set a nice footer
      dashboard.section.footer.val = " 󰄛 Powered by Gemini "
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- Adjust spacing
      dashboard.config.opts.margin = 5
      alpha.setup(dashboard.opts)

      -- Define colors based on theme
      local theme = require("config.theme_selector").get_theme()
      if theme == "gruvbox" then
        vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#d3869b", bold = true }) -- Purple
        vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#ebdbb2" }) -- FG
        vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#83a598", bold = true }) -- Blue
        vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#b8bb26", italic = true }) -- Green
      else
        vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#cba6f7", bold = true }) -- Mauve (Purple)
        vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#cdd6f4" }) -- Text
        vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#89b4fa", bold = true }) -- Blue
        vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#a6e3a1", italic = true }) -- Green
      end
    end,
  },
}
