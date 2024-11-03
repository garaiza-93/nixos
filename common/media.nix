{ pkgs, inputs, system, ... }:

{
  home.packages = with pkgs; [
    ani-cli
    inputs.lobster-git.packages.${system}.default
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
