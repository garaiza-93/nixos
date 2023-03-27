{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-22.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs-old";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";

    polybar-master = {
      type = "git";
      url = "https://github.com/polybar/polybar.git";
      submodules = true;
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-old
    , nixos-wsl
    , home-manager
    , impermanence
    , polybar-master
    }:
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
                inherit polybar-master impermanence;
              };
              home-manager.users.goose = { ... }: {
                imports = [ ./profiles/goose.nix ];
              };
            }
            impermanence.nixosModules.impermanence
            {
              environment.persistence."/nix/persist/system" = {
                directories = [
                  "/etc/NetworkManager/system-connections/"
                  "/root"
                ];
                files = [
                  "/etc/passwd"
                ];
              };
              environment.etc."machine-id".source = "/nix/etc/machine-id";
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
