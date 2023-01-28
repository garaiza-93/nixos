{ config, pkgs, ... }:

let
  img = ../img;

in
{
  home.sessionVariables."ZDOTDIR"= "\${HOME}/.config/zsh";
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      l = "ls -lAth --color=auto";
      fucknvidia = "sudo nvidia-settings";
      sysedit = "nvim ~/.config/nixos";
      nvimedit = "nvim ~/.config/nixos/devtools/neovim/config";
      buildpersonal = "cd ~/.config/nixos && sudo nixos-rebuild switch --flake .#EVA-01";
      buildwork = "cd ~/.config/nixos && sudo nixos-rebuild switch --flake .#wsl";
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
