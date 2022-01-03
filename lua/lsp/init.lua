local u = require "utils"

local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
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
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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

  --[[ REFACTORED
  --shortcut
  local function map(...)
   vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local mapopts = { noremap = true, silent = true }
  map("n", "<space>D", "<cmd>lua vim.lsp.buf.typedefinition()<CR>", mapopts)
  map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", mapopts)
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", mapopts)
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", mapopts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", mapopts)
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", mapopts)
  map("n", "<C-x><C-x>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", mapopts)
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", mapopts)
  map("n", "<space>ld", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", mapopts)
  map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", mapopts)
  map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", mapopts)
  map("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", mapopts)
  map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = false })
  ]]

  if client.resolved_capabilities.document_formatting then
    -- vim.cmd "autocmd BufWritePre <buffer> lua global.lsp.formatting()"
    vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)"
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

--thePrimeagen
local function config(_cfg)
  return vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
  }, _cfg or {})
end

local servers = { "tsserver", "html", "cssls", "jsonls" }
for _, ls in ipairs(servers) do
  lsp[ls].setup(config())
end

for _, svr in ipairs { "sumneko_lua", "eslint" } do
  require("lsp." .. svr).setup(on_attach, capabilities)
end
