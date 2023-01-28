{ pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  services.ratbagd.enable = true;
  hardware.xpadneo.enable = true;
}
