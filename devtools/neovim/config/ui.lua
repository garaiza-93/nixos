local Terminal = require('toggleterm.terminal').Terminal

function Lazygit_term()
  Terminal:new({ cmd = 'lazygit', direction = 'float' });
end

require('bufferline').setup {
  options = {
    mode = 'tabs',
    always_show_bufferline = false,
    separator_style = 'thin',
    custom_filter = function(buf_number, _)
      if vim.bo[buf_number].filetype ~= 'startify' and
          vim.bo[buf_number].filetype ~= 'NvimTree'
      then
        return true
      else
        return false
      end
    end,
    show_close_icon = false,
    hover = {
      enabled = true,
      delay = 0,
      reveal = { 'close' },
    }
  },
}

require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
    disabled_filetypes = { 'alpha' },
    ignore_focus = {},
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = {
      {
        'buffers',
        hide_filename_extension = true,
        symbols = {
          alternate_file = '',
        },
        mode = 4,
      },
    },
    lualine_x = { 'filetype' },
    lualine_y = { 'diagnostics' },
    lualine_z = { 'location' }
  }
}

require('trouble').setup {}
