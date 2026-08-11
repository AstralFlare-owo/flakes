{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./.config/tmux/tmux.conf;
  };

  home.file = {
    ".config/tmux/plugins/tmux-which-key/config.yaml".source =
      ./.tmux/plugins/tmux-which-key/config.yaml;
  };
}
