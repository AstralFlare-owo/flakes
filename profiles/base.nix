{ ... }: {
  imports = [
    ../modules/system/common.nix
    ../modules/system/home-manager.nix
    ../modules/users/af.nix
    ../modules/system/graphics/niri.nix
    ../modules/system/ime/fcitx.nix
  ];
}
