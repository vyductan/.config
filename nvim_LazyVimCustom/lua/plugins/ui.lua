return {
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
   -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
   -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
    -- statusline
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function(plugin)
        local icons = require("config.icons")
        return {
          options = {
            icons_enabled = true,
            theme = 'solarized_dark',
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            disabled_filetypes = {}
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = {
              {
                     "diagnostics",
                      symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                      },
                    },
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    {
                          'filename',
              file_status = true, -- displays file status (readonly status, modified status)
               --symbols = { modified = "  ", readonly = "", unnamed = "" }
              path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            } },
            lualine_x = {
              'encoding',
              'filetype'
            },
            lualine_y = { { "progress", separator = " ", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } }, },
            lualine_z = {
                    function()
                      return " " .. os.date("%R")
                    end,
                  },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            } },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          extensions = { 'fugitive' }
        }
      end,
    }
}
