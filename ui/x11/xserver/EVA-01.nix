{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    layout = "us";
    xkbVariant = "";
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
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
