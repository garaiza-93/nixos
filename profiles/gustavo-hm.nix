{ pkgs, ... }: {
  home.stateVersion = "24.05";

  home.username = "gustavo";
  home.homeDirectory = "/home/gustavo";
  home.sessionVariables."ZDOTDIR" = "\${HOME}/.config/zsh";
  home.packages = with pkgs; [ awscli2 kubectl gh fzf jq ];

  manual.manpages.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ../devtools/wsl.nix
    ../devtools/core.nix
    ../devtools/git-hm.nix
    ../common/btop.nix
    ../zsh/gustavo-hm-zsh.nix
    ../prompts/gustavo-hm.nix

    # hoping to use cachix
    (let
      declCachix = builtins.fetchTarball {
        url =
          "https://github.com/jonascarpay/declarative-cachix/archive/a2aead56e21e81e3eda1dc58ac2d5e1dc4bf05d7.tar.gz";
        sha256 = "022fsn8ba29cla5g63vpwc5ys9bwir47jwdxfr5p9ahqrddadfir";
      };
    in import "${declCachix}/home-manager.nix")
  ];

  caches.cachix = [
    {
      name = "helix";
      sha256 = "0mi1wp45nv86vgiakvhz66av0lnf7vpwk4vwgkmdczikgx6cvrsz";
    }
    {
      name = "nix-community";
      sha256 = "0m6kb0a0m3pr6bbzqz54x37h5ri121sraj1idfmsrr6prknc7q3x";
    }
  ];
}
