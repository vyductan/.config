return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    otps = {},
    config = function(_opts)
      require('mason-lspconfig').setup({
        automatic_installation = true
      })
    end
  },
  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        -- root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          null_ls.builtins.diagnostics.fish,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
          -- nls.builtins.formatting.stylua,
          -- nls.builtins.formatting.shfmt,
          -- nls.builtins.formatting.fish_indent,
          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    otps = {},
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
}
