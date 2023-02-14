{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs-old";

    polybar-master = {
      type = "git";
      url = "https://github.com/polybar/polybar.git";
      submodules = true;
      flake = false;
    };

    tokyo-night-gtk = {
      url = "github:Fausto-Korpsvart/Tokyo-Night-GTK-Theme";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-old, nixos-wsl, home-manager, polybar-master, tokyo-night-gtk }:
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
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit polybar-master tokyo-night-gtk;
              };
              home-manager.users.goose = { ... }: {
                imports = [ ./profiles/goose.nix ];
              };
            }
          ];
        };
        wsl = nixpkgs-old.lib.nixosSystem {
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
