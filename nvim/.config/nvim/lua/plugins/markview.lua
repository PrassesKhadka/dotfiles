return {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },

    keys = {
        { "<leader>mp", "<cmd>Markview toggle<cr>",  desc = "Toggle Markview Preview for current buffer" },
        { "<leader>me", "<cmd>Markview enable<cr>",  desc = "Enable Markview Preview for current buffer" },
        { "<leader>md", "<cmd>Markview disable<cr>", desc = "Disable Markview Preview for current buffer" },
        { "<leader>ms", "<cmd>Markview split<cr>",   desc = "Split Markview Preview" },
    },

    opts = {
        {
            -- Buffer types to ignore
            buf_ignore = { "nofile" },
            -- Delay, in miliseconds
            -- to wait before a redraw occurs(after an event is triggered)
            debounce = 50,
            -- Filetypes where the plugin is enabled filetypes = { "markdown", "quarto", "rmd" },
            -- Highlight groups to use
            -- "dynamic" | "light" | "dark"
            highlight_groups = "dynamic",
            -- Modes where hybrid mode is enabled
            hybrid_modes = nil,
            -- Tree-sitter query injections
            injections = {},
            -- Initial plugin state,
            -- true = show preview
            -- falss = don't show preview
            initial_state = true,
            -- Max file size that is rendered entirely
            max_file_length = 1000,
            -- Modes where preview is shown
            modes = { "n", "no", "c" },
            -- Lines from the cursor to draw when the
            -- file is too big
            render_distance = 100,
            -- Window configuration for split view
            split_conf = {},

            -- Rendering related configuration
            block_quotes = {},
            callbacks = {},
            checkboxes = {},
            code_blocks = {},
            escaped = {},
            footnotes = {},
            headings = {},
            horizontal_rules = {},
            html = {},
            inline_codes = {},
            latex = {},
            links = {},
            list_items = {},
            tables = {}
        }
    },

}
