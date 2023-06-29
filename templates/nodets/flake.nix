{
  description = "Basic Node+Typescript environment with language server";

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

          nvim-node = inputs'.nvim-nixified.packages.nodets-config;
        in rec {
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
              nvim-node
              nodePackages.typescript
              nodePackages.typescript-language-server
              nodePackages.vls
              nodePackages.eslint
              nodePackages.eslint_d
            ];
          };
        };
    };
}
