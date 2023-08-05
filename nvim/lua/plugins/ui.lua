return {
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
  -- pretty_hover
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
    keys = {
      {
        "<C-i>",
        function()
          require("pretty_hover").hover()
        end,
        mode = { "n", "i", "v" },
        desc = "Hover - Info - Signature",
      },
    },
  },
}
