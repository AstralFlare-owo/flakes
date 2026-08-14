{ pkgs, ... }:
let
  qq-wayland = pkgs.symlinkJoin {
    name = "qq-wayland";
    paths = [ pkgs.qq ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      # QQ 新版不再认 ELECTRON_OZONE_PLATFORM_HINT，直接给二进制入口加参数
      rm $out/bin/qq
      makeWrapper ${pkgs.qq}/bin/qq $out/bin/qq \
        --add-flags "--ozone-platform=wayland"

      # 原 desktop 入口写死旧 store 绝对路径，会绕过 wrapper，改成走新入口
      rm $out/share/applications/qq.desktop
      sed -e "s|^Exec=.*|Exec=$out/bin/qq %U|" \
        ${pkgs.qq}/share/applications/qq.desktop > $out/share/applications/qq.desktop
    '';
  };
in
{
  home.packages = [ qq-wayland ];
}
