{ ... }:

let img = ../img;
in {
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
      nvimedit = "cd ~/.config/nvim && nvim flake.nix";
      updateinput = ''
        nix flake metadata | grep -E "^├|^└" | sed 's/:.*//g' | sed -e 's/\x1b\[[0-9;]*m//g' | sed 's/[^a-zA-Z0-9\-]//g' | fzf | xargs nix flake lock --update-input'';
      buildpersonal =
        "sudo nixos-rebuild switch --flake path:$HOME/.config/nixos#EVA-01 && cd -";
      buildwork =
        "sudo nixos-rebuild switch --flake path:$HOME/.config/nixos#wsl && cd -";
      buildhm =
        "home-manager switch --flake $HOME/.config/nixos#gustavo && cd -";
      updatepersonal =
        "cd ~/.config/nixos && nix flake update && sudo nixos-rebuild switch --flake .#EVA-01 && cd -";
      updatework =
        "cd ~/.config/nixos && nix flake update && sudo nixos-rebuild switch --flake .#wsl && cd -";
      updatehm =
        "cd ~/.config/nixos && nix flake update && home-manager switch --flake $HOME/.config/nixos#gustavo-hm && cd -";
      updatenvim =
        "cd ~/.config/nixos && nix flake lock --update-input nvim-nixified && sudo nixos-rebuild switch --flake .#EVA-01 && cd -";
      neofetch = "neofetch --source ${img}/seele-ascii";
      adl =
        "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 929283673727.dkr.ecr.us-east-2.amazonaws.com";
      ghe = "GH_HOST=https://github.com/ntst-simple gh";
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
    '';
    envExtra = ''
      export TERM=xterm-256color
      export DIRENV_LOG_FORMAT=
      eval "$(direnv hook zsh)"
    '';
  };
}
