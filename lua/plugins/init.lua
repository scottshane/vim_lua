--[[ Plugins ]]
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
  return string.format('require("config/%s")', name)
end

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end
--use a protected call so we dont error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
--[[
--Plugins to try
"akinsho/nvim-toggleterm.lua", -- toggle terminal
"folke/todo-comments.nvim" -- I think HL for todos:
"ahmedkhalf/project.nvim" -- someone finally solved Packages?
rcarriga/nvim-notify --?

]]
return packer.startup {
  function(use)
    --plugins here
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-cmdline"
    use "folke/lua-dev.nvim"
    use "saadparwaiz1/cmp_luasnip"
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets" --a bunch of snippets to use
    use "kyazdani42/nvim-web-devicons"

    use "ckipp01/stylua-nvim" --stylua formatter
    use "wbthomason/packer.nvim" --packer self-management
    use "nvim-lua/popup.nvim" --Popup api implementation from Vim

    use "nvim-lua/plenary.nvim" --lua function used in plugins
    use "cohama/lexima.vim" --looking for better replacement for 'jiangmiao/auto-pairs'
    --  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
    use "tpope/vim-fugitive" --git
    use "tpope/vim-surround" -- surround alters to try "blackCauldron7/surround.nvim"
    use "tpope/vim-scriptease" -- debugging
    use {
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("lualine").setup {
          options = {
            theme = "auto",
            icons_enabled = true,
          },
        }
      end,
    }
    --colorschemes
    use "shaunsingh/nord.nvim"
    use "navarasu/onedark.nvim"
    use "rebelot/kanagawa.nvim"

    -- comments
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    }

    --formatter
    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("null-ls").setup()
      end,
      requires = { "nvim-lua/plenary.nvim" },
    }

    -- use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"

    --file tree
    use {
      "kyazdani42/nvim-tree.lua",
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
    }

    use "b0o/schemastore.nvim" --lsp
    --ripgrep
    use "jremmen/vim-ripgrep"

    --Telescope
    use {
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } },
      config = require "../telescopeconfig",
    }

    use "nvim-telescope/telescope-file-browser.nvim"

    --Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    --GLow markdown previewer
    --requires glow bin from https://github.com/charmbracelet/glow
    --use {"ellisonleao/glow.nvim"}

    --vimrwiki
    use { "vimwiki/vimwiki" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
}
