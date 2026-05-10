{ config, pkgs, ... }:

let
  nix-legacy-unsafe = pkgs.runCommand "nix-legacy-unsafe" {
    nativeBuildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin

    makeWrapper ${config.nix.package}/bin/nix-shell $out/bin/nix-shell-unsafe \
      --set NIXPKGS_ALLOW_UNFREE 1 \
      --set NIXPKGS_ALLOW_INSECURE 1

    makeWrapper ${config.nix.package}/bin/nix-env $out/bin/nix-env-unsafe \
      --set NIXPKGS_ALLOW_UNFREE 1 \
      --set NIXPKGS_ALLOW_INSECURE 1

    makeWrapper ${config.nix.package}/bin/nix-build $out/bin/nix-build-unsafe \
      --set NIXPKGS_ALLOW_UNFREE 1 \
      --set NIXPKGS_ALLOW_INSECURE 1
  '';

  nix-command-unsafe = pkgs.writeShellScriptBin "nix-unsafe" ''
    export NIXPKGS_ALLOW_INSECURE=1
    export NIXPKGS_ALLOW_UNFREE=1
    if [ $# -gt 0 ] && [[ "$1" != -* ]]; then
      SUBCMD="$1"
      shift
      exec ${config.nix.package}/bin/nix "$SUBCMD" --impure "$@"
    else
      exec ${config.nix.package}/bin/nix "$@"
    fi
  '';
in
{
  home.packages = [
    nix-legacy-unsafe
    nix-command-unsafe
  ];
}