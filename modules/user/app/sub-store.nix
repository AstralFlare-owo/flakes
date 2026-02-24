{ pkgs, ... }: {
  home.packages = with pkgs; [
    sub-store
    sub-store-frontend
  ];

  systemd.user.services.sub-store = {
    Unit = {
      Description = "Sub-Store";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "simple";
      WorkingDirectory = "%h";
      ExecStart = "${pkgs.sub-store}/bin/sub-store";
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
