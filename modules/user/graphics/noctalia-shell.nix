{ inputs, config, lib, ... }: {
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf (lib.attrByPath [ "programs" "noctalia-shell" "enable" ] false config) {
    programs.noctalia-shell.systemd.enable = lib.mkDefault true;
  };
}
