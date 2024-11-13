{
  programs.git = {
    enable = true;
    userName = "Gustavo Araiza";
    userEmail = "57430880+garaiza-93@users.noreply.github.com";
    aliases = {
      fuckit = "push --force";
      new = "checkout -b";
      undo = "reset HEAD~1";
    };
    ignores = [ "/.data" "/.direnv" ".nvimrc.lua" "boxxy*" "*.envrc" ];
    extraConfig = {
      user.username = "garaiza-ntst";
      init.defaultBranch = "master";

      core.editor = "hx";
      core.whitespace = "fix,-indent-with-non-tab,tailing-space,cr-at-eol";

      web.browser = "firefox";

      github.user = "garaiza_ntst";
      github.token = "token";

      url."ssh://git@github.com".insteadOf = "https://github.com";
    };
  };
}
