local options = {
  --timeoutlen = 100,
  --updatetime = 1000,
  backup = false,
  clipboard = "unnamedplus",
  completeopt = { "menuone", "noinsert", "noselect" },
  conceallevel = 0,
  cursorline = false,
  expandtab = true,
  hlsearch = false,
  fileencoding = "utf-8",
  mouse = "a",
  number = true,
  relativenumber = true,
  scrolloff = 8,
  shiftwidth = 2,
  showmode = false,
  sidescrolloff = 8,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  undofile = true,
  writebackup = false,
  cmdheight = 1,
  hidden = true,
  showtabline = 1,
  termguicolors = true,
  wildmenu = true,
  wildmode = "longest:full,full",
  autoread = true,
}
vim.opt.shortmess:append("I")
vim.opt.guifont = "SauceCodePro Nerd Font Regular:h11"

-- enable filetype.lua
vim.g.do_filetype_lua = 1

--[[
  """"""""""""""""""""""""""""""""""""""""""""""""""
  " VimWiki
  """""""""""""""""""""""""""""""""""""""""""""""""
]]
vim.g.vimwiki_list = {
  {
    ["path"] = "~/vimwiki",
    ["syntax"] = "markdown",
    ["name"] = "Personal",
    ["ext"] = ".md",
  },
  {
    ["path"] = "~/parkerwiki",
    ["syntax"] = "markdown",
    ["name"] = "Parker",
    ["ext"] = ".md",
  },
}

vim.g.vimwiki_ext2syntax = {
  [".md"] = "markdown",
  [".markdown"] = "markdown",
  [".mdown"] = "markdown",
}

-- Make vimwiki links as [text](text.md) instead of [text](text)
vim.g.vimwiki_markdown_link_ext = 1
vim.g.taskwiki_markdown_syntax = "markdown"
vim.g.markdown_folding = 1
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_vimwiki_conceallevel = 0
vim.g.vimwiki_conceal_onechar_markers = 0
vim.g.vim_vimwiki_conceal_code_blocks = 0

--[[
  """"""""""""""""""""""""""""""""""""""""""""""""""
  " Nvim-Tree
  """""""""""""""""""""""""""""""""""""""""""""""""
]]
vim.g.nvim_tree_respect_buf_cwd = 1

--[[
primagean match strategy
g.completion_matching_strategy_list [ 'exact', 'substring', 'fuzzy' ]
]]
--vim.cmd "set formatoptions-=cro"
--default format options "tcqj"
-- vim.opt.formatoptions:remove "c"
-- vim.opt.formatoptions:remove "r"
-- vim.opt.formatoptions:remove "o"

for k, v in pairs(options) do
  vim.opt[k] = v
end
