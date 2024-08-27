{ pkgs, config, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-xhdpi";
      package = pkgs.tokyonight-gtk-theme;
    };
  };

  # more handy to use this file imperatively.
  # also it's annoying having to move this file
  # due to constant conflicts.
  home.file.".config/gtk-3.0/bookmarks".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.xdg.configHome}/gtk-3.0/bookmarks";
}
