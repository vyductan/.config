return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><space>", false },
    },
    config = function(_)
      require("telescope").load_extension("diff")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
