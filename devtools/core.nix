{ pkgs, ... }: {
  home.packages = with pkgs; [
    fzf
    jq
    lazydocker
    lazygit
    python311Packages.howdoi
    thefuck
  ];
  imports = [ ./direnv.nix ./editors.nix ./tmux.nix ];
}
