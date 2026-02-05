-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Liquid
-- local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
-- if not configs.liquid then
--   configs.liquid = {
--     default_config = {
--       cmd = { "shopify", "theme", "language-server" },
--       filetypes = { "liquid" },
--       root_dir = lspconfig.util.root_pattern(".theme-check.yml"),
--       settings = {},
--     },
--   }
-- end
-- lspconfig.liquid.setup({})
