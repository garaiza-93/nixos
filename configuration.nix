{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
}
