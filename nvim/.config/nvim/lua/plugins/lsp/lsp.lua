return {
	-- Main lsp configuration with blink-cmp as a completion engine,fzf and diagnostic configuration included
	"neovim/nvim-lspconfig",
	dependencies = {
		-- automatically install lsps and related tools to stdpath for neovim
		-- mason must be loaded before its dependents so we need to set it up here.
		-- note: `opts = {}` is the same as calling `require('mason').setup({})`
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		-- automates installing and updating external tools (linters, formatters, dap adapters, language servers, etc.)
		"whoissethdaniel/mason-tool-installer.nvim",
		-- file manipulation operations like rename, move, and delete of files or resources that are recognized by the lsp.
		"antosha417/nvim-lsp-file-operations",
		-- useful status updates for lsp.
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		--  this function gets run when an lsp attaches to a particular buffer.
		--  that is to say, every time a new file is opened that is associated with
		--  an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--  function will be executed to configure the current buffer
		vim.api.nvim_create_autocmd("lspattach", {
			group = vim.api.nvim_create_augroup("userlspconfig", {}),
			callback = function(event)
				-- For LSP keymaps, I use 'g' as prefix
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "lsp: " .. desc })
				end

				-- jump to the definition of the word under your cursor.
				--  this is where a variable was first declared, or where a function is defined, etc.
				--  to jump back, press <c-o> and <c-i> to go ahead.
				map("gd", require("fzf-lua").lsp_definitions, "[g]oto [d]efinition")

				-- warn: this is not goto definition, this is goto declaration.
				--  for example, in c this would take you to the header.
				map("gD", vim.lsp.buf.declaration, "[g]oto [d]eclaration")

				-- find references for the word under your cursor.
				map("gr", require("fzf-lua").lsp_references, "[g]oto [r]eferences")

				-- jump to the implementation of the word under your cursor.
				--  useful when your language has ways of declaring types without an actual implementation.
				map("gi", require("fzf-lua").lsp_implementations, "[g]oto [i]mplementation")

				-- jump to the type of the word under your cursor.
				--  useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("gtd", require("fzf-lua").lsp_typedefs, "[t]ype [d]efinition")

				-- fuzzy find all the symbols in your current document.
				--  symbols are things like variables, functions, types, etc.
				map("gds", require("fzf-lua").lsp_document_symbols, "[d]ocument [s]ymbols")

				-- fuzzy find all the symbols in your current workspace.
				--  similar to document symbols, except searches over your entire project.
				map("gws", require("fzf-lua").lsp_live_workspace_symbols, "[w]orkspace [s]ymbols")

				-- rename the variable under your cursor.
				--  most language servers support renaming across files, etc.
				map("grn", vim.lsp.buf.rename, "[r]e[n]ame")

				-- execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your lsp for this to activate.
				map("gca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })
				map("gfs", vim.lsp.buf.signature_help, "show [f]unction [s]ignature help")

				-- optimize imports (normal mode)
				map(
					"goi",
					'<cmd>lua vim.lsp.buf.code_action({ context = { only = { "source.organizeimports" } } })<cr>',
					"[o]ptimize [i]mports",
					"n"
				)

				-- show documentation for what is under cursor
				map("K", vim.lsp.buf.hover, "show documentation for what is under cursor", "n")

				-- restart lsp
				map("grs", ":lsprestart<cr>", "restart lsp", "n")
			end,
		})

		-- vim.lsp.inlay_hint.enable(true)

		-- Diagnostic Configuration
		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
					[vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
					[vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
					[vim.diagnostic.severity.INFO] = icons.diagnostics.info,
				},
			},
			update_in_insert = true,
			severity_sort = true,
		})

		-- 🔍 LSP diagnostics navigation keymaps
		-- "fd" -> to find diagnostic using fzf-lua
		vim.keymap.set("n", "fd", require("fzf-lua").diagnostics_document, { noremap = true, silent = true })
		-- show line diagnostics
		vim.keymap.set("n", "ld", vim.diagnostic.open_float, { noremap = true, silent = true })
		-- go to the previous diagnostic message (e.g., error or warning)
		vim.keymap.set("n", "pd", vim.diagnostic.goto_prev, { noremap = true, silent = true })
		-- go to the next diagnostic message
		vim.keymap.set("n", "nd", vim.diagnostic.goto_next, { noremap = true, silent = true })
		-- open the location list with all current diagnostics for the buffer;
		-- vim.keymap.set("n", "cd", vim.diagnostic.setloclist, { noremap = true, silent = true })

		-- show floating diagnostics on hover
		vim.api.nvim_create_autocmd("cursorhold", {
			callback = function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end,
		})

		--  LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local original_capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

		-- # Handle Auto-Imports
		-- Enable resolve support for auto-imports
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "documentation", "detail", "additionalTextEdits" },
		}

		-- Ensure the LSP can resolve import edits
		vim.lsp.handlers["textDocument/completionItem/resolve"] = vim.lsp.handlers["textDocument/completionItem/resolve"]
			or function(_, result)
				return result
			end

		-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

		--  -- Enable the following language servers
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--  For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			-- 🌐 Frontend
			ts_ls = {
				settings = {
					javascript = {
						preferences = {
							importModuleSpecifierPreference = "relative",
							quotePreference = "auto",
						},
					},
					typescript = {
						preferences = {
							importModuleSpecifierPreference = "relative",
							quotePreference = "auto",
						},
					},
				},
			},
			html = {},
			cssls = {},
			tailwindcss = {},
			eslint = {},

			-- 🖥️ Backend (BE)
			-- 🐍 Python
			pyright = {
				capabilities = capabilities,

				settings = {
					python = {
						analysis = {
							autoImportCompletions = true,
							pythonPath = "/usr/bin/python3",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							typeCheckingMode = "basic",
						},
					},
				},
			},

			-- 🦀 Rust
			rust_analyzer = {
				cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
						completion = {
							autoimport = {
								enable = true,
							},
						},
						assists = { importMergeBehavior = "full" },
						cargo = { loadOutDirsFromCheck = true },
						imports = { granularity = { group = "module" }, prefix = "self" },
					},
				},
			},

			-- 🤚 Bash
			bashls = {},

			-- ⚙️ Lua / Neovim
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "Lua 5.3",
						},
						diagnostics = {
							globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						doc = {
							privateName = { "^_" },
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			},
		}

		-- Ensure the servers and tools above are installed
		--
		-- To check the current status of installed tools and/or manually install
		-- other tools, you can run
		--    :Mason
		--
		-- You can press `g?` for help in this menu.
		--
		-- `mason` had to be setup earlier: to configure its options see the
		-- `dependencies` table for `nvim-lspconfig` above.
		--
		-- You can add other tools here that you want Mason to install
		-- for you, so that they are available from within Neovim.

		-- 👍 For lsp servers
		local ensure_installed = vim.tbl_keys(servers or {})

		-- 👍 For formatters
		-- 1. Ensure binaries are installed using mason and mason-tool-installer and then use `conform.nvim` to use them
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			-- For JS/TS
			"prettier",
			"prettierd", -- Used to format javascript and typescript code
			-- For Python
			"isort",
			"black",
			-- For Rust
			"rustfmt",
		})

		-- ➡️ Automatically ensure the tools you need for development are always installed. When using Mason in Neovim, you normally have to manually install tools(formatter,linters,lsps)
		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			auto_update = true,
			run_on_start = true,
			debounce_hours = 24,
		})

		-- 🔗 Bridges Mason & nvim-lspconfig:
		-- Automatically connects LSP servers installed via Mason
		-- with Neovim’s built-in LSP client configuration.
		-- 🧠 In short: Mason installs → mason-lspconfig links → lspconfig runs.
		require("mason-lspconfig").setup({
			ensure_installed = {}, -- explicitly set to an empty table , populates installs via mason-tool-installer
			-- mason-tool-installer manages it so off
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for ts_ls)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
