return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
		},
	},
	config = function()
		local ts = require("nvim-treesitter")
		local languages = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"go",
			"yaml",
			"html",
			"css",
			"python",
			"http",
			"prisma",
			"markdown",
			"markdown_inline",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
			"vimdoc",
			"c",
			"java",
			"rust",
			"ron",
		}

		ts.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})
		-- Parser install/update is handled by :TSUpdate and the plugin build step.
		-- Running installs during startup can fail loudly if tree-sitter CLI tooling
		-- is not available yet, and it slows down every boot.

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function(args)
				if vim.bo[args.buf].buftype ~= "" then
					return
				end

				local ok = pcall(vim.treesitter.start, args.buf)
				if not ok then
					return
				end

				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		vim.keymap.set({ "x", "o" }, "af", function()
			select.select_textobject("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "if", function()
			select.select_textobject("@function.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ac", function()
			select.select_textobject("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ic", function()
			select.select_textobject("@class.inner", "textobjects")
		end)

		local move = require("nvim-treesitter-textobjects.move")
		vim.keymap.set({ "n", "x", "o" }, "nf", function()
			move.goto_next_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "nc", function()
			move.goto_next_start("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "nfe", function()
			move.goto_next_end("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "nce", function()
			move.goto_next_end("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "pf", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "pc", function()
			move.goto_previous_start("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "pfe", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "pce", function()
			move.goto_previous_end("@class.outer", "textobjects")
		end)
	end,
}
