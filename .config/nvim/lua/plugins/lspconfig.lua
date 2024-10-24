return {
  "neovim/nvim-lspconfig",
  config = function()
    -- load defaults i.e lua_lsp
    require("nvchad.configs.lspconfig").defaults()

    local nvlsp = require "nvchad.configs.lspconfig"
    local servers = {
      clangd = {},
      pyright = {},
    }

    -- lsps with default config
    for name, opts in pairs(servers) do
      opts.on_init = nvlsp.on_init
      opts.on_attach = nvlsp.on_attach
      opts.capabilities = nvlsp.capabilities

      require("lspconfig")[name].setup(opts)
    end
  end,
}
