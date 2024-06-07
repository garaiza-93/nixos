{
  description = "Basic Rust environment with toolchain and language server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nvim-nixified.url = "github:garaiza-93/nvim-nixified";
  };

  outputs = { nixpkgs, flake-utils, fenix, nvim-nixified, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ fenix.overlays.default ];
        };

        toolchain = pkgs.fenix.complete;
        nvim-rust = nvim-nixified.packages.${system}.rust-config;
      in rec {
        # Executed by `nix build`
        packages.default = (pkgs.makeRustPlatform {
          inherit (toolchain) cargo rustc;
        }).buildRustPackage {
          pname = "template";
          version = "0.1.0";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
        };

        # Executed by `nix run`
        apps.default = flake-utils.lib.mkApp { drv = packages.default; };

        # Used by `nix develop`
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            (with toolchain; [ cargo rustc rust-src clippy rustfmt ])
            pkg-config
            cargo-watch
            rust-analyzer-nightly

            nvim-rust
          ];

          RUST_SRC_PATH = "${toolchain.rust-src}/lib/rustlib/src/rust/library";

          shellHook = ''
            export PATH=$PATH:${pkgs.lldb}/bin
          '';
        };
      });
}
