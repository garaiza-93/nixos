{ home, impermanence, ... }:

{
  home.stateVersion = "23.05";
  manual.manpages.enable = true;

  imports = [
    ../ui/x11/ui.nix
    ../common/all.nix
    ../devtools/all.nix
    (impermanence + "/home-manager.nix")
  ];

  home.persistence."/nix/persist/home/goose" = {
    allowOther = true;
    directories = [
      ".config/nix"
      ".config/nixos"
      ".config/BetterDiscord"
      ".config/cef_user_data"
      ".config/cura"
      ".config/discord"
      ".config/kusti8"
    ];
  };
}
