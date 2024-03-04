{ nixpkgs-old, system, ... }:
let oldpkgs = nixpkgs-old.legacyPackages.${system};
in {
  home.stateVersion = "22.11";

  home.username = "gustavo";
  home.homeDirectory = "/home/gustavo";
  home.sessionVariables."ZDOTDIR" = "\${HOME}/.config/zsh";
  home.packages = with oldpkgs; [ awscli2 ];

  manual.manpages.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ../devtools/all.nix
    ../common/btop.nix
    ../zsh/default.nix
    ../prompts/gustavo-hm.nix
  ];
}
