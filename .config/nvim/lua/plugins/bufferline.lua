return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    opts = function()
        return {
            options = {
                style_preset = require("bufferline").style_preset.minimal,
                tab_size = 12,
                show_buffer_close_icons = false,
                show_close_icon = false,
                separator_style = "thin",
                offsets = {
                    { filetype = "NvimTree" },
                },
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get(),
        }
    end,
    config = function(_, config_opts)
        require("bufferline").setup(config_opts)

        local map = vim.keymap.set
        local opts = { silent = true }
        map("n", "<S-l>", ":BufferLineCycleNext<Cr>", opts)
        map("n", "<S-h>", ":BufferLineCyclePrev<Cr>", opts)
        map("n", "<A-<>", ":BufferLineMovePrev<Cr>", opts)
        map("n", "<A->>", ":BufferLineMoveNext<Cr>", opts)
    end,
}
