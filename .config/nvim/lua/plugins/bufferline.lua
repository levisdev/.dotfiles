return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	config = function()
		require("bufferline").setup({
			options = {
				show_close_icon = false,
				show_buffer_close_icons = false,
				offsets = {
					{
						filetype = "NvimTree",
						separator = true,
					},
				},
			},
		})

		local map = vim.keymap.set
		local opts = { remap = false, silent = true }

		map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
		map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
		map("n", "<A->>", ":BufferLineMoveNext<CR>", opts)
		map("n", "<A-<>", ":BufferLineMovePrev<CR>", opts)
	end,
}
