{ pkgs, ... }: {
  home.packages = with pkgs; [
    fzf
    jq
    lazydocker
    lazygit
    python311Packages.howdoi
    thefuck
  ];
  imports = [ ./git.nix ./direnv.nix ./editors.nix ./tmux.nix ];
}
