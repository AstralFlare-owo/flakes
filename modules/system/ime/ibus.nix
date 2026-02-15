{ pkgs, ... }: {
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      (rime.override {
        rimeDataPkgs = with pkgs;[
          rime-ice
        ];
      })
    ];
  };

  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.input-sources]
    sources=[('xkb', 'us'), ('ibus', 'rime')]
  '';

  environment.sessionVariables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };
}
