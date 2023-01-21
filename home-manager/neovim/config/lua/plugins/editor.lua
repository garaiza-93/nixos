return
{
  { 'ray-x/lsp_signature.nvim', config = function() require('lsp_signature').setup {} end },
  { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end },
  { 'kylechui/nvim-surround', config = function() require('nvim-surround').setup {} end },
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function() require('nvim-ts-autotag').setup {} end
  },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    version = 'nightly',
    keys = {
      {'<leader>ef', '<cmd>NvimTreeToggle<cr>', desc = 'File Explorer' },
    },
    config = function()
      require('nvim-tree').setup()
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim' },
    config = function()
      require('telescope').setup {}
      require('telescope').load_extension 'file_browser'
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        char = '▏',
        show_end_of_line = false,
        disable_with_no_list = true,
        buftype_exclude = { 'terminal' },
        filetype_exclude = { 'help', 'git', 'markdown', 'snippets', 'text', 'alpha', 'mason', 'packer' },
      }
    end
  },
}
