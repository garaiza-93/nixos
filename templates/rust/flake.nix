{
  description = "Basic Rust environment with toolchain and language server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    mission-control.url = "github:Platonic-Systems/mission-control";
    nvim-nixified.url = "github:garaiza-93/nvim-nixified";
  };

  outputs =
    inputs@{ self, nixpkgs, flake-utils, flake-parts, nvim-nixified, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports =
        [ inputs.flake-root.flakeModule inputs.mission-control.flakeModule ];
      perSystem = { pkgs, lib, config, inputs', ... }:
        let
          pname = "name-me";
          version = "0.1.0";

          nvim-rust = inputs'.nvim-nixified.packages.rust-config;
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
            rWatch = {
              description = "continuous cargo check";
              exec = "boxxy -d cargo watch";
            };
            rWatchAll = {
              description = "Watch check and tests";
              exec = "boxxy -d cargo watch -x check -x test";
            };
            rTest = {
              description = "Run tests";
              exec = "boxxy -d cargo test";
            };
          };
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.mission-control.devShell ];
            buildInputs = with pkgs; [
              boxxy
              nvim-rust
              cargo
              cargo-watch
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
