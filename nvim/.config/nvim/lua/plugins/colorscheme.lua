return {
    {
        "navarasu/onedark.nvim",
        name = "onedark",
        config = function()
            require("onedark").setup({
                -- Main options --
                style = "deep",               -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
                transparent = true,           -- Show/hide background
                term_colors = true,           -- Change terminal color as per the selected theme style
                ending_tildes = true,         -- Show end-of-buffer tildes
                cmp_itemkind_reverse = false, -- Reverse item kind highlights in cmp menu

                -- Toggle theme style ---
                toggle_style_key = nil,
                toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },

                -- Code style ---
                code_style = {
                    comments = "italic",
                    keywords = "none",
                    functions = "none",
                    strings = "none",
                    variables = "none",
                },

                -- Lualine options --
                lualine = { transparent = true },

                -- Custom Highlights --
                colors = {},
                highlights = {},

                -- Plugins Config --
                diagnostics = {
                    darker = true,
                    undercurl = true,
                    background = true,
                },
            })
            require("onedark").load()
        end,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                variant = "moon",      -- auto, main, moon, or dawn
                dark_variant = "moon", -- main, moon, or dawn
                dim_inactive_windows = true,
                extend_background_behind_borders = true,

                enable = {
                    terminal = true,
                    legacy_highlights = true,
                    migrations = true,
                },

                styles = {
                    bold = true,
                    italic = true,
                    transparency = false,
                },

                groups = {
                    border = "muted",
                    link = "iris",
                    panel = "surface",
                    error = "love",
                    hint = "iris",
                    info = "foam",
                    note = "pine",
                    todo = "rose",
                    warn = "gold",
                    git_add = "foam",
                    git_change = "rose",
                    git_delete = "love",
                    git_dirty = "rose",
                    git_ignore = "muted",
                    git_merge = "iris",
                    git_rename = "pine",
                    git_stage = "iris",
                    git_text = "rose",
                    git_untracked = "subtle",
                    h1 = "iris",
                    h2 = "foam",
                    h3 = "rose",
                    h4 = "gold",
                    h5 = "pine",
                    h6 = "foam",
                },

                palette = {
                    -- Override builtin palette if desired
                    -- moon = {
                    --     base = '#18191a',
                    --     overlay = '#363738',
                    -- },
                },

                highlight_groups = {
                    -- Comment = { fg = "foam" },
                    -- VertSplit = { fg = "muted", bg = "muted" },
                },
            })
        end,
    },

    {
        "aktersnurra/no-clown-fiesta.nvim",
        priority = 1000,
        lazy = false, -- loads automatically at startup
        config = function()
            local plugin = require("no-clown-fiesta")
            plugin.setup({
                styles = {
                    type = { bold = true },
                    lsp = { underline = false },
                    match_paren = { underline = true },
                },
            })
            return plugin.load()
        end,
    },

    {
        -- active colorscheme, applied in config/options.lua
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("tokyonight").setup({
                style = "night",   -- storm, moon, night or day
                transparent = true, -- use the terminal background, like the tmux bar
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    sidebars = "transparent",
                    floats = "dark",
                },
            })
        end,
    },
}
