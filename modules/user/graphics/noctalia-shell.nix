{ inputs, config, lib, ... }: {
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf config.programs.noctalia-shell.enable {
    programs.noctalia-shell.systemd.enable = lib.mkDefault true;
  };
}
