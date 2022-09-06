{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  # Enable bluetooth on the system
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Enable A2DP Sink
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Active Blueman
  services.blueman.enable = true;

  # FIXTHAT: https://github.com/rycee/home-manager/issues/84
  services.dbus.packages = [ pkgs.blueman ];

  home-manager.users."${params.username}" = {
    # Blueman applet (add to the tray)
    services.blueman-applet.enable = false;

    # Open blueman as a popup
    xsession.windowManager.i3.config.floating.criteria = [{ class = ".blueman-manager-wrapped"; }];
  };
}
