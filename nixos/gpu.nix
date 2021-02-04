{ config, pkgs, ... }:

{
  environment.systemPackages = [];
  services.xserver = {
    videoDrivers = ["intel"];
    exportConfiguration = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
