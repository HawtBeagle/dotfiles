return {
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr })
        end,
      })
      -- Toggle the symbols outline
      vim.keymap.set("n", "<leader>s", "<cmd>AerialToggle! right<cr>", { desc = "Toggle Symbols Outline" })
    end,
  },
}
