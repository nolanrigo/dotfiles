{ config, pkgs, ... }: {

  services.logind.extraConfig = ''
    HandleSuspendKey=ignore
    HandleHibernateKey=ignore
    HandleLidSwitch=ignore
  '';

  systemd.user.services."disable-sleep" = {
    description = "Disable sleep and screen blanking";
    serviceConfig = {
      WantedBy = [ "default.target" ];
      ExecStart = pkgs.writeShellScript "disable-sleep" ''
        xset s off
        xset -dpms
      '';
    };
  };
}
