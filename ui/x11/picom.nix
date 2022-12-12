{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 2;
    backend = "glx";

    #opacityRules = [];

    settings = {
      blur-kern = "5x5box";
      blur = {
        method = "dual_kawase";
        strength = 5;
        background = false;
        background-frame = false;
        background-fixed = false;
        kern = "5x5box";
      };
    };
  };
}
