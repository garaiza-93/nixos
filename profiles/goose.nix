{ home, pkgs, ... }:

{
  home.stateVersion = "22.11";
  manual.manpages.enable = true;

  imports = [
    ../ui/x11/i3.nix
    ../apps/apps.nix
  ];
}
