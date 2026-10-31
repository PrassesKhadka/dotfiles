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
	"markdown",
	"markdown_inline",
	"bash",
	"lua",
	"vim",
	"dockerfile",
	"gitignore",
	"query",
	"vimdoc",
	"java",
	"rust",
}

local function tree_sitter_cli_available()
	if vim.fn.executable("tree-sitter") == 0 then
		vim.notify("Skipping Treesitter parser install: tree-sitter CLI was not found", vim.log.levels.WARN)
		return false
	end

	local result = vim.system({ "tree-sitter", "--version" }, { text = true }):wait()
	if result.code == 0 then
		return true
	end

	local reason = vim.trim((result.stderr ~= "" and result.stderr) or result.stdout or "unknown error")
	if reason == "" then
		reason = "unknown error"
	end
	vim.notify("Skipping Treesitter parser install: " .. reason, vim.log.levels.WARN)
	return false
end

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = function()
		local ts = require("nvim-treesitter")
		ts.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})
		if tree_sitter_cli_available() then
			ts.install(languages, { max_jobs = 4, summary = true }):wait(300000)
			ts.update(languages, { max_jobs = 4, summary = true }):wait(300000)
		end
	end,
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			lazy = false,
		},
	},
	config = function()
		local ts = require("nvim-treesitter")

		ts.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

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
			move = {
				set_jumps = true,
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
