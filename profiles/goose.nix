{ home, config, pkgs, ... }:

{
  home.stateVersion = "22.11";
  manual.manpages.enable = true;

  imports = [
    ../ui/x11/ui.nix
    ../home-manager/home.nix
  ];
}
