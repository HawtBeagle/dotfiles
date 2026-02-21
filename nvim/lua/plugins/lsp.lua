return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { "jdtls", "yamlls", "google-java-format", "stylua" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "yamlls" }, -- Only non-Java servers here
    },
  },
  -- LSP Config (Modern Neovim 0.11+ style)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Modern Neovim 0.11 API (Bypasses deprecated lspconfig framework)
      if vim.lsp.config then
        -- Configure YAML
        vim.lsp.config("yamlls", {
          capabilities = capabilities,
          settings = {
            yaml = {
              schemas = {
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
              },
            },
          },
        })
        vim.lsp.enable("yamlls")
      end

      -- Global LSP keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local themes = require("telescope.themes")
          local builtin = require("telescope.builtin")
          local cursor_theme = { layout_config = { width = 0.8, height = 0.4 } }
          
          -- Essential Navigation (IntelliJ Style Floating Popups)
          vim.keymap.set("n", "gd", function()
            builtin.lsp_definitions(themes.get_cursor(cursor_theme))
          end, { buffer = bufnr, desc = "Go to Definition" })
          
          vim.keymap.set("n", "gi", function()
            builtin.lsp_implementations(themes.get_cursor(cursor_theme))
          end, { buffer = bufnr, desc = "Go to Implementation" })
          
          vim.keymap.set("n", "gr", function()
            builtin.lsp_references(themes.get_cursor(cursor_theme))
          end, { buffer = bufnr, desc = "Show References" })
          
          vim.keymap.set("n", "gt", function()
            builtin.lsp_type_definitions(themes.get_cursor(cursor_theme))
          end, { buffer = bufnr, desc = "Go to Type Definition" })
          
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Hover Docs" })
          
          -- Actions
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
        end,
      })
    end,
  },
  -- JDTLS for advanced Java support
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  },
}
