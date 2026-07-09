{ lib, pkgs, ... }:
let
  dingtalk = pkgs.nur.repos.yakkhini.dingtalk;
  gsettingsSchemaPackages = with pkgs; [
    gtk3
    gsettings-desktop-schemas
  ];
  gsettingsSchemaPath = lib.concatMapStringsSep ":" (
    package: "${package}/share/gsettings-schemas/${package.name}"
  ) gsettingsSchemaPackages;

  dingtalkWithGtkSchemas = pkgs.symlinkJoin {
    name = "${dingtalk.name}-with-gtk-schemas";
    paths = [ dingtalk ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/dingtalk \
        --prefix XDG_DATA_DIRS : "${gsettingsSchemaPath}"
    '';
  };
in
{
  home.packages = [
    dingtalkWithGtkSchemas
  ];
}
