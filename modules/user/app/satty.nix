{ pkgs, ... }: {
  programs.satty = {
    enable = true;
    settings = {
      font = {
        family = "sans-serif";
        fallback = [
          "Noto Sans CJK SC"
          "Noto Color Emoji"
        ];
      };
    };
  };

  home.packages = [
    (pkgs.writeShellScriptBin "satty-edit-clipboard" ''
      ${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.satty}/bin/satty --filename -
    '')
  ];
}
