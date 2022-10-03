{ config, pkgs, ... }: {

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Enable A2DP Sink
        # Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services = {
    blueman.enable = true;
    dbus.packages = [pkgs.blueman];
  };

  home-manager.users.${config.user.name} = {
    services.blueman-applet.enable = true;
  };
}
