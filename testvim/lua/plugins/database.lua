return {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
        {
            "<leader>bd",
            "<CMD>DBUI<CR>",
            desc = "show database interactive ui",
        },
    },
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { "sql", "mysql", "plsql" },
            lazy = true,
        }, -- Optional
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_auto_execute_table_helpers = 1
    end,
}
