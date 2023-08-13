{ config, pkgs, lib, ... }: {
  home-manager.users.${config.user.name} = {
    services.dropbox.enable = false;
  };

  environment.systemPackages = with pkgs; [
    maestral
    maestral-gui
  ];

  /*
  systemd.user.services.maestral = {
    description = "Maestral";
    wantedBy = ["graphical-session.target"];
    environment = {};
    serviceConfig = {
      ExecStart = "${lib.getBin pkgs.maestral}/bin/maestral start";
      ExecReload = "${lib.getBin pkgs.coreutils}/bin/kill -HUP $MAINPID";
      ExecStop = "${lib.getBin pkgs.maestral}/bin/maestral stop";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };
  */
}
