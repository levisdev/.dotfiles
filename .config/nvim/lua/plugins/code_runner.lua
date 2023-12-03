return {
	"CRAG666/code_runner.nvim",
	keys = {
		{ "<C-b>", ":RunCode<Cr>", silent = true },
	},
	config = function()
		require("code_runner").setup({
			mode = "float",
			startinsert = true,
			float = {
				close_key = "q",
				border = "rounded",
			},
		})
	end,
}
