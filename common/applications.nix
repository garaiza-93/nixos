{ pkgs, ... }:

{
  home.sessionVariables."BROWSER" = "firefox";
  home.packages = with pkgs; [
    firefox
    gparted
    gvfs
    killall
    lightdm
    lxappearance
    neofetch
    nix-index
    qbittorrent
    thefuck
    xfce.thunar
    timeshift
    unetbootin
    unzip
    wget
    xdotool
    xorg.xwininfo
  ];
}
