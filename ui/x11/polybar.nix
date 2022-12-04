{ self, pkgs, config, ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar example &";
  };
}
