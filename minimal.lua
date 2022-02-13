local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("i", "jj", "<esc>", opts)


vim.cmd [[set runtimepath=$VIMRUNTIME]]
vim.cmd [[set packpath=/tmp/nvim/site]]
local package_root = '/tmp/nvim/site/pack'
local install_path = package_root .. '/packer/start/packer.nvim'
local function load_plugins()
  require('packer').startup {
    {
      'wbthomason/packer.nvim',
      {
        'nvim-telescope/telescope.nvim',
        requires = {
          'nvim-lua/plenary.nvim',
          { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
      },
      -- ADD PLUGINS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
      { "kyazdani42/nvim-tree.lua",
      config = function()
        require("nvim-tree").setup {
          disable_netrw = true,
          hijack_netrw = true,
          open_on_setup = false,
          ignore_ft_on_setup = {},
          auto_close = false,
          open_on_tab = false,
          hijack_cursor = true,
          update_cwd = false,
          git = {
            enable = true,
            ignore = true,
            timeout = 500,
          },
          diagnostics = {
            enable = true,
          },
          trash = {
            cmd = "trash",
            require_confirm = true,
          },
        }
      end,
    },
    --lualine
{ "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("lualine").setup {
          options = {
            theme = "auto",
            icons_enabled = true,
          },
        }
      end,
    },
    --cmp
    {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/cmp-nvim-lua"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-cmdline"},
    {"saadparwaiz1/cmp_luasnip"},
    --lsp
    {"neovim/nvim-lspconfig"},
    -- snippits
    {"L3MON4D3/LuaSnip"},
    {"rafamadriz/friendly-snippets" }, --a bunch of snippets to use
    {"kyazdani42/nvim-web-devicons"},
    --lua-dev
    {"folke/lua-dev.nvim"}, 
    --tPope
    { "tpope/vim-fugitive"}, --git
    { "tpope/vim-surround"}, -- surround alters to try "blackCauldron7/surround.nvim"
    { "tpope/vim-scriptease"}, -- debugging
    --stylua formatter
    { "ckipp01/stylua-nvim" },
   --Popup api implementation from Vim 
    {"nvim-lua/popup.nvim"},
    --looking for better replacement for 'jiangmiao/auto-pairs'
    {"cohama/lexima.vim"},
    -- colorschemes
    {"rebelot/kanagawa.nvim"},
   { "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },
    --formatter
   { "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("null-ls").setup()
      end,
      requires = { "nvim-lua/plenary.nvim" },
    },
    --lsp-ts-utils
   {"jose-elias-alvarez/nvim-lsp-ts-utils"},
   --lsp - json schemas
   {"b0o/schemastore.nvim"},
   --rip-grep
   { "jremmen/vim-ripgrep" },
   --vimwiki
   { "vimwiki/vimwiki" }
   -- -----
    },
    config = {
      package_root = package_root,
      compile_path = install_path .. '/plugin/packer_compiled.lua',
      display = { non_interactive = true },
    },
  }
end
_G.load_config = function()
  require('telescope').setup()
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('file_browser')
  -- ADD INIT.LUA SETTINGS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
   require "/lua/options/init"
   require "/lua/colorscheme"
   require "/lua.complt.init"
   -- require "/lua.utils"
   require "/lua.treesitter.init"
   require "./lua/lsp/init"
  

end
if vim.fn.isdirectory(install_path) == 0 then
  print("Installing Telescope and dependencies.")
  vim.fn.system { 'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', install_path }
end
load_plugins()
require('packer').sync()
vim.cmd [[autocmd User PackerComplete ++once echo "Ready!" | lua load_config()]]

