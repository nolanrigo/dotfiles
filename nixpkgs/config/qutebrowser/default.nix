{ pkgs, config, lib, ... }:

let
  inherit (import ./translation.nix { lib = lib; }) translationEngines;
  inherit (import ./quickmarks.nix {}) attrsToConfigLines;
  inherit (lib) recursiveUpdate;
in {
  programs.qutebrowser = {
    enable = true;

    searchEngines = lib.recursiveUpdate (translationEngines ["fr" "en"]) {
      DEFAULT = "https://duckduckgo.com/?q={}&kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web";
      g = "https://www.google.com/search?q={}";
      yt = "https://www.youtube.com/results?search_query={}";
      gh = "https://github.com/{}";
      npm = "https://www.npmjs.com/package/{}";
      npmd = "https://www.npmjs.com/package/@types/{}";
      npms = "https://www.npmjs.com/search?q={}";
      nix = "https://search.nixos.org/packages?from=0&size=30&sort=relevance&query={}";
      e = "http://e.localhost:{}";
    };

    settings = {
      url = {
        default_page = "https://start.duckduckgo.com/?kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web";
      };
      tabs = {
        show = "always";
        tabs_are_windows = false;
        last_close = "close";
      };
      statusbar = {
        widgets = ["keypress" "url" "scroll" "history" "tabs" "progress"];
      };
    };
  };

  xdg.configFile."qutebrowser/quickmarks".text = let
    quickmarks = {
      # General
      mail = "https://beta.protonmail.com";

      # Daily tools
      tcss = "https://nerdcave.com/tailwind-cheat-sheet";
      tui = "https://tailwindui.com";
      ricons = "https://react-icons.github.io/react-icons";
      awssdk = "https://docs.aws.amazon.com/AWSJavaScriptSDK/latest";
      aws = "https://aws.amazon.com";
      cdk = "https://docs.aws.amazon.com/cdk/api/latest";
    };
  in builtins.concatStringsSep "\n" (attrsToConfigLines quickmarks);

}
