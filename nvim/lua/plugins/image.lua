return {
  {
    "3rd/image.nvim",
    config = function()
      require("image").setup({
        -- Auto-detect backend
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki", "leetcode" },
          },
        },
        max_height_window_percentage = 50,
        hierarchical_path = true,
        window_overlap_clear_enabled = true,
      })
    end,
  },
}
