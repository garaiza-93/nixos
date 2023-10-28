{ pkgs, ... }:
let
  retroarch = pkgs.retroarch.override {
    cores = with pkgs.libretro; [ dolphin pcsx-rearmed mupen64plus flycast ];
  };
in {
  home.sessionVariables."STEAM_EXTRA_COMPAT_TOOLS_PATHS" =
    "\${HOME}/.steam/root/compatibilitytools.d";
  home.packages = with pkgs; [
    osu-lazer
    pcsx2
    prismlauncher-qt5
    protontricks
    protonup-ng
    retroarch
    steam
    steam-run
  ];
}
