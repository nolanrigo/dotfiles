{ config, pkgs, ... }: let 
  theme = pkgs.fetchFromGitHub {
    name = "qutebrowser-dracula-theme";
    owner = "dracula";
    repo = "qutebrowser-dracula-theme";
    rev = "master";
    sha256 = "sha256-BXTvYFZnzEDlNEOTaWm4m8MEelVrRsUkNdwYKxaxw/g=";
  };
  translationEngines = ls: builtins.listToAttrs (
    builtins.concatLists (
      builtins.concatLists (
        builtins.map (
          f: builtins.map (
            t: [
              { name = "${f}${t}"; value = "https://www.deepl.com/translator#${f}/${t}/{}"; }
              { name = "g${f}${t}"; value = "https://translate.google.com#${f}/${t}/{}"; }
            ]
          ) ls
        ) ls
      )
    )
  );
in {
  home-manager.users.${config.user.name} = {

    home.packages = with pkgs; [
      brave
    ];

    xdg.configFile."qutebrowser/dracula" = {
      source = theme;
    };

    programs.qutebrowser = {
      enable = true;
      searchEngines = (translationEngines ["fr" "en" "de" "es" "et"]) // {
        DEFAULT = "https://duckduckgo.com/?q={}&kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web";
        g = "https://www.google.com/search?q={}";
        yt = "https://www.youtube.com/results?search_query={}";
        gh = "https://github.com/nolanrigo/{}";
        npm = "https://www.npmjs.com/package/{}";
        npmd = "https://www.npmjs.com/package/@types/{}";
        npms = "https://www.npmjs.com/search?q={}";
        nip = "https://search.nixos.org/packages?from=0&size=30&sort=relevance&query={}";
        e = "http://e.localhost:{}";
      };
      quickmarks = {
        # General
        mail = "https://mail.proton.me";
        cal = "https://www.icloud.com/calendar"; # waiting for protonmail on IOS cal = "https://calendar.proton.me";
        drive = "https://drive.proton.me";
        maps = "https://maps.google.com";
        wsp = "https://web.whatsapp.com";

        # Qutebrowser
        settings = "https://www.qutebrowser.org/doc/help/settings.html";

        # Daily tools
        home-manager = "https://nix-community.github.io/home-manager/options.html";
        tcss = "https://nerdcave.com/tailwind-cheat-sheet";
        tui = "https://tailwindui.com";
        tvalues = "https://tailwind-match.netlify.app";
        tcolors = "https://find-nearest-tailwind-colour.netlify.app";
        ricons = "https://react-icons.github.io/react-icons";
        wdns = "https://www.whatsmydns.net";
        httpbin = "https://requestbin.net";
        cdk = "https://docs.aws.amazon.com/cdk/api/v2/index.html";
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
      extraConfig = ''
        import dracula.draw

        # Load existing settings made via :set
        config.load_autoconfig()

        dracula.draw.blood(c, {
            'spacing': {
                'vertical': 4,
                'horizontal': 4
            }
        }) 
      '';
    };
  };
}
