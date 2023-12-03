return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
        { "<leader>ff", ":Telescope find_files<Cr>",                silent = true },
        { "<leader>fg", ":Telescope live_grep<Cr>",                 silent = true },
        { "<Leader>fb", ":Telescope current_buffer_fuzzy_find<Cr>", silent = true },
        { "<leader>fh", ":Telescope help_tags<Cr>",                 silent = true },
    },
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                prompt_prefix = "   ",
                selection_caret = "❯ ",
                sorting_strategy = "ascending",
                layout_strategy = "bottom_pane",
                layout_config = {
                    bottom_pane = {
                        height = 25,
                        preview_cutoff = 80,
                        prompt_position = "top",
                    },
                    horizontal = {
                        preview_cutoff = 100,
                        preview_width = 0.6,
                        prompt_position = "top",
                    },
                },
                file_ignore_patterns = { "node_modules" },
                mappings = {
                    i = {
                        ["<Esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim",
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.6,
                    },
                },
            },
        })

        telescope.load_extension("fzf")
    end,
}
