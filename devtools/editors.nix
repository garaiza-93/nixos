{ inputs, ... }: {
  home.packages = [
    inputs.helix.packages.x86_64-linux.default
    inputs.nvim-nixified.packages.x86_64-linux.default
  ];
}
