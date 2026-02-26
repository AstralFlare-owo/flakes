{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/base.nix
    ../../modules/system/hardware/ddcutil.nix
    ../../modules/system/hardware/wacom.nix
    ../../modules/system/graphics/gnome.nix
    ../../modules/system/app/clash-verge-rev.nix
    ../../modules/system/app/easytier.nix
    ../../modules/system/virtualisation/kvm.nix
    ../../modules/system/app/steam.nix
    ../../modules/system/app/syncthing.nix
    ../../modules/system/app/gpu-screen-recorder.nix
    ../../modules/system/graphics/niri.nix
    ../../modules/system/ime/fcitx.nix
    ../../modules/system/app/obs-studio.nix
  ];

  hardware.nvidia.prime.offload = {
    enable = true;
    enableOffloadCmd = true;
  };
  hardware.nvidia.modesetting.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  services.syncthing.user = "af";

  services.easytier.instances.ctmc.extraArgs = [ "--hostname" "g5000.aflare" ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.systemPackages = with pkgs; [
    lenovo-legion
  ];

  environment.etc."flatpak/overrides/global".text = ''
    [Environment]
    GDK_BACKEND=wayland,x11
    QT_QPA_PLATFORM=wayland;xcb
    SDL_VIDEODRIVER=wayland
    ELECTRON_OZONE_PLATFORM_HINT=wayland
  '';

  networking.hostName = "AstRiverse";
  system.stateVersion = "26.05";
}
