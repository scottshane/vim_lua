local options = {
	backup = false,
	clipboard = "unnamedplus",
	-- cmdheight = 1,
	completeopt = {"menuone", "noselect"},
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
	expandtab=true,
	shiftwidth=2,
	tabstop=2,
	cursorline =false,
	number = true,
	relativenumber = true,
	signcolumn = "yes",
	scrolloff = 8,
	sidescrolloff = 8,
}

vim.opt.shortmess:append "c"
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("w")

for k,v in pairs(options) do
	vim.opt[k] = v
end

