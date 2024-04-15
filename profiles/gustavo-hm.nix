{ pkgs, ... }: {
  home.stateVersion = "24.05";

  home.username = "gustavo";
  home.homeDirectory = "/home/gustavo";
  home.sessionVariables."ZDOTDIR" = "\${HOME}/.config/zsh";
  home.packages = with pkgs; [ awscli2 gh fzf ];

  manual.manpages.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ../devtools/tmux.nix
    ../devtools/direnv.nix
    ../devtools/editors.nix
    ../devtools/git-hm.nix
    ../common/btop.nix
    ../zsh/gustavo-hm-zsh.nix
    ../prompts/gustavo-hm.nix
  ];
}
