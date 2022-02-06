{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  services.xserver = {
    libinput = {
      enable = true;
      mouse = {
        accelSpeed = "3";
        accelProfile = "flat";
        leftHanded = false;
        naturalScrolling = false;
      };
    };
  };

  home-manager.users."${params.username}".services.unclutter = {
    enable = true;
    timeout = 5;
  };
}
