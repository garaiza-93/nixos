{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "Hack Nerd Font Mono";
      size = 12;
    };

    theme = "Tokyo Night";

    settings = {
      background_opacity = "0.8";
    };
  };
}
