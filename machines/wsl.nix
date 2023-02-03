{ self, pkgs, ... }:

{
#  imports = [
#    ../configuration.nix
#  ];

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.11";

  networking.hostName = "wsl";

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
    users.gustavo = {
      isNormalUser = true;
      description = "gustavo";
      extraGroups = [ "wheel" ];
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "gustavo";
    
    startMenuLaunchers = true;
    docker-native.enable = true;
  };
}
