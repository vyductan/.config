return {
  -- {
  --   "windwp/nvim-ts-autotag",
  --   opts = {
  --     --       autotag = true,
  --     -- -- Fix issue slash "<div /" -> "<div /div>" https://github.com/windwp/nvim-ts-autotag/issues/125#issuecomment-1655438951
  --     -- enable_close_on_slash = false,
  --
  --     -- Fix issue slash "<div /" -> "<div /div>" https://github.com/windwp/nvim-ts-autotag/issues/125#issuecomment-1655438951
  --     autotag = {
  --       autotag = true,
  --       enable_close_on_slash = false,
  --     },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    opts = {
      -- ensure_installed = {
      --   "comment",
      --   "prisma",
      -- },
      autotag = {
        -- Setup autotag using treesitter config.
        enable = true,
        -- Fix issue slash "<div /" -> "<div /div>" https://github.com/windwp/nvim-ts-autotag/issues/125#issuecomment-1655438951
        enable_close_on_slash = false,
      },
    },
  },
  -- disable nvim-treesitter-context https://github.com/LazyVim/LazyVim/issues/1725
}
