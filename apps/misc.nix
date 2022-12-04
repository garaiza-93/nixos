{ config, pkgs, nixpkgs, lib, ... }:

{
  programs = {
    java.enable = true;
    zsh.enable = true;
  };

  home.packages = with pkgs; [
    ani-cli
    discord
    firefox
    flameshot
    gparted
    grapejuice
    killall
    lightdm
    neofetch
    neovim
    networkmanager-openvpn
    nix-index
    openvpn
    peek
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
