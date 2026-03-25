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
  didChangeWatchedFiles = { dynamicRegistration = true, relativePatternSupport = true },
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
    -- ULTRA PERFORMANCE: 8GB RAM + Specialized Library Search
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
        -- Smart filtering: ignore heavy non-source folders
        resourceFilters = { "node_modules", ".git", "target", "build", ".metadata" },
      },
      configuration = {
        updateBuildConfiguration = "automatic",
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/Users/ganti/licious/Library/Java/JavaVirtualMachines/corretto-11.0.30/Contents/Home",
          },
          {
            name = "JavaSE-17",
            path = "/opt/homebrew/Cellar/openjdk@17/17.0.18/libexec/openjdk.jdk/Contents/Home",
          },
          {
            name = "JavaSE-21",
            path = "/Users/ganti/licious/Library/Java/JavaVirtualMachines/ms-21.0.9/Contents/Home",
          },
          {
            name = "JavaSE-24",
            path = "/Users/ganti/licious/Library/Java/JavaVirtualMachines/openjdk-24.0.2+12-54/Contents/Home",
            default = true,
          },
        },
      },
      import = {
        gradle = { 
          enabled = true,
          wrapper = { enabled = true },
        },
        maven = { enabled = true },
      },
      -- BALANCED SEARCH SCOPE
      references = {
        includeDecompiledSources = true, -- BACK ON: for library methods
        includeAccessors = true,         -- ENABLED: helps find Spring bean usage
      },
      implementations = {
        includeDecompiledSources = true,
      },
      referencesCodeLens = { enabled = true },
      implementationsCodeLens = { enabled = true },
      completion = {
        maxResults = 20,
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
          "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
        },
      },
      autobuild = { enabled = true },
      saveActions = { organizeImports = false },
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

-- Add test bundles
local test_bundles = vim.split(vim.fn.glob(vim.fn.expand("~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"), 1), "\n")
vim.list_extend(config.init_options.bundles, test_bundles)

-- Add Spring Boot bundles if plugin is available
local status_ok, spring_boot = pcall(require, "spring_boot")
if status_ok then
  vim.list_extend(config.init_options.bundles, spring_boot.java_extensions())
end

-- Add Java-specific refactoring keybindings and CodeLens refresh
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "jdtls" then
      local opts = { buffer = bufnr, silent = true }
      
      vim.keymap.set("n", "<leader>ju", jdtls.update_project_config, { buffer = bufnr, desc = "Update Project Config" })
      vim.keymap.set("v", "<leader>rm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { buffer = bufnr, desc = "Extract Method" })
      vim.keymap.set("v", "<leader>rv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { buffer = bufnr, desc = "Extract Variable" })
      vim.keymap.set("v", "<leader>rc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { buffer = bufnr, desc = "Extract Constant" })

      -- Auto-refresh CodeLens
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end
  end,
})

-- Start JDTLS
jdtls.start_or_attach(config)
