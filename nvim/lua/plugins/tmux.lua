return {
  {
    "aserowy/tmux.nvim",
    config = function()
      local tmux = require("tmux")
      tmux.setup({
        navigation = {
          -- enable default keybindings (navigation)
          enable_default_keybindings = true,
          -- prevent cycle navigation
          cycle_navigation = false,
          -- persist zoom state when navigating
          persist_zoom = false,
        },
        resize = {
          -- disable default keybindings (resize)
          enable_default_keybindings = false,
        },
      })
      
      -- Explicitly set the keybindings to ensure they work inside Neovim
      vim.keymap.set('n', '<C-h>', tmux.move_left, { desc = "Move Left" })
      vim.keymap.set('n', '<C-j>', tmux.move_bottom, { desc = "Move Down" })
      vim.keymap.set('n', '<C-k>', tmux.move_top, { desc = "Move Up" })
      vim.keymap.set('n', '<C-l>', tmux.move_right, { desc = "Move Right" })
    end,
  },
}
