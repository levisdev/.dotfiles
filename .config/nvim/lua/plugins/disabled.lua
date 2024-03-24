local plugins = {
  { "nvimdev/dashboard-nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
}

local list = {}

for _, plugin in pairs(plugins) do
  table.insert(list, vim.tbl_extend("force", plugin, { enabled = false }))
end

return list
