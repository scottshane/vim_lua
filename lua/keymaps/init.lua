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
--[[ Normal Mode ]]
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

--[[ Insert Mode ]]
-- escape with JJ
keymap("i", "jj", "<esc>", opts)
-- save go back to insert mode
keymap("i", "jw", "<C-o>:w<CR>", opts)
--[[Visual Mode]]
--Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
--[[movement]]
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "gj", "j", opts)
keymap("n", "gk", "k", opts)
--[[termimal Mode]]
--remap exit terminal insert
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

--[[NvimTree Mode]]
--remap nvim tree
--keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>e", ":Telescope file_browser theme=ivy<CR>", opts)

--telescope remap
keymap(
  "n",
  "<leader>ff",
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy())<cr>",
  opts
)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap(
  "n",
  "<leader>b",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy())<cr>",
  opts
)
keymap("n", "<leader>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
keymap("n", "<leader>4", ":split | terminal<CR>", opts)
keymap("n", "<leader>sh", ":set hls!<CR>", opts)
