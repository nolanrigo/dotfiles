{ config, pkgs, ... }:

# INFO: Dealing with battery, power, and sleep mode
# INFO: For now, I'm not using a laptop, power management doesn't make sense
let
  params = import ./params.nix;
in {
  /*
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';
  */

  # Caffeine allow to temporally disable sleeping mode through the tray
  home-manager.users."${params.username}" = {
    services.caffeine.enable = false;
  };
}
