{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    mission-center
    # nethogs
    lm_sensors
  ];

  # nethogs 需要读取所有进程的 /proc 信息与抓包，非 root 用户通过 capability wrapper 放行
  security.wrappers.nethogs = {
    owner = "root";
    group = "root";
    source = "${pkgs.nethogs}/bin/nethogs";
    capabilities = "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+pe";
  };
}
