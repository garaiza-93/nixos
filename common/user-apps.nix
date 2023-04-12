{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ani-cli
    betterdiscordctl
    cura
    discord
    hue-plus
    libreoffice
    lutris
    piper
    wineWowPackages.full
    winetricks
  ];
}
