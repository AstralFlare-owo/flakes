{ config, lib, ... }:
let
  enabled = lib.attrByPath [ "programs" "dank-material-shell" "enable" ] false config;
  baseSettings =
    builtins.fromJSON (builtins.readFile ./.config/DankMaterialShell/settings.json);
in
{
  config = lib.mkIf enabled {
    programs.dank-material-shell.settings = baseSettings;
  };
}
