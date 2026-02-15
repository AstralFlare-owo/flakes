{ ... }: {
  services.easytier = {
    enable = true;
    instances.ctmc = {
      configServer = "udp://_et.aflare.top:22020/ctmc";
    };
  };
}
