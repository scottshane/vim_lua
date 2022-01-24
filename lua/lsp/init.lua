local u = require "utils"

local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
  print "lspconfig require failed"
  return
end
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  print "cmp_nvim_lsp require failed"
  return
end

-- Debugging
--[[ vim.lsp.set_log_level 'debug'
if vim.fn.has 'nvim-0.5.1' == 1 then
    require('vim.lsp.log').set_format_func(vim.inspect)
end

local border_opts = { border = "single", focusable = false, scope = "line" }
vim.diagnostic.config { virtual_text = false, float = border_opts }
]]

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
    headrer = "",
    prefix = "",
  },
}

local border_opts = { border = "single", focusable = false, scope = "line" }
-- vim.diagnostic.config { virtual_text = false, float = border_opts }
vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border_opts)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_opts)

local preferred_formatting_clients = { "eslint_d", "prettierd" }
local fallback_formatting_client = "null-ls"

local formatting = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local selected_client
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if vim.tbl_contains(preferred_formatting_clients, client.name) then
      selected_client = client
      break
    end
    if client.name == fallback_formatting_client then
      selected_client = client
    end
    if not selected_client then
      return
    end
  end
  local params = vim.lsp.util.make_formatting_params()
  local result, err = selected_client.request_sync("textDocument/formatting", params, 5000, bufnr)
  if result and result.result then
    vim.lsp.util.apply_text_document_edit(result.result, bufnr)
  elseif err then
    vim.notify("global.lsp.formatting: " .. err, vim.log.level.WARN)
  end
end
-- Move to init.lua
global = {}
global.lsp = {
  border_opts = border_opts,
  formatting = formatting,
}

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd "autocmd BufWritePre <buffer> lua global.lsp.formatting()"
    -- vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)"
  end

  -- commands
  u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
  u.lua_command("LspRename", "vim.lsp.buf.rename()")
  u.lua_command("LspHover", "vim.lsp.buf.hover()")
  u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
  u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")
  u.lua_command("LspDiagPrev", "vim.diagnostic.goto_prev()")
  u.lua_command("LspDiagNext", "vim.diagnostic.goto_next()")
  u.lua_command("LspDiagQuickfix", "vim.diagnostic.setqflist()")
  u.lua_command("LspDeclaration", "vim.lsp.buf.declaration()")
  u.lua_command("LspDefinition", "vim.lsp.buf.definition()")
  u.lua_command("LspImplementation", "vim.lsp.buf.implementation()")
  u.lua_command("LspReferences", "vim.lsp.buf.references()")
  u.lua_command("LspDiagLocList", "vim.lsp.diagnostic.set_loclist()")
  u.lua_command("LspShowLineDiag", "vim.lsp.diagnostic.show_line_diagnostics()")
  --binding
  u.buf_map(bufnr, "n", "<leader>f", ":LspFormatting<CR>")
  u.buf_map(bufnr, "n", "<leader>rn", ":LspRename<CR>")
  u.buf_map(bufnr, "n", "K", ":LspHover<CR>")
  u.buf_map(bufnr, "n", "<leader>D", ":LspTypeDef<CR>")
  u.buf_map(bufnr, "n", "[d", ":LspDiagPrev<CR>")
  u.buf_map(bufnr, "n", "d]", ":LspDiagNext<CR>")
  u.buf_map(bufnr, "n", "<leader>q", ":LspDiagQuickfix<CR>")
  u.buf_map(bufnr, "i", "<C-x><C-x>", ":LspSignatureHelp<CR>")
  u.buf_map(bufnr, "n", "gD", ":LspDeclaration<CR>")
  u.buf_map(bufnr, "n", "gd", ":LspDefinition<CR>")
  u.buf_map(bufnr, "n", "gi", ":LspImplementation<CR>")
  u.buf_map(bufnr, "n", "gr", ":LspReferences<CR>")
  u.buf_map(bufnr, "n", "<leader>q", ":LspDiagLocList<CR>")
  u.buf_map(bufnr, "n", "<leader>ln", ":LspShowLineDiag<CR>")

  --[[ MOVE TO TELESCOPE COMNFIG
  map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", mapopts)
  map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", mapopts)
  map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", mapopts)
  map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", mapopts)
  ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

--thePrimeagen
local function pmg_config(_cfg)
  return vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
  }, _cfg or {})
end

local servers = { "html", "cssls" }
for _, ls in ipairs(servers) do
  lsp[ls].setup(pmg_config())
end

lsp["jsonls"].setup {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lsp["tsserver"].setup {
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    local ts_utils = require "nvim-lsp-ts-utils"
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,
      import_all_timeout = 5000,
      import_all_priorities = {
        same_file = 1,
        local_file = 2,
        buffer_content = 3,
        buffers = 4,
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      filter_out_diagnostics_by_serverity = {},
      filter_out_diagnostics_by_code = { 80001 },
      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,
    }

    ts_utils.setup_client(client)
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}
--lua
require("lsp.sumneko_lua").setup(on_attach, capabilities)

local null_ls = require "null-ls"
null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with { diagnostics_format = "[#{c}] #{m} (#{s})" },
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd.with({disable_filetypes = {"json"}}),
  },
  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)"
    end
  end,
  capabilities = capabilities,
}

-- supress lsp notifications
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match "%[lspconfig%]" then
    return
  end
  notify(msg, ...)
end
