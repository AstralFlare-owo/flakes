{ config, ... }: {
  users.groups.syncthing.members = builtins.attrNames config.users.users;

  services.syncthing = {
    user = "af";
    enable = true;
    openDefaultPorts = true;
  };
}
