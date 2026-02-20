return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will be displayed even if other settings would normally hide them
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/folders
          },
        },
        window = {
          position = "left",
          width = 30,
          popup = {
            border = {
              style = "rounded",
              text_pos = "top",
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Explorer" })
    end,
  },
}
