return {
    "nvimtools/none-ls.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting

        require("mason-null-ls").setup({
            ensure_installed = {
                "stylua",
                "prettierd",
                "clang_format",
                "black",
            },
            handlers = {
                clang_format = function()
                    null_ls.register(formatting.clang_format.with({
                        filetypes = { "c", "cpp" },
                        extra_args = { "-style=microsoft" },
                    }))
                end,
            },
        })

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
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
