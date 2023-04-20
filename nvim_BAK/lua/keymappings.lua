local keymap = vim.keymap

-- map leader to <Space>
keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- Do not yank with x
keymap.set('n', 'x', '"_x')

-- Increment/Decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 's<left>', '<C-w>h')
keymap.set('', 's<up>', '<C-w>j')
keymap.set('', 's<down>', '<C-w>k')
keymap.set('', 's<right>', '<C-w>l')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sl', '<C-w>l')
-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Move current line / block
keymap.set('n', '<A-j>', ':m .+1<CR>==')
keymap.set('n', '<A-k>', ':m .-2<CR>==')
keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
keymap.set('v', '<A-j>', ":m '>+1<CR>fv-gv")
keymap.set('v', '<A-k>', ":m '<-2<CR>fv-gv")

-- Navigation
keymap.set('i', '<A-Up>', '<C-\\><C-N><C-w>k')
keymap.set('i', '<A-Down>', '<C-\\><C-N><C-w>j')
keymap.set('i', '<A-Left>', '<C-\\><C-N><C-w>h')
keymap.set('i', '<A-Right>', '<C-\\><C-N><C-w>l')
keymap.set('n', '<A-Right>', '<C-\\><C-N><C-w>l')
