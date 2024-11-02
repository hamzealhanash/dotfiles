return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>wk",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "which-key-trigger Buffer Local Keymaps",
        },
    },
}
