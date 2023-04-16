{ pkgs, config, ... }:
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.mesa ];
    };
    nvidia.forceFullCompositionPipeline = true;
    #TODO: Once 530 driver is fixed, use older driver
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  };

}
