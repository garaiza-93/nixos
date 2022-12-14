{ self, config, pkgs, ... }:

let
  # Tokyo Night baybeeee
  background = "argb:CD1a1b26";
  background-alt = "#24283b";
  foreground = "#c0caf5";
  blue_accent = "#7aa2f7";
  urgent = "#f7768e";

  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;

    font = "Hack Nerd Font 14";
    location = "center";
    terminal = "${pkgs.kitty}/bin/kitty";

    theme = {
      window = {
        background-color = mkLiteral "${background}";
        border = 1;
        border-color = mkLiteral "${background-alt}";
        width = 600;

        children = mkLiteral "[ horibox ]";
      };

      horibox = {
        background-color = mkLiteral "#FF0000";
        orientation = mkLiteral "horizontal";

        children = mkLiteral "[ textbox, search ]";
      };

      search = {
        background-color = mkLiteral "#00FF00";
        orientation = mkLiteral "vertical";

        children = mkLiteral "[ entry, listview ]";
      };

      textbox = {
        background-color = mkLiteral "#0000FF";
        color = mkLiteral "inherit";
        markup = true;
        content = "<span size=\"large\"><b>hello world</b></span>\\ngoodbye world";

        font = "Hack Nerd Font 12";
      };

      entry = {
        background-color = mkLiteral "#FFFF00";
        color = mkLiteral "inherit";

        expand = false;
      };

      listview = {
        background-color = mkLiteral "#FF00FF";
      };

      element-text = {
        background-color = mkLiteral "${background-alt}";
        color = mkLiteral "${foreground}";
      };

      "element-text selected" = {
        background-color = mkLiteral "${blue_accent}";
        color = mkLiteral "${background}";
      };
    };
  };
}

