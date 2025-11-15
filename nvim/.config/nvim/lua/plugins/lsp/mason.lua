return {
    -- Mason for managing packages such as: Formatters, Linters, and  LSP servers
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
}
