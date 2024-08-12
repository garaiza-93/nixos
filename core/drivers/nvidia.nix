{ pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    graphics.extraPackages = [ pkgs.mesa ];

    nvidia.forceFullCompositionPipeline = true;
    nvidia.modesetting.enable = true;
  };
}
