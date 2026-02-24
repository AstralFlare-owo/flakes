{ config, inputs, lib, ... }:
let
  baseSettings =
    builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  templatesEnabled =
    lib.attrByPath [ "templates" "enableUserTheming" ] false baseSettings;
in
{
  programs.noctalia-shell = {
    settings = baseSettings;
    user-templates =
      lib.mkIf templatesEnabled (builtins.readFile ./.config/noctalia/user-templates.toml);
  };
}
