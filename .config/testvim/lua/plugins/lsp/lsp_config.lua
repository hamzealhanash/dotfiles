local servers = {
    html = { cmd = { "html-lsp", "--stdio" } },
    cssls = { cmd = { "css-languageserver", "--stdio" } },
    eslint = { cmd = { "eslint", "--stdin-tolerant", "--stdin-filename", "%uri" } },
    bashls = { cmd = { "bash-language-server", "--stdio" } },
    ts_ls = { cmd = { "ts-language-server", "--stdio" } },
    pylsp = { cmd = { "pylsp", "--stdio" } },
    jsonls = { cmd = { "json-languageserver", "--stdio" } },
    yamlls = { cmd = { "yamlls", "--stdio" } },
}
return {
    { "mfussenegger/nvim-jdtls" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        event = { "BufWritePre", "BufReadPre", "BufNewFile" },
        config = function()
            local mason = require("mason")
            local mason_lsp = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local mason_tool_installer = require("mason-tool-installer")
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            ---------------==> mason  <==------------------
            mason.setup({
                ui = {
                    icons = {
                        package = "",
                        installed = "✔",
                        pending = "⏳",
                        failed = "✘",
                    },
                    border = "rounded",
                },
            })
            ----------==> mason-lspconfig <==------------
            mason_lsp.setup({
                ensure_installed = {
                    "html",
                    "cssls",
                    "eslint",
                    "bashls",
                    "ts_ls",
                    "pylsp",
                    "jsonls",
                    "yamlls",
                },
                automatic_installation = true,
                handlers = {
                    function(server)
                        local opts = {
                            capabilities = capabilities,
                            flags = {
                                debounce_text_changes = 150,
                            },
                        }

                        local extend, user_config = pcall(require, "plugins.lsp.servers." .. server)

                        if extend then
                            opts = vim.tbl_deep_extend(
                                "force",
                                opts,
                                user_config.setup_and_get_config()
                            )
                        end
                        if server ~= "jdtls" then
                            lspconfig[server].setup(opts)
                        end
                    end,
                },
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "html",
                    "cssls",
                    "eslint",
                    "bashls",
                    "ts_ls",
                    "pylsp",
                    "jsonls",
                    "yamlls",
                },
            })
            -----------==> lsp config <==-----------------

            local on_attach = function(_, _)
                vim.keymap.set(
                    "n",
                    "<leader>cr",
                    vim.lsp.buf.rename,
                    { desc = " Renames all references to the symbol under the cursor" }
                )
                ---
                vim.keymap.set(
                    "n",
                    "<leader>ca",
                    vim.lsp.buf.code_action,
                    { desc = "Show Code Action for the line under the curser" }
                )
                ---
                vim.keymap.set(
                    "n",
                    "<leader>cc",
                    vim.lsp.buf.hover,
                    { desc = "show func/var/class info" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>cf",
                    require("telescope.builtin").lsp_references,
                    { desc = "Show all same function used in other places" }
                )
            end
            -- Used to enable autocompletion
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {}
            )
            local open_floating_preview = vim.lsp.util.open_floating_preview

            lspconfig.html.setup({})
            lspconfig.cssls.setup({})
            lspconfig.eslint.setup({})
            lspconfig.bashls.setup({})
            lspconfig.ts_ls.setup({})
            lspconfig.pylsp.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.yamlls.setup({})

            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })
        end,
    },
}
