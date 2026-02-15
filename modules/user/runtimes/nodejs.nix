{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs
    pnpm-shell-completion
  ];
}
