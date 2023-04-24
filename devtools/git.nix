{ ... }:

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
    extraConfig = {
      user.username = "garaiza-93";
      init.defaultBranch = "master";

      core.editor = "nvim";
      core.whitespace = "fix,-indent-with-non-tab,tailing-space,cr-at-eol";

      web.browser = "firefox";

      github.user = "garaiza-93";
      github.token = "token";

      url."ssh://git@github.com".insteadOf = "https://github.com";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
      git_protocol = "ssh";
    };
  };
}
