{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-B";
      package = pkgs.tokyo-night-gtk;
    };
  };
}
