if not vim.g.vscode then
  return {}
end

local enabled = {
  "flit.nvim",
  "lazy.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  "mini.pairs",
  "mini.surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "vim-repeat",
  "LazyVim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    vim.keymap.set("n", "<leader><space>", "<cmd>Find<cr>")
    vim.keymap.set("n", "<leader>/", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
    vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
    vim.keymap.set("n", "]d", [[<cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<cr>]])
    vim.keymap.set("n", "[d", [[<cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<cr>]])
    vim.keymap.set("n", "H", [[<cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>]])
    vim.keymap.set("n", "L", [[<cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>]])
    vim.keymap.set("n", "{", [[<cmd>call VSCodeNotify('workbench.action.moveEditorLeftInGroup')<cr>]])
    vim.keymap.set("n", "}", [[<cmd>call VSCodeNotify('workbench.action.moveEditorRightInGroup')<cr>]])
  end,
})

return {
  {
    "LazyVim/LazyVim",
    config = function(_, opts)
      opts = opts or {}
      -- disable the colorscheme
      opts.colorscheme = function() end
      require("lazyvim").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
