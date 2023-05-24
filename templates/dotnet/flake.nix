{
  description = "Basic dotnet7 dev environment";

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
            local caps = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities());
            require("lspconfig").omnisharp.setup {
              cmd = { "dotnet", "${omnisharp}/lib/omnisharp-roslyn/OmniSharp.dll"},
              capabilities = caps,
            }

            vim.cmd("LspStart");
            '';
        in
        {
          # Executed by 'nix build'

          # Used by `nix develop`
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              #BECAUSE MICROSOFT BAD (uses bind mounts to declutter $HOME)
              boxxy

              #basics
              dotnet-sdk_7
              dotnet-runtime

              #packages
              dotnetPackages.Nuget #install nuget declaratively

              #unit testing
              dotnetPackages.NUnit
              dotnetPackages.NUnitRunners

              #language server of choice
              omnisharp-roslyn
            ];

            DOTNET_CLI_TELEMETRY_OPTOUT = 1;
            DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "true";

            shellHook = ''
              echo '${nvimrc}' > .nvimrc.lua
            '';
          };
        }
      );
}
