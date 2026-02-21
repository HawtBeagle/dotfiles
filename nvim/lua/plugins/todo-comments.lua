return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- Your configuration here, or leave empty to use defaults
    },
    config = function()
      local todo = require("todo-comments")
      todo.setup()
      
      -- Keybindings
      vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Find TODOs" })
      vim.keymap.set("n", "]t", todo.jump_next, { desc = "Next TODO" })
      vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Previous TODO" })
    end,
  },
}
