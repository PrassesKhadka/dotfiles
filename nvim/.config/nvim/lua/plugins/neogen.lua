-- doc comment generator for various languages
return {
	{
		"danymat/neogen",
		dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
		opts = {
			snippet_engine = "luasnip",
			enabled = true,
			languages = {
				rust = {
					template = {
						annotation_convention = "rust_alternative",
					},
				},
				java = {
					template = {
						annotation_convention = "javadoc",
					},
				},
				python = {
					template = {
						annotation_convention = "google_docstrings",
					},
				},
				typescript = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
				typescriptreact = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
				javascript = {
					template = {
						annotation_convention = "jsdoc",
					},
				},
				javascriptreact = {
					template = {
						annotation_convention = "jsdoc",
					},
				},
				lua = {
					template = {
						annotation_convention = "ldoc",
					},
				},
				go = {
					template = {
						annotation_convention = "godoc",
					},
				},
			},
		},
		config = function(_, opts)
			require("neogen").setup(opts)

			local neogen = require("neogen")

			-- generate docs
			vim.keymap.set("n", "<leader>nf", function()
				neogen.generate({ type = "func" })
			end, { desc = "Neogen: function doc" })

			vim.keymap.set("n", "<leader>nc", function()
				neogen.generate({ type = "class" })
			end, { desc = "Neogen: class doc" })

			vim.keymap.set("n", "<leader>nt", function()
				neogen.generate({ type = "type" })
			end, { desc = "Neogen: type doc" })

			vim.keymap.set("n", "<leader>nF", function()
				neogen.generate()
			end, { desc = "Neogen: generate doc" })

			-- jump placeholders
			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if neogen.jumpable() then
					neogen.jump_next()
				end
			end, { desc = "Neogen: next field" })

			vim.keymap.set({ "i", "s" }, "<C-h>", function()
				if neogen.jumpable(true) then
					neogen.jump_prev()
				end
			end, { desc = "Neogen: previous field" })
		end,
	},
}
