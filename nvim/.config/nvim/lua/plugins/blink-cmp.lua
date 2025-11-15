return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = {
				["<Tab>"] = { "accept", "fallback" },
				["<C-q>"] = { "hide", "fallback" },
				["<C-j>"] = { "select_next", "show", "snippet_forward", "fallback" },
				["<C-k>"] = { "select_prev" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = true } },
			-- Shows function signature while typing
			signature = { enabled = true },
			-- Disable command line completion:
			cmdline = { enabled = false },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				-- More configuration for lsp in lsp.lua
				default = { "lsp", "path", "snippets", "buffer", "dadbod" },
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					-- Configuring vim-dadbod-completion for blink-cmp, supports PostgreSQL, MySQL,SQLite
					-- Out of the box integration with vim-dadbod-ui
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
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
