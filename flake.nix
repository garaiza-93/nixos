{
  nixConfig = {
    substituters = [
      "https://cosmic.cachix.org/"
      "https://nyx.chaotic.cx/"
      "https://nix-community.cachix.org"
      "https://helix.cachix.org"
    ];
    trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-22.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager-old.url = "github:nix-community/home-manager/release-22.11";

    dolphin-emu-nix.url = "github:matthewcroughan/dolphin-emu-nix";
    fenix.url = "github:nix-community/fenix";
    lobster-git.url = "github:justchokingaround/lobster";

    nix-gaming.url = "github:fufexan/nix-gaming";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nvim-nixified.url = "github:garaiza-93/nvim-nixified";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-old.inputs.nixpkgs.follows = "nixpkgs";
    lobster-git.inputs.nixpkgs.follows = "nixpkgs";
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

    vesktop-latest = {
      type = "git";
      url = "https://github.com/Vencord/Vesktop.git";
      rev = "e9da30e420a45c6b38e99e6b854a707e42e6fd8a";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-old, nixos-cosmic, nixos-wsl
    , home-manager, home-manager-old, nix-gaming, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        EVA-01 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/EVA-01.nix
            ./ui/x11/xserver/EVA-01.nix
            nix-gaming.nixosModules.pipewireLowLatency
            nix-gaming.nixosModules.platformOptimizations
            nixos-cosmic.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs system; };
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
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.gustavo = {
                imports = [ ./profiles/gustavo.nix ];
              };
            }
          ];
        };
      };
      homeConfigurations."gustavo-hm" =
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./profiles/gustavo-hm.nix ];
          extraSpecialArgs = { inherit inputs system; };
        };
    };
}
