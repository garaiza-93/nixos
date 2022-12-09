{ self, pkgs, lib, ... }:

let
  wallpapers = ../../wallpapers;
in
{
  xsession.windowManager.bspwm = {
    enable = true;
    alwaysResetDesktops = true;

    extraConfigEarly = ''
      bspc config workspace_count 5

      bspc config window_gap 10

      bspc config focused_border_color "#f5f000"
      bspc config normal_border_color "#ff00ff"

      bspc config automatic_scheme follow
      bspc config initial_polarity second_child

      bspc config active_border_color     "#ff9900"
      bspc config focused_border_color    "#ff9900"
      bspc config normal_border_color     "#888888"
      bspc config presel_border_color     "#33cc33"
      bspc config urgent_border_color     "#cc0000"
    '';

    #settings = { };

    #rules = { };

    #startupPrograms = { };

    #extraConfig = '''';

  };
}
