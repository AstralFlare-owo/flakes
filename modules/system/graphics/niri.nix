{ pkgs, ... }: {
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    niri
    alacritty
    fuzzel
    xwayland-satellite
    swaylock
    swayidle
  ];
}
