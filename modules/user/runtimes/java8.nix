{ pkgs, ... }:
let
  jdk = pkgs.jdk8;
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
    "jinfo"
    "jmap"
    "jps"
    "jrunscript"
    "jstack"
    "jstat"
    "jstatd"
    "keytool"
    "pack200"
    "rmiregistry"
    "serialver"
  ];
  wrappers = map (bin:
    pkgs.writeShellScriptBin "${bin}8" ''
      exec ${jdk}/bin/${bin} "$@"
    ''
  ) bins;
in
{
  home.packages = wrappers;
}
