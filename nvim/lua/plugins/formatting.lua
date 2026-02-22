return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Use LSP formatting for Java to respect .editorconfig/IntelliJ settings
        java = { "lsp" }, 
        javascript = { { "prettierd", "prettier" } },
        json = { "jq" },
        yaml = { "prettier" },
      },
      -- Disable auto-format on save to prevent git noise
      format_on_save = false, 
    },
  },
}
