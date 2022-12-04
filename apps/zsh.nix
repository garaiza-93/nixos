{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      l = "ls -lAth --color=auto";
      fucknvidia = "sudo nvidia-settings";
      sysedit = "nvim ~/.config/nixpkgs";
      sysbuild = "sudo nixos-rebuild switch --flake";
    };
    history = {
      size = 10000;
      path = "~/.cache/zsh_history";
    };
  };
}
