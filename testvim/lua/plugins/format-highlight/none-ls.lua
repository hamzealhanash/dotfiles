return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufWritePre", "BufNewFile" },
  config = function()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local null_ls = require "null-ls"
    null_ls.setup {

      source = {
        null_ls.builtins.formatting.prettier,
      },

      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_clear_autocmds {
            group = augroup,
            buffer = bufnr,

            callback = function()
              vim.lsp.buf.format { bufnr = bufnr }
            end,
          }
        end
      end,
    }
  end,
}
