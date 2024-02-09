return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    {
        "famiu/bufdelete.nvim",
        keys = {
            { "<C-w>", ":Bd<Cr>", silent = true },
        },
    },

    {
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n" },
            { "gcb", mode = "n" },
            { "gc", mode = "v" },
            { "gb", mode = "v" },
        },
        config = true,
    },

    {
        "chrisgrieser/nvim-puppeteer",
        lazy = false,
    },

    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        opts = {
            border = "none",
        },
    },
}
