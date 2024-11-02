return {
  "stevearc/overseer.nvim",
  event = { "BufReadPre", "BufWritePre", "BufNewFile" },
  opts = {},
  config = function()
    require("overseer").setup()
  end,
}