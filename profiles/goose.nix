{ home, config, pkgs, ... }:

{
  home.stateVersion = "23.05";
  manual.manpages.enable = true;

  imports = [
    ../ui/x11/ui.nix
    ../common/all.nix
    ../devtools/all.nix
  ];
}
