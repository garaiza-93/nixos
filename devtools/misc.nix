{ pkgs, ... }:

{
  home.packages = with pkgs; [
    google-cloud-sdk
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
