{ config, pkgs, ... }: {
  home-manager.users.${config.user.name} = {
    programs = {
      watson = {
        enable = true;
        settings = {
          backend = {
            url = "";
            token = "";
          };
          options = {
            stop_on_start = true;
            stop_on_restart = false;
            date_format = "%Y.%m.%d";
            time_format = "%H:%M:%S%z";
            week_start = "monday";
            log_current = false;
            pager = true;
            report_current = false;
            reverse_log = true;
          };
        };
      };

      fish.shellAbbrs = {
        w = "watson";
      };
    };
  };
}
