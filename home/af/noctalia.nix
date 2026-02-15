{ config, inputs, lib, ... }:
let
  baseSettings =
    builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  templatesEnabled =
    lib.attrByPath [ "templates" "enableUserTheming" ] false baseSettings;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = baseSettings;
  };

  programs.noctalia-shell.user-templates =
    lib.mkIf templatesEnabled (builtins.readFile ./.config/noctalia/user-templates.toml);
}
