{ config, pkgs, ... }:

{
  environment.systemPackages = [];
  services.xserver = {
    videoDrivers = ["modesetting"];
    useGlamor = true;
    exportConfiguration = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
