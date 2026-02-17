{ inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs; };
    sharedModules = [ inputs.openclaw.homeManagerModules.openclaw ];
    users.af = import ../../home/af;
  };
}
