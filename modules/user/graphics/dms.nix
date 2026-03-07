{ inputs, config, lib, ... }:
{
  imports = [ inputs.dms.homeModules.default ];

  config = lib.mkIf (lib.attrByPath [ "programs" "dank-material-shell" "enable" ] false config) {
    programs.dank-material-shell.systemd.enable = lib.mkDefault true;
  };
}
