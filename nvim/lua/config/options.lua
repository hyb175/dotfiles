-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.autoformat = false
vim.g.root_spec = { "cwd" }
vim.g.lazyvim_picker = "fzf"
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = { trail = "·", tab = "→ " } -- Visual indicators
