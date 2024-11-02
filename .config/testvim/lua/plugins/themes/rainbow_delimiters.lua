return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPre", "BufWritePre", "BufNewFile" },
  config = function()
    local rainbow = require "rainbow-delimiters"
    require("rainbow-delimiters.setup").setup {

      strategy = {
        [""] = rainbow.strategy["global"],
        vim = rainbow.strategy["local"],
      },

      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      priority = {
        [""] = 110,
        lua = 210,
      },
      highlight = {
        "RainbowDelimiterYellow",
        "RainbowDelimiterGreen",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
        "RainbowDelimiterGray",
        "RainbowDelimiterRed",
      },
    }
  end,
}