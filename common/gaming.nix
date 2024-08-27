{ pkgs, inputs, ... }:
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
    inputs.dolphin-emu-nix.packages.x86_64-linux.dolphin-emu
    osu-lazer
    pcsx2
    prismlauncher
    protontricks
    protonup-ng
    r2modman
    retroarch
    (steamtinkerlaunch.overrideAttrs
      (o: { src = inputs.steamtinkerlaunch-master; }))
    xivlauncher
  ];
}
