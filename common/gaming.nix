{ pkgs, dolphin-emu-nix, steamtinkerlaunch-master, ... }:
let
  mupen64plus-patched = pkgs.libretro.mupen64plus.overrideAttrs (o: {
    patches = (o.patches or [ ]) ++ [ ../patches/larger_cart_rom.patch ];
  });
  retroarch = pkgs.retroarch.override {
    cores = with pkgs.libretro; [
      dolphin
      pcsx-rearmed
      mupen64plus-patched
      flycast
    ];
  };
in {
  home.sessionVariables."STEAM_EXTRA_COMPAT_TOOLS_PATHS" =
    "\${HOME}/.steam/root/compatibilitytools.d";
  home.packages = with pkgs; [
    dolphin-emu-nix.packages.x86_64-linux.dolphin-emu
    itch
    osu-lazer
    pcsx2
    prismlauncher-qt5
    protontricks
    protonup-ng
    r2modman
    retroarch
    steam
    steam-run
    (steamtinkerlaunch.overrideAttrs (o: { src = steamtinkerlaunch-master; }))
  ];
}
