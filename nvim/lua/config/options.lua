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

-- Map leader to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick escape
vim.keymap.set("i", "jk", "<Esc>", { desc = "Enter Normal Mode" })

-- IntelliJ-style Back/Forward navigation
vim.keymap.set("n", "<C-[>", "<C-o>", { desc = "Navigate Back" })
vim.keymap.set("n", "<C-]>", "<C-i>", { desc = "Navigate Forward" })
