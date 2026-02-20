return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(gs.next_hunk)
            return "<Ignore>"
          end, { expr = true, desc = "Next Change" })

          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(gs.prev_hunk)
            return "<Ignore>"
          end, { expr = true, desc = "Previous Change" })

          -- Actions
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Change" })
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
        end,
      })
    end,
  },
}
