{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    polybar-master = {
      url = "github:polybar/polybar";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, polybar-master }:
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
              home-manager.extraSpecialArgs = {
                inherit self polybar-master;
              };
              home-manager.users.goose = { ... }: {
                imports = [ ./profiles/goose.nix ];
              };
            }
          ];
        };
      };
    };
}
