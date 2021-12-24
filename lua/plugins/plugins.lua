--[[ Plugins ]]
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

--Autocommand reloads nvim whenever plugins.lua is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync 
  augroup end
]]

--use a protected call so we dont error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then 
  return
end

packer.init {
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float {border="single"}
      end
    }
  }
};

return require('packer').startup(function(use)
 --plugins here
 use "neovim/nvim-lspconfig"
 use "wbthomason/packer.nvim" --packer self-management
 use "nvim-lua/popup.nvim" --Popup api implementation from Vim
 use "nvim-lua/plenary.nvim" --lua function used in plugins
 use "cohama/lexima.vim" --looking for better replacement for 'jiangmiao/auto-pairs'
 --  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
 use "tpope/vim-fugitive" --git
 use "tpope/vim-surround" -- surround alters to try "blackCauldron7/surround.nvim"
-- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
-- status line   
 use {
  'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup{
        options = {
          theme='nord',
          icons_enabled = true,
        }
      }
    end
  }
 --colorschemes
 use "mhartington/oceanic-next"
 -- use "arcticicestudio/nord-vim"
 use "shaunsingh/nord.nvim"

--file tree
use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require'nvim-tree'.setup{
        disable_netrw       = true,
        hijack_netrw        = true,
        open_on_setup       = false,
        ignore_ft_on_setup  = {},
        auto_close          = false,
        open_on_tab         = false,
        hijack_cursor       = true,
        update_cwd          = false,
        git = {
          enable = true,
          ignore = true,
          timeout = 500,
      },
      diagnostics = {
        enable = true
      },
      trash = {
        cmd = "trash",
        require_confirm = true
      }
    } end
}
--Telescope
 use "nvim-telescope/telescope.nvim"

--Treesitter
 use {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate"
 }
-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
