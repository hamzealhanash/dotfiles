return {
    "folke/trouble.nvim",
    event = { "LspAttach" },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>td",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Trouble Diagnostics",
        },
        {
            "<leader>tD",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Trouble Buffer Diagnostics",
        },
        {
            "<leader>ts",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = " Trouble Symbols ",
        },
        {
            "<leader>tt",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = " Trouble LSP Definitions / references / ...",
        },
        {
            "<leader>tl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Trouble Location List",
        },
        {
            "<leader>tq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Trouble Quickfix List",
        },
    },
}