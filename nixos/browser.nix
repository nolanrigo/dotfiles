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

      searchEngines = (translationEngines ["fr" "en" "de"]) // {
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
          prefers_color_scheme_dark = true;
          darkmode.enabled = true;
        };
      };

    };

    xdg.configFile."qutebrowser/quickmarks".text = quickmarksConf {
      # General
      mail = "https://beta.protonmail.com";

      # Daily tools
      home-manager = "https://github.com/nix-community/home-manager";
      tcss = "https://nerdcave.com/tailwind-cheat-sheet";
      tui = "https://tailwindui.com";
      ricons = "https://react-icons.github.io/react-icons";
      awssdk = "https://docs.aws.amazon.com/AWSJavaScriptSDK/latest";
      awscdk = "https://docs.aws.amazon.com/cdk/api/latest";
      aws = "https://eu-west-3.console.aws.amazon.com/console/home?region=eu-west-3";
    };

    # Firefox as backup browser
    programs.firefox.enable = true;

    # qutebrowser as $BROWSER
    home.sessionVariables.BROWSER = "qutebrowser";

    # Add keybindings to i3
    xsession.windowManager.i3.config.keybindings = let
      mod = params.modifier;
    in {
      "${mod}+slash" = exec "$BROWSER";
    };
  };
}
