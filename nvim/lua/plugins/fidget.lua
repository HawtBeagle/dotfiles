return {
  {
    "j-hui/fidget.nvim",
    opts = {
      -- Progress notifications
      progress = {
        display = {
          render_limit = 16, -- Max number of simultaneous progress messages
          done_ttl = 3,      -- How long to show "done" messages
          done_icon = "✔",
          progress_icon = { pattern = "dots", period = 1 },
        },
      },
      -- General notifications
      notification = {
        window = {
          winblend = 0, -- Fully transparent
        },
      },
    },
  },
}
