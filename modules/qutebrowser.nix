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
      package = pkgs.qutebrowser-qt6.override { enableWideVine = true; };

      searchEngines = (translationEngines ["fr" "en" "de" "es" "et" "et"]) // {
        DEFAULT = "https://duckduckgo.com/?q={}&kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web";
        g = "https://www.google.com/search?q={}";
        yt = "https://www.youtube.com/results?search_query={}";
        gh = "https://github.com/nolanrigo/{}";
        npm = "https://www.npmjs.com/package/{}";
        npmd = "https://www.npmjs.com/package/@types/{}";
        npms = "https://www.npmjs.com/search?q={}";
        npmq = "https://packagequality.com/#?package={}";
        nip = "https://search.nixos.org/packages?from=0&size=30&sort=relevance&query={}";
        e = "http://e.localhost:{}";
      };
      quickmarks = {
        # General
        mail = "https://mail.proton.me";
        maildev = "http://localhost:8025";
        cal = "https://calendar.proton.me";
        drive = "https://drive.proton.me";
        timer = "https://track.toggl.com/timer";
        maps = "https://maps.google.com";
        wsp = "https://web.whatsapp.com";
        music = "https://music.youtube.com";
        todo = "https://app.clickup.com";
        podcast = "https://play.pocketcasts.com/podcasts";

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

        # others
        fingers = "https://zty.pe";
        email-spam-tester = "https://www.mail-tester.com";
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
        # fix aspect ratio, see https://github.com/qutebrowser/qutebrowser/discussions/6649?sort=top#discussioncomment-1221450
        qt.args = [ "enable-experimental-web-platform-features" ];
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

    programs.firefox = {
      enable = true;
      profiles = {
        nolan = {
          bookmarks = [];
        };
      };
    };
  };
}
