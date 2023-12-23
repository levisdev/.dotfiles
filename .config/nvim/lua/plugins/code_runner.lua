return {
	"CRAG666/code_runner.nvim",
	keys = {
		{ "<C-b>", ":RunCode<Cr>", silent = true },
	},
	opts = {
		mode = "float",
		startinsert = true,
		float = {
			close_key = "q",
			border = "rounded",
		},
	},
}
