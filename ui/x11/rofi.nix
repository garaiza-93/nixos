{ self, config, pkgs, ... }:

let
  # Tokyo Night baybeeee
  background = "argb:cd1a1b26";
  background-solid = "#1a1b26";
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
        background-color = mkLiteral "transparent";
        border = 1;
        border-color = mkLiteral "${background-alt}";

        orientation = mkLiteral "horizontal";
        spacing = 0;
        children = mkLiteral "[ vertbox, searchbox ]";
      };

      vertbox = {
        background-color = mkLiteral "transparent";

        orientation = mkLiteral "vertical";
        children = mkLiteral "[ textbox ]";
      };

      textbox = {
        background-color = mkLiteral "${background}";
        color = mkLiteral "${foreground}";
        border-color = mkLiteral "${blue_accent}";
        border = 1;

        padding = 5;
        expand = true;
        markup = true;
        content = "<span size=\"large\"><b>hello world</b></span>\\ngoodbye world";
      };

      searchbox = {
        background-color = mkLiteral "${background-solid}";
        color = mkLiteral "${foreground}";
        border-color = mkLiteral "${blue_accent}";
        border = 1;

        orientation = mkLiteral "vertical";
        children = mkLiteral "[ entry, listview ]";
      };


      entry = {
        background-color = mkLiteral "${background-alt}";
        color = mkLiteral "${foreground}";
        border-color = mkLiteral "${blue_accent}";
        border = mkLiteral "0 0 1px 0";

        expand = false;
      };

      listview = {
        background-color = mkLiteral "${background-alt}";
        color = mkLiteral "${foreground}";
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

