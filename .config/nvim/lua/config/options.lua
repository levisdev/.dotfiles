-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.guifont = "JetBrainsMono Nerd Font:h14"
opt.pumblend = 0
opt.wildignore = { "*/node_modules/*" }
opt.iskeyword:append("-")

vim.cmd([[
    cnoreabbrev W w
    cnoreabbrev Q q
]])
