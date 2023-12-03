return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { "<leader>e", ":NvimTreeToggle<Cr>", silent = true },
    },
    config = function()
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")
            local map = vim.keymap.set

            local function opts(desc)
                return { desc = desc, buffer = bufnr, silent = true, nowait = true }
            end

            map("n", "<Cr>", api.node.open.edit, opts("Open"))
            map("n", "l", api.node.open.edit, opts("Open"))
            map("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
            map("n", "a", api.fs.create, opts("Create"))
            map("n", "d", api.fs.remove, opts("Delete"))
            map("n", "r", api.fs.rename, opts("Rename"))
            map("n", "x", api.fs.cut, opts("Cut"))
            map("n", "c", api.fs.copy.node, opts("Copy"))
            map("n", "y", api.fs.copy.filename, opts("Copy Name"))
            map("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
            map("n", "p", api.fs.paste, opts("Paste"))
            map("n", "R", api.tree.reload, opts("Refresh"))
            map("n", "<C-]>", api.tree.change_root_to_node, opts("Cd"))
            map("n", "-", api.tree.change_root_to_parent, opts("Up"))
            map("n", "P", api.node.navigate.parent, opts("Parent Directory"))
            map("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
            map("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
            map("n", "S", api.node.run.system, opts("Run System"))
            map("n", "g?", api.tree.toggle_help, opts("Help"))
        end
        require("nvim-tree").setup({
            on_attach = on_attach,
            hijack_cursor = true,
            disable_netrw = true,
            view = {
                width = 25,
                signcolumn = "no",
                preserve_window_proportions = true,
            },
            renderer = {
                root_folder_label = false,
                icons = {
                    glyphs = {
                        default = "󰈚",
                        folder = {
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                    },
                },
            },
            git = {
                enable = false,
            },
            actions = {
                open_file = {
                    resize_window = false,
                },
            },
        })
    end,
}
