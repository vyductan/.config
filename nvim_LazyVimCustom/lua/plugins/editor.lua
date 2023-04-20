return {
  {
  "folke/which-key.nvim",
  opts = {},
  config = function(_, otps)
    local wk = require("which-key")
    wk.setup(otps)
    end,
  }
}
