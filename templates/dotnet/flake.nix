{
  description = "Basic dotnet7 dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    mission-control.url = "github:Platonic-Systems/mission-control";
    nvim-nixified.url = "github:garaiza-93/nvim-nixified";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, nvim-nixified, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports =
        [ inputs.flake-root.flakeModule inputs.mission-control.flakeModule ];
      perSystem = { pkgs, lib, config, inputs', ... }:
        let nvim-dotnet = inputs'.nvim-nixified.packages.dotnet-config;
        in {
          # Executed by 'nix build'
          #empty...
          # Used by `nix develop`
          mission-control.scripts = {
            dnbuild = {
              description = "dotnet build";
              exec = "${pkgs.boxxy}/bin/boxxy -d dotnet build";
            };
          };
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.mission-control.devShell ];
            buildInputs = with pkgs; [
              nvim-dotnet
              #basics
              dotnet-sdk
              dotnet-runtime

              #packages
              dotnetPackages.Nuget # install nuget declaratively

              #unit testing
              dotnetPackages.NUnit
              dotnetPackages.NUnitRunners

              #language server of choice
              omnisharp-roslyn
            ];

            DOTNET_CLI_TELEMETRY_OPTOUT = 1;
            DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "true";

            shellHook = ''
              export PATH=$PATH:${pkgs.omnisharp-roslyn}/bin:${pkgs.netcoredbg}/bin
            '';
          };
        };
    };
}
