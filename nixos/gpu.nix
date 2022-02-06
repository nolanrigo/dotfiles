{ config, pkgs, ... }:

{
  environment.systemPackages = [];
  services.xserver = {
    dpi = 96;
    videoDrivers = ["nvidia"];
    # useGlamor = true;
    exportConfiguration = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
  };
}
