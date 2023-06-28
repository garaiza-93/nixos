{
  description = "Basic Rust environment with toolchain and language server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    mission-control.url = "github:Platonic-Systems/mission-control";
    mynvim.url = "github:garaiza-93/nvim-nixified";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, flake-parts, mynvim, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports =
        [ inputs.flake-root.flakeModule inputs.mission-control.flakeModule ];
      perSystem = { pkgs, lib, config, inputs', ... }:
        let
          pname = "name-me";
          version = "0.1.0";

          nvim-rust = inputs'.mynvim.packages.rust-config;
        in rec {
          # Executed by `nix build`
          packages.default = pkgs.rustPlatform.buildRustPackage {
            inherit pname version;
            src = ./.;
            cargoLock.lockFile = ./Cargo.lock;
          };

          # Executed by `nix run`
          apps.default = flake-utils.lib.mkApp { drv = packages.default; };

          # Used by `nix develop`
          mission-control.scripts = {
            init = {
              description = "cargo init";
              exec = "boxxy -d cargo init";
            };
          };
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.mission-control.devShell ];
            buildInputs = with pkgs; [
              boxxy
              nvim-rust
              cargo
              rustc
              clippy
              rustfmt
              rust-analyzer
              pkg-config
            ];

            RUST_SRC_PATH =
              "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          };
        };
    };
}
