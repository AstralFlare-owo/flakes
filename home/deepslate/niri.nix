{ config, lib, nixosConfig, ... }:
let
  baseConfig = builtins.readFile ./.config/niri/config.kdl;
  noctaliaInclude = "\ninclude \"./noctalia.kdl\"\n";
  noctaliaSettings = builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  niriThemeEnabled = lib.any (t: (t.id or "") == "niri" && (t.enabled or false)) (
    lib.attrByPath [ "templates" "activeTemplates" ] [ ] noctaliaSettings
  );
  # 系统级 DMS 启用状态（modules/system/graphics/dms.nix）
  dmsEnabled = nixosConfig.programs.dank-material-shell.enable or false;
  # DMS 动态配置文件（dms setup 生成，~/.config/niri/dms/*.kdl）
  # optional=true：文件缺失时不报错，避免 niri 启动失败
  dmsInclude = file: "\ninclude optional=true \"./dms/${file}.kdl\"\n";
  dmsIncludes = lib.concatStrings (map dmsInclude [
    "alttab"
    "binds"
    "colors"
    "cursor"
    "input"
    "layout"
    "outputs"
    "windowrules"
    "wpblur"
  ]);
in
{
  home.file.".config/niri/config.kdl".text =
    baseConfig
    + (if dmsEnabled then dmsIncludes else "")
    + (if (config.programs.noctalia-shell.enable or false) && niriThemeEnabled then noctaliaInclude else "");
}
