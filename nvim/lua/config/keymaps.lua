-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Do not yank with x, c, p
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("v", "p", '"_dP')

map("n", "<leader><space>", "<cmd>Telescope keymaps<cr>", { desc = "Spotlight" })

-- Increment/Decrement
map("n", "+", "<C-a>", { desc = "Increment Number" })
map("n", "-", "<C-x>", { desc = "Decrement Number" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })
map("i", "<C-a>", "<esc>gg<S-v>G", { desc = "Select All" })

-- Redo
map("n", "r", "<C-r>")

-- Buffer move BufferLine
map("n", "{", "<cmd>BufferLineMovePrev<cr>", { desc = "Move current buffer backwards" })
map("n", "}", "<cmd>BufferLineMoveNext<cr>", { desc = "Move current buffer forwards" })

-- New tab
vim.keymap.set("n", "te", ":tabedit<Return>", { silent = true })
-- Window Split
map("n", "<C-\\>", "<C-W>v", { desc = "Split window right" })
map("n", "<C-->", "<C-W>s", { desc = "Split window below" })
map("n", "<C-_>", "<C-W>s") -- For Macos
map("n", "<leader>w-", "<Nop>") -- LazyVim unbind
map("n", "<leader>w|", "<Nop>") -- LazyVim unbind
map("n", "<leader>-", "<Nop>") -- LazyVim unbind
map("n", "<leader>|", "<Nop>") -- LazyVim unbind

-- -- Pane Navigation
-- vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", { desc = "Go to Left Pane" })
-- vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", { desc = "Go to Right Pane" })
-- vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", { desc = "Go to Upper Pane" })
-- vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", { desc = "Go to Lower Pane" })

-- -- Move window
-- vim.keymap.set("n", "sw", "<C-w>w")
-- vim.keymap.set("", "s<left>", "<C-w>h")
-- vim.keymap.set("", "s<up>", "<C-w>j")
-- vim.keymap.set("", "s<down>", "<C-w>k")
-- vim.keymap.set("", "s<right>", "<C-w>l")
-- vim.keymap.set("", "sh", "<C-w>h")
-- vim.keymap.set("", "sj", "<C-w>j")
-- vim.keymap.set("", "sk", "<C-w>k")
-- vim.keymap.set("", "sl", "<C-w>l")

-- Resize window
-- vim.keymap.set("n", "<C-w>_", "2<C-w>-") -- For Macos
-- vim.keymap.set("n", "<C-w><left>", "<C-w><")
-- vim.keymap.set("n", "<C-w><right>", "<C-w>>")
-- vim.keymap.set("n", "<C-w><up>", "<C-w>+")
-- vim.keymap.set("n", "<C-w><down>", "<C-w>-")
-- Resize window using <ctrl> arrow keys
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- -- [Unnecessary] Tab Navigation
-- -- https://unix.stackexchange.com/a/314150
-- map(
--   "n",
--   "<C-1>",
--   '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 1" }
-- )
-- map(
--   "n",
--   "<C-2>",
--   '<cmd>lua require("bufferline").go_to_buffer(2, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 2" }
-- )
-- map(
--   "n",
--   "<C-3>",
--   '<cmd>lua require("bufferline").go_to_buffer(3, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 3" }
-- )
-- map(
--   "n",
--   "<C-4>",
--   '<cmd>lua require("bufferline").go_to_buffer(4, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 4" }
-- )
-- map(
--   "n",
--   "<C-5>",
--   '<cmd>lua require("bufferline").go_to_buffer(5, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 5" }
-- )
-- map(
--   "n",
--   "<C-6>",
--   '<cmd>lua require("bufferline").go_to_buffer(6, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 6" }
-- )
-- map(
--   "n",
--   "<C-7>",
--   '<cmd>lua require("bufferline").go_to_buffer(7, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 7" }
-- )
-- map(
--   "n",
--   "<C-8>",
--   '<cmd>lua require("bufferline").go_to_buffer(8, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 8" }
-- )
-- map(
--   "n",
--   "<C-9>",
--   '<cmd>lua require("bufferline").go_to_buffer(9, true)<cr>',
--   { silent = true, desc = "Switch to Tab (BufferLine) 9" }
-- )
