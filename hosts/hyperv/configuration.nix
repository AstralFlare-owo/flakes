{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/base.nix
    ../../modules/system/graphics/gnome.nix
  ];

  virtualisation.hypervGuest.enable = true;
  services.xserver.modules = [ "pkgs.xorg.xf86videofbdev" ];

  services.xserver.videoDrivers = [ "fbdev" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hv.aflare";
}
