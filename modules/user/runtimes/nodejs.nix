{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs
    pnpm
  ];

  programs.bun.enable = true;
  programs.npm.enable = true;
}
