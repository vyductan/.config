return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      {
        automatic_installation = true,
        -- ensure_installed = {
        --   "tsserver",
        --   "pylsp",
        -- },
      },
    },
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "flake8",
  --       "black",
  --     },
  --   },
  -- },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = { { "nvim-tree/nvim-web-devicons" }, { "nvim-treesitter/nvim-treesitter" } },
    keys = {
      { "\\\\", "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "t" } },
    },
    config = function()
      require("lspsaga").setup({})
    end,
  },
}
