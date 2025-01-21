{ pkgs, ... }: {
  home.stateVersion = "24.05";

  home.username = "gustavo";
  home.homeDirectory = "/home/gustavo";
  home.sessionVariables."ZDOTDIR" = "\${HOME}/.config/zsh";
  home.packages = with pkgs; [ awscli2 ripgrep kubectl gh fzf jq lazygit nodePackages.prettier ];

  manual.manpages.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ../devtools/wsl.nix
    ../devtools/core.nix
    ../devtools/git-hm.nix
    ../common/btop.nix
    ../zsh/gustavo-hm.nix
    ../prompts/gustavo-hm.nix
  ];
}
