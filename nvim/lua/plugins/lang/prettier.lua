return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "prettierd")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(
        opts.sources,
        nls.builtins.formatting.prettierd.with({
          -- extra_args = {
          --   -- "--no-semi",
          --   "--single-quote",
          --   "--single-attribute-per-line",
          --   "--jsx-single-quote",
          -- },
        })
      )
    end,
  },
}
