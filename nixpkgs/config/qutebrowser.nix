{ pkgs, config, ... }:

{
  programs.qutebrowser = {
    enable = true;

    extraConfig = ''
      c.url.default_page = "https://start.duckduckgo.com/?kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web";
      c.url.searchengines = {
        'DEFAULT': 'https://duckduckgo.com/?q={}&kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kt=p&t=hk&ia=web',
        'g': 'https://www.google.com/search?q={}',
        'yt': 'https://www.youtube.com/results?search_query={}',
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
}
