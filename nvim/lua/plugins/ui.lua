return {
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = {
        buffer_selected = {
          bold = true,
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = {
          -- Set not show a message if hover is not available
          -- ex: shift+k on Typescript code
          silent = true,
        },
      },
      presets = {
        -- add border
        lsp_doc_border = true,
      },
    },
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.window = {
  --       completion = cmp.config.window.bordered(),
  --       documentation = cmp.config.window.bordered(),
  --     }
  --     -- TODO: show import source
  --     -- https://github.com/hrsh7th/nvim-cmp/issues/98
  --   end,
  -- },
  -- { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
}
