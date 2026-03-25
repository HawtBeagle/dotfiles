return {
  {
    "jkeresman01/spring-initializr.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    lazy = false, -- Load immediately to ensure the command is available
    config = function()
      require("spring-initializr").setup({
        default_options = {
          type = "maven-project",
          javaVersion = "21",
        },
      })

      -- Keybinding to trigger the generator
      -- Works from anywhere (Dashboard, Empty Buffer, etc.)
      vim.keymap.set("n", "<leader>sn", "<cmd>SpringGenerateProject<CR>", { desc = "Spring Boot: New Project" })
    end,
  },
}
