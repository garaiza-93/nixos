{ home, config, pkgs, ... }:

{
  home.stateVersion = "22.11";
  manual.manpages.enable = true;

  imports = [
   ../devtools/neovim/neovim.nix
   ../devtools/git.nix
   ../devtools/tmux.nix
   ../devtools/misc.nix
   ../common/btop.nix
   ../common/zsh.nix
  ];
}
