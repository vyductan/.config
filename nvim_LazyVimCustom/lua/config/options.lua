-- vim.cmd('autocmd!')

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.confirm = true

vim.wo.number = true

-- vim.opt.title = true
-- vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'fish'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
-- vim.opt.smarttab = true
-- vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
-- vim.opt.ai = true            -- Auto indent
-- vim.opt.si = true            -- Smart indent
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.wrap = false -- Disable line wrap

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
-- but this doesn't work on iTerm2.

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Automatically go to next line
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'
