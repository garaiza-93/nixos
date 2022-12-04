{ home, ... }:

{
  home.stateVersion = "22.11";
  manual.manpages.enable = false;

  imports = [
    ../../ui/x11/i3.nix
    ../../apps/apps.nix
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.goose = {
      isNormalUser = true;
      description = "goose";
      extraGroups = [ "networkmanager" "wheel" "audio" ];
    };
  };
}
