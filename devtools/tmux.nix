{ configs, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    extraConfig = ''
    #True color
set -g default-terminal 'xterm-256color'
set-option -sa terminal-overrides ',xterm-256color:Tc'
#Mouse support
set -g mouse on
#Auto-restore
set -g @continuum-restore 'on'

#Install tpm (plugin manager)
if "test ! -d ~/.tmux/plugins/tpm" \
   "run 'git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins'"

#Plugins
set -g @plugin 'ofirgall/tmux-window-name'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'garaiza-93/tokyo-night-tmux'
#Keybinds
unbind C-b
unbind C-z
set-option -g prefix C-z
bind z split-window -v -c "#{pane_current_path}"
bind x split-window -h -c "#{pane_current_path}"
bind c kill-pane
bind v new-window -c ~
bind b kill-window

#Init plugin manager
run '~/.config/tmux/plugins/tpm/tpm
    '';
  };
}
