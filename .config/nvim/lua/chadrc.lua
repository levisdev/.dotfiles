---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
}

M.ui = {
  tabufline = {
    lazyload = false,
    order = { "treeOffset", "buffers" },
  },
}

M.term = {
  sizes = {
    vsp = 0.3,
    ["bo vsp"] = 0.3,
  },
  float = {
    row = 0.1,
    col = 0.15,
    width = 0.7,
    height = 0.6,
  },
}

return M
