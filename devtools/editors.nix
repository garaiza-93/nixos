{ pkgs, lib, config, inputs, ... }: {
  home.packages = [ inputs.nvim-nixified.packages.x86_64-linux.default ];

  programs.helix.enable = true;
  # Handle Helix configuration imperatively. Might port to the module later.
  home.file.".config/helix/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.xdg.configHome}/nixos/devtools/helix-config.toml";

  programs.helix.package = pkgs.helix.overrideAttrs (self: {
    makeWrapperArgs = with pkgs;
      self.makeWrapperArgs or [ ] ++ [
        "--suffix"
        "PATH"
        ":"
        (lib.makeBinPath [
          lldb
          netcoredbg
          dotnet-sdk
          msbuild
          ripgrep

          taplo
          marksman

          nodePackages.bash-language-server
          nil
          omnisharp-roslyn
          (python3.withPackages (ps:
            with ps;
            [ python-lsp-server ]
            ++ python-lsp-server.optional-dependencies.all))
          nodePackages.vscode-langservers-extracted
          nodePackages.yaml-language-server
        ])
        "--set-default"
        "RUST_SRC_PATH"
        "${rustPlatform.rustcSrc}/library"
      ];
  });

  programs.helix.languages = with pkgs; {
    language-server = {
      nil = {
        command = "${nil}/bin/nil";
        # command = "nil";
        config.nil = {
          formatting.command = [ "${nixpkgs-fmt}/bin/nixpkgs-fmt" ];
          nix.flake.autoEvalInputs = true;
        };
      };
      omnisharp = {
        command = "${omnisharp-roslyn}/bin/OmniSharp";
        args = [ "-l" "Error" "--languageserver" "-z" ];
      };
    };
    language = [
      {
        name = "c-sharp";
        debugger.name = "netcoredbg";
        debugger.command = "${netcoredbg}/bin/netcoredbg";
        language-servers = [ "omnisharp" ];
      }
      {
        name = "json";
        language-servers = [{
          name = "vscode-json-language-server";
          except-features = [ "format" ];
        }];
      }
      {
        name = "markdown";
        language-servers = [{
          name = "marksman";
          except-features = [ "format" ];
        }];
      }
    ];
  };
}
