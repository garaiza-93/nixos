local global = vim.g
global.t_co = 256
global.mousemoveevent = true
vim.o.mousemoveevent = true
vim.o.updatetime = 50

--Code folding
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
