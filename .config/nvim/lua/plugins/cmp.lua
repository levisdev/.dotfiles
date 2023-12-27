return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		"FelipeLema/cmp-async-path",
		"lukas-reineke/cmp-under-comparator",

		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		local unlink_group = vim.api.nvim_create_augroup("UnlinkSnippet", {})
		vim.api.nvim_create_autocmd("ModeChanged", {
			group = unlink_group,
			pattern = { "s:n", "i:*" },
			callback = function(event)
				if luasnip.session and luasnip.session.current_nodes[event.buf] and not luasnip.session.jump_active then
					luasnip.unlink_current()
				end
			end,
		})

		local cmp_icons = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		}

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			view = {
				entries = { name = "custom", selection_order = "near_cursor" },
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			experimental = {
				ghost_text = true,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-d>"] = cmp.mapping.scroll_docs(-1),
				["<C-f>"] = cmp.mapping.scroll_docs(1),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<Cr>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						if not entry then
							luasnip.jump(1)
						else
							cmp.confirm()
						end
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			sources = cmp.config.sources({
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
				{ name = "async_path" },
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = cmp_icons[vim_item.kind] or ""
					vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						nvim_lua = "[Lua]",
						buffer = "[Buffer]",
						async_path = "[Path]",
						luasnip = "[LuaSnip]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "async_path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
