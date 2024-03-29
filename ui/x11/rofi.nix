{ config, pkgs, ... }:

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

    font = "Hack Nerd Font 12";
    location = "center";
    terminal = "${pkgs.kitty}/bin/kitty";

    theme = {
      window = {
        background-color = mkLiteral "transparent";
        border-color = mkLiteral "${background-alt}";
        border = 1;

        width = 900;

        expand = false;
        orientation = mkLiteral "horizontal";
        spacing = 0;
        children = mkLiteral "[ textboxtips, searchbox ]";
      };

      textboxtips = {
        background-color = mkLiteral "${background}";
        color = mkLiteral "${foreground}";
        border-color = mkLiteral "${blue_accent}";
        border = 1;

        padding = 5;
        expand = false;
        markup = true;
        content = "<span size=\"x-large\"><b>Run an Application</b></span>\\n<span size=\"small\">Remember to take breaks. Drink your water.</span>\\n\\n\\n\\n\\n\\n\\n\\n\\n<span><i>Alt+1: Workspaces\\nAlt+2: Applications(default)\\nAlt+3: All Executables\\nAlt+4: Connect to Server (SSH)</i></span>";
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
        padding = mkLiteral "0px 0px 0px 2px";
        expand = false;
      };

      listview = {
        background-color = mkLiteral "${background-alt}";
        color = mkLiteral "${foreground}";
        expand = false;
      };

      element-text = {
        background-color = mkLiteral "${background-alt}";
        color = mkLiteral "${foreground}";
        padding = mkLiteral "0px 0px 0px 2px";
      };

      "element-text selected" = {
        background-color = mkLiteral "${blue_accent}";
        color = mkLiteral "${background}";
      };
    };
  };
}
