{ config, ... }: {
  users.groups.syncthing.members = builtins.attrNames config.users.users;

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };
}
