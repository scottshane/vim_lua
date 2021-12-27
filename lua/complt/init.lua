local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print('failed to load cmp')
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  print('failed to load luasnip')
  return
end

-- require("luasnip/loaders/from_vscode").lazy_load()

--[[ local check_backspace= function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub("col", "col"):match "%s"
end ]]

local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  snippet= {
    expand= function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources= {
      {name= 'nvim_lsp'},
      {name= "luasnip"},
      {name= "buffer", keyword_length= 4},
      {name= "path"},
    },

  formmatting= {
    fields= {"abbr", "menu"},
    format= function(entry, vim_item)
      vim_item.menu= ({
        luasnip= "[Snippet]",
        buffer= "[Buffer]",
        path= "[Path]"
      })[entry.source.name]
      return vim_item
    end,
  },
  confirm_opts= {
    behavior= cmp.ConfirmBehavior.Replace,
    select= false
  },
  -- documentation= { border= {"╭", "─", "╮", "│", "╯", "─", "╰", "│"} },
  experimaental= {
    ghost_text= false,
    native_menu= false,
  }
}
