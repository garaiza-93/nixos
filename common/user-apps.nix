{ pkgs, ... }: {
  home.packages = with pkgs; [
    ani-cli
    discord
    gimp
    hue-plus
    libreoffice-qt
    lutris
    pkgs.nur.repos.xeals.cura5
    piper
    (vesktop.override { withSystemVencord = false; })
    wineWowPackages.full
    winetricks
  ];
  services.gammastep = {
    enable = true;
    dawnTime = "8:00-9:00";
    duskTime = "17:00-18:00";
    latitude = "34.0";
    longitude = "-118";
    tray = true;
    settings.general.brightness-day = 1.0;
    settings.general.brightness-night = 0.5;
  };
}
