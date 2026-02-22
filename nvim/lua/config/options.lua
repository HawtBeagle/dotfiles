-- Basic Neovim Options
local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.updatetime = 250
opt.timeoutlen = 300

opt.clipboard = "unnamedplus"

opt.laststatus = 3 -- Global statusline
opt.showmode = false -- Don't show mode (already in statusline)
opt.cmdheight = 0 -- Hide command line when not in use

-- DISABLE THE TABLINE (removes [Scratch] labels at the top)
opt.showtabline = 0

-- GLOBAL WINFIXBUF KILLSWITCH
-- This forces all windows to be unlockable so Telescope never crashes
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  callback = function()
    vim.opt_local.winfixbuf = false
  end,
})

-- Map leader to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick escape
vim.keymap.set("i", "jk", "<Esc>", { desc = "Enter Normal Mode" })

-- IntelliJ-style Back/Forward navigation (Using Alt instead of Ctrl to avoid Esc conflict)
vim.keymap.set("n", "<M-[>", "<C-o>", { desc = "Navigate Back" })
vim.keymap.set("n", "<M-]>", "<C-i>", { desc = "Navigate Forward" })
