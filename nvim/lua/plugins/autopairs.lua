return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {
      check_ts = true, -- Use treesitter to check for pairs
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" },
        java = false, -- don't check treesitter on java
      },
    },
  },
}
