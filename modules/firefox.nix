{ config, pkgs, ... }: {
  home-manager.users.${config.user.name} = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;

      /*
      profiles = {
        nolan = {
          name = "Nolan";
          search = {
            default = "DuckDuckGo";
            force = true;
            engines = { };
          };
          bookmarks = [
            {
              name = "wikipedia";
              tags = [ "wiki" ];
              keyword = "wiki";
              url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
          ];
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [

          ];
          settings = {

          };
          extraConfig = ''


          '';

        };
      };
      */
    };
  };
}
