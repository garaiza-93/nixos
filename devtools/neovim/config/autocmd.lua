local new_group = vim.api.nvim_create_augroup
local new_cmd = vim.api.nvim_create_autocmd
--Groups
local lspGrp = new_group('lsp', { clear = true })

local function conditionalFormat()
  if string.match(vim.bo.filetype, 'javascript') or string.match(vim.bo.filetype, 'typescript') then
    vim.cmd('EslintFixAll') -- if eslint_lsp is used. i use eslint_lsp, i dunno about you.
  else
    vim.cmd('lua vim.lsp.buf.format()')
  end
end

--Format file before write
new_cmd(
  { 'BufWritePre' },
  {
    callback = conditionalFormat,
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
