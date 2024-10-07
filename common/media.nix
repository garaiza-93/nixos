{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ani-cli
    miru
    mpv
    vlc

    feh
    flameshot

    pavucontrol
    peek
    playerctl
  ];
}
