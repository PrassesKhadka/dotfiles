return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- Keymap config
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', 'ff', builtin.find_files, { desc = 'Telescope find project files' })
            vim.keymap.set('n', 'fg', builtin.live_grep, { desc = 'Telescope live project grep' })

            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = { -- In insert mode
                            ["<esc>"] = require('telescope.actions').close, -- optional: ESC to close
                        },
                        n = {
                            -- In normal mode
                            ["q"] = require('telescope.actions').close, -- press q to quit
                        },
                    },
                    file_ignore_patterns = {
                        "node_modules",
                        ".git/",
                        ".yarn",
                        "dist/",
                        ".next/",
                        ".vscode/",
                        "target/",
                        ".venv/",
                    },
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--no-ignore', -- Include files ignored by .gitignore
                        '--hidden',    -- Include hidden files
                        -- Exclude the following directories
                        "--glob=!**/.git/*",
                        "--glob=!**/node_modules/*",
                        "--glob=!**/.yarn/*",
                        "--glob=!**/dist/*",
                        "--glob=!**/.next/*",
                        "--glob=!**/.vscode/*",
                        "--glob=!**/target/*",
                        "--glob=!**/.venv/*",
                        '--binary', -- Ignore all binary files
                    },
                },
                pickers = {
                    find_files = {
                        find_command = {
                            'rg',
                            '--files',
                            '--hidden',
                            '--no-ignore',
                            '--glob', '!target/',
                            '--glob', '!.venv/*',
                            '--binary'
                        },
                    },
                },
                extensions = {
                    themes = require('telescope.themes').get_dropdown({}),
                },
            })

            -- Keymap to bring up the colorscheme picker
            vim.keymap.set('n', '<leader>uC', function()
                require('telescope.builtin').colorscheme({
                    enable_preview = true, -- Shows preview of the colorschemes
                })
            end, { noremap = true, silent = true })
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    }
}
