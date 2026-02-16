{ lib, ... }:
let
  noctaliaSettings =
    builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  kittyThemeEnabled =
    lib.any (t: (t.id or "") == "kitty" && (t.enabled or false))
      (lib.attrByPath [ "templates" "activeTemplates" ] [ ] noctaliaSettings);
  themeSettings = lib.optionalAttrs kittyThemeEnabled {
    extraConfig = ''
      include ~/.config/kitty/themes/noctalia.conf
    '';
  };
  baseSettings = {
    settings = {
      hide_window_decorations = "yes";
      background_opacity = "0.8";
    };
  };
  finalSettings = lib.recursiveUpdate baseSettings themeSettings;
in
{
  programs.kitty =
    {
      shellIntegration.enableZshIntegration = true;
    }
    // finalSettings;
}
