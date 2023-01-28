{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl = "github:nix-community/NixOS-WSL";

    polybar-master = {
      type = "git";
      url = "https://github.com/polybar/polybar.git";
      submodules = true;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, polybar-master }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        EVA-01 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/EVA-01.nix
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
        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/wsl.nix
            nixos-wsl.nixosModules.wsl
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit self;
              };
              home-manager.users.gustavo = { ... }: {
                imports = [ ./profiles/gustavo.nix ];
              };
            }
          ];
        };
      };
    };
}
