return {
  -- {
  --   "barrett-ruth/import-cost.nvim",
  --   build = "sh install.sh bun",
  --   -- build = "sh install.sh pnpm",
  --   opts = {},
  -- },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- opts = {
  --   --   filetype_extend = {
  --   --     typescript = { "react-es7" },
  --   --   },
  --   -- },
  --   opts = function(_, opts)
  --     local ls = require("luasnip")
  --     ls.filetype_extend("typescript", "react-es7")
  --     return opts
  --     -- nls.setup({
  --     --   debug = true,
  --     -- })
  --     -- table.insert(
  --     --   opts.sources,
  --     --   nls.builtins.formatting.black.with({
  --     --     extra_args = {
  --     --       "--line-length=120",
  --     --     },
  --     --   })
  --     -- )
  --   end,
  -- },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- show the completions even if there's whitespace before the cursor
      -- https://github.com/hrsh7th/nvim-cmp/discussions/1353
      -- vim.api.nvim_create_autocmd("CursorHoldI", {
      --   group = vim.api.nvim_create_augroup("cmp_complete_on_space", {}),
      --   callback = function()
      --     local line = vim.api.nvim_get_current_line()
      --     local cursor = vim.api.nvim_win_get_cursor(0)[2]
      --
      --     if string.sub(line, cursor, cursor + 1) == " " then
      --       require("cmp").complete()
      --     end
      --   end,
      -- })
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  -- -- apply react-es7 snippets for "ts" file
  -- {
  --   "rafamadriz/friendly-snippets",
  --   config = function()
  --     local ls = require("luasnip")
  --     -- ls.filetype_extend("typescript", { "typescriptreact" })
  --     ls.filetype_extend("typescript", { "tsdoc" })
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --   end,
  -- },
  {
    "gbprod/yanky.nvim",
    keys = {
      -- stylua: ignore
      -- Keep yanked it paste in visual mode
      { "p", "<Plug>(YankyPutAfter)", mode = { "n" }, desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n" }, desc = "Put yanked text before cursor" },
      { "P", "<Plug>(YankyPutAfter)", mode = { "x" }, desc = "Put yanked text after cursor" },
      { "p", "<Plug>(YankyPutBefore)", mode = { "x" }, desc = "Put yanked text before cursor" },
    },
  },
}
