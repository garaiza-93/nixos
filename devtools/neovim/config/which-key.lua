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
    l = { '<cmd>set rnu!<cr>', 'Toggle Relative Line Numbers' },
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
  l = {
    name = 'LSP-based Actions',
    a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Actions' },
    c = { '<cmd>lua vim.lsp.buf.completion()<cr>', 'Show Completions' },
    f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format' },
    r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Refactor' },
    i = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Show Hover' },
    s = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Show Signature' },
    w = { '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', 'Show All Symbols' },
  },
  t = { '<cmd>FloatermNew --wintype=split --height=0.3 --position=botright<cr>', 'Terminal' },
}
wk.register(general, { prefix = '<leader>' })
