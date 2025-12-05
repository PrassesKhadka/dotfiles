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

-- Log last declared variable
vim.keymap.set("n", "llv", function()
	local ft = vim.bo.filetype

	-- Define separate patterns for Rust to handle the 'mut' keyword reliably
	local patterns = {
		rust_mut = [[let%s+mut%s+([%a_][%w_]*)]], -- Matches 'let mut variable'
		rust_plain = [[let%s+([%a_][%w_]*)]], -- Matches 'let variable'

		javascript = [[const%s+([%a_][%w_]*)]],
		typescript = [[const%s+([%a_][%w_]*)]],
		javascriptreact = [[const%s+([%a_][%w_]*)]],
		typescriptreact = [[const%s+([%a_][%w_]*)]],
		python = [[([%a_][%w_]*)%s*=]],
		java = [[([%a_][%w_]*)%s*=[^=]],
	}

	local templates = {
		javascript = 'console.log("%s: ", %s);',
		typescript = 'console.log("%s: ", %s);',
		javascriptreact = 'console.log("%s: ", %s);',
		typescriptreact = 'console.log("%s: ", %s);',

		python = 'print(f"%s: {%s}")',
		java = 'System.out.println("%s: " + %s);',
		rust = 'println!("{}: {:?}", "%s", %s);',
	}

	local var = nil

	-- === RUST-SPECIFIC LOGIC ===
	if ft == "rust" then
		local current_line = vim.fn.line(".")

		for l = current_line, 1, -1 do
			local text = vim.fn.getline(l)

			-- 1. Try to match 'let mut' first (most specific)
			var = text:match(patterns.rust_mut)
			if var then
				break
			end

			-- 2. If no match, try to match 'let'
			var = text:match(patterns.rust_plain)
			if var then
				break
			end
		end

		-- After the loop, if a variable was found, use the rust template
		if var then
			local log_line = string.format(templates.rust, var, var)
			vim.api.nvim_put({ log_line }, "l", true, true)
			return
		end

	-- === GENERAL LOGIC (For all other languages) ===
	else
		local pattern = patterns[ft]
		local template = templates[ft]

		if not pattern or not template then
			print("Unsupported filetype: " .. ft)
			return
		end

		local current_line = vim.fn.line(".")

		for l = current_line, 1, -1 do
			local text = vim.fn.getline(l)
			local found = text:match(pattern)
			if found then
				var = found
				break
			end
		end

		if var then
			local log_line = string.format(template, var, var)
			vim.api.nvim_put({ log_line }, "l", true, true)
			return
		end
	end

	print("No variable found in this block.")
end, { desc = "Insert debug log for last declared variable" })
