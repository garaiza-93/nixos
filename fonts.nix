{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
    iosevka-comfy.comfy
    iosevka-comfy.comfy-wide
  ];
}
