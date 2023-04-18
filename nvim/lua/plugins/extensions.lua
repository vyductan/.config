return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        keys = {
          { "<leader>en", "<cmd>Navbuddy<cr>", desc = "Code Structure" },
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
  },
  {
    "jemag/telescope-diff.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
      { "<leader>ed", "", desc = "+ Diff files" },
      {
        "<leader>edc",
        function()
          require("telescope").extensions.diff.diff_current({ hidden = true })
        end,
        desc = "Compare current",
      },
      {
        "<leader>edd",
        function()
          require("telescope").extensions.diff.diff_files({ hidden = true })
        end,
        desc = "Compare 2 files",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>eg", "<cmd>DiffviewOpen<cr>", desc = "Git Diff" },
    },
    opts = {},
  },
}
