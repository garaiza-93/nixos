{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-BL-LB";
      package = pkgs.tokyo-night-gtk;
    };

    gtk3.bookmarks = [
      "file:///home/goose/Documents"
      "file:///home/goose/Downloads"
      "file:///home/goose/Games"
      "file:///home/goose/Pictures"
      "file:///home/goose/Videos"
      "file:///home/goose/Torrents"
      "file:///home/hd1/Torrents"
    ];
  };
}
