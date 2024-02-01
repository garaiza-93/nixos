{ pkgs, ... }:

{
  home.packages = with pkgs; [
    feh
    flameshot
    mpv
    pavucontrol
    peek
    playerctl
  ];
}
