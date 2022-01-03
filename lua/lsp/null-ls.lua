local null_ls_ok, null_ls = pcall(require, "null_ls")
if not null_ls_ok then
  return
end
local test_rename = "testing"
print(test_rename)

local formmatting = null_ls.builtins.formmatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formmatting.prettier.with {
      filetypes= {
        'javascript',
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "markdown",
        "graphql"
      },
      extra_args= {'--single-quotes', '--single-quotes-jsx'}
    },
    formmatting.stylua.with({
      args = {"--indent-width", "2", "--indent-type", "Spaces", "-"}
    })
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})

