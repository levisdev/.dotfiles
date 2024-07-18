return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        bashls = {},
        html = {},
        cssls = {},
        emmet_ls = {},
      },
    },
  },
}
