{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./i3.nix
      ./hardware-configuration.nix
      <sops-nix/modules/sops>
    ];

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

  networking = {
    hostName = "EVA-01";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.utf8";

  fileSystems = {
    "/home/hd1" = {
      device = "/dev/sda1";
      fsType = "ext4";
    };
    "/home/ssd1" = {
      device = "/dev/sdb1";
      fsType = "ext4";
    };
  };

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    enable = true;
  };
  
  services.flatpak.enable = true;
  
  services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";

      desktopManager = {
        xterm.enable = false;
      };

      videoDrivers = [ "nvidia" ];
      config = ''
          Section "Screen"
              Identifier      "Screen0"
        Device          "Device0"
        Monitor         "Monitor0"
        DefaultDepth    24
        Option          "Stereo" "0"
        Option          "nvidiaXineramaInfoOrder" "DFP-4"
        Option          "metamodes" "2560x1440_144 +0+0"
        Option          "SLI" "Off"
        Option          "MultiGPU" "off"
        Option          "BaseMosaic" "off"
        SubSection      "Display"
            Depth       24
        EndSubSection
          EndSection
      '';
    };

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    pulseaudio = {
      enable = true;
      support32Bit = true;
      extraConfig = "load-module module-combine-sink";
    };
    xpadneo.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.goose = {
      isNormalUser = true;
      description = "goose";
      extraGroups = [ "networkmanager" "wheel" "audio" ];
      packages = with pkgs; [
        ani-cli
        discord
        grapejuice
        firefox
        neofetch
        protonup-ng
        prismlauncher-qt5
        qbittorrent
        xivlauncher
      ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        withJava = true;
        withPrimus = true;
        extraPkgs = pkgs: with pkgs; [
          libgdiplus
          glxinfo
        ];
      };
    };
  };

  programs = {
    java = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    zsh = {
      enable = true;
    };
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      cargo
      curl
      gcc
      git
      gparted
      home-manager
      htop
      flameshot
      killall
      libglibutil
      lightdm
      gnumake
      neovim
      networkmanager-openvpn
      nix-index
      openvpn
      peek
      plocate
      ripgrep
      thefuck
      timeshift
      tmux
      unetbootin
      unzip
      vim
      wine
      winetricks
      wget
      xdotool
      xorg.xwininfo
      yad
    ];
    sessionVariables = {
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      ZDOTDIR = "\${HOME}/.config/zsh";
      # following line adds to PATH, not replace.
      PATH = [
        "\${XDG_BIN_HOME}"
      ];
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "22.05";

}
