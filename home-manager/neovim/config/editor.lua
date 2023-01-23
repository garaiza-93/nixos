require('lsp_signature').setup {}
require('nvim-autopairs').setup {}
require('nvim-surround').setup {}
require('nvim-ts-autotag').setup {}
require('nvim-tree').setup()
require('telescope').setup {}
require('telescope').load_extension 'file_browser'
require('indent_blankline').setup {
  char = '▏',
  show_end_of_line = false,
  disable_with_no_list = true,
  buftype_exclude = { 'terminal' },
  filetype_exclude = { 'help', 'git', 'markdown', 'snippets', 'text', 'alpha', 'mason', 'packer' },
}
