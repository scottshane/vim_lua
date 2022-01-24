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
      root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", "package.json"),
      on_attach = function(client, bufnr)
        vim.cmd "echo on_attach function definitions"
        client.resolved_capabilities.document_formatting = true
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      settings = {
        codeActionOnSave = {
          enable = true,
          mode = "all",
        },
        debug = false,
        log = {
          enable = false,
          level = "trace",
          use_console = "sync",
        },
        format = {
          enable = true,
        },
      },
    }
  end,
}

return M
