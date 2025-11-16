-- Picker, finder, etc.
return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	keys = {
		{
			"ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find Files in project directory",
		},
		{
			"fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Find by grepping in project directory",
		},
		-- Since fg (live_grep) fails in ~/.config, Ripgrep respects .gitignore and global ignore files
		{
			"fgc",
			function()
				require("fzf-lua").live_grep({
					cwd = vim.fn.stdpath("config"),
					hidden = true,
				})
			end,
			desc = "Grep Neovim config",
		},
		{
			"fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[F]ind [H]elp",
		},
		{
			"fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "[F]ind [K]eymaps",
		},
		{
			"fb",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "[F]ind [B]uiltin FZF",
		},
		{
			"fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[F]ind current [W]ord",
		},
		{
			"fW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "[F]ind current [W]ORD",
		},
		{
			"fr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "[F]ind [R]esume",
		},
		{
			"fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "[F]ind [O]ld Files/Buffers",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "[,] Find existing buffers",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "[/] Live grep the current buffer",
		},
	},
	opts = function()
		return {
			{ "border-fused", "hide" },
			-- too slow, especially for large repo
			git_icons = false,
			keymap = {
				builtin = {
					["<S-j>"] = "preview-page-down",
					["<S-k>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-q"] = "abort",
				},
			},
			winopts = {
				border = "rounded",
				height = 0.9,
				width = 0.9,
				preview = {
					layout = "horizontal", -- 'horizontal' means the preview is on the right of the results
					horizontal = "right:50%", -- The preview takes up 50% of the horizontal space
					border = "single", -- Use a border for the preview
					-- hidden = "visible", -- Preview visible by default
				},
			},
		}
	end,
}
