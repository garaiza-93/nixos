{ self, ... }:

{
  imports = [
    ../configuration.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "gustavo";
    startMenuLaunchers = true;
    nativeSystemd = true;
    interop.register = false;
  };
}
