{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <sops-nix/modules/sops>
      <home-manager/nixos>
      ./home.nix
    ];


  networking = {
    networkmanager.enable = true;
  };


  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    enable = true;
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  hardware = {
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
      gparted
      flameshot
      lightdm
      neovim
      networkmanager-openvpn
      nix-index
      openvpn
      peek
      plocate
      ripgrep
      timeshift
      unetbootin
      wine
      winetricks
      xdotool
      xorg.xwininfo
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

}
