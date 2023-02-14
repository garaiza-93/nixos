{ tokyo-night-gtk, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-B";
      package = tokyo-night-gtk;
    };
  };
}
