{ config, pkgs, ... }:

# not managed by home manager!
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      withJava = true;
      withPrimus = true;
      extraPkgs = pkgs: with pkgs; [
        libgdiplus
        glxinfo
      ];
    };
  };
}
