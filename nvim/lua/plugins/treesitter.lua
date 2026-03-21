return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "java", "typescript", "tsx", "javascript", "html", "css", "xml", "yaml", "json", "properties", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "go", "gomod" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
}
