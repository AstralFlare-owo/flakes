{ pkgs, ... }: {
  home.packages = with pkgs; [
    gping
    doggo
    ueberzugpp
    httpie
    tcping-rs
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
      "--cycle"
      "--preview-window=right,60%,border-left"
    ];
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = false;
        sort_by = "natural";
        sort_sensitive = false;
      };
    };
    extraPackages = with pkgs; [
      ffmpegthumbnailer
      p7zip
      jq
      poppler
      fd
      ripgrep
      fzf
      zoxide
      ueberzugpp
    ];
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--hidden"
      "--glob=!.git/*"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
    };
  };

  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [ ".git/" ];
  };

  programs.delta = {
    enable = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "-hbSgO"
      "--git"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };
}
