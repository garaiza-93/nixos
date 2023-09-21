{ pkgs, ... }: {
  home.packages = with pkgs; [
    ani-cli
    betterdiscordctl
    discord
    gimp
    hue-plus
    libreoffice
    lutris
    piper
    wineWowPackages.full
    winetricks
  ];
}
