{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  services.xserver = {
    libinput = {
      enable = true;
      mouse = {
        accelSpeed = "4";
        accelProfile = "flat";
        leftHanded = false;
        naturalScrolling = false;
      };
      touchpad = {
        accelSpeed = "0";
        accelProfile = "flat";
        leftHanded = false;
        naturalScrolling = true;
        tapping = false;
        scrollMethod = "twofinger";
      };
    };
  };

  home-manager.users."${params.username}".services.unclutter = {
    enable = true;
    timeout = 5;
  };
}
