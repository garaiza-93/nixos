{ ... }:

let
  img = ../img;

in
{
  home.sessionVariables."ZDOTDIR" = "\${HOME}/.config/zsh";
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      ls = "ls --color=auto";
      l = "ls -lh --color=auto";
      L = "ls -lAh --color=auto";
      ld = "ls -lth --color=auto";
      Ld = "ls -lAth --color=auto";
      fucknvidia = "sudo nvidia-settings";
      sysedit = "cd ~/.config/nixos && nvim flake.nix";
      nvimedit = "cd ~/.config/nixos && nvim devtools/neovim/neovim.nix";
      buildpersonal = "sudo nixos-rebuild switch --flake path:$HOME/.config/nixos#EVA-01";
      buildwork = "sudo nixos-rebuild switch --flake path:$HOME/.config/nixos#wsl";
      updatepersonal = "cd ~/.config/nixos && nix flake update && sudo nixos-rebuild switch --flake .#EVA-01 && cd -";
      updatework = "cd ~/.config/nixos && nix flake update && sudo nixos-rebuild switch --flake .#wsl && cd -";
      neofetch = "neofetch --source ${img}/seele-ascii";
    };
    history = {
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };
    envExtra = ''
      export TERM=xterm-256color
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      format = "$nix_shell$username$hostname$directory$git_branch$git_state$git_status$cmd_duration";

      nix_shell = {
        symbol = "";
        format = "[$symbol]($style) ";
        style = "bright-purple bold";
      };

      username = {
        show_always = true;
        style_user = "#8aa2f7 bold";
        style_root = "bright-red bold";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "#7aa2f7 bold";
        format = "[@$hostname$ssh_symbol ]($style)";
      };
      git_branch = {
        format = "[$symbol$branch ]($style)";
        style = "#9ece6a bold";
      };

      git_state.style = "#bb9af7";

      git_status.style = "#f7768e";

      directory.truncation_length = 3;

      cmd_duration = {
        style = "bold purple";
      };
    };
  };
}
