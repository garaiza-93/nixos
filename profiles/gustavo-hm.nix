{ pkgs, ... }: {
  home.stateVersion = "22.11";

  home.username = "gustavo";
  home.homeDirectory = "/home/gustavo";
  home.sessionVariables."ZDOTDIR" = "\${HOME}/.config/zsh";
  home.packages = with pkgs; [ awscli2 ];

  manual.manpages.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ../devtools/all.nix
    ../common/btop.nix
    ../zsh/gustavo-hm.nix
    ../prompts/gustavo-hm.nix
  ];
}
