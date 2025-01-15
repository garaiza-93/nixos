{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 2;
    backend = "glx";

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
      shadow-exclude = [ "class_g ?= 'Peek'" ];
      blur-background-exclude = [ "class_g ?= 'Peek'" ];
    };
  };
}
