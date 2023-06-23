local new_group = vim.api.nvim_create_augroup
local new_cmd = vim.api.nvim_create_autocmd
--Groups
local lspGrp = new_group('lsp', { clear = true })

--Format file before write
new_cmd(
  { 'BufWritePre' },
  {
    callback = function()
      vim.lsp.buf.format()
    end,
    group = lspGrp
  }
)
new_cmd(
  { 'CursorHold' },
  {
    command = 'lua vim.diagnostic.open_float({ focusable = false })',
    group = lspGrp
  }
)

-- Hide status/tab/cmd lines in alpha greeter
new_cmd(
  { 'User' },
  {
    pattern = 'AlphaReady',
    desc = 'disable tabline, and cmdline',
    callback = function()
      vim.opt.showtabline = 0
      require('lualine').hide()
      vim.opt.laststatus = 0
      vim.opt.cmdheight = 0
    end,
  }
)
-- And to reenable it
new_cmd(
  { 'BufUnload' },
  {
    buffer = 0,
    desc = 'enable what we disabled',
    callback = function()
      vim.opt.showtabline = 2
      vim.opt.laststatus = 2
      require('lualine').hide({ unhide = true })
      vim.opt.cmdheight = 1
    end,
  }
)

--Load project local settings (do NOT use "set exrc" due to RCE)
new_cmd(
  { 'VimEnter' },
  {
    desc = 'load project local settings',
    callback = function()
      local projectrc = vim.fn.findfile('.nvimrc.lua', '.;**/.git')
      if projectrc ~= '' then
        dofile(projectrc)
      end
    end
  }
)
