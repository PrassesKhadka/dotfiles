return {
	"glepnir/template.nvim",
	cmd = { "Template", "TemProject" },
	config = function()
		local temp_dir = vim.fs.normalize(vim.fn.stdpath("config") .. "/templates")
		if vim.fn.isdirectory(temp_dir) == 0 then
			return
		end

		require("template").setup({
			temp_dir = temp_dir,
			patterns = {
				"*.cpp",
				"*.js",
				"*.py",
				"*.java",
				"*.kotlin",
			},
			auto_apply = false,
			apply_in_place = true,
		})
	end,
}
