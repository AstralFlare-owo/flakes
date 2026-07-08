{ pkgs, ... }: {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  # security.wrappers.sunshine = {
  #     owner = "root";
  #     group = "root";
  #     capabilities = "cap_sys_admin+ep";
  #     source = "${pkgs.sunshine}/bin/sunshine";
  # };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
