{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
    dolphin
    konsole
    kate
    okular
    ark
    gwenview
    spectacle
    kcalc
    filelight
  ];
}
