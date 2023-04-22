require('nvim-autopairs').setup {}
require('nvim-surround').setup {}
require('nvim-ts-autotag').setup {}
require('nvim-tree').setup {
  update_focused_file = { enable = true },
  prefer_startup_root = true,
  view = {
    adaptive_size = true;
  }
}
require('telescope').setup {}
require('telescope').load_extension 'file_browser'
require('indent_blankline').setup {
  char = '▏',
  show_end_of_line = false,
  disable_with_no_list = true,
  buftype_exclude = { 'terminal' },
  filetype_exclude = { 'help', 'git', 'markdown', 'snippets', 'text', 'alpha', 'mason', 'packer' },
}
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  indent = { true },
  rainbow = { enable = true }
}
