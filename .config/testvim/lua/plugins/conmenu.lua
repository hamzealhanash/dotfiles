return {
    "meznaric/conmenu",
    dependencies = { "ThePrimeagen/git-worktree.nvim", "tpope/vim-dispatch" },
    keys = {
        {
            "<leader><leader>",
            "<CMD>ConMenu<CR>",
            { silent = true, desc = "Open context menu" },
        },
    },
    init = function()
        vim.g["conmenu#default_menu"] = {

            { " H-Terminal", ":lua require('nvterm.terminal').toggle 'horizontal'" },
            { " V-terminal", ":lua require('nvterm.terminal').toggle 'vertical'" },

            { "────────────────────────" },
            {
                "󰊢 Git",
                {
                    { "  Worktree Add", "git worktree add" },
                    { "  Worktree List", "git worktree list" },
                    { "  Worktree Remove", "git worktree remove" },
                },
            },
            {
                " dotfiles",
                {
                    { " nvchad", ":e ~/.config/nvim/init.lua" },
                    { " myconfig", ":e ~/.config/testvim/init.lua" },
                    { "󰒲 lazyvim", "e ~/.config/lazyvim/init.lua" },
                    { " Fish", ":e ~/.config/fish/config.fish" },
                    { "󰍹 fastfetch", "~/.config/fastfetch/config.jsonc" },
                },
            },
            {
                "󰒲 Lazy",
                {
                    { "󰒲 Show UI", ":Lazy" },
                    { "󰚰 Update", ":Lazy update" },
                    { " Sync", ":Lazy sync" },
                    { "󰑓 Reload", ":Lazy reload" },
                },
            },
            {
                "󱁤 Utils",
                {
                    { " Database", ":DBUI" },
                    { "󰋗 Help", ":call ShowDocumentation()" },
                },
            },
            { "────────────────────────" },
            { "󰈆 Quit All", ":qa<CR>" },
            { "󰸨 Save and Quit All", ":wqa<CR>" },
            { " Save ", ":w<CR>" },
            { " Save As", ":w <filename><CR>" },
        }
        vim.api.nvim_set_hl(0, "KeyHighlight", { fg = "#569CD6" })
    end,
}