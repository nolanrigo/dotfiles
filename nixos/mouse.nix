{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  services.xserver = {
    libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        tappingDragLock = false;
        accelProfile = "flat";
      };
    };
    # LOOK AT: synaptics for advandced trackpad gestures
    config = ''
      Section "InputClass"
        Identifier "MX Vertical Mouse"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0"
      EndSection
    '';
  };

  home-manager.users."${params.username}".services.unclutter = {
    enable = true;
    timeout = 5;
  };
}
