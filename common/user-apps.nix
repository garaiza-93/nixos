{ pkgs, ... }:
{
  home.sessionVariables."STEAM_EXTRA_COMPAT_TOOLS_PATHS" = "\${HOME}/.steam/root/compatibilitytools.d";
  home.packages = with pkgs; [
    ani-cli
    betterdiscordctl
    cura
    discord
    libreoffice
    lutris
    pcsx2
    piper
    prismlauncher-qt5
    protonup-ng
    wine
    winetricks
  ];
}
