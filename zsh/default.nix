let img = ../img;
in {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    defaultKeymap = "viins";

    dotDir = ".config/zsh";
    shellAliases = {
      ls = "ls --color=auto";
      l = "ls -lh --color=auto";
      L = "ls -lAh --color=auto";
      ld = "ls -lth --color=auto";
      Ld = "ls -lAth --color=auto";
      fucknvidia = "sudo nvidia-settings";
      sysedit = "cd ~/.config/nixos && $EDITOR flake.nix";
      nvimedit = "cd ~/.config/nvim && $EDITOR flake.nix";
      helixedit = "cd ~/.config/nixos && $EDITOR devtools/helix-config.toml";
      updateinput = ''
        nix flake metadata | grep -E "^├|^└" | sed 's/:.*//g' | sed -e 's/\x1b\[[0-9;]*m//g' | sed 's/[^a-zA-Z0-9\-]//g' | fzf | xargs nix flake lock --update-input'';
      buildpersonal =
        "sudo nixos-rebuild switch --flake path:$SYSTEM_FLAKE_DIR#EVA-01 --accept-flake-config && cd -";
      buildwork =
        "sudo nixos-rebuild switch --flake path:$SYSTEM_FLAKE_DIR#wsl --accept-flake-config && cd -";
      buildhm =
        "home-manager switch --flake $SYSTEM_FLAKE_DIR#gustavo-hm && cd -";
      updatepersonal =
        "cd ~/.config/nixos && nix flake update && buildpersonal";
      updatework =
        "cd ~/.config/nixos && nix flake update && buildwork";
      updatehm =
        "cd ~/.config/nixos && nix flake update && home-manager switch --flake $SYSTEM_FLAKE_DIR#gustavo-hm && cd -";
      updatenvim = "cd ~/.config/nixos && nix flake update nvim-nixified";
      neofetch = "neofetch --source ${img}/seele-ascii";
      gitexcludefile = "$SYSTEM_FLAKE_DIR/scripts/gitexcludefile.sh";
      updateflakes = "$SYSTEM_FLAKE_DIR/scripts/update_flakes.sh";
      fuck-it-ssh = "eval $(ssh-agent -s) && ssh-add";
    };
    history = {
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };
    initExtra = ''
      autoload -U add-zsh-hook
      load-local-conf() {
           # check file exists, is regular file and is readable:
           if [[ -f .aliases && -r .aliases && IN_NIX_SHELL ]]; then
             source .aliases
           fi
      }
      add-zsh-hook chpwd load-local-conf
      bindkey '^[[Z' autosuggest-accept
    '';
    envExtra = ''
      export EDITOR=hx
      export TERM=xterm-256color
      export DIRENV_LOG_FORMAT=
      export SYSTEM_FLAKE_DIR=$XDG_CONFIG_HOME/nixos
      eval "$(direnv hook zsh)"
    '';
  };
}
