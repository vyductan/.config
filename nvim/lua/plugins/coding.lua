return {
  -- TODO: show import source
  -- https://github.com/hrsh7th/nvim-cmp/issues/98
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- add border
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "barrett-ruth/import-cost.nvim",
    build = "sh install.sh pnpm",
    opts = {},
  },
}
