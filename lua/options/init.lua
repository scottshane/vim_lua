local options = {
	backup = false,
	clipboard = "unnamedplus",
	completeopt = {"menuone","noinsert", "noselect"},
  cmdheight = 1,
	conceallevel = 0,
	fileencoding = "utf-8",
  hidden = true,
	mouse = "a",
	showmode = false,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	--timeoutlen = 100,
	undofile = true,
	--updatetime = 1000, 
	writebackup = false,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	cursorline = true,
	number=true,
	relativenumber = true,
	signcolumn = "yes",
	scrolloff = 8,
	sidescrolloff = 8,
  termguicolors = true,
  showtabline = 0 
}
--[[

primagean match strategy 
g.completion_matching_strategy_list [ 'exact', 'substring', 'fuzzy' ]
]]
vim.opt.formatoptions:remove "c" 
vim.opt.formatoptions:remove "r" 
vim.opt.formatoptions:remove "w" 

for k,v in pairs(options) do
	vim.opt[k] = v
end

