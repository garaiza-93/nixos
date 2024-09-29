{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ani-cli
    animdl
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
