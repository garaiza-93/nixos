{
  description = "Basic Node+Typescript environment with language server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    mission-control.url = "github:Platonic-Systems/mission-control";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, flake-parts, ...}:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.flake-root.flakeModule
        inputs.mission-control.flakeModule
      ];
      perSystem = { pkgs, lib, config, ... }:
        let
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

            local servers = { "vuels", "tsserver" }
            local caps = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities());

            for _, lsp in ipairs(servers) do
              require("lspconfig")[lsp].setup { capabilities = caps, on_attach = on_attach }
            end

            vim.cmd("LspStart");

            local null_ls = require("null-ls");
            local sources = { null_ls.builtins.formatting.eslint_d, null_ls.builtins.diagnostics.eslint_d, null_ls.builtins.code_actions.eslint_d,};
            null_ls.setup({sources = sources})
            '';
        in
        rec
        {
          # Executed by 'nix build'
          packages.default = pkgs.mkNpmPackage {
            inherit pname version;
            src = ./.;
            npmLock = ./package-lock.json;
            packageJSON = ./package.json;
          };

          # Executed by `nix run`
          apps.default = flake-utils.lib.mkApp { drv = packages.default; };

          # Used by `nix develop`
          mission-control.scripts = {
            install = {
              description = "npm install";
              exec = "${pkgs.boxxy}/bin/boxxy -d npm install";
            };
          };
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.mission-control.devShell ];
            buildInputs = with pkgs; [
              boxxy
              nodejs-18_x

              nodePackages.typescript
              nodePackages.typescript-language-server
              nodePackages.vls
              nodePackages.eslint
              nodePackages.eslint_d
            ];

            shellHook = ''
              echo '${nvimrc}' > .nvimrc.lua
            '';
          };
        };
      };
}
