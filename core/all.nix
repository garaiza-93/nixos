{ ... }:

{
  imports = [
    ./drivers/nvidia.nix
    ./bluetooth.nix
    ./boot.nix
    ./security.nix
    ./sound.nix
    ./virtualization.nix
  ];
}
