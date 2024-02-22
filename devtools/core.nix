{ pkgs, ... }: {
  home.packages = [ pkgs.fzf ];
  imports = [ ./direnv.nix ./editors.nix ./git.nix ./tmux.nix ];
}
