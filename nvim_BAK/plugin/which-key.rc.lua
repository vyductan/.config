local ok_status, wk = pcall(require, "which-key")
if not ok_status then return end

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local vopts = {
  mode = "v",     -- VISUAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
}
local mappings = {
  d = {
    name = "Diagnostic",
    a = { "<cmd>Lspsaga code_action<CR>", "Code Action", { silent = true } },
    n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
    p = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Pre Diagnostic" },
    N = { function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
      "Next ERROR" },
    P = { function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
      "Pre ERROR" },
    c = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show Cursor Diagnostic" },
    l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostic" },
    b = { "<cmd>Lspsaga show_buffer_diagnostics<CR>", "Show Buffer Diagnostic" },
    w = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Show Workspace Diagnostic" },
  },
  f = {
    name = "File",
    f = { "<cmd>Telescope find_files<CR>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>Lspsaga code_action<CR>", "Code Action", { silent = true } }
  }
}
wk.register(mappings, opts)
wk.register(vmappings, vopts)

wk.setup({

})
