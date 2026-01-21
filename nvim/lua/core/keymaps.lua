-- set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- escape mode in the terminal
keymap.set('t', '<Esc>', "<C-\\><C-n>")
keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>")

-- remapping for using navigation keys
keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- minimize terminal split
keymap.set('n', '<C-g>', "3<C-w>_")
