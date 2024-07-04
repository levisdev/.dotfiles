local plugins = {
  { "catppuccin/nvim", name = "catppuccin" },
  { "rcarriga/nvim-notify" },
  { "folke/noice.nvim" },
  { "nvimdev/dashboard-nvim" },
  { "echasnovski/mini.pairs" },
}

local list = {}

for _, plugin in pairs(plugins) do
  table.insert(list, vim.tbl_extend("force", plugin, { enabled = false }))
end

return list
