return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- IDE features
        lsp_cfg = false, -- handled in lsp.lua
        lsp_gofumpt = true,
        dap_debug = true,
        dap_debug_gui = true,
        test_runner = 'go',
        run_in_floaterm = true,
        
        -- Aesthetics
        icons = {
          breakpoint = '',
          currentpos = '',
        },
      })

      -- Keybindings (GoLand style)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", { desc = "Run all tests" })
          vim.keymap.set("n", "<leader>gf", "<cmd>GoTestFunc<cr>", { desc = "Run current test function" })
          vim.keymap.set("n", "<leader>gi", "<cmd>GoImport<cr>", { desc = "Fix imports" })
          vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<cr>", { desc = "Run current file" })
          vim.keymap.set("n", "<leader>gd", "<cmd>GoDebug<cr>", { desc = "Start debugger (Delve)" })
          vim.keymap.set("n", "<leader>gl", "<cmd>GoLint<cr>", { desc = "Run linter" })
        end,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()'
  },
}
