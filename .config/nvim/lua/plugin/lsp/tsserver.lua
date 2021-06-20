require('lspconfig').tsserver.setup{
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    require('plugin.lsp').on_attach(client, bufnr)
  end,
  capabilities = require('plugin.lsp').capabilities,
}

