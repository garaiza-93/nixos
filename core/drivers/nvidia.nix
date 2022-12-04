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
    nvidia.forceFullCompositionPipeline = true;
  };

}
