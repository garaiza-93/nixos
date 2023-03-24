{
  description = "Basic Rust environment with toolchain and language server";

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

          nvimrc = ''local servers = { 'rust_analyzer' }
            local caps = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities());
            for _, lsp in ipairs(servers) do
              require('lspconfig')[lsp].setup {capabilities = caps}
            end

            vim.cmd("LspStart");'';
        in
        rec
        {
          # Executed by `nix build`
          packages.default = buildRustPackage {
            inherit pname version;
            src = ./.;
            cargoLock.lockFile = ./Cargo.lock;
          };

          # Executed by `nix run`
          apps.default = flake-utils.lib.mkApp { drv = packages.default; };

          # Used by `nix develop`
          devShells.default = pkgs.mkShell {

            buildInputs = with pkgs; [
              cargo
              rustc
              rust-src
              clippy
              rustfmt
              rust-analyzer
              pkg-config
            ];

            RUST_SRC_PATH = "${toolchain.rust-src}/lib/rustlib/src/rust/library";

            shellHook = ''echo '${nvimrc}' > .nvimrc.lua'';
          };
        }
      );
}
