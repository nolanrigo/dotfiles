{ config, pkgs, ... }:

# INFO: Dealing with battery, power, and sleep mode
let
  params = import ./params.nix;
in {
  services.upower.enable = true;

  # Caffeine allow to temporally disable sleeping mode through the tray
  home-manager.users."${params.username}" = {
    services.caffeine.enable = true;
  };
}
