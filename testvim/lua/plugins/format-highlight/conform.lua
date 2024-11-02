return {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({

            formatters_by_ft = {
                lua = { "stylua" },
                css = { "prettierd" },
                html = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                sql = { "sql-formatter" },
                python = { "isort" },
                json = { "prettierd" },
                rust = { "rustywind" },
                xml = { "xmlformatter" },
                yaml = { "yamlfmt" },
                c = { "clang-format" },
                java = { "google-java-format" },
                bash = { "beautysh" },
                [""] = { "prettierd" },
            },

            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
    end,
}