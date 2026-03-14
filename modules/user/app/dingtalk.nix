{ pkgs, ... }: {
  home.packages = with pkgs; [
    pkgs.nur.repos.yakkhini.dingtalk
  ];
}
