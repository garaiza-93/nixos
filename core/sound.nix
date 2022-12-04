{ self, pkgs, ... }:

{
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraConfig = "load-module module-combine-sink";
  };
}
