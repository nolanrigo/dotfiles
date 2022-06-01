{ config, pkgs, ... }:

let
  inherit (builtins) fetchGit readFile;
  params = import ./params.nix;
  deps = import ./dependencies.nix;
  exec = import ./helpers/i3-exec.nix;
  translationEngines = import ./helpers/translation-engines.nix;
  quickmarksConf = import ./helpers/quickmarks-conf.nix;
in {
  home-manager.users."${params.username}" = {
    # Qutebrowser
    programs.qutebrowser = {
      enable = true;

      extraConfig = readFile "${deps.base16-qutebrowser}/themes/default/base16-${params.theme.base16-name}.config.py";

      searchEngines = (translationEngines ["fr" "en" "de" "es"]) // {
        DEFAULT = "https://duckduckgo.com/?q={}&kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web";
        g = "https://www.google.com/search?q={}";
        yt = "https://www.youtube.com/results?search_query={}";
        gh = "https://github.com/{}";
        npm = "https://www.npmjs.com/package/{}";
        npmd = "https://www.npmjs.com/package/@types/{}";
        npms = "https://www.npmjs.com/search?q={}";
        nip = "https://search.nixos.org/packages?from=0&size=30&sort=relevance&query={}";
        e = "http://e.localhost:{}";
      };

      settings = {
        url = {
          default_page = "https://start.duckduckgo.com/?kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web";
        };
        content = {
          pdfjs = true;
        };
        tabs = {
          show = "multiple";
          tabs_are_windows = false;
          last_close = "blank";
        };
        statusbar = {
          widgets = ["keypress" "url" "scroll" "history" "tabs" "progress"];
        };
        colors.webpage = {
          # bg = params.theme.colors.primary.background;
          preferred_color_scheme = "dark";
        };
      };

    };

    xdg.configFile."qutebrowser/quickmarks".text = quickmarksConf {
      # General
      mail = "https://mail.proton.me";
      cal = "https://www.icloud.com/calendar"; # waiting for protonmail on IOS cal = "https://calendar.proton.me";
      drive = "https://drive.proton.me";
      maps = "https://maps.google.com";
      wsp = "https://web.whatsapp.com";

      # Qutebrowser
      settings = "https://www.qutebrowser.org/doc/help/settings.html";

      # Daily tools
      home-manager = "https://github.com/nix-community/home-manager";
      tcss = "https://nerdcave.com/tailwind-cheat-sheet";
      tui = "https://tailwindui.com";
      tvalues = "https://tailwind-match.netlify.app";
      tcolors = "https://find-nearest-tailwind-colour.netlify.app";
      ricons = "https://react-icons.github.io/react-icons";
      wdns = "https://www.whatsmydns.net";
      httpbin = "https://requestbin.net";
    };

    # qutebrowser as $BROWSER
    home.sessionVariables.BROWSER = "qutebrowser";

    # Add keybindings to i3
    xsession.windowManager.i3.config.keybindings = let
      mod = params.modifier;
    in {
      "${mod}+slash" = exec "$BROWSER";
    };

    # Backup browsers
    programs.firefox.enable = true;
    home.packages = [pkgs.google-chrome];
  };
}
