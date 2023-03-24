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

          nvimrc = ''local servers = { "eslint", "tsserver" }
            local caps = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities());

            for _, lsp in ipairs(servers) do
              require("lspconfig")[lsp].setup { capabilities = caps }
            end

            vim.cmd("LspStart");
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
              nodePackages.vscode-langservers-extracted
            ];

            shellHook = ''echo '${nvimrc}' > .nvimrc.lua'';
          };
        }
      );
}
