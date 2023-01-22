{ config, lib, pkgs, ... }:
with lib;
{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
    ];

    extraConfig = ''
      :luafile ~/.config/nvim/lua/init.lua
    '';
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
