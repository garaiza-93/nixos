{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    extraConfig = builtins.concatStringsSep "\n" [
      ''
      	lua << EOF
	${lib.strings.fileContents config/init.lua}
	EOF
      ''
    ]
  };
}
