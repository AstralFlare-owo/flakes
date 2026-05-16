{ pkgs, ... }: {
  home.packages = with pkgs; [
    (pkgs.symlinkJoin {
      name = "typora-wrapped";
      paths = [ typora ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/typora \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3"
      '';
    })
  ];
}
