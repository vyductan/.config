return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          local tw = require("lspconfig.configs.tailwindcss")
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Additional settings for Phoenix projects
          opts.settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
              classAttributes = {
                "class",
                "className",
                "ngClass",
                "\\w+(Cls)",
                "classNames",
              },
              experimental = {
                -- configFile = "./@acme/tailwind/web.ts",
                classRegex = {
                  -- clsm
                  { "clsm\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                  -- headlessui transition
                  "(?:enter|leave)(?:From|To)?=\\s*(?:\"|'|{`)([^(?:\"|'|`})]*)",
                  -- shadcn-ui
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  -- tailwind-variants
                  { "([\"'`][^\"'`]*.*?[\"'`])", "[\"'`]([^\"'`]*).*?[\"'`]" },

                  -- { "([a-zA-Z0-9\\-:]+)" },
                },
              },
            },
          }

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       tailwindcss = {
  --         -- root_dir = "tailwind.config.ts",
  --         -- root_dir = root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.cjs', 'postcss.config.mjs', 'postcss.config.ts', 'package.json', 'node_modules', '.git'),
  --         settings = {
  --           tailwindCSS = {
  --             classAttributes = {
  --               "class",
  --               "className",
  --               "ngClass",
  --               "\\w+(Cls)",
  --               "classNames",
  --             },
  --             -- classRegex
  --             -- classRegex = {
  --             --   -- clsm
  --             --   { "clsm\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
  --             --   -- headlessui transition
  --             --   "(?:enter|leave)(?:From|To)?=\\s*(?:\"|'|{`)([^(?:\"|'|`})]*)",
  --             --   -- shadcn-ui
  --             --   { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
  --             --   { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
  --             --   -- classNames
  --             --   -- { "classNames: \\{\\s*[^}]*?\\b([a-zA-Z0-9-_:\\/\\s]+)\\b[^}]*\\}", "[\"'`]([^\"'`]*?)[\"'`]" },
  --             --   -- { "classNames\\(([^)]+)\\)", "'([^']*)'" },
  --             --   -- { "classNames:\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
  --             -- },
  --             experimental = {
  --               classRegex = {
  --                 -- clsm
  --                 { "clsm\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
  --                 -- headlessui transition
  --                 "(?:enter|leave)(?:From|To)?=\\s*(?:\"|'|{`)([^(?:\"|'|`})]*)",
  --                 -- shadcn-ui
  --                 { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
  --                 { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
  --                 { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
  --
  --                 { "([a-zA-Z0-9\\-:]+)" },
  --                 -- classNames
  --                 -- { "classNames: \\{\\s*[^}]*?\\b([a-zA-Z0-9-_:\\/\\s]+)\\b[^}]*\\}", "[\"'`]([^\"'`]*?)[\"'`]" },
  --                 -- { "classNames\\(([^)]+)\\)", "'([^']*)'" },
  --                 -- { "classNames:\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
  --               },
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
