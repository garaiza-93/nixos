{ config, pkgs, ... }: {
  home = {
    username = "goose";
    homeDirectory = "/home/goose";
    stateVersion = "22.11";
  };
  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      shellAliases = {
        l = "ls -lAth --color=auto";
        dotedit = "nvim ~/.config/nixpkgs/home.nix";
        dotbuild = "home-manager switch";
        fucknvidia = "sudo nvidia-settings";
        sysedit = "nvim /etc/nixos/configuration.nix";
        sysbuild = "sudo nixos-rebuild switch";
      };
      history = {
        size = 10000;
        path = "~/.cache/zsh_history";
      };
    };
  };
}
