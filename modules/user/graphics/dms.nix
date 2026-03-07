{ inputs, config, lib, osConfig ? { }, ... }:
let
  systemDmsEnabled = lib.attrByPath [ "programs" "dank-material-shell" "enable" ] false osConfig;
in
{
  imports = [ inputs.dms.homeModules.default ];

  config = lib.mkMerge [
    (lib.mkIf systemDmsEnabled {
      programs.dank-material-shell.enable = lib.mkDefault true;
    })
    (lib.mkIf (lib.attrByPath [ "programs" "dank-material-shell" "enable" ] false config) {
      programs.dank-material-shell.systemd.enable = lib.mkDefault true;
    })
  ];
}
