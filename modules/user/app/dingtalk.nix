{ pkgs, ... }: {
  home.packages = with pkgs; [
    pkgs.nur.repos.xddxdd.dingtalk
  ];
}
