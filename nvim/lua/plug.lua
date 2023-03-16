require('packer').startup({
   function(use)
      -- packer self management
      use('wbthomason/packer.nvim')

      -- lsp plugins
      use('williamboman/mason.nvim')
      use('williamboman/mason-lspconfig.nvim')
      use {
         'VonHeikemen/lsp-zero.nvim',
         requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-nvim-lsp-signature-help'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
         }
      }
      use "rafamadriz/friendly-snippets"

      -- {{{ utility plugins
      -- these plugins are all realted to editor configs
      use({ 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } })
      use({ 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } })
      use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })
      use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
      use('windwp/nvim-autopairs')
      use('terrortylor/nvim-comment')
      use('sbdchd/neoformat')
      use('phaazon/hop.nvim')
      use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } })
      use('folke/which-key.nvim')
      -- using packer.nvim
      use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
      -- }}}

      -- {{{ imporved syntax plugins
      use('nvim-treesitter/nvim-treesitter')
      -- use({ 'glepnir/dashboard-nvim', disable = false })
      -- use('norcalli/nvim-colorizer.lua')
      -- }}}

      -- use {
      --    "someone-stole-my-name/yaml-companion.nvim",
      --    requires = {
      --       { "neovim/nvim-lspconfig" },
      --       { "nvim-lua/plenary.nvim" },
      --       { "nvim-telescope/telescope.nvim" },
      --    },
      --    config = function()
      --    require("telescope").load_extension("yaml_schema")
      --    end,
      -- }
      -- go
      use('fatih/vim-go')
	  -- rust
	  use ('simrat39/rust-tools.nvim')
      --  themes
      use('joshdick/onedark.vim')
      use('sickill/vim-monokai')
      use('shaunsingh/nord.nvim')
      use('sainnhe/gruvbox-material')
      use('sainnhe/everforest')
      use('folke/tokyonight.nvim')
	  use('rose-pine/neovim')
	  use('catppuccin/nvim')
      -- else
      use {
       'kdheepak/tabline.nvim', requires = {'hoob3rt/lualine.nvim', 'kyazdani42/nvim-web-devicons'}
      }

      end,
      -- display packer dialouge in the center in a floating window
      config = {
         display = {
            open_fn = require('packer.util').float,
         },
      },
   })

   -- # vim foldmethod=marker
