{ pkgs, ... }: {
  users.users.af = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirtd" "i2c" "docker" ];
    shell = pkgs.zsh;
  };
}
