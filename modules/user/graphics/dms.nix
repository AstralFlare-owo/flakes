{ pkgs, lib, osConfig ? { }, ... }:
let
  dmsEnabled = lib.attrByPath [ "programs" "dank-material-shell" "enable" ] false osConfig;
  jsonFormat = pkgs.formats.json { };
in
{
  config = lib.mkIf dmsEnabled {
    xdg.configFile."DankMaterialShell/settings.json".source = jsonFormat.generate "dms-settings.json" {
      use24HourClock = true;
      showSeconds = true;
      clockDateFormat = "yyyy-MM-dd ddd";
      lockDateFormat = "yyyy-MM-dd ddd";

      showLauncherButton = true;
      showWorkspaceSwitcher = true;
      showFocusedWindow = true;
      showClock = true;
      showSystemTray = true;
      showMusic = true;
      showNotificationButton = true;
      showBattery = true;
      showControlCenterButton = true;
      showClipboard = true;
      showCpuUsage = true;
      showMemUsage = true;
      showCpuTemp = true;
      showGpuTemp = false;
      showWeather = false;

      workspaceScrolling = true;
      workspaceFollowFocus = false;
      showWorkspaceIndex = true;
      showWorkspaceName = false;
      showOccupiedWorkspacesOnly = false;

      controlCenterShowAudioIcon = true;
      controlCenterShowAudioPercent = false;
      controlCenterShowBrightnessIcon = true;
      controlCenterShowBrightnessPercent = false;
      controlCenterShowBatteryIcon = false;
      controlCenterShowMicIcon = false;
      controlCenterShowMicPercent = true;
      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowVpnIcon = true;
      controlCenterShowScreenSharingIcon = true;
      showPrivacyButton = true;

      notificationHistoryEnabled = true;
      notificationTimeoutLow = 5000;
      notificationTimeoutNormal = 5000;
      notificationTimeoutCritical = 0;

      lockBeforeSuspend = true;
      lockScreenShowPowerActions = true;
      lockScreenShowSystemIcons = true;
      lockScreenShowTime = true;
      lockScreenShowDate = true;
      lockScreenShowProfileImage = true;
      lockScreenShowPasswordField = true;
      lockScreenShowMediaPlayer = true;

      cornerRadius = 12;
      popupTransparency = 1.0;
      dockTransparency = 1.0;
      barConfigs = [
        {
          id = "default";
          name = "Noctalia-like";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          leftWidgets = [ "launcherButton" "clock" "cpuUsage" "focusedWindow" ];
          centerWidgets = [ "workspaceSwitcher" ];
          rightWidgets = [
            "systemTray"
            "music"
            "notificationButton"
            "battery"
            "controlCenterButton"
            "clipboard"
          ];
          spacing = 6;
          innerPadding = 4;
          bottomGap = 0;
          transparency = 0.93;
          widgetTransparency = 1.0;
          squareCorners = false;
          noBackground = false;
          borderEnabled = false;
          widgetOutlineEnabled = false;
          fontScale = 1.0;
          iconScale = 1.0;
          autoHide = false;
          scrollEnabled = true;
        }
      ];
    };
  };
}
