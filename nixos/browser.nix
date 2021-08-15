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
        tabs = {
          show = "multiple";
          tabs_are_windows = false;
          last_close = "blank";
        };
        statusbar = {
          widgets = ["keypress" "url" "scroll" "history" "tabs" "progress"];
        };
        colors.webpage = {
          bg = params.theme.colors.primary.background;
          preferred_color_scheme = "dark";
        };
      };

    };

    xdg.configFile."qutebrowser/quickmarks".text = quickmarksConf {
      # General
      mail = "https://beta.protonmail.com";
      cal = "https://calendar.protonmail.com";
      maps = "https://maps.google.com";
      wsp = "https://web.whatsapp.com";

      # Qutebrowser
      settings = "https://www.qutebrowser.org/doc/help/settings.html";

      # Daily tools
      home-manager = "https://github.com/nix-community/home-manager";
      tcss = "https://nerdcave.com/tailwind-cheat-sheet";
      tui = "https://tailwindui.com";
      ricons = "https://react-icons.github.io/react-icons";
      wdns = "https://www.whatsmydns.net";
      awssdk = "https://docs.aws.amazon.com/AWSJavaScriptSDK/latest";
      awscdk = "https://docs.aws.amazon.com/cdk/api/latest";
      aws = "https://eu-west-3.console.aws.amazon.com/console/home?region=eu-west-3";
      awslbd = "https://eu-west-3.console.aws.amazon.com/lambda/home?region=eu-west-3#/functions";
      awslog = "https://eu-west-3.console.aws.amazon.com/cloudwatch/home?region=eu-west-3#logsV2:log-groups";
      awsddb = "https://eu-west-3.console.aws.amazon.com/dynamodbv2/home?region=eu-west-3#tables";
      awssqs = "https://eu-west-3.console.aws.amazon.com/sqs/v2/home?region=eu-west-3#/queues";
      awss3 = "https://s3.console.aws.amazon.com/s3/home?region=eu-west-3";
      awscdn = "https://console.aws.amazon.com/cloudfront/home?region=eu-west-3";
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
