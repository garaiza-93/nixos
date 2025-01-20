{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    leftwm-theme
    leftwm-config
  ];
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    desktopManager.xterm.enable = false;
    windowManager.bspwm.enable = true;
    windowManager.leftwm.enable = true;
    config = ''
      Section "Screen"

      # Removed Option "metamodes" "2560x1440_144 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      # Removed Option "nvidiaXineramaInfoOrder" "DFP-4"
          Identifier     "Screen0"
          Device         "Device0"
          Monitor        "Monitor0"
          DefaultDepth    24
          Option         "Stereo" "0"
          Option         "nvidiaXineramaInfoOrder" "DP-2"
          Option         "metamodes" "2560x1440_165 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
          Option         "SLI" "Off"
          Option         "MultiGPU" "Off"
          Option         "BaseMosaic" "off"
          SubSection     "Display"
              Depth       24
          EndSubSection
      EndSection
    '';
  };
}
