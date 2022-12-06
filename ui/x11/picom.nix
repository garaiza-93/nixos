{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 2;
    backend = "glx";
  };
}
