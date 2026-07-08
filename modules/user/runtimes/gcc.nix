{ pkgs, ... }: {
  programs.gcc.enable = true;

  home.packages = with pkgs; [
    gnumake
  ];
}
