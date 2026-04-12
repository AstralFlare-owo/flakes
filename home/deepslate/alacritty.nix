{ lib, ... }:
let
  noctaliaSettings =
    builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  alacrittyThemeEnabled =
    lib.any (t: (t.id or "") == "alacritty" && (t.enabled or false))
      (lib.attrByPath [ "templates" "activeTemplates" ] [ ] noctaliaSettings);
  themeSettings = lib.optionalAttrs alacrittyThemeEnabled {
    general.import = [
      "~/.config/alacritty/themes/noctalia.toml"
    ];
  };
  baseSettings = {
    window = {
      decorations = "None";
      opacity = 0.8;
    };
  };
  finalSettings = lib.recursiveUpdate baseSettings themeSettings;
in
{
  programs.alacritty = {
    settings = finalSettings;
  };
}
