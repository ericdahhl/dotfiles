require('lspconfig').vuels.setup{

  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    require('plugin.lsp').on_attach(client, bufnr)
  end,

  capabilities = require('plugin.lsp').capabilities,
  settings = {
    vetur = {
      experimental = {
        templateInterpolationService = true,
      },
      validation = {
        templateProps = true,
      },
      completion = {
        tagCasing = 'initial',
      },
    },
  },
}
