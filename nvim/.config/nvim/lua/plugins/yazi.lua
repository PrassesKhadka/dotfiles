-- yazi as a floating file manager (same config, previews and keys as in the terminal); neo-tree stays the sidebar
return {
	"mikavilpas/yazi.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{ "<leader>-", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Yazi at the current file" },
		{ "<leader>_", "<cmd>Yazi cwd<cr>", desc = "Yazi in nvim's working directory" },
		{ "<leader>yr", "<cmd>Yazi toggle<cr>", desc = "Yazi: resume the last session" },
	},
	opts = {
		open_for_directories = false,
		floating_window_scaling_factor = 0.9,
		yazi_floating_window_border = "rounded",
		keymaps = {
			show_help = "<f1>",
		},
	},
}
