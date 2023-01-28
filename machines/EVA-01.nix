{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      ../core/all.nix
      ../fonts.nix
      ../configuration.nix
      ../no-home-manager/steam.nix
    ];

  system.stateVersion = "unstable";

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelModules = [ "kvm-amd" ];
  };


  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

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
      device = "/dev/disk/by-uuid/30b739a9-bca2-45c6-b939-a688f675a92b";
      fsType = "ext4";
    };
    "/home/ssd1" = {
      device = "/dev/disk/by-uuid/535f71b3-d1bb-4dce-9ab3-3cd91bf431fc";
      fsType = "ext4";
    };
  };

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    enable = true;
  };

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "EVA-01";
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
  };

  services.ratbagd.enable = true;
  hardware.xpadneo.enable = true;
  programs.nm-applet.enable = true;

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    video.hidpi.enable = lib.mkDefault true;
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

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
      extraGroups = [ "networkmanager" "wheel" "audio" "mlocate" ];
    };
  };
}
