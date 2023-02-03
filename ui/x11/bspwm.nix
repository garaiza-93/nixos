{ self, pkgs, lib, ... }:

let
  wallpapers = ../../img;
in
{
  xsession.windowManager.bspwm = {
    enable = true;
    alwaysResetDesktops = true;

    extraConfigEarly = ''
      bspc monitor -d 1 2 3 4 5

      bspc config pointer_modifier mod1
      bspconfig pointer_action1 move

      bspc config window_gap 25

      bspc config normal_border_color "#765898"
      bspc config active_border_color "#312a59"
      bspc config focused_border_color "#df588e"

      bspc config automatic_scheme spiral
    '';

    #settings = { };

    rules = {
      "Firefox".desktop = "^1";
      "Discord".desktop = "^2";
      "Steam" = {
        desktop = "^3";
        follow = true;
      };
      "PrismLauncher" = {
        desktop = "^3";
        state = "floating";
        follow = true;
      };
      "Minecraft* 1.7.10" = {
        desktop = "^4";
        state = "fullscreen";
        follow = false;
      };
      "Minecraft* 1.18.2" = {
        desktop = "^4";
        state = "fullscreen";
        follow = false;
      };
      "FINAL FANTASY XIV" = {
        desktop = "^4";
        state = "fullscreen";
        follow = true;
        focus = true;
      };
    };

    startupPrograms = [
      "systemctl --user restart polybar.service"
      "systemctl --user restart picom.service"
      "feh --bg-scale ${wallpapers}/eva01.png"
      "flameshot"
    ];

    #extraConfig = '''';

  };
}
