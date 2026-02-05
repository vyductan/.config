-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.shell = "fish"

opt.encoding = "utf-8"

opt.whichwrap = "b,s,h,l,<,>,[,]"

vim.diagnostic.config({
  float = {
    border = "single",
  },
})

-- Prevent changing directories - https://github.com/LazyVim/LazyVim/discussions/952#discussioncomment-6254848
-- require("lazyvim.util").get_root = vim.loop.cwd
-- switched to project.nvim

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
-- vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
-- vim.g.root_spec = { "cwd" }
vim.g.root_spec = { ".git" }

-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
vim.g.lazyvim_picker = "fzf"
