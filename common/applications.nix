{ pkgs, ... }:

{
  home.sessionVariables."BROWSER" = "firefox";
  home.packages = with pkgs; [
    ani-cli
    borgbackup
    firefox
    gparted
    gvfs
    killall
    lightdm
    lxappearance
    neofetch
    nix-index
    nyxt
    transmission-gtk
    thefuck
    xfce.thunar
    xfce.tumbler
    unetbootin
    unzip
    wget
    xdotool
    xorg.xwininfo
  ];
}
