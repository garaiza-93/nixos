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

  #security.pam.services.sddm.enableGnomeKeyring = true;
  # trying to manage this using home-manager
  # services.gnome.gnome-keyring.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
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
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
    "/home/hd1" = {
      device = "/dev/disk/by-uuid/30b739a9-bca2-45c6-b939-a688f675a92b";
      fsType = "ext4";
    };
    # "/home/ssd1" = {
    #   device = "/dev/disk/by-uuid/535f71b3-d1bb-4dce-9ab3-3cd91bf431fc";
    #   fsType = "ext4";
    # };
  };
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  xdg.portal = {
    config.common.default = "gtk";
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
    logmein-hamachi.enable = true;
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
    };
    monado.enable = true;
    monado.defaultRuntime = true;

    # desktopManager.cosmic.enable = true;
    displayManager.sddm.enable = true;
    # displayManager.cosmic-greeter.enable = true;
  };

  programs = {
    nm-applet.enable = true;
    zsh.enable = true;
    java.enable = true;
    dconf.enable = true;
    seahorse.enable = true;

    steam.enable = true;
    steam.platformOptimizations.enable = true;

    alvr.enable = true;
  };

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.xpadneo.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

  environment = {
    systemPackages = with pkgs; [ haguichi python3 ];
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
