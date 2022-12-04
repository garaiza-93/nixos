{ pkgs, ... }:
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidia.forceFullCompositionPipeline = true;
  };

}
