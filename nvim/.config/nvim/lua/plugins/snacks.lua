-- Render images (png, jpg, gif, svg, ...) and PDFs inside Neovim using the kitty graphics protocol
-- Needs: ImageMagick (`magick`/`convert`) for conversions, Ghostscript for PDFs, and tmux >= 3.3 with allow-passthrough
-- Check with :checkhealth snacks
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		image = { enabled = true },
	},
}
