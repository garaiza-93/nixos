{ inputs, ... }: {
  home.packages = [ inputs.nvim-nixified.packages.x86_64-linux.default ];
}
