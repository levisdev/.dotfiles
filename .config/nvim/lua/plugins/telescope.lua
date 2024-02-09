return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
    },
    cmd = "Telescope",
    keys = {
        { "<leader>ff", ":Telescope find_files<Cr>", silent = true },
        { "<leader>fg", ":Telescope live_grep<Cr>", silent = true },
        { "<leader>fb", ":Telescope current_buffer_fuzzy_find<Cr>", silent = true },
        { "<leader>fh", ":Telescope help_tags<Cr>", silent = true },
    },
    opts = function()
        local actions = require("telescope.actions")
        local telescopeConfig = require("telescope.config")
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        table.insert(vimgrep_arguments, {
            "--trim",
            "--hidden",
            "--glob",
            "!**/.git/*",
        })

        return {
            defaults = {
                prompt_prefix = "   ",
                selection_caret = "❯ ",
                sorting_strategy = "ascending",
                layout_strategy = "bottom_pane",
                file_ignore_patterns = { "node_modules" },
                vimgrep_arguments = vimgrep_arguments,
                layout_config = {
                    bottom_pane = {
                        height = 20,
                        preview_cutoff = 80,
                    },
                    horizontal = {
                        preview_cutoff = 100,
                        preview_width = 0.6,
                        prompt_position = "top",
                    },
                },
                mappings = {
                    i = {
                        ["<Esc>"] = actions.close,
                        ["<C-c>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.6,
                    },
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
        }
    end,
    config = function(_, opts)
        local telescope = require("telescope")

        telescope.setup(opts)
        telescope.load_extension("fzf")
    end,
}
