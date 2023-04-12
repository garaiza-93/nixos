{ pkgs, ... }:
{
  home.sessionVariables."STEAM_EXTRA_COMPAT_TOOLS_PATHS" = "\${HOME}/.steam/root/compatibilitytools.d";
  home.packages = with pkgs; [
    pcsx2
    prismlauncher-qt5
    protontricks
    protonup-ng
    steam
    steamtinkerlaunch
    steamtinkerlaunch
  ];
}
