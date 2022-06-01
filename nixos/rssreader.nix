{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}" = {
    programs.newsboat = {
      enable = true;

      urls = [
        {
          title = "techradar";
          url = "https://www.techradar.com/rss";
          tags = ["tech"];
        }
      ];

      autoReload = true;
      maxItems = 0; # 0 = Infinity
      browser = "$BROWSER";

      extraConfig = ''
        # Vim
        unbind-key ENTER
        unbind-key j
        unbind-key K
        bind-key j down
        bind-key k up
        bind-key l open
        bind-key h quit


        # Theme
        color background         default   default
        color listnormal         default   default
        color listnormal_unread  default   default
        color listfocus          black     cyan
        color listfocus_unread   black     cyan
        color info               default   black
        color article            default   default

        highlight article "^(Title):.*$" blue default
        highlight article "https?://[^ ]+" red default
        highlight article "\\[image\\ [0-9]+\\]" green default
      '';
    };

    # newsboat as rss
    programs.fish.shellAbbrs.rss = "newsboat";
  };
}
