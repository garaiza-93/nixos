{
  environment.persistence."/persist/system" = {
    directories = [
      "/etc/NetworkManager/system-connections/"
      "/root"
    ];
  };
  environment.etc."machine-id".source = "/nix/etc/machine-id";
}
