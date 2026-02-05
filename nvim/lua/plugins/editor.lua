return {
  -- {
  --   -- "nvim-telescope/telescope.nvim",
  --   "nvim-telescope/telescope.nvim",
  --   keys = {
  --     -- search key shortcuts
  --     -- { "<leader><space>", false },
  --     {
  --       "<leader><space>",
  --       -- require("lazyvim.util").telescope("find_files", { cwd = false }),
  --       LazyVim.pick("auto", { root = false }),
  --       desc = "Find Files (cwd)",
  --     },
  --     -- {
  --     --   "<leader>fg",
  --     --   require("lazyvim.util").telescope("files"),
  --     --   desc = "Find Git Files (root dir)",
  --     -- },
  --   },
  --   config = function(_)
  --     require("telescope").load_extension("diff")
  --   end,
  --   -- opts = { recurse_submodules = true },
  -- },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  -- {
  --   "nvim-pack/nvim-spectre",
  --   cmd = "Spectre",
  --   opts = { open_cmd = "noswapfile vnew" },
  -- -- stylua: ignore
  -- keys = {
  --   { "<leader>sR", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
  --   { "<leader>sr", function() require("spectre").open_file_search({select_word=true}) end, desc = "Replace in current file (Spectre)" },
  -- },
  -- },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      -- {
      --   "<leader>sr",
      --   function()
      --     local grug = require("grug-far")
      --     local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      --     grug.open({
      --       transient = true,
      --       prefills = {
      --         filesFilter = ext and ext ~= "" and "*." .. ext or nil,
      --       },
      --     })
      --   end,
      --   mode = { "n", "v" },
      --   desc = "Search and Replace",
      -- },
      {
        "<leader>r",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              paths = vim.fn.expand("%"),
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
