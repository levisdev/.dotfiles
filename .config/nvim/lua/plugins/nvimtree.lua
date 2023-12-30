return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { "<leader>e", ":NvimTreeToggle<Cr>", { silent = true } },
    },
    opts = function()
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, silent = true, nowait = true }
            end

            local mappings = {
                ["<C-]>"] = { api.tree.change_root_to_node, "CD" },
                ["l"] = { api.node.open.edit, "Open" },
                ["<Cr>"] = { api.node.open.edit, "Open" },
                ["<C-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
                ["<C-h>"] = { api.node.open.horizontal, "Open: Horizontal Split" },
                ["h"] = { api.node.navigate.parent_close, "Close Directory" },
                ["r"] = { api.fs.rename, "Rename" },
                [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
                ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
                ["a"] = { api.fs.create, "Create" },
                ["x"] = { api.fs.cut, "Cut" },
                ["y"] = { api.fs.copy.filename, "Copy Name" },
                ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
                ["p"] = { api.fs.paste, "Paste" },
                ["d"] = { api.fs.remove, "Delete" },
                ["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
                ["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
                ["P"] = { api.node.navigate.parent, "Parent Directory" },
                ["-"] = { api.tree.change_root_to_parent, "Up" },
                ["R"] = { api.tree.reload, "Refresh" },
                ["s"] = { api.node.run.system, "Run System" },
                ["g?"] = { api.tree.toggle_help, "Help" },
            }

            for keys, mapping in pairs(mappings) do
                vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
            end
        end

        return {
            on_attach = on_attach,
            hijack_cursor = true,
            disable_netrw = true,
            view = {
                signcolumn = "no",
                width = 25,
            },
            renderer = {
                root_folder_label = false,
                symlink_destination = false,
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
            filters = {
                custom = { "^.git$" },
            },
            git = {
                enable = false,
            },
        }
    end,
}
