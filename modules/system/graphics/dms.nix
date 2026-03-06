{ inputs, lib, pkgs, ... }:
let
  jsonFormat = pkgs.formats.json { };
  greeterSettings = jsonFormat.generate "dms-greeter-settings.json" {
    use24HourClock = true;
    showSeconds = true;
    clockDateFormat = "yyyy-MM-dd ddd";
    lockDateFormat = "yyyy-MM-dd ddd";
    showWeather = false;
    cornerRadius = 12;
    popupTransparency = 1.0;
    dockTransparency = 1.0;
  };
in
{
  imports = [
    inputs.dms.nixosModules.dank-material-shell
    inputs.dms.nixosModules.greeter
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
    configFiles = [
      "/etc/xdg/DankMaterialShell/settings.json"
    ];
  };

  environment.etc."xdg/DankMaterialShell/settings.json".source = greeterSettings;

  services.greetd.enable = true;
  services.greetd.settings.default_session.user = "greeter";

  services.xserver.displayManager.gdm.enable = lib.mkForce false;
  services.displayManager.gdm.enable = lib.mkForce false;
}
