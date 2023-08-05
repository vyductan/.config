return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  maxLineLength = 120,
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      -- nls.setup({
      --   debug = true,
      -- })
      table.insert(
        opts.sources,
        nls.builtins.formatting.black.with({
          extra_args = {
            "--line-length=120",
          },
        })
      )
    end,
  },
}
