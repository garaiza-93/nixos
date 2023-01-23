local wk = require('which-key')
wk.setup {
  plugins = {
    marks = false,
    registers = false,
    spelling = { enabled = false, suggestions = 20 },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false
    }
  }
}

local general = {
  c = {
    name = 'Code',
    d = { '<cmd>TroubleToggle<cr>', 'Toggle Diagnostics' },
    f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format' },
    l = { '<cmd>set rnu!<cr>', 'Toggle Relative Line Numbers' },
    r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Refactor' }
  },
  e = {
    name = 'Explore',
    f = { '<cmd>NvimTreeToggle<cr>', 'File Tree' },
    s = { '<cmd>Alpha<cr>', 'Start' }
  },
  f = {
    name = 'Find with Telescope',
    b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
    f = { '<cmd>Telescope find_files<cr>', 'By Filename' },
    g = { '<cmd>Telescope live_grep<cr>', 'By Grep' },
  },
  g = {
    name = 'Go to',
    d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Definition' },
    D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration' },
    i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Implementation' },
    r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'References' },
    t = { '<cmd>lua vim.lsp.buf.type_defintion()<cr>', 'Type Defintion' },
    b = { '<cmd>pop<cr>', 'Previous Symbol' },
  },
  r = { '<cmd>luafile ~/.config/nvim/init.lua<cr>', 'Refresh Settings' },
  t = {
    name = 'Tools',
    a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Actions' },
    t = { '<cmd>FloatermNew --wintype=split --height=0.3 --position=botright<cr>', 'Terminal' },
  },
  z = {
    name = 'Folds',
  }
}
wk.register(general, { prefix = '<leader>' })

--local folding = {
--  R = { require('ufo').openAllFolds(), 'Open All Folds' },
--  M = { require('ufo').closeAllFolds(), 'Close All Folds' },
--}
wk.register(folding, { prefix = 'z' })
