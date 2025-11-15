return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- Optional, for file icons
		},
		config = function()
			-- Set keymap for toggling Neo-tree with <leader>e
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, noremap = true })

			-- Set keymap to focus Neo-tree with <leader>f
			vim.keymap.set("n", "<leader>f", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })

			-- Set keymap for toggling Git status with <leader>ge
			vim.keymap.set("n", "<leader>ge", ":Neotree toggle git_status<CR>", { silent = true, noremap = true })

			-- Function to toggle hidden & git-ignored files
			local function toggle_hidden()
				local state = require("neo-tree.sources.manager").get_state("filesystem")
				if state then
					local filters = state.filtered_items
					filters.visible = not filters.visible
					filters.hide_dotfiles = not filters.hide_dotfiles
					filters.hide_gitignored = not filters.hide_gitignored
					require("neo-tree.sources.filesystem")._navigate_internal(state, nil, nil)
				end
			end

			-- Keymap to toggle hidden and git-ignored files
			vim.keymap.set(
				"n",
				"<leader>th",
				toggle_hidden,
				{ noremap = true, silent = true, desc = "Toggle Hidden Files" }
			)

			-- Optionally configure Neo-tree here
			require("neo-tree").setup({
				window = {
					-- width = 20,                      -- Set the width to 30 columns (adjust this value as needed)
				},
				filesystem = {
					follow_current_file = { enabled = true }, -- Automatically focus the file in the explorer
					hijack_netrw_behavior = "open_current", -- Replace netrw
					filtered_items = {
						visible = true, -- Show hidden files
						hide_dotfiles = false, -- Show dotfiles (e.g., `.gitignore`, `.env`)
						hide_gitignored = false, -- Show files ignored by Git
						hide_by_name = {
							"node_modules", -- JS deps
							"target", -- Maven build output
							"build", -- Gradle build output
						},
						hide_by_pattern = { "%.class$" }, -- regex: hide all .class files for java
						-- You can customize which folders to hide
					},
				},
			})
		end,
	},
}
