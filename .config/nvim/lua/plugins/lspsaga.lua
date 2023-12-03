return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({
            symbol_in_winbar = {
                enable = false,
            },
            code_action = {
                show_server_name = true,
            },
            lightbulb = {
                enable = false,
            },
        })
    end,
}
