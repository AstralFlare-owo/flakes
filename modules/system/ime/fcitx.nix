{ pkgs, lib, ... }: {
  environment.systemPackages = [
    pkgs.gnomeExtensions.kimpanel
  ];

  programs.dconf.profiles.user.databases = lib.mkAfter [
    {
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = lib.gvariant.mkArray [
          "kimpanel@kde.org"
        ];
      };
    }
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-gtk
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-minecraft
      fcitx5-pinyin-moegirl
      (fcitx5-rime.override {
        rimeDataPkgs = with pkgs; [
          rime-ice
        ];
      })
      fcitx5-material-color
    ];
    fcitx5.settings = {
      inputMethod = {
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "keyboard-us";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "pinyin";
        GroupOrder."0" = "Default";
      };
    };
  };

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  systemd.user.services.fcitx5 = {
    description = "Fcitx5 Input Method";
    serviceConfig = {
      ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
      Restart = "on-failure";
      RestartSec = 2;
    };
    wantedBy = [ "default.target" ];
  };
}
