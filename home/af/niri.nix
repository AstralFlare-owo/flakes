{ config, lib, ... }:
let
  dmsEnabled = lib.attrByPath [ "programs" "dank-material-shell" "enable" ] false config;
  noctaliaEnabled = lib.attrByPath [ "programs" "noctalia-shell" "enable" ] false config;
  baseConfig = builtins.readFile ./.config/niri/config.kdl;
  shellBindBlockBase = ''
    Super+Space hotkey-overlay-title="启动程序：noctalia" { spawn-sh "noctalia-shell ipc call launcher toggle"; }
    Super+L hotkey-overlay-title="锁屏：noctalia" { spawn-sh "noctalia-shell ipc call lockScreen lock"; }
    Ctrl+Alt+Delete hotkey-overlay-title="会话菜单：noctalia" { spawn-sh "noctalia-shell ipc call sessionMenu toggle"; }
    Super+Shift+E hotkey-overlay-title="会话菜单：noctalia" { spawn-sh "noctalia-shell ipc call sessionMenu toggle"; }
    Super+R hotkey-overlay-title="启动器：noctalia 命令" { spawn-sh "noctalia-shell ipc call launcher command"; }
    Super+V hotkey-overlay-title="启动器：noctalia 剪贴板" { spawn-sh "noctalia-shell ipc call launcher clipboard"; }
  '';
  shellBindBlock =
    if dmsEnabled then
      ''
        Super+Space hotkey-overlay-title="启动程序：dms" { spawn-sh "dms ipc call spotlight toggle"; }
        Super+L hotkey-overlay-title="锁屏：dms" { spawn-sh "dms ipc call lock lock"; }
        Ctrl+Alt+Delete hotkey-overlay-title="会话菜单：dms" { spawn-sh "dms ipc call powermenu toggle"; }
        Super+Shift+E hotkey-overlay-title="会话菜单：dms" { spawn-sh "dms ipc call powermenu toggle"; }
        Super+R hotkey-overlay-title="启动器：dms 命令" { spawn-sh "dms ipc call spotlight command"; }
        Super+V hotkey-overlay-title="剪贴板：dms" { spawn-sh "dms ipc call clipboard toggle"; }
      ''
    else if noctaliaEnabled then
      shellBindBlockBase
    else
      ''
        Super+Space hotkey-overlay-title="启动程序：fuzzel" { spawn "fuzzel"; }
        Super+L hotkey-overlay-title="锁屏：swaylock" { spawn "swaylock"; }
        Ctrl+Alt+Delete hotkey-overlay-title="退出：Niri" { quit; }
        Super+Shift+E hotkey-overlay-title="退出：Niri" { quit; }
        Super+R hotkey-overlay-title="启动器：fuzzel" { spawn "fuzzel"; }
        Super+V hotkey-overlay-title="剪贴板：cliphist" { spawn-sh "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }
      '';
  patchedConfig = builtins.replaceStrings [ shellBindBlockBase ] [ shellBindBlock ] baseConfig;
  noctaliaInclude = "\ninclude \"./noctalia.kdl\"\n";
  noctaliaSettings =
    builtins.fromJSON (builtins.readFile ./.config/noctalia-shell/settings.json);
  niriThemeEnabled =
    lib.any (t: (t.id or "") == "niri" && (t.enabled or false))
      (lib.attrByPath [ "templates" "activeTemplates" ] [ ] noctaliaSettings);
in
{
  assertions = [
    {
      assertion = !(dmsEnabled && noctaliaEnabled);
      message = "Race detected: `programs.dank-material-shell.enable` and `programs.noctalia-shell.enable` cannot both be true.";
    }
  ];

  home.file.".config/niri/config.kdl".text =
    patchedConfig
    + (if noctaliaEnabled && niriThemeEnabled then noctaliaInclude else "");
}
