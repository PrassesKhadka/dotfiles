return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Automatically update parsers on update
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                "json",
                "javascript",
                "typescript",
                "tsx",
                "go",
                "yaml",
                "html",
                "css",
                "python",
                "http",
                "prisma",
                "markdown",
                "markdown_inline",
                "svelte",
                "graphql",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "query",
                "vimdoc",
                "c",
                "java",
                "rust",
                "ron",
            },
            highlight = { enable = true },
            indent = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer", -- a function (including definition)
                        ["if"] = "@function.inner", -- inner part of a function
                        ["ac"] = "@class.outer",    -- a class
                        ["ic"] = "@class.inner",    -- inner part of a class
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- record movements in the jumplist
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]C"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[C"] = "@class.outer",
                    },
                },
            },
        }
    end
}
