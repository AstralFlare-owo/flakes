{ config, inputs, lib, ... }:
let
  enabled = config.programs.noctalia-shell.enable;
  baseSettings =
    builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  templatesEnabled =
    lib.attrByPath [ "templates" "enableUserTheming" ] false baseSettings;
in
{
  config = lib.mkIf enabled {
    programs.noctalia-shell = {
      settings = baseSettings;
      user-templates =
        lib.mkIf templatesEnabled (builtins.readFile ./.config/noctalia/user-templates.toml);
    };
  };
}
