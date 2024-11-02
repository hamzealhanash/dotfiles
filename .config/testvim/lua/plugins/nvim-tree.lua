return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "DaikyXendo/nvim-material-icon",
    },
    config = function()
        local map = vim.keymap.set
        local api = require("nvim-tree.api")
        local function opts(desc)
            return {
                desc = "nvim-tree: " .. desc,
                noremap = true,
                silent = true,
                nowait = true,
            }
        end
        local function on_attach()
            map(
                "n",
                "cd",
                api.tree.change_root_to_node,
                opts("change root location to current dirs")
            )
            map("n", "a", api.fs.create, opts("nvimtree: create file"))
            map("n", "<CR>", api.node.open.edit, opts("nvimtree: open dirs"))
            map("n", "dd", api.fs.remove, opts("nvimtree: deletes files"))
            map("n", "e", api.fs.rename_basename, opts("nvimtree: rename file (name only)"))
            map("n", "za", api.node.show_info_popup, opts("nvimtree: show file info"))
            map("n", "r", api.fs.rename_sub, opts("nvimtree: rename file to it's root"))
            map("n", "x", api.node.navigate.parent_close, opts("nvimtree: Move to the parent dir"))
            map("n", "b", api.marks.toggle, opts("nvimtree: Toggle Bookmark"))
            map("n", "m", api.fs.cut, opts("nvimtree: Move File"))
        end
        map("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", opts("Toggle file explorer"))

        require("nvim-tree").setup({
            on_attach = on_attach,
            filters = { dotfiles = false },
            disable_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                width = 40,
                preserve_window_proportions = true,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                group_empty = true,

                indent_markers = { enable = true },
                icons = {
                    glyphs = {
                        default = "󰈚",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                        },
                        git = {
                            unmerged = "",
                            ignored = "",
                            renamed = "󰗴",
                        },
                    },
                },
            },

            sort = {
                sorter = "case_sensitive",
            },
        })
    end,
}
