{
  description = "nodejs and Typescript devshell/builds using dream2nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          nvimrc = ''local servers = { 'eslint', 'tsserver' }
            local caps = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities());

            for _, lsp in ipairs(servers) do
              require('lspconfig')[lsp].setup { capabilities = caps }
            end

            vim.cmd("LspStart");
            '';
        in
        rec
        {
          # Used by `nix develop`
          devShells.default = pkgs.mkShell {

            buildInputs = with pkgs; [
              nodePackages.typescript
              nodePackages.typescript-language-server
              nodePackages.vscode-langservers-extracted
              nodejs
            ];
            shellHook = ''echo '${nvimrc}' > .nvimrc.lua'';
          };
        }
      );
}
