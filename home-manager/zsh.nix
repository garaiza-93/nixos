{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      l = "ls -lAth --color=auto";
      fucknvidia = "sudo nvidia-settings";
      sysedit = "nvim ~/.config/nixpkgs";
      sysbuild = "cd ~/.config/nixpkgs && sudo nixos-rebuild switch --flake '.#main'";
    };
    history = {
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };
  };
}
