{
  home.stateVersion = "22.11";
  home.sessionVariables."ZDOTDIR" = "\${HOME}/.config/zsh";

  manual.manpages.enable = true;

  imports = [
    ../devtools/all.nix
    ../common/btop.nix
    ../zsh/default.nix
    ../prompts/default.nix
  ];
}
