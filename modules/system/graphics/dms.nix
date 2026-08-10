{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.dms.nixosModules.dank-material-shell
    inputs.dank-greeter.nixosModules.default
  ];

  # Dank Material Shell（来自 github:AvengeMedia/DankMaterialShell flake）
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };

  # DMS Greeter（来自 github:AvengeMedia/dank-greeter flake）
  # 接管显示管理器：禁用 GDM，避免与 greetd 争抢 display-manager.service 和 VT1
  # （gnome.nix 启用的 GDM 会占住 display-manager 别名，导致 greetd 无法成为
  # 启动目标，plymouth-quit-wait 继续等待 GDM 而卡在开机画面）
  services.displayManager.gdm.enable = lib.mkForce false;

  programs.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    # Sync deepslate 的 DMS 主题/壁纸到 greeter
    configHome = "/home/deepslate";
  };

  # greetd 默认以 "greeter" 用户运行 greeter，dank-greeter 模块断言该用户必须存在
  users.users.greeter = {
    isSystemUser = true;
    home = "/var/lib/greeter";
    group = "greeter";
    shell = pkgs.bash;
  };
  users.groups.greeter = { };
}
