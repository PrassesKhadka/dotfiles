return {
    {
        "tpope/vim-dadbod",
        lazy = true,
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = { "tpope/vim-dadbod" },
        cmd = { "DBUI", "DBUIToggle", "DBUIFindBuffer", "DBUIRenameBuffer" },
        init = function()
            -- Save location for DBUI configuration
            vim.g.db_ui_save_location = "~/.local/share/nvim/db_ui"

            -- Keymaps
            vim.keymap.set("n", "<leader>du", ":DBUIToggle<CR>", { silent = true, noremap = true, desc = "Toggle DBUI" })
            vim.keymap.set("n", "<leader>df", ":DBUIFindBuffer<CR>",
                { silent = true, noremap = true, desc = "Find DB buffer" })
            vim.keymap.set("n", "<leader>dr", ":DBUIRenameBuffer<CR>",
                { silent = true, noremap = true, desc = "Rename DB buffer" })
            vim.keymap.set("n", "<leader>dl", ":DBUILastQueryInfo<CR>",
                { silent = true, noremap = true, desc = "Last query info" })
        end,
    },
    {
        -- "vim_dadbod_completion.blink" supports it out of the box for completion
        "kristijanhusak/vim-dadbod-completion",
        dependencies = { "tpope/vim-dadbod" },
        ft = { "sql", "mysql", "plsql" },
    },
}
