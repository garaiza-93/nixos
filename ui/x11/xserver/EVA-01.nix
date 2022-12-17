{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    desktopManager.xterm.enable = false;
    windowManager.bspwm.enable = true;
    displayManager.defaultSession = "none+bspwm";
    libinput.enable = true;
    libinput.mouse.accelProfile = "flat";
    config = ''
      Section "Screen"
        Identifier      "Screen0"
        Device          "Device0"
        Monitor         "Monitor0"
        DefaultDepth    24
        Option          "Stereo" "0"
        Option          "nvidiaXineramaInfoOrder" "DFP-4"
        Option          "metamodes" "2560x1440_144 +0+0"
        Option          "SLI" "Off"
        Option          "MultiGPU" "off"
        Option          "BaseMosaic" "off"
        SubSection      "Display"
            Depth       24
        EndSubSection
      EndSection
    '';
  };
}
