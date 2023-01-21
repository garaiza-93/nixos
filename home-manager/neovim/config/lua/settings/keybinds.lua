-- Leader
vim.g.mapleader = ' '
vim.g.localleader = '\\'

local map = vim.keymap.set

--Returning to normal mode
map('i', 'jk', '<ESC>', { noremap = true })
map('i', 'kj', '<ESC>', { noremap = true })
--Continuous indenting by using last highlight (gv)
map('v', '>', '>gv', { noremap = true })
map('v', '<', '<gv', { noremap = true })
