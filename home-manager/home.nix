{ pkgs, ... }:

{
  home.sessionVariables =
    {
      "BROWSER" = "firefox";
      "STEAM_EXTRA_COMPAT_TOOLS_PATHS" = "\${HOME}/.steam/root/compatibilitytools.d";
      "ZDOTDIR" = "\${HOME}/.config/zsh";
    };

  imports = [
    ./btop.nix
    ./git.nix
    ./kitty.nix
    ./misc.nix
    ./rofi.nix
    ./tmux.nix
    ./zsh.nix
  ];
}
