require('lspconfig').rust_analyzer.setup({

  on_attach = function(client, bufnr)
    require('plugin.lsp').on_attach(client, bufnr)
  end,

  capabilities = require('plugin.lsp').capabilities,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      --[[ procMacro = {
        enable = true
      }, ]]
    }
  }
})
