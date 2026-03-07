{ inputs, afDevice, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    overwriteBackup = true;
    extraSpecialArgs = { inherit inputs; afDevice = afDevice; };
    users.af = import ../../home/af;
  };
}
