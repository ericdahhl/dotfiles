-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()
--
-- Ensure packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end


return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Visual stuff
    use 'tomasiser/vim-code-dark'
    use {
      'hoob3rt/lualine.nvim',
      config = function() require('plugin.lualine') end,
    }
    use 'sainnhe/gruvbox-material'
    use 'sainnhe/edge'
    use 'morhetz/gruvbox'
    use 'folke/tokyonight.nvim'
    use 'marko-cerovac/material.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- extend editor functionality
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    use { 
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function() require('plugin.treesitter') end,
      requires = {
        'windwp/nvim-ts-autotag',
        'nvim-treesitter/playground',
      }
    }

    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('plugin.lsp')
        require('plugin.lsp.clangd')
        require('plugin.lsp.rustanalyzer')
        require('plugin.lsp.pyright')
        require('plugin.lsp.tsserver')
        require('plugin.lsp.vuels')
        require('plugin.lsp.efm')
        require('plugin.lsp.tailwindcss')
      end,
      requires = {
        {
          'hrsh7th/nvim-compe',
          config = function() require('plugin.compe') end,
        },
        {
          'hrsh7th/vim-vsnip',
        }
      }
    }

    use 'lewis6991/gitsigns.nvim'
    use 'sindrets/diffview.nvim'
    use 'b3nj5m1n/kommentary'
    use 'kyazdani42/nvim-tree.lua'

end)
