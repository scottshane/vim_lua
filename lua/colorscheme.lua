--  ONEDARK  COLORSCHEME SETTINGS
  --[[ vim.g.onedark_style="darker"
  require('onedark').setup() ]]

  require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    colors = {},
    overrides = {},
})

vim.cmd("colorscheme kanagawa")

--NORD COLORSCHEME SETTING
-- vim.cmd[[
-- try
--   colorscheme nord
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]

-- vim.cmd("colorscheme kanagawa")
--vim.cmd("set background=dark")
