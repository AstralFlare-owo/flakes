{ pkgs, lib, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [
    {
      # Disable auto screen blanking and auto suspend.
      settings."org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 0;
      settings."org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-ac-timeout = lib.gvariant.mkUint32 0;
        sleep-inactive-battery-type = "nothing";
        sleep-inactive-battery-timeout = lib.gvariant.mkUint32 0;
      };
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = lib.gvariant.mkArray [
          "appindicatorsupport@rgcjonas.gmail.com"
          "dash-to-dock@micxgx.gmail.com"
          "clipboard-history@alexsaveau.dev"
          "caffeine@patapon.info"
          "rounded-window-corners@fxgn"
        ];
      };
      settings."org/gnome/shell/extensions/caffeine" = {
        restore-state = true;
        screen-blank = "never";
        show-indicator = "never";
        show-timer = false;
        show-notifications = false;
      };
      settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
      # Enable fractional scaling (Wayland + X11).
      settings."org/gnome/mutter".experimental-features = lib.gvariant.mkArray [
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];
    }
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    dash-to-dock
    clipboard-history
    caffeine
    rounded-window-corners-reborn
  ];
}
