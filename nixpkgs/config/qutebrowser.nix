{ pkgs, config, lib, ... }:

{
  programs.qutebrowser = {
    enable = true;

    extraConfig = ''
      c.url.default_page = "https://start.duckduckgo.com/?kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web";
      c.url.searchengines = {
        'DEFAULT': 'https://duckduckgo.com/?q={}&kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web',
        'g': 'https://www.google.com/search?q={}',
        'yt': 'https://www.youtube.com/results?search_query={}',
        'npm': 'https://www.npmjs.com/package/{}',
        'npmd': 'https://www.npmjs.com/package/@types/{}',
        'npms': 'https://www.npmjs.com/search?q={}',
        'nix': 'https://nixos.org/nixos/packages.html?query={}',
      }

      DEEPL_TRANSLATE_URL = 'https://www.deepl.com/translator'
      GOOGLE_TRANSLATE_URL = 'https://translate.google.com'

      TRANSLATE_LANGUAGES = ['fr', 'en']

      for f in TRANSLATE_LANGUAGES:
          for t in TRANSLATE_LANGUAGES:
              c.url.searchengines[f+t] = DEEPL_TRANSLATE_URL + '#'+f+'/'+t+'/{}'
              c.url.searchengines['g'+f+t] = GOOGLE_TRANSLATE_URL + '#'+f+'/'+t+'/{}'
    '';
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
      cdk = "https://docs.aws.amazon.com/cdk/api/latest";

      # ProjectE
      cpeai = "http://e.localhost:3203";
      cpead = "http://e.localhost:3202";
      cpeau = "http://e.localhost:3201";
      cpebw = "http://e.localhost:3204";
      cpebwg = "http://e.localhost:3204/___graphql";
      cpel = "http://e.localhost:3205";
      cpelg = "http://e.localhost:3205/___graphql";
    };
    mapAttrsToList = f: attrs: map (name: f name (builtins.getAttr name attrs)) (builtins.attrNames attrs);
    attrsToConfigLines = mapAttrsToList (key: value: key + " " + value);
  in builtins.concatStringsSep "\n" (attrsToConfigLines quickmarks);

}
