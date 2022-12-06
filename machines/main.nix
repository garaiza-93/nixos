{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      ../core/boot.nix
      ../core/sound.nix
      ../fonts.nix
      ../core/drivers/nvidia.nix
      ../configuration.nix
    ];

  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  services.blueman.enable = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e9d29fb0-4b79-4f43-9652-9d9fe052c1aa";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/0162-22F2";
      fsType = "vfat";
    };
    "/home/hd1" = {
      device = "/dev/sdb1";
      fsType = "ext4";
    };
    "/home/ssd1" = {
      device = "/dev/sda1";
      fsType = "ext4";
    };
  };

  swapDevices = [ ];

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    enable = true;
  };

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "EVA-01";
    networkmanager.enable = true;
  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    video.hidpi.enable = lib.mkDefault true;
    xpadneo.enable = true;
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";
  system.stateVersion = "unstable";

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/libexec" ];
    sessionVariables = {
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      # following line adds to PATH, not replace.
      PATH = [
        "\${XDG_BIN_HOME}"
      ];
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.goose = {
      isNormalUser = true;
      description = "goose";
      extraGroups = [ "networkmanager" "wheel" "audio" ];
    };
  };
}
