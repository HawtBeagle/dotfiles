return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { 
        "jdtls", 
        "vtsls",
        "eslint-lsp",
        "prettierd",
        "js-debug-adapter",
        "yamlls", 
        "stylua",
        "java-debug-adapter",
        "java-test",
      },
    },
  },

  -- Bridges Mason with lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "vtsls",
        "eslint",
        "yamlls",
      },
      automatic_installation = true,
    },
  },

  -- TypeScript Helpers
  { "yioneko/nvim-vtsls", dependencies = { "nvim-lspconfig" } },
  { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },

  -- LSP Config (Cleaned for Neovim 0.11+)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "yioneko/nvim-vtsls",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Helper to setup servers properly
      local setup_server = function(server, opts)
        opts.capabilities = capabilities
        -- Root detection: prefer project root, fallback to current working directory
        opts.root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git") or vim.loop.cwd
        
        if vim.lsp.config then
          vim.lsp.config(server, opts)
          vim.lsp.enable(server)
        else
          lspconfig[server].setup(opts)
        end
      end

      -- YAML setup
      setup_server("yamlls", {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
            },
          },
        },
      })

      -- TypeScript setup (vtsls)
      setup_server("vtsls", {
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        settings = {
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = { completeFunctionCalls = true },
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      })

      -- ESLint setup
      setup_server("eslint", {
        settings = { workingDirectory = { mode = "auto" } },
      })

      -- Global LSP keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local themes = require("telescope.themes")
          local builtin = require("telescope.builtin")
          local cursor_theme = { layout_config = { width = 0.8, height = 0.4 } }
          
          -- Essential Navigation
          vim.keymap.set("n", "gd", function()
            builtin.lsp_definitions(themes.get_cursor(cursor_theme))
          end, { buffer = bufnr, desc = "Go to Definition" })
          
          vim.keymap.set("n", "gi", function()
            builtin.lsp_implementations(themes.get_cursor(cursor_theme))
          end, { buffer = bufnr, desc = "Go to Implementation" })
          
          -- SMART SUPER JUMP (Implementation -> Interface)
          vim.keymap.set("n", "gh", function()
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "jdtls" then
              require('jdtls').super_implementation()
            else
              vim.lsp.buf.declaration()
            end
          end, { buffer = bufnr, desc = "Go to Super/Interface" })
          
          vim.keymap.set("n", "sr", function()
            builtin.lsp_references(themes.get_ivy({
              layout_config = { height = 0.4 },
              include_declaration = false,
            }))
          end, { buffer = bufnr, desc = "Show References (Fast)" })
          
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
