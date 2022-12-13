{ self, config, pkgs, ... }:

let
  # Tokyo Night baybeeee
  background-alt = "#1A1B26FF";
  background = "#15161EFF";
  foreground = "#C0CAF5";
  selected = "#33467C";
  active = "#414868";
  urgent = "#F7768E";

  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;

    font = "Hack Nerd Font 12";
    location = "center";
    terminal = "${pkgs.kitty}/bin/kitty";

    theme = {
      "*" = {
        background-color = mkLiteral "${background}";
        color = mkLiteral "${foreground}";
        separator-color = mkLiteral "${background-alt}";
        width = 512;
      };

      mainbox = {
        padding = mkLiteral "10px";
      };

      prompt.enabled = false;
    };
  };
}

