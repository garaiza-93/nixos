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
      sysedit = "cd ~/.config/nixos && nvim flake.nix";
      nvimedit = "cd ~/.config/nvim && nvim flake.nix";
      updateinput = ''
        nix flake metadata | grep -E "^├|^└" | sed 's/:.*//g' | sed -e 's/\x1b\[[0-9;]*m//g' | sed 's/[^a-zA-Z0-9\-]//g' | fzf | xargs nix flake lock --update-input'';
      buildpersonal =
        "sudo nixos-rebuild switch --flake path:$HOME/.config/nixos#EVA-01 && cd -";
      buildwork =
        "sudo nixos-rebuild switch --flake path:$HOME/.config/nixos#wsl && cd -";
      buildhm =
        "home-manager switch --flake $HOME/.config/nixos#gustavo-hm && cd -";
      updatepersonal =
        "cd ~/.config/nixos && nix flake update && sudo nixos-rebuild switch --flake .#EVA-01 && cd -";
      updatework =
        "cd ~/.config/nixos && nix flake update && sudo nixos-rebuild switch --flake .#wsl && cd -";
      updatehm =
        "cd ~/.config/nixos && nix flake update && home-manager switch --flake $HOME/.config/nixos#gustavo-hm && cd -";
      updatenvim = "cd ~/.config/nixos && nix flake update nvim-nixified";
      neofetch = "neofetch --source ${img}/seele-ascii";
      gitexcludefile = "$HOME/.config/nixos/scripts/gitexcludefile.sh";
      updateflakes = "$HOME/.config/nixos/scripts/update_flakes.sh";
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
      bindkey '\t\t' autosuggest-accept
    '';
    envExtra = ''
      export TERM=xterm-256color
      export DIRENV_LOG_FORMAT=
      eval "$(direnv hook zsh)"
    '';
  };
}
