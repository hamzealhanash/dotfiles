local language_servers = {
    "bashls",
    "clangd",
    "cssls",
    "html",
    "jdtls", -- Java Language Server
    "jsonls",
    "lemminx", -- XML Language Server
    "lua_ls",
    "sqlls",
    "ts_ls",
    "yamlls",
}
local mason_tools = {
    "clang-format",
    "eslint_d",
    "google-java-format",
    "java-debug-adapter",
    "java-test",
    "jq",
    "prettier",
    "pylint",
    "sql-formatter",
    "stylua",
    "xmlformatter",
}
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        {
            "folke/neodev.nvim",
            opts = { library = { plugins = false } },
        },
        -- Useful status updates for LSP
        { "j-hui/fidget.nvim", opts = {} },
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local map = vim.keymap.set
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        local diagnostics = require("plugins.lsp.config.diagnostics")
        local formatter = require("plugins.lsp.config.formatter")

        require("mason").setup()
        -- Setup diagnostics
        diagnostics.setup_diagnostics()

        -- Used to enable autocompletion
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            has_cmp and cmp_nvim_lsp.default_capabilities() or {}
        )

        local on_attach = function()
            local cmp = require("cmp")
            vim.diagnostic.config({ virtual_text = true })
            map(
                "n",
                "<leader>cr",
                vim.lsp.buf.rename,
                { desc = "LSP: Rename every thing selected" }
            )
            map(
                "n",
                "<leader>cf",
                require("telescope.builtin").lsp_references,
                { desc = "Show all same function used in other places" }
            )
            map("i", "<C-q>", cmp.abort, { desc = "close the completion menu" })
            map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Show Code Action " })
            map("n", "<leader>cs", vim.lsp.buf.hover, { desc = "Show func/var/class info" })
            map("i", "<C-space>", cmp.complete, { desc = "Show completion menu" })
        end

        mason_lspconfig.setup({
            ensure_installed = language_servers,
            automatic_installation = true,
            handlers = {
                function(server)
                    local opts = {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = { debounce_text_changes = 150 },
                    }
                    local extend, user_config = pcall(require, "plugins.lsp.servers." .. server)

                    if extend then
                        opts =
                            vim.tbl_deep_extend("force", opts, user_config.setup_and_get_config())
                    end
                    if server ~= "jdtls" then
                        lspconfig[server].setup(opts)
                    end
                end,
            },
        })

        require("mason-tool-installer").setup({
            ensure_installed = mason_tools,
        })

        -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
        local open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or "rounded" -- Set border to rounded
            return open_floating_preview(contents, syntax, opts, ...)
        end
    end,
}