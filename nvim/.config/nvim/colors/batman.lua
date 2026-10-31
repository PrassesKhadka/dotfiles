-- Batman: greys and yellow, matching WezTerm's built-in "Batman" scheme
-- The background is left to the terminal so it matches WezTerm (and its opacity)
-- No red/green in this palette: errors are bright yellow, warnings gold, info/hints grey

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "batman"

local c = {
	bg = "#1b1d1e",
	bg_alt = "#262829",
	sel = "#4d504c",
	border = "#505354",
	comment = "#6f6f6f",
	muted = "#737174",
	subtle = "#919495",
	grey = "#a3a3a6",
	text = "#c6c5bf",
	bright = "#dadbd6",
	olive = "#c8be46",
	gold = "#e6dc44",
	light = "#fff78e",
	yellow = "#fcef0c",
	diff_add = "#2b2c1c",
	diff_delete = "#2a2b2c",
}

local groups = {
	-- editor
	Normal = { fg = c.text },
	NormalNC = { fg = c.text },
	NormalFloat = { fg = c.text, bg = c.bg_alt },
	FloatBorder = { fg = c.border, bg = c.bg_alt },
	FloatTitle = { fg = c.yellow, bg = c.bg_alt, bold = true },
	Cursor = { fg = c.bg, bg = c.yellow },
	CursorLine = { bg = c.bg_alt },
	CursorColumn = { bg = c.bg_alt },
	ColorColumn = { bg = c.bg_alt },
	CursorLineNr = { fg = c.yellow, bold = true },
	LineNr = { fg = c.border },
	SignColumn = {},
	FoldColumn = { fg = c.border },
	Folded = { fg = c.subtle, bg = c.bg_alt },
	NonText = { fg = c.border },
	EndOfBuffer = { fg = c.border },
	Whitespace = { fg = c.border },
	SpecialKey = { fg = c.border },
	Conceal = { fg = c.muted },
	Visual = { bg = c.sel },
	Search = { fg = c.bg, bg = c.gold },
	IncSearch = { fg = c.bg, bg = c.yellow },
	CurSearch = { fg = c.bg, bg = c.yellow },
	Substitute = { fg = c.bg, bg = c.yellow },
	MatchParen = { fg = c.yellow, bold = true, underline = true },
	Pmenu = { fg = c.text, bg = c.bg_alt },
	PmenuSel = { fg = c.bg, bg = c.gold },
	PmenuSbar = { bg = c.bg_alt },
	PmenuThumb = { bg = c.sel },
	StatusLine = { fg = c.text, bg = c.bg_alt },
	StatusLineNC = { fg = c.comment, bg = c.bg_alt },
	WinSeparator = { fg = c.border },
	VertSplit = { fg = c.border },
	TabLine = { fg = c.subtle, bg = c.bg_alt },
	TabLineSel = { fg = c.yellow, bold = true },
	TabLineFill = { bg = c.bg_alt },
	WinBar = { fg = c.subtle },
	WinBarNC = { fg = c.muted },
	Title = { fg = c.yellow, bold = true },
	Directory = { fg = c.gold },
	Question = { fg = c.gold },
	MoreMsg = { fg = c.gold },
	ModeMsg = { fg = c.text, bold = true },
	ErrorMsg = { fg = c.yellow, bold = true },
	WarningMsg = { fg = c.gold },
	QuickFixLine = { bg = c.sel },

	-- syntax
	Comment = { fg = c.comment, italic = true },
	Constant = { fg = c.light },
	String = { fg = c.gold },
	Character = { fg = c.gold },
	Number = { fg = c.light },
	Boolean = { fg = c.light },
	Float = { fg = c.light },
	Identifier = { fg = c.text },
	Function = { fg = c.light },
	Statement = { fg = c.gold },
	Keyword = { fg = c.gold },
	Conditional = { fg = c.gold },
	Repeat = { fg = c.gold },
	Label = { fg = c.gold },
	Exception = { fg = c.gold },
	Operator = { fg = c.subtle },
	PreProc = { fg = c.olive },
	Include = { fg = c.olive },
	Define = { fg = c.olive },
	Macro = { fg = c.olive },
	Type = { fg = c.grey },
	StorageClass = { fg = c.gold },
	Structure = { fg = c.grey },
	Typedef = { fg = c.grey },
	Special = { fg = c.olive },
	SpecialChar = { fg = c.olive },
	Delimiter = { fg = c.subtle },
	Tag = { fg = c.gold },
	Todo = { fg = c.bg, bg = c.yellow, bold = true },
	Underlined = { underline = true },
	Error = { fg = c.yellow, bold = true },

	-- treesitter (the rest link to the groups above by default)
	["@variable"] = { fg = c.text },
	["@variable.builtin"] = { fg = c.light, italic = true },
	["@variable.parameter"] = { fg = c.bright },
	["@variable.member"] = { fg = c.text },
	["@property"] = { fg = c.text },
	["@constant.builtin"] = { fg = c.light },
	["@module"] = { fg = c.grey },
	["@type.builtin"] = { fg = c.grey, italic = true },
	["@punctuation"] = { fg = c.subtle },
	["@tag"] = { fg = c.gold },
	["@tag.attribute"] = { fg = c.grey },
	["@tag.delimiter"] = { fg = c.subtle },
	["@markup.heading"] = { fg = c.yellow, bold = true },
	["@markup.link"] = { fg = c.gold, underline = true },
	["@markup.raw"] = { fg = c.light },

	-- diagnostics
	DiagnosticError = { fg = c.yellow },
	DiagnosticWarn = { fg = c.gold },
	DiagnosticInfo = { fg = c.grey },
	DiagnosticHint = { fg = c.subtle },
	DiagnosticOk = { fg = c.olive },
	DiagnosticUnderlineError = { undercurl = true, sp = c.yellow },
	DiagnosticUnderlineWarn = { undercurl = true, sp = c.gold },
	DiagnosticUnderlineInfo = { undercurl = true, sp = c.grey },
	DiagnosticUnderlineHint = { undercurl = true, sp = c.subtle },
	SpellBad = { undercurl = true, sp = c.yellow },
	SpellCap = { undercurl = true, sp = c.gold },
	SpellRare = { undercurl = true, sp = c.grey },
	SpellLocal = { undercurl = true, sp = c.grey },

	-- git / diff
	Added = { fg = c.olive },
	Changed = { fg = c.subtle },
	Removed = { fg = c.yellow },
	DiffAdd = { bg = c.diff_add },
	DiffChange = { bg = c.bg_alt },
	DiffText = { bg = c.sel },
	DiffDelete = { fg = c.muted, bg = c.diff_delete },
	GitSignsAdd = { link = "Added" },
	GitSignsChange = { link = "Changed" },
	GitSignsDelete = { link = "Removed" },
}

for name, spec in pairs(groups) do
	vim.api.nvim_set_hl(0, name, spec)
end

-- :terminal colors, same ANSI palette as WezTerm's Batman scheme
local ansi = {
	"#1b1d1e", "#e6dc44", "#c8be46", "#f4fd22", "#737174", "#747271", "#62605f", "#c6c5bf",
	"#505354", "#fff78e", "#fff27d", "#feed6c", "#919495", "#9a9a9d", "#a3a3a6", "#dadbd6",
}
for i, color in ipairs(ansi) do
	vim.g["terminal_color_" .. (i - 1)] = color
end
