return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"kristijanhusak/vim-dadbod-completion", -- SQL completion
			-- Additional plugin, feel free to remove it
			"moyiz/blink-emoji.nvim", -- Emoji completion
		},
		version = "1.*",

		opts = {
			keymap = {
				["<Enter>"] = { "accept", "fallback" },
				["<Esc>"] = { "hide", "fallback" },

				["<Tab>"] = { "snippet_forward", "select_next", "show", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

				["<C-j>"] = { "snippet_forward", "select_next", "show", "fallback" },
				["<C-k>"] = { "snippet_backward", "select_prev", "fallback" },

				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },
			-- Shows function signature while typing
			signature = { enabled = false },
			-- Enable command line ghost completion:
			cmdline = { completion = { ghost_text = { enabled = true } } },

			snippets = { preset = "luasnip" },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				-- More configuration for lsp in lsp.lua
				default = { "lsp", "path", "snippets", "buffer", "dadbod", "emoji" },
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					-- Snippets → highest priority
					-- snippets = {
					-- 	name = "Snippets",
					-- 	module = "blink.cmp.sources.snippets",
					-- 	score_offset = 1000, -- 👈 higher score = higher priority
					-- },

					-- Configuring vim-dadbod-completion for blink-cmp, supports PostgreSQL, MySQL,SQLite
					-- Out of the box integration with vim-dadbod-ui
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },

					-- Configuring emoji-completion
					-- use ':', to show empji autocompletion
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15, -- Tune by preference
						opts = {
							insert = true, -- Insert emoji (default) or complete its name
							---@type string|table|fun():table
							trigger = function()
								return { ":" }
							end,
						},
						should_show_items = function()
							local blacklist = { "NvimTree", "oil", "help" }
							return not vim.tbl_contains(blacklist, vim.o.filetype)

							-- To enable it only for certain files
							-- return vim.tbl_contains(
							-- 	-- Enable emoji completion only for git commits and markdown.
							-- 	-- By default, enabled for all file-types.
							-- 	{ "gitcommit", "markdown" },
							-- 	vim.o.filetype
						end,
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
