-- <leader> value is mapped in Lazy.lua as " "(space) since lazy needs it to be initialised first
-- other keymaps are set in their respective config e.g. telescope,neotree,lazy, etc

-- Press <leader><space> to insert a space after the cursor in normal mode
vim.keymap.set('n', '<leader><space>', 'a <Esc>', { noremap = true, silent = true })

-- Make key sequences faster
vim.o.timeoutlen = 300

-- Exit insert mode by typing jj
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Map Enter to add an empty line below and still remain in normal mode
vim.keymap.set('n', '<CR>', 'o<Esc>', { desc = "Empty line below" })
-- Map Shift+Enter to add an empty line above and still remain in normal mode
vim.keymap.set("n", "<S-CR>", "O<Esc>", { desc = "Empty line above" })

-- In neovim Ctrl+I is also interpreted as a Tab key.
-- To avoid override the default, this is written
--Command	Action	Opposite
-- Ctrl+O	Jump back in jumplist
-- Ctrl+I	Jump forward in jumplist
vim.keymap.set('n', '<C-i>', '<C-i>', { noremap = true })

-- Map <Leader>vv to Visual Block mode
vim.api.nvim_set_keymap('n', 'vb', '<c-v>', { noremap = true, silent = true })

-- Make <C-BS> ctrl + backspace  delete previous word in insert mode
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true, silent = true })

-- undo
vim.keymap.set("i", "<C-z>", "<Esc>ua", { desc = "undo", noremap = true, silent = true })
vim.keymap.set({ "n", "v", "x" }, "<C-z>", "u", { desc = "undo", noremap = true, silent = true })

-- redo
vim.keymap.set("i", "<C-y>", "<Esc><C-r>a", { desc = "redo", noremap = true, silent = true })
vim.keymap.set("n", "<C-y>", "<C-r>", { desc = "redo", noremap = true, silent = true })

-- select all
vim.keymap.set("i", "<C-a>", "<Esc>ggVGa", { desc = "select all", noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "select all", noremap = true, silent = true })

-- cut to system clipboard (normal mode)
vim.keymap.set("n", "<C-x>", '"+d', { desc = "cut to system clipboard", noremap = true, silent = true })

-- copy to system clipboard (normal mode)
vim.keymap.set("n", "<C-c>", '"+y', { desc = "copy to system clipboard", noremap = true, silent = true })

-- paste from system clipboard (normal mode)
vim.keymap.set("n", "<C-v>", '"+p', { desc = "paste from system clipboard", noremap = true, silent = true })

-- cut to system clipboard (visual mode)
vim.keymap.set("x", "<C-x>", '"+d', { desc = "cut to system clipboard", noremap = true, silent = true })

-- copy to system clipboard (visual mode)
vim.keymap.set("x", "<C-c>", '"+y', { desc = "copy to system clipboard", noremap = true, silent = true })

-- paste from system clipboard (visual mode)
vim.keymap.set("v", "<C-v>", '"+p', { desc = "paste from system clipboard", noremap = true, silent = true })

-- copy the whole paragraph to sys clipboard
vim.keymap.set('n', 'yap', '"+yap', { noremap = true, silent = true })

-- paste from system clipboard (visual mode)
vim.keymap.set("v", "<C-v>", '"+p', { desc = "paste from system clipboard", noremap = true, silent = true })

-- paste from system clipboard (insert mode)
vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { desc = "paste from system clipboard", noremap = true, silent = true })

-- override delete in the void register
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })

-- override copy to system clipboard register
vim.keymap.set('n', 'y', '"+y', { noremap = true, silent = true })

-- Key mapping for Ctrl+s to save the current file in Normal mode
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Key mapping for Ctrl+s to save the current file in Insert mode and stay in Insert mode
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- select and move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "select and move", noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "select and move", noremap = true, silent = true })

-- Keep selection when indenting in visual mode
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection" })

--bufferlin
-- Key mappings for buffer navigation and management
vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })            -- Go to the left buffer
vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })            -- Go to the right buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { noremap = true, silent = true })               -- Close current buffer
vim.keymap.set('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { noremap = true, silent = true }) -- Close other buffers

-- Split management
vim.keymap.set('n', '<leader>v', '<cmd>vsplit<CR>', { silent = true, desc = "Vertical split" })
vim.keymap.set('n', '<leader>h', '<cmd>split<CR>', { silent = true, desc = "Horizontal split" })
vim.keymap.set('n', '<leader>c', '<cmd>close<CR>', { silent = true, desc = "Close split" })

--code formatting
-- Keymap for formatting code using LSP
vim.keymap.set("n", "<C-f>", function()
    vim.lsp.buf.format({
        async = true,
        -- You can specify filters here to choose certain LSP servers for formatting, like:
        -- filter = function(client) return client.name == "tsserver" end
    })
end, { desc = "Format Code" })

-- Keymap to format only the selected code in visual mode
vim.keymap.set("v", "<C-f>", function()
    vim.lsp.buf.format({
        async = true,
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        }
    })
end, { desc = "Format Selected Code" })

-- Keymaps for switching windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left window", silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right window", silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to bottom window", silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to top window", silent = true })

vim.keymap.set('n', '<C-b>', function() require('telescope.builtin').live_grep() end,
    { desc = "find text", noremap = true, silent = true })

-- window resize
-- Resize window horizontally using Ctrl + Left/Right Arrow
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Optionally, you can also map resizing vertically using Up/Down Arrow
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })

local luasnip = require("luasnip")

-- Remap Tab to jump to the next snippet field
vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
    end
end, { silent = true })

-- Remap Shift+Tab to jump to the previous snippet field
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
    end
end, { silent = true })

local zdraw = require("zdraw")

-- Keymaps to toggle drawing mode
vim.keymap.set('n', '<leader>ds', zdraw.start_drawing, { desc = "Start Drawing" })
vim.keymap.set('n', '<leader>de', zdraw.stop_drawing, { desc = "Stop Drawing" })

-- Keymaps to center cursor in screen
vim.keymap.set('n', 'j', 'jzz', { noremap = false, silent = true, desc = "center cursor" })
vim.keymap.set('n', 'k', 'kzz', { noremap = false, silent = true, desc = "center cursor" })
vim.keymap.set('n', '<Down>', '<Down>zz', { noremap = false, silent = true, desc = "center cursor" })
vim.keymap.set('n', '<Up>', '<Up>zz', { noremap = false, silent = true, desc = "center cursor" })
