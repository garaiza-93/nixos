{
  description = "Basic Python environment";

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

          nvim-python = inputs'.nvim-nixified.packages.python-config;
        in rec {
          # Executed by 'nix build'
          packages.default = pkgs.mkPythonPackage {
            inherit pname version;
            src = ./.;
          };

          # Executed by `nix run`
          apps.default = flake-utils.lib.mkApp { drv = packages.default; };

          # Used by `nix develop`
          mission-control.scripts = {
            cowsay = {
              description = "Test command";
              exec = "${pkgs.boxxy}/bin/boxxy -d ${pkgs.cowsay}";
            };
          };
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.mission-control.devShell ];
            buildInputs = with pkgs; [
              boxxy
              python311
              nvim-python
            ];
          };
        };
    };
}
