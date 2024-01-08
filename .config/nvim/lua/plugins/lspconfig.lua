return {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "b0o/schemastore.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        capabilities.textDocument.completion.completionItem = {
            snippetSupport = true,
        }

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "jsonls",
                "pylsp",
                "powershell_es",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                jsonls = function()
                    lspconfig.jsonls.setup({
                        capabilities = capabilities,
                        settings = {
                            json = {
                                schemas = require("schemastore").json.schemas(),
                                validate = { enable = true },
                            },
                        },
                    })
                end,
                lua_ls = function()
                    lspconfig.lua_ls.setup({
                        on_init = function(client)
                            local path = client.workspace_folders[1].name
                            if not vim.loop.fs_stat(path .. "/.luarc.json") then
                                client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                                    Lua = {
                                        runtime = {
                                            version = "LuaJIT",
                                        },
                                        workspace = {
                                            checkThirdParty = false,
                                            library = {
                                                vim.env.VIMRUNTIME,
                                            },
                                        },
                                    },
                                })
                                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                            end
                            return true
                        end,
                    })
                end,
            },
        })

        lspconfig.clangd.setup({
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--background-index",
                "--header-insertion=iwyu",
                "--header-insertion-decorators",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--offset-encoding=utf-16",
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", ":Telescope lsp_references<Cr>", opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            end,
        })

        vim.diagnostic.config({
            virtual_text = false,
            underline = false,
        })

        for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
            vim.fn.sign_define("DiagnosticSign" .. diag, {
                text = "",
                texthl = "DiagnosticSign" .. diag,
                linehl = "",
                numhl = "DiagnosticSign" .. diag,
            })
        end
    end,
}
