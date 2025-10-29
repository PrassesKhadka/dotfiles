return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        event = "VeryLazy",
        config = function()
            -- Setup toggleterm
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                direction = "float",
                start_in_insert = true,
                float_opts = { border = "curved" },
            })

            -- Keybindings
            -- Toggle a normal terminal
            vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { desc = "Toggle terminal" })

            -- Toggle a floating terminal
            vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { desc = "Toggle floating terminal" })

            -- To toggle a specific terminal like lazygit or lazydocker
            -- Example: Terminal for lazygit and lazydocker
            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
            local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })

            function _lazygit_toggle()
                lazygit:toggle()
            end

            vim.keymap.set('n', '<leader>g', _lazygit_toggle, { desc = "Toggle LazyGit terminal" })

            function _lazydocker_toggle()
                lazydocker:toggle()
            end

            vim.keymap.set('n', '<leader>d', _lazydocker_toggle, { desc = "Toggle LazyGit terminal" })
        end,
    },
}
