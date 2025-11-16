return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",

    -- To enable luasnip 
	config = function()
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
