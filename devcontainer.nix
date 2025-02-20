{ ... }: {
  home.username = "vscode";
  home.homeDirectory = "/home/vscode";
  home.stateVersion = "24.05";
  home.file.".tmux.conf".text = ''
    set-option -g status off
    set -g default-terminal "tmux-256color"
    set -ga terminal-overrides ",*256col*:Tc"
    set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
    set-environment -g COLORTERM "truecolor"
  '';
}
