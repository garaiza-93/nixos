{ pkgs, ... }: {
  home.sessionVariables."BROWSER" = "firefox";
  home.packages = with pkgs; [
    ani-cli
    borgbackup
    firefox
    gparted
    killall
    lxappearance
    neofetch
    nix-index
    ripgrep
    transmission_4-gtk
    xfce.thunar
    xfce.tumbler
    unetbootin
    unzip
    wget
    xdotool
    xorg.xwininfo
  ];
}
