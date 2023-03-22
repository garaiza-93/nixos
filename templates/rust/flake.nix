{
  description = "Basic Cargo project with toolchain and language server";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, fenix, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pname = "name-me";
          version = "0.1.0";
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ fenix.overlays.default ];
          };
          toolchain = pkgs.fenix.complete;
        in
        rec
        {
          # Executed by `nix build`
          packages.default = (pkgs.makeRustPlatform {
            # Use nightly rustc and cargo provided by fenix for building
            inherit (toolchain) cargo rustc;
          }).buildRustPackage {
            inherit pname version;
            src = ./.;
            cargoLock.lockFile = ./Cargo.lock;
          };

          # Executed by `nix run`
          apps.default = flake-utils.lib.mkApp { drv = packages.default; };

          # Used by `nix develop`
          devShells.default = pkgs.mkShell {

            buildInputs = with pkgs; [
              (with toolchain; [
                cargo
                rustc
                rust-src
                clippy
                rustfmt
                rust-analyzer
              ])
              pkg-config
            ];

            RUST_SRC_PATH = "${toolchain.rust-src}/lib/rustlib/src/rust/library";
          };
        }
      );
}
