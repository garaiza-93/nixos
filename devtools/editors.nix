{ pkgs, lib, config, inputs, system, ... }:
let
  fenixPkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ inputs.fenix.overlays.default ];
  };

  toolchain = fenixPkgs.fenix.stable;
in {
  home.packages = with pkgs;
    [
      # inputs.nvim-nixified.packages.x86_64-linux.default
      pkg-config
      cargo-watch
    ] ++ (with toolchain; [ cargo rustc rust-src rustfmt ]);

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
          # msbuild
          ripgrep

          toolchain.clippy
          toolchain.rust-analyzer
          marksman
          nil
          taplo
          omnisharp-roslyn
          # (python3.withPackages (ps:
          #   with ps;
          #   [ python-lsp-server ]
          #   ++ python-lsp-server.optional-dependencies.all))
          nodePackages.bash-language-server
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted
          nodePackages.yaml-language-server
        ])
        "--set-default"
        "RUST_SRC_PATH"
        "${toolchain.rust-src}/lib/rustlib/src/rust/library"
      ];
  });

  programs.helix.languages = with pkgs; {
    language-server = {
      nil = {
        command = "${nil}/bin/nil";
        config.nil = {
          formatting.command = [ "${nixpkgs-fmt}/bin/nixpkgs-fmt" ];
          # if you uncomment, be sure to add ssh key to agent
          # before starting Helix!!!
          # nix.flake.autoEvalInputs = true;
        };
      };
      omnisharp = {
        command = "${omnisharp-roslyn}/bin/OmniSharp";
        args = [ "-l" "Error" "--languageserver" "-z" ];
      };
      rust-analyzer = {
        command = "${toolchain.rust-analyzer}/bin/rust-analyzer";
        config = { check.command = "clippy"; };
      };
      yaml-language-server = {
        command = "${yaml-language-server}/bin/yaml-language-server";
        config.yaml = {
          schemas = { kubernetes = "/*.y{a,}ml"; };
          format.enable = true;
        };
      };
    };
    language = [
      {
        name = "bash";
        auto-format = true;
        file-types = [ "sh" "bash" ];
        formatter = {
          command = "${shfmt}/bin/shfmt";
          # Indent with 2 spaces, simplify the code, indent switch cases, add space after redirection
          args = [ "-i" "4" "-s" "-ci" "-sr" ];
        };
      }
      {
        name = "c-sharp";
        language-servers = [ "omnisharp" ];
        auto-format = true;
        # debugger = {
        #   name = "netcoredbg";
        #   command = "${netcoredbg}/bin/netcoredbg";
        #   transport = "stdio";
        #   templates = [{
        #     name = "binary";
        #     request = "launch";
        #     completion = [{
        #       name = "binary";
        #       completion = "filename";
        #     }];
        #   }];
        # };
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
      {
        name = "python";
        language-servers = [{ name = "pylsp"; }];
      }
      {
        name = "nix";
        language-servers = [ "nil" ];
      }
      {
        name = "rust";
        language-servers = [ "rust-analyzer" ];
        auto-format = true;
        debugger = {
          name = "lldb-dap";
          command = "${lldb}/bin/lldb-dap";
          transport = "stdio";
          templates = [{
            name = "binary";
            request = "launch";
            completion = [{
              name = "binary";
              completion = "filename";
            }];
            # Workaround, see helix wiki
            # https://github.com/helix-editor/helix/wiki/Debugger-Configurations#configuration-for-rust
            args = {
              program = "{0}";
              initCommands = [
                "command script import /usr/local/etc/lldb_dap_rustc_primer.py"
              ];
            };
          }];
        };
      }
      {
        name = "toml";
        language-servers = [{ name = "taplo"; }];
      }
      {
        name = "yaml";
        file-types = [ "yaml" "yml" ];
        language-servers = [ "yaml-language-server" ];
      }
    ];
  };
}
