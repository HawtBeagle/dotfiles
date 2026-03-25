return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { 
        "jdtls", 
        "vscode-spring-boot-tools",
        "vtsls",
        "eslint-lsp",
        "prettierd",
        "js-debug-adapter",
        "yamlls", 
        "stylua",
        "java-debug-adapter",
        "java-test",
        "gopls",
        "delve",
      },
    },
  },

  -- Bridges Mason with lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
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
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
      vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
      
      -- Initialize Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "vtsls", "eslint", "yamlls", "gopls", "sts4" },
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Helper for Native Neovim 0.11+ setup
      local function setup(server, root_markers, opts)
        opts = opts or {}
        opts.capabilities = vim.tbl_deep_extend("force", capabilities, opts.capabilities or {})
        opts.root_markers = root_markers
        
        -- Native configuration
        vim.lsp.config(server, opts)
        vim.lsp.enable(server)
      end

      -- Setup gopls
      setup("gopls", { "go.mod", ".git" }, {
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      -- Setup vtsls (TypeScript)
      setup("vtsls", { "package.json", "tsconfig.json", "jsconfig.json", ".git" }, {
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

      -- Setup eslint
      setup("eslint", { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json", ".git" }, {
        settings = { workingDirectory = { mode = "auto" } },
      })

      -- Setup yamlls
      setup("yamlls", { ".git" }, {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
            },
          },
        },
      })

      -- Setup yamlls
-- ... existing code ...

      -- Custom Diagnostic Handler to dim entire line for unused imports
      local original_publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]
      vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
        if result and result.diagnostics then
          for _, diagnostic in ipairs(result.diagnostics) do
            -- Look for "unnecessary" tag (unused code)
            if diagnostic.tags and vim.tbl_contains(diagnostic.tags, 1) then
              -- Expand diagnostic range to the start of the line
              diagnostic.range.start.character = 0
            end
          end
        end
        original_publish_diagnostics(_, result, ctx, config)
      end

      -- Setup sts4 (Spring Boot Tools)
      setup("sts4", { "pom.xml", "build.gradle", "build.gradle.kts", ".git" })

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
          
          vim.keymap.set("n", "sr", function()
            builtin.lsp_references(vim.tbl_extend("force", themes.get_cursor(cursor_theme), {
              include_declaration = false,
            }))
          end, { buffer = bufnr, desc = "Show References" })
          
          vim.keymap.set("n", "gt", function()
            builtin.lsp_type_definitions(themes.get_cursor(cursor_theme))
          end, { buffer = bufnr, desc = "Go to Type Definition" })

          -- SMART SUPER JUMP (Implementation -> Interface)
          vim.keymap.set("n", "gh", function()
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "jdtls" then
              require('jdtls').super_implementation()
            else
              vim.lsp.buf.declaration()
            end
          end, { buffer = bufnr, desc = "Go to Super/Interface" })
          
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Hover Docs" })
          
          -- Diagnostics (Error/Warning info)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show Line Diagnostics" })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous Diagnostic" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next Diagnostic" })

          -- Actions
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })

          -- INLAY HINTS TOGGLE (Fix for Neovim 0.11 "Invalid col" crash)
          if vim.lsp.inlay_hint then
            -- Disable by default for stability (optional, remove next line to keep enabled)
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            
            vim.keymap.set("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
              local status = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) and "Enabled" or "Disabled"
              vim.notify("Inlay Hints " .. status)
            end, { buffer = bufnr, desc = "Toggle Inlay Hints" })
          end
        end,
      })

      -- AUTO-START JDTLS on Project Open
      -- Detects Java markers and triggers ftplugin/java.lua
      vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
        callback = function()
          local markers = { "pom.xml", "build.gradle", "build.gradle.kts" }
          for _, marker in ipairs(markers) do
            if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. marker) == 1 then
              -- Temporarily set filetype to java to trigger jdtls
              vim.cmd("silent! set filetype=java")
              -- Do not reset filetype immediately, let jdtls start
              vim.defer_fn(function()
                -- If we are still in a directory (like neo-tree or alpha), 
                -- reset the filetype so we don't get java syntax on a dashboard
                local buftype = vim.bo.buftype
                local filetype = vim.bo.filetype
                if buftype == "nofile" or filetype == "alpha" then
                  vim.cmd("silent! set filetype=")
                end
              end, 500)
              break
            end
          end
        end,
      })
    end,
  },
  -- JDTLS for advanced Java support
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  },

  -- Spring Boot specialized support
  {
    "JavaHello/spring-boot.nvim",
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
    opts = {},
  },
}
