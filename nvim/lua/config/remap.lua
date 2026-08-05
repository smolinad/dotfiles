vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>x', vim.cmd.Ex)

-- Selected and move
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'C-d', "<C-d>zz")
vim.keymap.set('n', 'C-u', "<C-u>zz")
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', 'Nzzzv')

--Buffer
vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")
vim.keymap.set('v', '<leader>y', "\"+y")

--Folder
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux new tmux-sessionizer<CR>')

--Escape
vim.keymap.set('i', 'C-c>', '<Esc>')

-- No mouse
vim.keymap.set("", "<up>", "<nop>", { noremap = true })
vim.keymap.set("", "<down>", "<nop>", { noremap = true })
vim.opt.mouse = ""
