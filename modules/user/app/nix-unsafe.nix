{ config, pkgs, ... }:

let
  nix-legacy-unsafe =
    pkgs.runCommand "nix-legacy-unsafe"
      {
        nativeBuildInputs = [ pkgs.makeWrapper ];
      }
      ''
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

  # TODO: Fix completions

  #   nix-legacy-unsafe-completions = pkgs.runCommand "nix-legacy-unsafe-completions" { } ''
  #     mkdir -p $out/share/zsh/site-functions
  #     echo "#compdef nix-shell-unsafe=nix-shell" > $out/share/zsh/site-functions/_nix-shell-unsafe
  #     echo "#compdef nix-env-unsafe=nix-env" > $out/share/zsh/site-functions/_nix-env-unsafe
  #     echo "#compdef nix-build-unsafe=nix-build" > $out/share/zsh/site-functions/_nix-build-unsafe

  #     mkdir -p $out/share/fish/vendor_completions.d
  #     echo "complete -c nix-shell-unsafe -w nix-shell" > $out/share/fish/vendor_completions.d/nix-shell-unsafe.fish
  #     echo "complete -c nix-env-unsafe -w nix-env" > $out/share/fish/vendor_completions.d/nix-env-unsafe.fish
  #     echo "complete -c nix-build-unsafe -w nix-build" > $out/share/fish/vendor_completions.d/nix-build-unsafe.fish

  #     mkdir -p $out/share/bash-completion/completions
  #     echo "complete -F _nix_shell nix-shell-unsafe" > $out/share/bash-completion/completions/nix-shell-unsafe
  #     echo "complete -F _nix_env nix-env-unsafe" > $out/share/bash-completion/completions/nix-env-unsafe
  #     echo "complete -F _nix_build nix-build-unsafe" > $out/share/bash-completion/completions/nix-build-unsafe
  #   '';

  #   nix-command-unsafe-completions = pkgs.runCommand "nix-command-unsafe-completions" { } ''
  #     mkdir -p $out/share/zsh/site-functions
  #     echo "#compdef nix-unsafe=nix" > $out/share/zsh/site-functions/_nix-unsafe

  #     mkdir -p $out/share/fish/vendor_completions.d
  #     echo "complete -c nix-unsafe -w nix" > $out/share/fish/vendor_completions.d/nix-unsafe.fish

  #     mkdir -p $out/share/bash-completion/completions
  #     echo "complete -F _nix nix-unsafe" > $out/share/bash-completion/completions/nix-unsafe
  #   '';
in
{
  home.packages = [
    nix-legacy-unsafe
    nix-command-unsafe
    # nix-legacy-unsafe-completions
    # nix-command-unsafe-completions
  ];
}
