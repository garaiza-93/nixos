{ pkgs, ... }: {
  services.xserver = { videoDrivers = [ "nvidia" ]; };

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.mesa ];
    };
    nvidia.forceFullCompositionPipeline = true;
  };

}
