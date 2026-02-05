return {
  -- {
  --
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "theme_check",
  --       "curlylint",
  --     })
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        theme_check = {},
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        ["liquid"] = { "curlylint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["liquid"] = { "prettier" },
      },
    },
  },
}
