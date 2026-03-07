{ config, options, inputs, lib, ... }:
let
  noctaliaModulePresent = lib.hasAttrByPath [ "programs" "noctalia-shell" ] options;
  baseSettings =
    builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  templatesEnabled =
    lib.attrByPath [ "templates" "enableUserTheming" ] false baseSettings;
in
{
  config = lib.optionalAttrs noctaliaModulePresent (
    lib.mkIf config.programs.noctalia-shell.enable {
      programs.noctalia-shell = {
        settings = baseSettings;
        user-templates =
          lib.mkIf templatesEnabled (builtins.readFile ./.config/noctalia/user-templates.toml);
      };
    }
  );
}
