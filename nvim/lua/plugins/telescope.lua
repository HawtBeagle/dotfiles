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
      local actions = require("telescope.actions")
      
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
            width = 0.90,
            height = 0.80,
          },
          sorting_strategy = "ascending",
          tiebreak = function(current_entry, existing_entry, _)
            return current_entry.index < existing_entry.index
          end,
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
      
      telescope.load_extension('fzf')
      local builtin = require("telescope.builtin")
      
      -- IntelliJ "Search Everywhere"
      vim.keymap.set("n", "<leader><leader>", function()
        builtin.find_files(themes.get_dropdown({
          previewer = false,
          layout_config = { width = 0.6, height = 0.4 },
        }))
      end)

      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<leader>fb", builtin.buffers)
    end,
  },
}
