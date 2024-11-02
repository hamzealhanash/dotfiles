return {
    "windwp/nvim-ts-autotag",
    event = { "LspAttach" },
    ft = {
        "javascriptreact",
        "html",
        "typescriptreact",
    },
    config = function()
        require("nvim-ts-autotag").setup()
    end,
}