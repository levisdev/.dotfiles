return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "[b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      options = {
        tab_size = 15,
        left_trunc_marker = "",
        right_trunc_marker = "",
        show_close_icon = false,
        show_buffer_close_icons = false,
        diagnostics = false,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = function()
              return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            end,
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    },
  },
}
