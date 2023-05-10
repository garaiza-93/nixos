{
  description = "Basic Node+Typescript environment with language server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          pname = "name-me";
          version = "0.1.0";

          nvimrc = ''
            local lsp_formatting = function(bufnr)
                vim.lsp.buf.format({
                    filter = function(client)
                        return client.name == "null-ls"
                    end,
                    bufnr = bufnr,
                })
            end

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            local on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            lsp_formatting(bufnr)
                        end,
                    })
                end
            end

            local servers = { "eslint", "tsserver" }
            local caps = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities());

            for _, lsp in ipairs(servers) do
              require("lspconfig")[lsp].setup { capabilities = caps, on_attach = on_attach }
            end

            vim.cmd("LspStart");

            local null_ls = require("null-ls");
            local sources = { null_ls.builtins.formatting.prettier };
            null_ls.setup({sources = sources})
            '';
        in
        rec
        {
          # Executed by 'nix build'
          packages.default = pkgs.mkYarnPackage {
            inherit pname;
            src = ./.;
            yarnLock = ./yarn.lock;
            packageJSON = ./package.json;
          };

          # Executed by `nix run`
          apps.default = flake-utils.lib.mkApp { drv = packages.default; };

          # Used by `nix develop`
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs-18_x
              yarn

              nodePackages.typescript
              nodePackages.typescript-language-server
              nodePackages.eslint
              nodePackages.prettier
              nodePackages.vscode-langservers-extracted
            ];

            shellHook = ''
              echo '${nvimrc}' > .nvimrc.lua
            '';
          };
        }
      );
}
