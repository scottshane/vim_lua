local M = {
  setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig["eslint"].setup {
      cmd = { "eslint_d", "--stdio" },
      filetypes = {
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "typescript",
        "typescriptreact",
        "css",
        "less",
        "scss",
        "markdown",
        "pandoc",
      },
      root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js"),
      on_attach = function(client, bufnr)
        print "on_attach function definitions"
        client.resolved_capabilities.document_formatting = true
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      settings = {
        codeActionOnSave = {
          enable = true,
          mode = "all",
        },
        format = {
          enable = true,
        },
      },
    }
  end,
}

return M
