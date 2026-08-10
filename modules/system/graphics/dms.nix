{ inputs, pkgs, ... }:
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
