return
{
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'jose-elias-alvarez/null-ls.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jayp0521/mason-null-ls.nvim', 
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function() 
      require('mason').setup()
      require('mason-lspconfig').setup {
        automatic_installation = true;
      }

      -- Automatically setup LSP servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,

        -- Dedicated handlers for specific servers after this line
        ['sumneko_lua'] = function()
          require('lspconfig').sumneko_lua.setup {
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                },
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file('', true),
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          }
        end
      }

      require('null-ls').setup()
      require('mason-null-ls').setup({
        automatic_installation = true,
        automatic_setup = true
      })
      --require('ufo').setup({
      --  provider_selector = function(bufnr, filetype, buftype)
      --    return { 'lsp', 'indent' }
      --  end
      --})
    end
  },
}
