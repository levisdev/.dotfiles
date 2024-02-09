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
                "emmet_ls",
                "cssls",
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
                local map = vim.keymap.set
                local opts = { buffer = ev.buf }
                map("n", "gd", vim.lsp.buf.definition, opts)
                map("n", "K", vim.lsp.buf.hover, opts)
                map("n", "<space>rn", vim.lsp.buf.rename, opts)
                map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                map("n", "gr", vim.lsp.buf.references, opts)
                map("n", "[d", vim.diagnostic.goto_prev, opts)
                map("n", "]d", vim.diagnostic.goto_next, opts)
            end,
        })

        vim.diagnostic.config({
            virtual_text = false,
            underline = false,
        })

        local signs = { Error = " 󰅙", Warn = " ", Hint = " 󰌵", Info = " 󰋼" }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end,
}
