-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Visual stuff
    use 'tomasiser/vim-code-dark'
    use 'hoob3rt/lualine.nvim'
    use 'sainnhe/gruvbox-material'
    use 'sainnhe/edge'
    use 'morhetz/gruvbox'
    use 'folke/tokyonight.nvim'

    -- extend editor functionality
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end } 
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use 'junegunn/fzf.vim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'glepnir/lspsaga.nvim'
    use 'folke/lsp-colors.nvim'

    use 'b3nj5m1n/kommentary'
    use 'honza/vim-snippets'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground' }
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

end)
