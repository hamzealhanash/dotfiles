local map = vim.keymap.set
---global
map("n", "<C-s>", "<cmd>w<CR>", { desc = "General Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General Copy whole file" })

map("n", "<C-DOWN>", ":m .+1<CR>==") -- move line up(n)

map("n", "<C-UP>", ":m .-2<CR>==") -- move line down(n)

map("v", "<C-DOWN>", ":m '>+1<CR>gv=gv") -- move line up(v)

map("v", "<C-UP>", ":m '<-2<CR>gv=gv") -- move line down(v)

map("n", "<C-B>", "<cmd> lua vim.ui.open(vim.fn.expand('%')) <cr>")

---------==> File fromat <==---------
map("n", "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "General Format file" })

---------==> npm info <==---------
local npmap = vim.api.nvim_set_keymap
map(
    "n",
    "<leader>nt",
    require("package-info").toggle,
    { silent = true, noremap = true, desc = "pkginfo: Show/Hide dependency versions" }
)
map(
    "n",
    "<LEADER>ns",
    require("package-info").show,
    { silent = true, noremap = true, desc = "pkginfo: Display Latest Package Version" }
)

map(
    "n",
    "<leader>nd",
    require("package-info").delete,
    { silent = true, noremap = true, desc = "pkginfo: Delete Dependency" }
)
npmap(
    "n",
    "<leader>ni",
    "<cmd>lua require('package-info').install()<cr>",
    { silent = true, noremap = true, desc = "pkginfo: Install New Dependency" }
)
--------- NeoTree ---------
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvim-tree: focus window" })

--------- telescope ---------
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map(
    "n",
    "<leader>fz",
    "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    { desc = "telescope find in current buffer" }
)
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "telescope find all files" }
)

--------- theme picker ---------
map("n", "<leader>th", function()
    require("nvchad.themes").open()
end, { desc = "themes: open nvchad themes" })

--------- nvterm ---------
map("n", "<leader>h", function()
    require("nvterm.terminal").toggle("horizontal")
end, { desc = "terminal open terminal in horizontal way" })

map("n", "<leader>v", function()
    require("nvterm.terminal").toggle("vertical")
end, { desc = "terminal open terminal in vertical way" })