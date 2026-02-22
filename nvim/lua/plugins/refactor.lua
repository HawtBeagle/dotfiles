return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {}, -- This automatically calls require("inc-rename").setup({})
    config = function()
      require("inc-rename").setup()
      vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "Live Rename" })
    end,
  },
}
