{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    virtiofsd
    dnsmasq
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
