-- keymapping
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
--remap space as leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--[[ Shutup Help ]]
keymap("", "<F1>", "<Nop>", opts)

--[[ ############### Normal Mode ###############]]
-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Get current files name and path
keymap("n", "<leader>pp", "1<C-g>", opts)

--[[ ############### Trouble  ###############]]
keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)

--[[ ############### Insert Mode ###############]]
-- escape with JJ
keymap("i", "jj", "<esc>", opts)
-- save go back to insert mode
keymap("i", "jw", "<C-o>:w<CR>", opts)

--[[ ############### Visual Mode #################]]
--Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
--[[movement]]
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "gj", "j", opts)
keymap("n", "gk", "k", opts)
-- move line [normal mode]
keymap("n", "<leader>j", ":m .+1<CR>==", opts)
keymap("n", "<leader>k", ":m .-2<CR>==", opts)
-- move line [insert mode]
--[[
Shut up for now  Meta key also includes <esc> key this
gets confusing sometimes. when dismissing float windows.

 keymap("i", "<A-j>", "<C-o>:m .+1<CR>==gi", opts)
 keymap("i", "<A-k>", "<C-o>:m .-2<CR>==gi", opts)
]]
--move line [visual mode]
keymap("v", "<leader>j", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<leader>k", ":m '<-2<CR>gv=gv", opts)

--[[############### termimal Mode ###############]]
--remap exit terminal insert
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

--[[NvimTree Mode]]
--remap nvim tree
keymap("n", "<leader>nt", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>e", ":Telescope file_browser theme=ivy<CR>", opts)

--telescope remap
-- "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy())<cr>",
keymap("n", "<leader>pr", ":Telescope project theme=ivy<cr>", opts)
keymap(
  "n",
  "<leader>ff",
  "<cmd>lua require('telescope.builtin').find_files({find_command={'rg', '--files', '--hidden', '-g', '!.git'}})<cr>",
  opts
)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
keymap("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<cr>", opts)
keymap("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>", opts)

keymap("n", "<leader>4", ":split | terminal<CR>", opts)
keymap("n", "<leader>sh", ":set hls!<CR>", opts)
