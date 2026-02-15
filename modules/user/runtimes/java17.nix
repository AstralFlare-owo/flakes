{ pkgs, ... }:
let
  jdk = pkgs.jdk17;
  bins = [
    "java"
    "javac"
    "jar"
    "jarsigner"
    "javadoc"
    "javap"
    "jdeps"
    "jcmd"
    "jconsole"
    "jdb"
    "jdeprscan"
    "jfr"
    "jhsdb"
    "jinfo"
    "jlink"
    "jmap"
    "jmod"
    "jps"
    "jrunscript"
    "jshell"
    "jstack"
    "jstat"
    "jstatd"
    "keytool"
    "pack200"
    "rmiregistry"
    "serialver"
  ];
  wrappers = map (bin:
    pkgs.writeShellScriptBin "${bin}17" ''
      exec ${jdk}/bin/${bin} "$@"
    ''
  ) bins;
in
{
  home.packages = wrappers;
}
