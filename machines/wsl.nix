{ pkgs, ... }:

{
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    settings.trusted-users = [ "root" "gustavo" ];
  };

  system.stateVersion = "22.11";

  networking.hostName = "wsl";
  networking.nameservers =
    [ "10.128.0.115" "10.128.0.116" "1.1.1.1" "8.8.8.8" ];

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/libexec" ];
    sessionVariables = rec {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_DATA_HOME = "$HOME/.local/share";
      # following line adds to PATH, not replace.
      PATH = [ "${XDG_BIN_HOME}" ];
      OMNISHARPHOME = "${XDG_CONFIG_HOME}/omnisharp";
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
      DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "true";
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.gustavo = {
      isNormalUser = true;
      description = "gustavo";
      extraGroups = [ "wheel" "docker" ];
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
    wslConf.network.generateResolvConf = false;
    defaultUser = "gustavo";

    startMenuLaunchers = true;
    docker-native.enable = true;
  };

  security.pki.certificates = [ "/etc/ssl/certs/simpleltc/sltc_ca.crt" ];
}
