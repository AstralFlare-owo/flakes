{ config, lib, ... }:
let
  baseConfig = builtins.readFile ./.config/niri/config.kdl;
  noctaliaInclude = "\ninclude \"./noctalia.kdl\"\n";
  noctaliaSettings =
    builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  niriThemeEnabled =
    lib.any (t: (t.id or "") == "niri" && (t.enabled or false))
      (lib.attrByPath [ "templates" "activeTemplates" ] [ ] noctaliaSettings);
in
{
  home.file.".config/niri/config.kdl".text =
    baseConfig
    + (if config.programs.noctalia-shell.enable && niriThemeEnabled then noctaliaInclude else "");
}
