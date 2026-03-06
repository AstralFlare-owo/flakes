{ inputs, lib, ... }: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.noctalia-shell.enable = lib.mkForce false;

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };
}
