{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnumake
    killall
    neofetch
    thefuck
    unzip
    wget
  ];
}
