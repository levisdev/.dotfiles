local map = vim.keymap.set
local opts = { remap = false, silent = true }

vim.g.mapleader = " "

-- Disable default key map for man command
map("n", "<S-k>", "<Nop>", opts)
map("v", "<S-k>", "<Nop>", opts)

-- Select all
map("n", "<C-a>", "gg<S-v>G", opts)

-- Split window
map("n", "ss", ":sp<Cr>", opts)
map("n", "sv", ":vs<Cr>", opts)

-- Navigate window
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Resize window
map("n", "<C-Up>", ":resize -1<Cr>", opts)
map("n", "<C-Down>", ":resize +1<Cr>", opts)
map("n", "<C-Left>", ":vertical resize -1<Cr>", opts)
map("n", "<C-Right>", ":vertical resize +1<Cr>", opts)

-- Exit edit mode
map("i", "jk", "<Esc>", opts)
map("t", "jk", "<C-\\><C-n>", opts)

-- Indent line
map("n", "<", "<<", opts)
map("n", ">", ">>", opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Swap line
map("n", "<A-j>", ":m .+1<Cr>==", opts)
map("n", "<A-k>", ":m .-2<Cr>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<Cr>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<Cr>==gi", opts)
map("v", "<A-j>", ":m '>+1<Cr>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<Cr>gv=gv", opts)

-- Move the cursor based on physical lines, not the actual lines.
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
