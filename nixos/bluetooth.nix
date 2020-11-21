{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  # Enable bluetooth on the system
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    config = {
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
    services.blueman-applet.enable = true;

    # Bind media buttons on bluetooth headset
    # Info: https://nixos.wiki/wiki/Bluetooth#Using_Bluetooth_headset_buttons_to_control_media_player
    systemd.user.services.mpris-proxy = {
      Unit = {
        Description = "Mpris proxy";
        After = [
          "network.target"
          "sound.target"
        ];
      };
      Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      Install.WantedBy = ["default.target"];
    };

    # Open blueman as a popup
    xsession.windowManager.i3.config.floating.criteria = [{ class = ".blueman-manager-wrapped"; }];
  };
}
