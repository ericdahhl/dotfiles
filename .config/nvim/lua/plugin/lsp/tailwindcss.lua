require('lspconfig').tailwindcss.setup{
  on_attach = function(client, bufnr)
    require('plugin.lsp').on_attach(client, bufnr)
  end,
  capabilities = require('plugin.lsp').capabilities,
}
