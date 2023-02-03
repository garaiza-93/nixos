{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Gustavo Araiza";
    userEmail = "57430880+garaiza-93@users.noreply.github.com";
    extraConfig = {
      user.username = "garaiza-93";
      init.defaultBranch = "master";
      
      core.editor = "nvim";
      core.whitespace = "fix,-indent-with-non-tab,tailing-space,cr-at-eol";

      web.browser = "firefox";

      github.user = "garaiza-93";
      github.token = "token";

      url."ssh://git@github.com/".insteadOf = "https://github.com";
    };
  };
}
