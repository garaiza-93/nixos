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
    cura
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
    nix-index
    openrgb
    pavucontrol
    pcsx2
    peek
    piper
    prismlauncher-qt5
    protonup-ng
    qbittorrent
    ripgrep
    rofi-vpn
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
