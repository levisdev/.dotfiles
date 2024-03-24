-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Exit edit mode
map("i", "jk", "<Esc>")

-- Split window
map("n", "ss", ":sp<Cr>")
map("n", "sv", ":vs<Cr>")

-- Indent line
map("n", "<", "<<")
map("n", ">", ">>")
