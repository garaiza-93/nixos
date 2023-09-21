{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager libguestfs distrobox ];
}
