{ ... }: {
  imports = [
    ../modules/system/common.nix
    ../modules/system/home-manager.nix
    ../modules/users/deepslate.nix
  ];
}
