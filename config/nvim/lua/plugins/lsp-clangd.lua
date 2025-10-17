return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { "clangd", "--compile-commands-dir=." },
          -- opcional: melhora o autocomplete
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          on_attach = function(client, bufnr)
            -- exemplo: atalhos LSP
            local bufmap = function(mode, lhs, rhs)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
            end
            bufmap("n", "K", vim.lsp.buf.hover)
            bufmap("n", "gd", vim.lsp.buf.definition)
          end,
        },
      },
    },
  },
}
