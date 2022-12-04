{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    i3-master = {
      url = "github:i3/i3";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, home-manager, i3-master }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        main = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/main.nix
            ./ui/x11/xserver/EVA-01.nix
            ./apps/apps.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.goose = { ... }: {
                imports = [ ./profiles/goose.nix ];
              };
            }
          ];
        };
      };
    };
}
