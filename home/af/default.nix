{ config, ... }: {
  home.username = "af";
  home.homeDirectory = "/home/af";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  imports = [
    ./niri.nix
    ./noctalia.nix
    ./alacritty.nix
    ./btop.nix
#   ../../modules/user/graphics/mako.nix
    ../../modules/user/graphics/ozone-platform-hint-fix.nix
#   ../../modules/user/graphics/waybar.nix
    ../../modules/user/runtimes/java8.nix
    ../../modules/user/runtimes/java17.nix
    ../../modules/user/runtimes/java21.nix
    ../../modules/user/runtimes/gcc.nix
    ../../modules/user/runtimes/nodejs.nix
    ../../modules/user/runtimes/python313.nix
    ../../modules/user/app/abdm.nix
    ../../modules/user/app/chrome.nix
    ../../modules/user/app/codex.nix
    ../../modules/user/app/dingtalk.nix
    ../../modules/user/app/hmcl.nix
    ../../modules/user/app/keepassxc.nix
    ../../modules/user/app/linuxqq.nix
    ../../modules/user/app/lutris.nix
    ../../modules/user/app/piliplus.nix
    ../../modules/user/app/protonplus.nix
    ../../modules/user/app/snipaste.nix
    ../../modules/user/app/sub-store.nix
    ../../modules/user/app/telegram.nix
    ../../modules/user/app/vscode.nix
    ../../modules/user/app/wechat.nix
    ../../modules/user/app/wpsoffice.nix
    ../../modules/user/app/zsh.nix
  ];

  home.file = {
    ".gitconfig".source = ./.gitconfig;
    ".zshrc".source = ./.zshrc;
    ".config/fastfetch/config.jsonc".source = ./.config/fastfetch/config.jsonc;
    ".config/user-dirs.dirs".source = ./.config/user-dirs.dirs;
    ".config/user-dirs.locale".source = ./.config/user-dirs.locale;
    ".config/waybar/config".source = ./.config/waybar/config;
    ".config/waybar/style.css".source = ./.config/waybar/style.css;
    ".local/share/fonts".source = ./fonts;
  };
}
