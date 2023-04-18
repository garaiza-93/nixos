{
  description = "Basic dotnet dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          omnisharp = pkgs.omnisharp-roslyn;

          nvimrc = ''
            require("lspconfig").omnisharp.setup {
              cmd = { "dotnet", "${omnisharp}/lib/omnisharp-roslyn/OmniSharp.dll"}
            }

            vim.cmd("LspStart");
            '';
        in
        {
          # Executed by 'nix build'

          # Used by `nix develop`
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              #basics
              dotnet-sdk
              dotnet-runtime
              #packages
              dotnetPackages.Nuget #install nuget declaratively

              #unit testing
              dotnetPackages.NUnit
              dotnetPackages.NUnitRunners

              #language server of choice
              omnisharp-roslyn
            ];

            DOTNET_ROOT = "\${XDG_DATA_HOME}/dotnet";
            DOTNET_CLI_TELEMETRY_OPTOUT = 1;
            DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "true";

            shellHook = ''
              echo '${nvimrc}' > .nvimrc.lua
              export NUGET_PACKAGES=$XDG_DATA_HOME/nuget
              export OMNISHARPHOME=$XDG_CONFIG_HOME/omnisharp
            '';
          };
        }
      );
}
