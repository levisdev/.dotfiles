return {
    "jay-babu/mason-null-ls.nvim",
    event = "BufRead",
    dependencies = {
        "nvimtools/none-ls.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting

        require("mason-null-ls").setup({
            ensure_installed = {
                "stylua",
                "prettierd",
                "black",
                "clang_format",
            },
            automatic_installation = true,
        })

        local sources = {
            formatting.stylua,
            formatting.prettierd,
            formatting.black,
            formatting.clang_format.with({
                filetypes = { "c", "cpp" },
                extra_args = { "-style=microsoft" },
            }),
        }

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        require("null-ls").setup({
            sources = sources,
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
    end,
}
