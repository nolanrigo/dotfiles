{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  networking = {
    hostName = params.name;
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = builtins.listToAttrs (
      builtins.map (i: { name = i; value = { useDHCP = true; }; })
      params.networkInterfaces
    );
    hosts = {
      "127.0.0.1" = params.denyDomains;
    };
  };

  # Allow user to manage network
  users.users."${params.username}".extraGroups = ["networkmanager"];

  home-manager.users."${params.username}" = {
    # Network manager applet (add to the tray)
    services.network-manager-applet.enable = true;
    # Open nm-connection-editor as a popup
    xsession.windowManager.i3.config.floating.criteria = [{ class = "Nm-connection-editor"; }];
  };

  # Avahi (Bonjour equivalent)
  services.avahi.enable = true;
}
