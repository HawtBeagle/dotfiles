local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Root detection
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if root_dir == "" then
  return
end

-- Capabilities for Completion and Navigation
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configuration
local config = {
  cmd = {
    "jdtls",
    "-configuration",
    vim.fn.stdpath("cache") .. "/jdtls/config",
    "-data",
    workspace_dir,
    "--jvm-arg=-Xms1g",
    "--jvm-arg=-Xmx2g",
    "--jvm-arg=-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
  },
  root_dir = root_dir,
  capabilities = capabilities,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
          "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
        },
      },
    },
  },
  init_options = {
    bundles = {
      vim.fn.glob(vim.fn.expand("~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"), 1),
    },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

-- Load Java Test Bundles
local test_bundles = vim.split(vim.fn.glob(vim.fn.expand("~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"), 1), "\n")
vim.list_extend(config.init_options.bundles, test_bundles)

-- Add Java-specific refactoring keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "jdtls" then
      local opts = { buffer = bufnr, silent = true }
      -- Extract Method
      vim.keymap.set("v", "<leader>rm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { buffer = bufnr, desc = "Extract Method" })
      -- Extract Variable
      vim.keymap.set("v", "<leader>rv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { buffer = bufnr, desc = "Extract Variable" })
      -- Extract Constant
      vim.keymap.set("v", "<leader>rc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { buffer = bufnr, desc = "Extract Constant" })
    end
  end,
})

-- Start JDTLS
jdtls.start_or_attach(config)
