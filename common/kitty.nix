{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "Iosevka Comfy";
      size = 12;
    };

    theme = "Tokyo Night";

    settings = {
      background_opacity = "0.8";
      enable_audio_bell = false;
    };
  };
}
