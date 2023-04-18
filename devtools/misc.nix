{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dotnet-sdk
    google-cloud-sdk
  ];
}
