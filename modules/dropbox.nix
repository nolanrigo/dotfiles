{ config, pkgs, lib, ... }: {
  home-manager.users.${config.user.name} = {
    services.dropbox.enable = false;
  };

  environment.systemPackages = with pkgs; [
    maestral
    maestral-gui
    bash
    libnotify
  ];

  systemd.services.maestral = let
    maestral = "${pkgs.maestral}/bin/maestral";
    bash = "${pkgs.bash}/bin/bash";
    notifySend = "${pkgs.libnotify}/bin/notify-send";
  in {
    description = "Maestral daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "notify";
      NotifyAccess = "exec";
      ExecStart = "${maestral} start -f";
      ExecStop = "${maestral} stop";
      ExecStopPost = "${bash} -c 'if [ ${"$"}{SERVICE_RESULT} != success ]; then ${notifySend} Maestral \"Daemon failed\"; fi'";
      WatchdogSec = "30s";
    };
  };
}
