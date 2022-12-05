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

      overlays = [
        (final: prev: {
          i3 = prev.i3.overrideAttrs (c: { src = i3-master; });
        })
        (self: super: {
          polybar = super.polybar.override { i3Support = true; pulseSupport = true; };
        })
      ];

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
              nixpkgs.overlays = overlays;
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
