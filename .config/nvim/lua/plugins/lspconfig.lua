return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"neovim/nvim-lspconfig",
		"tamago324/nlsp-settings.nvim",
	},
	config = function()
		local nlspsettings = require("nlspsettings")

		nlspsettings.setup({
			config_home = vim.fn.stdpath("config") .. "/lsp",
			local_settings_dir = ".nlsp-settings",
			local_settings_root_markers_fallback = { ".git" },
			append_default_schemas = true,
			loader = "json",
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"clangd",
				"pylsp",
				"jsonls",
				"powershell_es",
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.offsetEncoding = { "utf-16" }

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local map = vim.keymap.set
				local opts = { buffer = ev.buf, silent = true }
				map("n", "gd", ":Lspsaga goto_definition<Cr>", opts)
				map("n", "K", ":Lspsaga hover_doc<Cr>", opts)
				map("n", "<space>rn", ":Lspsaga rename<Cr>", opts)
				map("n", "<space>ca", ":Lspsaga code_action<Cr>", opts)
				map("n", "gr", ":Lspsaga finder<Cr>", opts)
				map("n", "[d", ":Lspsaga diagnostic_jump_prev<Cr>", opts)
				map("n", "]d", ":Lspsaga diagnostic_jump_next<Cr>", opts)
			end,
		})

		vim.diagnostic.config({
			virtual_text = false,
			float = {
				source = "always",
			},
			update_in_insert = true,
		})

		local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
	end,
}
