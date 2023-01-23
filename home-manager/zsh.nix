{ config, pkgs, ... }:

let
  img = ../img;

in
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      l = "ls -lAth --color=auto";
      fucknvidia = "sudo nvidia-settings";
      sysedit = "nvim ~/.config/nixpkgs";
      sysbuild = "cd ~/.config/nixpkgs && sudo nixos-rebuild switch --flake '.#main'";
      neofetch = "neofetch --source ${img}/seele-ascii";
    };
    history = {
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "spaceship-prompt/spaceship-prompt"; tags = [ use:spaceship.zsh from:github as:theme ]; }
      ];
    };
    envExtra = ''
      export TERM=xterm-256color
    '';
  };
}
