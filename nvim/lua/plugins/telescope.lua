return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      local telescope = require("telescope")
      local themes = require("telescope.themes")
      
      -- Custom path shortening function
      local function shorten_path(path)
        local parts = {}
        for part in string.gmatch(path, "([^/]+)") do
          table.insert(parts, part)
        end
        if #parts <= 4 then return path end
        return parts[1] .. "/.../" .. parts[#parts-2] .. "/" .. parts[#parts-1] .. "/" .. parts[#parts]
      end

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.85,
            height = 0.80,
          },
          sorting_strategy = "ascending",
          path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            return string.format("%s (%s)", tail, shorten_path(path))
          end,
          borderchars = {
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })
      
      -- Load the fzf extension
      telescope.load_extension('fzf')
      
      local builtin = require("telescope.builtin")
      
      -- IntelliJ "Search Everywhere" (leader leader)
      vim.keymap.set("n", "<leader><leader>", function()
        builtin.find_files(themes.get_dropdown({
          previewer = false,
          layout_config = { width = 0.6, height = 0.4 },
          prompt_title = "Search Everywhere",
        }))
      end, { desc = "Search Everywhere (IntelliJ Style)" })

      -- Standard pickers with top-prompt dropdown
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files(themes.get_dropdown({ previewer = false }))
      end, { desc = "Find Files" })
      
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers(themes.get_dropdown({ previewer = false }))
      end, { desc = "Buffers" })
    end,
  },
}
