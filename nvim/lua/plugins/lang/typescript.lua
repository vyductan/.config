return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          -- Select typescript version doesn't work correctly in monorepo
          -- https://github.com/yioneko/vtsls/issues/167#issuecomment-2162166505
          root_dir = function()
            local lazyvimRoot = require("lazyvim.util.root")
            return lazyvimRoot.git()
          end,
          -- settings = {
          --   vtsls = {
          --     autoUseWorkspaceTsdk = true,
          --     -- enablePromptUseWorkspaceTsdk = true,
          --     preferences = {
          --       autoImportFileExcludePatterns = {
          --         "next/router.d.ts",
          --         "next/dist/client/router.d.ts",
          --       },
          --     },
          --     tsdk = "node_modules/typescript/lib",
          --   },
          -- },
          -- keys = {
          --   {
          --     "<leader>cz",
          --     function()
          --       LazyVim.lsp.execute({ command = "typescript.openTsServerLog" })
          --     end,
          --     desc = "Selec??n",
          --   },
          -- },
        },
      },
    },
  },
}
