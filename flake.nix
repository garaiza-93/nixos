{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager-old.url = "github:nix-community/home-manager/release-22.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nvim-nixified.url = "github:garaiza-93/nvim-nixified";
    dolphin-emu-nix.url = "github:matthewcroughan/dolphin-emu-nix";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-old.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs-old";

    polybar-master = {
      type = "git";
      url = "https://github.com/polybar/polybar.git";
      submodules = true;
      flake = false;
    };

    steamtinkerlaunch-master = {
      type = "git";
      url = "https://github.com/sonic2kk/steamtinkerlaunch.git";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-old, nixos-wsl, home-manager
    , home-manager-old, polybar-master, nvim-nixified, dolphin-emu-nix
    , steamtinkerlaunch-master }:
    let system = "x86_64-linux";
    in {
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
                inherit polybar-master nvim-nixified dolphin-emu-nix
                  steamtinkerlaunch-master;
              };
              home-manager.users.goose = {
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
            home-manager-old.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit self; };
              home-manager.users.gustavo = {
                imports = [ ./profiles/gustavo.nix ];
              };
            }
          ];
        };
      };
      homeConfigurations."gustavo" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        modules = [ ./profiles/gustavo-hm.nix ];
        extraSpecialArgs = { inherit nvim-nixified; };

      };
    };
}
