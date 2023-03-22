{
  description = "nodejs and Typescript devshell/builds using dream2nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    dream2nix.url = "github:nix-community/dream2nix";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, dream2nix, flake-utils, ... }:
    let
      lib = nixpkgs.lib // builtins;
      systems = [ "x86_64-linux" ];
      forAllSystems = f:
        lib.genAttrs systems (
          system:
          f system (nixpkgs.legacyPackages.${system})
        );

      partial-flake = dream2nix.lib.makeFlakeOutputs
        {
          systems = flake-utils.lib.defaultSystems;
          config.projectRoot = ./.;
          source = ./.;
          projects = ./projects.toml;
        };
    in
    dream2nix.lib.dlib.mergeFlakes [
      partial-flake
      {
        devShells = forAllSystems (system: pkgs: (
          lib.optionalAttrs
            (partial-flake ? devShells.${system}.name-me.overrideAttrs)
            rec {
              default = name-me;
              name-me =
                partial-flake.devShells.${system}.name-me.overrideAttrs
                  (old: {
                    buildInputs = with pkgs; [
                      nodePackages.typescript
                      nodePackages.typescript-language-server
                      nodePackages.vscode-langservers-extracted
                      nodejs
                    ] ++ old.buildInputs;
                  });
            }
        ));
      }
    ];
}
