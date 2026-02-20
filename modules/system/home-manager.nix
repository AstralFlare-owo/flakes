{ inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    overwriteBackup = true;
    extraSpecialArgs = { inherit inputs; };
    sharedModules = [ inputs.openclaw.homeManagerModules.openclaw ];
    users.af = import ../../home/af;
  };
}
