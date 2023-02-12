{ tokyo-night-gtk, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = tokyo-night-gtk;
    };
  };
}
