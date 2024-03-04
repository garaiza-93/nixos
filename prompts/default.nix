{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      format =
        "$nix_shell$username$hostname$directory$git_branch$git_state$git_status$cmd_duration";

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

      cmd_duration = { style = "bold purple"; };
    };
  };
}
