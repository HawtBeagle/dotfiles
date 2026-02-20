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
  capabilities = capabilities, -- ADDED THIS
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
    bundles = {},
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

-- Start JDTLS
jdtls.start_or_attach(config)
