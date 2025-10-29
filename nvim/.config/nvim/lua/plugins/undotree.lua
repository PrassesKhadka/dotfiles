return {
    'mbbill/undotree',
    branch = 'master',
    config = function()
        vim.g.undotree_CustomUndotreeCmd = 'botright vertical 64 new'
        vim.g.undotree_CustomDiffpanelCmd = 'belowright horizontal 24 new'
        vim.g.undotree_SetFocusWhenToggle = 1

        vim.keymap.set("n", "<leader>ut", ':UndotreeToggle<CR>')
    end
}
