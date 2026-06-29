{ pkgs, ... }:

let
  opencode-bin = "${pkgs.opencode}/bin/opencode";

  opencode-wrapped = pkgs.writeShellScriptBin "opencode" ''
    if [ -n "$_OPENCODE_BARE" ]; then
      exec ${opencode-bin} "$@"
    fi
    CONFIG="$HOME/.config/opencode/opencode.json"
    TMP=$(mktemp)
    if [ -f "$CONFIG" ]; then
      ${pkgs.jq}/bin/jq '.plugin |= map(select(. != "oh-my-openagent@latest"))' "$CONFIG" > "$TMP" && mv "$TMP" "$CONFIG"
    else
      echo '{}' | ${pkgs.jq}/bin/jq '.plugin = []' > "$CONFIG"
    fi
    export _OPENCODE_BARE=1
    exec ${opencode-bin} "$@"
  '';

  omo = pkgs.writeShellScriptBin "omo" ''
    if [ -n "$_OPENCODE_BARE" ]; then
      exec ${opencode-bin} "$@"
    fi
    CONFIG="$HOME/.config/opencode/opencode.json"
    TMP=$(mktemp)
    if [ -f "$CONFIG" ]; then
      ${pkgs.jq}/bin/jq '.plugin |= (. - ["oh-my-openagent@latest"] + ["oh-my-openagent@latest"])' "$CONFIG" > "$TMP" && mv "$TMP" "$CONFIG"
    else
      echo '{}' | ${pkgs.jq}/bin/jq '.plugin = ["oh-my-openagent@latest"]' > "$CONFIG"
    fi
    export _OPENCODE_BARE=1
    exec ${opencode-bin} "$@"
  '';
in
{
  programs.opencode = {
    enable = true;
    package = opencode-wrapped;
  };

  home.packages = with pkgs; [
    opencode-desktop
    omo
  ];
}
