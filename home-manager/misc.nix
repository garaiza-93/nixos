{ config, pkgs, nixpkgs, lib, ... }:

{
  programs = {
    java.enable = true;
    feh.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    ani-cli
    betterdiscordctl
    discord
    firefox
    flameshot
    gparted
    grapejuice
    killall
    lightdm
    lutris
    neofetch
    neovim
    networkmanager-openvpn
    nix-index
    openvpn
    openrgb
    pcsx2
    peek
    piper
    plocate
    prismlauncher-qt5
    protonup-ng
    qbittorrent
    ripgrep
    thefuck
    timeshift
    unetbootin
    unzip
    wget
    wine
    winetricks
    xdotool
    xivlauncher
    xorg.xwininfo
  ];
}
