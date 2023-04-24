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
  b = {
    name = 'Buffers',
    D = { '<cmd>%bd|e#<cr>', 'Delete All But Current' },
    d = { '<cmd>bd<cr>', 'Delete Current' },
    l = { '<cmd>Telescope buffers<cr>', 'List All' },
    n = { '<cmd>bn<cr>', 'Next' },
    p = { '<cmd>bp<cr>', 'Previous' },
    s = { '<cmd>sp<cr>', 'Split' },
    v = { '<cmd>vsp<cr>', 'Vertical Split' }
  },
  c = {
    name = 'Code',
    I = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Info' },
    S = { '<cmd>Telescope lsp_document_symbols<cr>', 'Symbols' },
    a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Actions' },
    c = { '<cmd>lua vim.lsp.buf.completion()<cr>', 'Completions' },
    d = { '<cmd>TroubleToggle<cr>', 'Diagnostics' },
    f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format' },
    i = { '<cmd>Telescope lsp_incoming_calls<cr>', 'Incoming Calls' },
    l = { '<cmd>set rnu!<cr>', 'Toggle Relative Line Numbers' },
    o = { '<cmd>Telescope lsp_outgoing_calls<cr>', 'Outgoing Calls' },
    r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Refactor' },
    s = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature' }
  },
  e = { '<cmd>NvimTreeToggle<cr>', 'File Explorer' },
  f = {
    name = 'Find',
    f = { '<cmd>Telescope find_files<cr>', 'By Filename' },
    g = { '<cmd>Telescope live_grep<cr>', 'By Grep' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Recent' }
  },
  g = {
    name = 'Go to',
    D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration' },
    b = { '<cmd>pop<cr>', 'Previous Symbol' },
    d = { '<cmd>Telescope lsp_definitions<cr>', 'Definition' },
    i = { '<cmd>Telescope lsp_implementations<cr>', 'Implementation' },
    r = { '<cmd>Telescope lsp_references<cr>', 'References' },
    t = { '<cmd>Telescope lsp_type_defintions<cr>', 'Type Defintion' }
  },
  s = {
    name = 'Splits',
    e = { '<C-w>=', 'Equalize' },
    h = { '<C-w><', 'Resize Left' },
    j = { '<C-w>-', 'Resize Down' },
    k = { '<C-w>+', 'Resize Up' },
    l = { '<C-w>>', 'Resize Right' }
  },
  t = {
    name = 'Tabs',
    N = { '<cmd>tabnew<cr>', 'New Tab' },
    c = { '<cmd>tabc<cr>', 'Close Tab' },
    n = { '<cmd>tabn<cr>', 'Next Tab' },
    p = { '<cmd>tabp<cr>', 'Previous Tab' }
  },
  T = {
    name = 'Terminals',
    l = { '<cmd>lua Lazygit_term()<cr>', 'Lazygit' },
    t = { '<cmd>ToggleTerm<cr>', 'Toggle Terminal' }
  },
  w = {
    name = 'Windows',
    C = { '<cmd>on<cr>', 'Close Others' },
    H = { '<C-w>H', 'Move Left' },
    J = { '<C-w>J', 'Move Down' },
    K = { '<C-w>K', 'Move Up' },
    L = { '<C-w>L', 'Move Right' },
    T = { '<C-w>T', 'Move to New Tab' },
    c = { '<cmd>hid<cr>', 'Close Current' },
    h = { '<C-w>h', 'Select Left' },
    j = { '<C-w>j', 'Select Down' },
    k = { '<C-w>k', 'Select Up' },
    l = { '<C-w>l', 'Select Right' }
  },
}
wk.register(general, { prefix = '<leader>' })
