return {
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      fps = 60,
      stages = "fade",
    },
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- separator_style = "slant",
        -- indicator = {
        --   style = "underline",
        -- },
      },
      highlights = {
        -- indicator_selected = {
        --   fg = "#FF0000",
        --   bg = "#FF0000",
        -- },
        buffer_selected = {
          bold = true,
        },
        -- separator = {
        --   fg = "#073642",
        --   bg = "#002b36",
        -- },
        -- separator_selected = {
        --   fg = "#073642",
        -- },
        -- background = {
        --   fg = "#657b83",
        --   bg = "#002b36",
        -- },
        -- fill = {
        --   bg = "#073642",
        -- },
      },
    },
  },
  -- noice.nvim
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["cmp.entry.get_documentation"] = true, -- fix warning checkhealth
        },
      },
    },
  },
}
