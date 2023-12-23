local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.number = true
opt.wrap = false
opt.laststatus = 3
opt.showmode = false
opt.signcolumn = "yes"
opt.termguicolors = true
opt.guifont = "FiraCode Nerd Font:h16"

opt.ignorecase = true
opt.smartcase = true

opt.splitbelow = true
opt.splitright = true

opt.updatetime = 100
opt.timeoutlen = 300

opt.foldlevel = 99
opt.foldenable = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.lazyredraw = true
opt.pumheight = 10
opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.wildignore = { "*/node_modules/*" }
opt.fillchars = { eob = " " }
opt.iskeyword:append("-")
opt.shortmess:append("sI")
opt.formatoptions:remove("ro")

vim.cmd([[
    cnoreabbrev W w
    cnoreabbrev Q q
]])
