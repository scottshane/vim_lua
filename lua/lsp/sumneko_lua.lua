-- https://github.com/jose-elias-alvarez/dotfiles/blob/main/config/nvim/lua/lsp/sumneko_lua.lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local settings = {
  Lua = {
    runtime = {
      path = runtime_path,
    },
    diagnostics = {
      globals = { "vim", "use" },
      disable = { "lowercase-global" },
    },
    workspace = {
      library = vim.api.nvim_get_runtime_file("", true),
    },
    telemetry = {
      enable = false,
    },
    completion = {
      showWord = "Disable",
      callSnippet = "Disable",
    },
  },
}

local M = {}

M.setup = function(on_attach, capabilities)
  local luadev = require("lua-dev").setup {
    lspconfig = {
      on_attach = on_attach,
      settings = settings,
      flag = {
        debounce_text_change = 150,
      },
      capabilities = capabilities,
    },
  }
  require("lspconfig").sumneko_lua.setup(luadev)
end
return M
