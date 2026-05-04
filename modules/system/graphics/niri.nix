{ pkgs, ... }: {
  programs.niri.package = pkgs.niri.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [
      (pkgs.fetchpatch {
        url = "https://github.com/wrvsrx/niri/compare/tag_support-shm-sharing_4~19..tag_support-shm-sharing_4.patch";
        hash = "sha256-mfX0CVJWSFb/Hr1lDvlggphpXc2PI6C5CBa+aGwkVIM=";
      })
    ];
  });

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
