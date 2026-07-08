set shell := [ "bash", "-euo", "pipefail", "-c" ]

flake := "."

default:
    @just --list

build host:
    nh os build {{flake}}#{{host}} --show-trace --accept-flake-config

test host:
    nh os test {{flake}}#{{host}} --show-trace --accept-flake-config

boot host:
    nh os boot {{flake}}#{{host}} --show-trace --accept-flake-config

switch host:
    nh os switch {{flake}}#{{host}} --show-trace --accept-flake-config

update:
    nix flake update

format:
    fd -e nix -X nixfmt