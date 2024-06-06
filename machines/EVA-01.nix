{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../core/all.nix
    ../fonts.nix
    ../configuration.nix
  ];

  system.stateVersion = "unstable";

  boot = {
    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [ "root" "goose" ];
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0b3ff611-7c24-4943-8768-4a46da0afc32";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/8DB2-8ACE";
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
    config.common.default = "gtk";
    enable = true;
  };

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "EVA-01";
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
    firewall.enable = true;
    firewall.allowPing = true;
  };

  services = {
    ratbagd.enable = true;
    flatpak.enable = true;
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
    };

    displayManager.defaultSession = "none+bspwm";
  };

  programs = {
    nm-applet.enable = true;
    zsh.enable = true;
    java.enable = true;
    dconf.enable = true;

    steam.enable = true;
    steam.platformOptimizations.enable = true;
  };

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.xpadneo.enable = true;

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
      PATH = [ "\${XDG_BIN_HOME}" ];
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.goose = {
      isNormalUser = true;
      description = "goose";
      extraGroups =
        [ "docker" "networkmanager" "wheel" "audio" "mlocate" "libvirtd" ];
    };
  };
}
