{ pkgs, ... }: {
  users.users.af = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirtd" "i2c" ];
    shell = pkgs.zsh;
  };
}
