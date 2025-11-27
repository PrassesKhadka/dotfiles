-- Set up yank highlighting
vim.api.nvim_create_augroup("YankHighlight", { clear = true })

-- Ensure the highlight group is defined after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "YankHighlight",
	pattern = "*",
	callback = function()
		vim.cmd([[highlight YankHighlight guibg=#FFD700 guifg=#000000 ctermbg=214 ctermfg=0]])
		-- dark grey
		-- vim.cmd [[highlight Visual guibg=#44475a guifg=NONE ctermbg=238 ctermfg=NONE]]

		-- soft blue
		vim.cmd([[highlight Visual guibg=#3E68D7 guifg=NONE ctermbg=61 ctermfg=NONE]])

		-- vibrant purple
		-- vim.cmd [[highlight Visual guibg=#9147FF guifg=NONE ctermbg=99 ctermfg=NONE]]
	end,
})

-- Create the autocmd for highlighting on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, higroup = "YankHighlight" })
	end,
})

local ls = require("luasnip")

-- Clear snippet session when leaving insert mode or moving cursor outside
vim.api.nvim_create_autocmd({ "ModeChanged", "CursorMovedI" }, {
	callback = function()
		if ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.locally_jumpable(1) then
			ls.unlink_current()
		end
	end,
})

-- Log last yank(lly) based on the programming language (ts,python,rust,java)
vim.keymap.set("n", "lly", function()
	local ft = vim.bo.filetype
	local var = vim.fn.getreg('"')

	local templates = {
		javascript = 'console.log("%s: ", %s);',
		typescript = 'console.log("%s: ", %s);',
		javascriptreact = 'console.log("%s: ", %s);',
		typescriptreact = 'console.log("%s: ", %s);',

		python = 'print(f"%s: {%s}")',
		java = 'System.out.println("%s: " + %s);',
		rust = 'println!("{}: {:?}", "%s", %s);',
	}

	local template = templates[ft]
	if not template then
		print("Unsupported filetype: " .. ft)
		return
	end

	local line = string.format(template, var, var)
	vim.api.nvim_put({ line }, "l", true, true)
end, { desc = "Insert debug print for last yank" })
