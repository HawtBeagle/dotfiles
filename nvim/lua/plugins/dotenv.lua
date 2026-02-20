return {
  {
    "ellisonleao/dotenv.nvim",
    config = function()
      require("dotenv").setup({
        enable_on_load = true, -- Load .env automatically if it exists
        verbose = false, -- Don't show a message every time
      })
      
      -- Keybinding to manually reload .env
      vim.keymap.set("n", "<leader>de", ":Dotenv<CR>", { desc = "Load .env file" })
    end,
  },
}
