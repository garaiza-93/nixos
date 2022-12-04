{ home, pkgs, ... }:

{
  home.stateVersion = "22.11";
  manual.manpages.enable = true;

  imports = [
    ../ui/x11/i3.nix
    ../home-manager/apps.nix
    ../apps/steam.nix
  ];
}
