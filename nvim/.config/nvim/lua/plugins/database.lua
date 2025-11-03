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
      vim.keymap.set("n", "<leader>df", ":DBUIFindBuffer<CR>", { silent = true, noremap = true, desc = "Find DB buffer" })
      vim.keymap.set("n", "<leader>dr", ":DBUIRenameBuffer<CR>", { silent = true, noremap = true, desc = "Rename DB buffer" })
      vim.keymap.set("n", "<leader>dl", ":DBUILastQueryInfo<CR>", { silent = true, noremap = true, desc = "Last query info" })
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    ft = { "sql", "mysql", "plsql" },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "kristijanhusak/vim-dadbod-completion" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Setup Dadbod completion in SQL buffers
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
