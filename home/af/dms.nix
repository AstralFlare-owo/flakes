{ config, options, lib, ... }:
let
  dmsModulePresent = lib.hasAttrByPath [ "programs" "dank-material-shell" ] options;
  baseSettings =
    builtins.fromJSON (builtins.readFile ./.config/DankMaterialShell/settings.json);
in
{
  config = lib.optionalAttrs dmsModulePresent (
    lib.mkIf config.programs.dank-material-shell.enable {
      programs.dank-material-shell.settings = baseSettings;
    }
  );
}
