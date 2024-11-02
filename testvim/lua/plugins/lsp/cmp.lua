return {
    {

        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets", -- Collection of snippet
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local icons = require("icons")
            local cmp_window = require("cmp.config.window")
            local defaults = require("cmp.config.default")()

            -- Load collection of snippets from plugin "rafamadriz/friendly-snippets"
            require("luasnip.loaders.from_vscode").lazy_load()

            local check_backspace = function()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
            end

            local has_words_before = function()
                local bufnr = vim.api.nvim_get_current_buf()
                if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "prompt" then
                    return false
                end
                table.unpack = table.unpack or unpack -- Lua 5.1 compatibility
                local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api
                            .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
                            :match("^%s*$")
                        == nil
            end

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noselect",
                    keyword_length = 2,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                sorting = defaults.sorting,
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end),
                    ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end),
                }),

                formatting = {
                    fields = { "abbr", "kind" },
                    format = function(en, item)
                        local ELLIPSIS_CHAR = icons.ui.Ellipsis
                        local MAX_LABEL_WIDTH = 50
                        local MIN_LABEL_WIDTH = 50

                        item.menu = ({
                            nvim_lua = " ",
                            path = " ",
                            vsnip = " ",
                            spell = " ",
                        })[en.source.name]
                        local label = item.abbr
                        local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)

                        if truncated_label ~= label then
                            item.abbr = truncated_label .. ELLIPSIS_CHAR
                        elseif string.len(label) < MIN_LABEL_WIDTH then
                            local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
                            item.abbr = label .. padding
                        end
                        item.kind = string.format(" %s  %s", icons.kind[item.kind], item.kind) -- This concatonates the icons with the name of the item kind
                        return item
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "emoji" },
                    { name = "nvim_lua" },
                    { name = "path" },
                }),
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = cmp_window.bordered(),
                    documentation = cmp_window.bordered(),
                },
            })
        end,
    },
}
