{ config, inputs, ... }: {
  home.packages = [ inputs.nvim-nixified.packages.x86_64-linux.default ];

  programs.helix.enable = true;
  # Handle Helix configuration imperatively. Might port to the module later.
  home.file.".config/helix/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.xdg.configHome}/nixos/devtools/helix-config.toml";

  programs.helix.languages = {
    language-server.omnisharp.command = "OmniSharp";
    languages = [{
      name = "c-sharp";
      debugger.command = "netcoredbg";
    }];
  };
}
