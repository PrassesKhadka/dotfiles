return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = function()
		local function has_normal_file_buffers()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
					local name = vim.api.nvim_buf_get_name(buf)
					local bo = vim.bo[buf]
					if name ~= "" and bo.buftype == "" and bo.filetype ~= "neo-tree" then
						return true
					end
				end
			end

			return false
		end

		local function should_open_neotree_on_startup()
			if has_normal_file_buffers() then
				return false
			end

			local argc = vim.fn.argc(-1)
			if argc == 0 then
				return true
			end

			if argc == 1 then
				local arg = vim.fn.argv(0)
				return arg ~= "" and vim.fn.isdirectory(vim.fn.fnamemodify(arg, ":p")) == 1
			end

			return false
		end

		return {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			post_restore_cmds = {
				function()
					if not has_normal_file_buffers() then
						return
					end

					vim.schedule(function()
						vim.cmd("Neotree close")
					end)
				end,
			},
			no_restore_cmds = {
				function(is_startup)
					if not is_startup or not should_open_neotree_on_startup() then
						return
					end

					vim.schedule(function()
						vim.cmd("Neotree show")
					end)
				end,
			},
			-- log_level = 'debug',
		}
	end,
}
