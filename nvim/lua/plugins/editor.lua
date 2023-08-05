return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- search key shortcuts
      { "<leader><space>", false },
    },
    config = function(_)
      require("telescope").load_extension("diff")
    end,
  },
}
