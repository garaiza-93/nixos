{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    iosevka-comfy.comfy
    iosevka-comfy.comfy-wide
  ];
}
