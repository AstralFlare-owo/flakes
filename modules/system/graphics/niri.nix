{ pkgs, ... }: {
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    niri
    alacritty
    fuzzel
    xwayland-satellite
    swaylock
    swayidle
    brightnessctl
    playerctl
    wireplumber
  ];

  xdg.portal = {
    config = {
      niri = {
        "org.freedesktop.impl.portal.ScreenCast" = [ "niri" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "niri" ];
        default = [ "gnome" "gtk" ];
      };
    };
  };
}
