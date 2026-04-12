{ pkgs, ... }: {
  users.users.deepslate = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirtd" "i2c" "docker" ];
    shell = pkgs.zsh;
  };
}
