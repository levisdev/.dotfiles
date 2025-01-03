return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<C-o>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-y>"] = { "show", "hide_documentation", "fallback" },
      },

      completion = {
        list = {
          selection = "auto_insert",
        },
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
}
