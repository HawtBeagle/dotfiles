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
          group_empty_dirs = true, -- group empty nested directories (great for Java/web)
          follow_current_file = {
            enabled = true, -- focus current file in the tree
            leave_dirs_open = true, -- keep dirs open when moving away
          },
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
          },
        },
        window = {
          position = "left",
          width = 40,
          mappings = {
            ["<cr>"] = "open", -- ensure enter opens in main window
            ["l"] = "open", 
            ["h"] = "close_node",
          },
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
