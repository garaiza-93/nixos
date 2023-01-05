{ self, ... }:

{
  services.betterlockscreen = {
    enable = true;
    inactiveInterval = 60;
  };
}
