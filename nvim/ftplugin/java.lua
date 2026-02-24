local jdtls = require("jdtls")

-- MULTI-MODULE ROOT DETECTION
local root_markers = { "settings.gradle", "settings.gradle.kts", "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if root_dir == "" or root_dir == nil then
  root_dir = require("jdtls.setup").find_root({ "build.gradle", "pom.xml" })
end

if root_dir == "" or root_dir == nil then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.workspace = {
  configuration = true,
  workspaceFolders = true,
  didChangeConfiguration = { dynamicRegistration = true },
  didChangeWatchedFiles = { dynamicRegistration = false },
}

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Configuration
local config = {
  cmd = {
    vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
    "-configuration",
    vim.fn.stdpath("cache") .. "/jdtls/config",
    "-data",
    workspace_dir,
    -- ULTRA PERFORMANCE: 8GB RAM + Optimized JVM Flags
    "--jvm-arg=-Xms1g",
    "--jvm-arg=-Xmx8g",
    "--jvm-arg=-XX:+UseG1GC",
    "--jvm-arg=-XX:+ParallelRefProcEnabled",
    "--jvm-arg=-XX:ParallelGCThreads=4",
    "--jvm-arg=-XX:ConcGCThreads=2",
    "--jvm-arg=-XX:+UnlockExperimentalVMOptions",
    "--jvm-arg=-XX:+UseStringDeduplication",
    "--jvm-arg=-XX:+OptimizeStringConcat",
    "--jvm-arg=-XX:MaxGCPauseMillis=100",
    "--jvm-arg=-XX:ReservedCodeCacheSize=512m",
    "--jvm-arg=-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
  },
  root_dir = root_dir,
  capabilities = capabilities,
  settings = {
    java = {
      project = {
        importOnFirstTimeStartup = "automatic",
        resourceFilters = { "node_modules", ".git", "target", "build" },
      },
      configuration = {
        updateBuildConfiguration = "automatic",
      },
      import = {
        gradle = { 
          enabled = true,
          wrapper = { enabled = true },
        },
        maven = { enabled = true },
      },
      -- PERFORMANCE: Optimized Search & Completion
      references = {
        includeDecompiledSources = true,
      },
      completion = {
        maxResults = 20, -- Faster menu response
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
          "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
        },
      },
      autobuild = { enabled = true },
      saveActions = { organizeImports = true },
      signatureHelp = { enabled = false },
      contentProvider = { preferred = "fernflower" },
    },
  },
  init_options = {
    bundles = {
      vim.fn.glob(vim.fn.expand("~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"), 1),
    },
    extendedClientCapabilities = extendedClientCapabilities,
  },
}

local test_bundles = vim.split(vim.fn.glob(vim.fn.expand("~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"), 1), "\n")
vim.list_extend(config.init_options.bundles, test_bundles)

-- Add Java-specific refactoring keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "jdtls" then
      local opts = { buffer = bufnr, silent = true }
      -- SILENCE THE UI: Performance win
      client.server_capabilities.semanticTokensProvider = nil
      
      vim.keymap.set("n", "<leader>ju", jdtls.update_project_config, { buffer = bufnr, desc = "Update Project Config" })
      vim.keymap.set("v", "<leader>rm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { buffer = bufnr, desc = "Extract Method" })
      vim.keymap.set("v", "<leader>rv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { buffer = bufnr, desc = "Extract Variable" })
      vim.keymap.set("v", "<leader>rc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { buffer = bufnr, desc = "Extract Constant" })
    end
  end,
})

-- Start JDTLS
jdtls.start_or_attach(config)
