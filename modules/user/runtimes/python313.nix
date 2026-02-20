{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    python313
    inputs.fix-python.packages.${pkgs.system}.default
  ];
}
