vim.g.mapleader = " "

function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Disable default key map for man command
map({ "n", "v" }, "<S-k>", "<Nop>")

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Split window
map("n", "ss", ":sp<Cr>")
map("n", "sv", ":vs<Cr>")

-- Navigate window
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Resize window
map("n", "<C-Up>", ":resize -1<Cr>")
map("n", "<C-Down>", ":resize +1<Cr>")
map("n", "<C-Left>", ":vertical resize -1<Cr>")
map("n", "<C-Right>", ":vertical resize +1<Cr>")

-- Exit edit mode
map("i", "jk", "<Esc>")
map("t", "jk", "<C-\\><C-n>")

-- Indent line
map("n", "<", "<<")
map("n", ">", ">>")
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Swap line
map("n", "<A-j>", ":m .+1<Cr>==")
map("n", "<A-k>", ":m .-2<Cr>==")
map("i", "<A-j>", "<Esc>:m .+1<Cr>==gi")
map("i", "<A-k>", "<Esc>:m .-2<Cr>==gi")
map("v", "<A-j>", ":m '>+1<Cr>gv=gv")
map("v", "<A-k>", ":m '<-2<Cr>gv=gv")

-- Move the cursor based on physical lines, not the actual lines.
map("n", "j", "gj")
map("n", "k", "gk")
