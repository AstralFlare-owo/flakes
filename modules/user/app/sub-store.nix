{ pkgs, ... }: {
  home.packages = with pkgs; [
    sub-store
    sub-store-frontend
  ];
}
