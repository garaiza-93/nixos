{ pkgs, ... }:

{
  home.sessionVariables."BROWSER" = "firefox";
  home.packages = with pkgs; [
    firefox
    gparted
    killall
    lightdm
    neofetch
    nix-index
    qbittorrent
    thefuck
    timeshift
    unetbootin
    unzip
    wget
    xdotool
    xorg.xwininfo
  ];
}
