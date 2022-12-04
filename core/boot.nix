{ self, pkgs, ... }:

let
  defaultUser = "goose";
in
{
  imports = [ ];
  environment.variables = { };


  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelPackages = pkgs.linuxPackages_6_0;
  };
}
