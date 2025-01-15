{
  home.stateVersion = "23.05";
  manual.manpages.enable = true;
  home.sessionVariables."ZDOTDIR" = "\${HOME}/.config/zsh";
  services.gnome-keyring.enable = true;

  imports = [
    ../ui/x11/ui.nix
    ../common/all.nix
    ../devtools/all.nix
    ../zsh/default.nix
    ../prompts/default.nix
  ];
}
