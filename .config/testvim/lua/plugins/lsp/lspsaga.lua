return {
    "nvimdev/lspsaga.nvim",
    event = { "LspAttach" },
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
        "DaikyXendo/nvim-material-icon", -- optional
    },
}