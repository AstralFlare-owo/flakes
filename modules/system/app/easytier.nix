{ ... }: {
  services.easytier = {
    enable = true;
    instances.ctmc = {
      configServer = "ctmc";
    };
  };
}
