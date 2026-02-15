{ pkgs, ... }: {
  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    tunMode = true;
    serviceMode = true;
  };
  services.mihomo.tunMode = true;
  networking.firewall.trustedInterfaces = [ "af-mihomo-tun" "Mihomo" ];
  networking.firewall.enable = false;
}
