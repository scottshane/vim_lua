local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print "failed to load cmp"
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  print "failed to load luasnip"
  return
end

-- this seems stupid. But this is how the needlessly clever get shit to work.
require("luasnip/loaders/from_vscode").lazy_load()

-- this is for <Tab> & <S-Tab> cte: Chris@machine
--[[ local check_backspace= function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub("col", "col"):match "%s"
end ]]

-- this is for <Tab> & <S-Tab> cite: comp github
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --["<Tab>"] = function(fallback)
    ["<c-h>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    --["<S-Tab>"] = function(fallback)
    ["<c-l>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = "luasnip" },
    { name = "nvim_lsp", group_index = 1 },
    { name = "nvim_lua" },
  }, {
    { name = "path" },
    { name = "buffer", keyword_length = 4, group_index = 2 },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", vim_item.kind)
      vim_item.menu = ({
        luasnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[LUA]",
        buffer = "[BUFFER]",
        path = "[PATH]",
      })[entry.source.name]
      return vim_item
    end,
  },
  --[[ cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      {name= 'path'},
    },{
      {name= 'cmdline'}
    }
    )
  }), ]]

  -- documentation= { border= {"╭", "─", "╮", "│", "╯", "─", "╰", "│"} },
  experimaental = {
    ghost_text = true,
    native_menu = false,
  },
}
