{ config, pkgs, nixpkgs, lib, ... }:

{
  programs = {
    java.enable = true;
    feh.enable = true;
    mpv.enable = true;
  };

  systemd.user.services.mpris-proxy = {
    Unit.Description = "Mpris proxy";
    Unit.After = [ "network.target" "sound.target" ];
    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    Install.WantedBy = [ "default.target" ];
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
