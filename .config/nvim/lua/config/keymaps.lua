-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Exit edit mode
map("i", "jk", "<Esc>")
map("t", "jk", "<C-\\><C-n>")

-- Split window
map("n", "ss", ":sp<Cr>")
map("n", "sv", ":vs<Cr>")

-- Navigate window
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Indent line
map("n", "<", "<<")
map("n", ">", ">>")
